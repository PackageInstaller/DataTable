return {
	Play318282001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318282001
		arg_1_1.duration_ = 6.87

		local var_1_0 = {
			zh = 6.7,
			ja = 6.866
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
				arg_1_0:Play318282002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K16i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16i")
				var_4_0.name = "K16i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K16i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K16i

				arg_1_1.bgs_.K16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K16i" then
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

			local var_4_8 = "10065ui_story"

			if arg_1_1.actors_["10065ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10065ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "10065ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["10065ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect10065ui_story == nil then
				arg_1_1.var_.characterEffect10065ui_story = var_4_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.characterEffect10065ui_story and not isNil(var_4_12) then
					arg_1_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect10065ui_story then
				arg_1_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			if 0.733333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.733333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action1_1")
			end

			local var_4_21 = arg_1_1.actors_["10065ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10065ui_story = var_4_21.localPosition
			end

			local var_4_22 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_22 then
				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_1_1.time_ - 1.8) / var_4_22)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_22 and arg_1_1.time_ < 1.8 + var_4_22 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0, -0.81, -6.19)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.425

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(318282001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 17 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 17)

				if (17 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 17)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282001", "story_v_out_318282.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_318282", "318282001", "story_v_out_318282.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_318282", "318282001", "story_v_out_318282.awb")

						arg_1_1:RecordAudio("318282001", var_4_31)
						arg_1_1:RecordAudio("318282001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_318282", "318282001", "story_v_out_318282.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_318282", "318282001", "story_v_out_318282.awb")
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
				actorName = "10065ui_story",
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
	Play318282002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318282002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318282003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1150ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1150ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1150ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1150ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1150ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1150ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1150ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1150ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.01, -6.2)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1150ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1150ui_story == nil then
				arg_9_1.var_.characterEffect1150ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1150ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1150ui_story then
				arg_9_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action7_2")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_8 = arg_9_1.actors_["10065ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10065ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, 100, 0)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["10065ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10065ui_story == nil then
				arg_9_1.var_.characterEffect10065ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect10065ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10065ui_story then
				arg_9_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(318282002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 2 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 2)

				if (2 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 2)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282002", "story_v_out_318282.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_318282", "318282002", "story_v_out_318282.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_318282", "318282002", "story_v_out_318282.awb")

						arg_9_1:RecordAudio("318282002", var_12_19)
						arg_9_1:RecordAudio("318282002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318282", "318282002", "story_v_out_318282.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318282", "318282002", "story_v_out_318282.awb")
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
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318282003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318282003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318282004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1150ui_story = arg_13_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1150ui_story"].transform.position).z)
				arg_13_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1150ui_story"].transform.localEulerAngles = arg_13_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1150ui_story"].transform.position).z)
				arg_13_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1150ui_story"].transform.localEulerAngles = arg_13_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1150ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1150ui_story == nil then
				arg_13_1.var_.characterEffect1150ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1150ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1150ui_story then
				arg_13_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_16_3 = 0
			local var_16_4 = 1.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(318282003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 58 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 58)

				if (58 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 58)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play318282004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318282004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318282005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1199ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1199ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1199ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1199ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1199ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1199ui_story = var_20_3.localPosition

				arg_17_1:ShowWeapon(arg_17_1.var_["1199ui_story" .. "Animator"].transform, false)
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_20_5 = "1199_story"

			if arg_17_1.actors_["1199_story"] == nil and not isNil((Asset.Load("Char/" .. "1199_story"))) then
				local var_20_6 = Object.Instantiate(Asset.Load("Char/" .. "1199_story"), arg_17_1.stage_.transform)

				var_20_6.name = var_20_5
				var_20_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_5] = var_20_6

				local var_20_7 = var_20_6:GetComponentInChildren(typeof(CharacterEffect))

				var_20_7.enabled = true

				local var_20_8 = GameObjectTools.GetOrAddComponent(var_20_6, typeof(DynamicBoneHelper))

				if var_20_8 then
					var_20_8:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_7.transform, false)

				arg_17_1.var_[var_20_5 .. "Animator"] = var_20_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_5 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_5 .. "LipSync"] = var_20_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_9 = arg_17_1.actors_["1199_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1199_story == nil then
				arg_17_1.var_.characterEffect1199_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_10 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_10 and not isNil(var_20_9) then
				if arg_17_1.var_.characterEffect1199_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1199_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_10 and arg_17_1.time_ < 0 + var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1199_story then
				arg_17_1.var_.characterEffect1199_story.fillFlat = false
			end

			local var_20_12 = 0
			local var_20_13 = 0.1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(318282004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 4 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 4)

				if (4 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 4)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282004", "story_v_out_318282.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_318282", "318282004", "story_v_out_318282.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_318282", "318282004", "story_v_out_318282.awb")

						arg_17_1:RecordAudio("318282004", var_20_19)
						arg_17_1:RecordAudio("318282004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318282", "318282004", "story_v_out_318282.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318282", "318282004", "story_v_out_318282.awb")
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
				actorName = "1199ui_story",
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
	Play318282005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318282005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play318282006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_127", "se_story_127_thunder", "")
			end

			local var_24_1 = arg_21_1.actors_["1199ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1199ui_story = var_24_1.localPosition
			end

			local var_24_2 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 then
				var_24_1.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_2)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 then
				var_24_1.localPosition = Vector3.New(0, 100, 0)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			local var_24_3 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_4 = 0.6

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_4 then
				local var_24_5 = Color.New(1, 1, 1)

				var_24_5.a = Mathf.Lerp(1, 0, (arg_21_1.time_ - var_24_3) / var_24_4)
				arg_21_1.mask_.color = var_24_5
			end

			if arg_21_1.time_ >= var_24_3 + var_24_4 and arg_21_1.time_ < var_24_3 + var_24_4 + arg_24_0 then
				local var_24_6 = Color.New(1, 1, 1)

				arg_21_1.mask_.enabled = false
				var_24_6.a = 0
				arg_21_1.mask_.color = var_24_6
			end

			local var_24_7 = manager.ui.mainCamera.transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = var_24_7.localPosition
			end

			local var_24_8 = 0.6

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_8 then
				local var_24_9, var_24_10 = math.modf((arg_21_1.time_ - 0) / 0.066)

				var_24_7.localPosition = Vector3.New(var_24_10 * 0.13, var_24_10 * 0.13, var_24_10 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= 0 + var_24_8 and arg_21_1.time_ < 0 + var_24_8 + arg_24_0 then
				var_24_7.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_11 = 0
			local var_24_12 = 1.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(318282005).content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 50 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_13) / 50)

				if (50 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_13) / 50)) > 0 and var_24_12 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_16 and arg_21_1.time_ < var_24_11 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318282006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318282006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318282007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(318282006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 22 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 22)

				if (22 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 22)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318282007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318282007
		arg_29_1.duration_ = 6.63

		local var_29_0 = {
			zh = 4.4,
			ja = 6.633
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
				arg_29_0:Play318282008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10065ui_story"]) and arg_29_1.var_.characterEffect10065ui_story == nil then
				arg_29_1.var_.characterEffect10065ui_story = arg_29_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10065ui_story"]) then
				if arg_29_1.var_.characterEffect10065ui_story and not isNil(arg_29_1.actors_["10065ui_story"]) then
					arg_29_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10065ui_story"]) and arg_29_1.var_.characterEffect10065ui_story then
				arg_29_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_hit", "")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action3_1")
			end

			local var_32_3 = arg_29_1.actors_["10065ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10065ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.81, -6.19)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_32_6 = 0
			local var_32_7 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(318282007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 7 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 7)

				if (7 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 7)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282007", "story_v_out_318282.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_318282", "318282007", "story_v_out_318282.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_318282", "318282007", "story_v_out_318282.awb")

						arg_29_1:RecordAudio("318282007", var_32_13)
						arg_29_1:RecordAudio("318282007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318282", "318282007", "story_v_out_318282.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318282", "318282007", "story_v_out_318282.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play318282008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318282008
		arg_33_1.duration_ = 2.2

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_33_0:Play318282009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1093ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1093ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1093ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1093ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1093ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1093ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1093ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_36_8 = arg_33_1.actors_["10065ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10065ui_story = var_36_8.localPosition
			end

			local var_36_9 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 then
				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_9)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0, 100, 0)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			local var_36_10 = arg_33_1.actors_["10065ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect10065ui_story == nil then
				arg_33_1.var_.characterEffect10065ui_story = var_36_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_11 and not isNil(var_36_10) then
				if arg_33_1.var_.characterEffect10065ui_story and not isNil(var_36_10) then
					arg_33_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_11)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_11 and arg_33_1.time_ < 0 + var_36_11 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect10065ui_story then
				arg_33_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_36_12 = 0
			local var_36_13 = 0.15

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(318282008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 6 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 6)

				if (6 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 6)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282008", "story_v_out_318282.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_318282", "318282008", "story_v_out_318282.awb") / 1000

					if var_36_18 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_12
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_318282", "318282008", "story_v_out_318282.awb")

						arg_33_1:RecordAudio("318282008", var_36_19)
						arg_33_1:RecordAudio("318282008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_318282", "318282008", "story_v_out_318282.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_318282", "318282008", "story_v_out_318282.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_20 and arg_33_1.time_ < var_36_12 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play318282009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318282009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318282010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1093ui_story = arg_37_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).z)
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles = arg_37_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).z)
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles = arg_37_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1093ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1093ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1093ui_story then
				arg_37_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_40_3 = 0
			local var_40_4 = 1.225

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(318282009).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 49 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 49)

				if (49 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 49)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318282010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318282010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play318282011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(318282010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 52 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 52)

				if (52 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 52)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318282011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318282011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play318282012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.675

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(318282011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 27 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 27)

				if (27 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 27)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318282012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318282012
		arg_49_1.duration_ = 13

		local var_49_0 = {
			zh = 6.9,
			ja = 13
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
				arg_49_0:Play318282013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10065ui_story"]) and arg_49_1.var_.characterEffect10065ui_story == nil then
				arg_49_1.var_.characterEffect10065ui_story = arg_49_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10065ui_story"]) then
				if arg_49_1.var_.characterEffect10065ui_story and not isNil(arg_49_1.actors_["10065ui_story"]) then
					arg_49_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10065ui_story"]) and arg_49_1.var_.characterEffect10065ui_story then
				arg_49_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action4_1")
			end

			local var_52_2 = arg_49_1.actors_["10065ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10065ui_story = var_52_2.localPosition
			end

			local var_52_3 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_49_1.time_ - 0) / var_52_3)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0, -0.81, -6.19)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			local var_52_4 = 0
			local var_52_5 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(318282012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 24 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 24)

				if (24 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 24)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282012", "story_v_out_318282.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282012", "story_v_out_318282.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_318282", "318282012", "story_v_out_318282.awb")

						arg_49_1:RecordAudio("318282012", var_52_11)
						arg_49_1:RecordAudio("318282012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318282", "318282012", "story_v_out_318282.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318282", "318282012", "story_v_out_318282.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play318282013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318282013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play318282014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10065ui_story = arg_53_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10065ui_story"].transform.position).z)
				arg_53_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10065ui_story"].transform.localEulerAngles = arg_53_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10065ui_story"].transform.position).z)
				arg_53_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10065ui_story"].transform.localEulerAngles = arg_53_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10065ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10065ui_story == nil then
				arg_53_1.var_.characterEffect10065ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect10065ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_2)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10065ui_story then
				arg_53_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_56_3 = 0
			local var_56_4 = 1.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(318282013).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 42 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 42)

				if (42 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 42)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play318282014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318282014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play318282015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.025

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(318282014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 41 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 41)

				if (41 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 41)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play318282015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318282015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play318282016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(318282015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 46 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 46)

				if (46 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 46)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play318282016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318282016
		arg_65_1.duration_ = 6.9

		local var_65_0 = {
			zh = 6.9,
			ja = 4.733
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
				arg_65_0:Play318282017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10065ui_story"]) and arg_65_1.var_.characterEffect10065ui_story == nil then
				arg_65_1.var_.characterEffect10065ui_story = arg_65_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10065ui_story"]) then
				if arg_65_1.var_.characterEffect10065ui_story and not isNil(arg_65_1.actors_["10065ui_story"]) then
					arg_65_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10065ui_story"]) and arg_65_1.var_.characterEffect10065ui_story then
				arg_65_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action2_1")
			end

			local var_68_2 = arg_65_1.actors_["10065ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10065ui_story = var_68_2.localPosition
			end

			local var_68_3 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_65_1.time_ - 0) / var_68_3)
				var_68_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_2.position).x, (manager.ui.mainCamera.transform.position - var_68_2.position).y, (manager.ui.mainCamera.transform.position - var_68_2.position).z)
				var_68_2.localEulerAngles.z = 0
				var_68_2.localEulerAngles.x = 0
				var_68_2.localEulerAngles = var_68_2.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(0, -0.81, -6.19)
				var_68_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_2.position).x, (manager.ui.mainCamera.transform.position - var_68_2.position).y, (manager.ui.mainCamera.transform.position - var_68_2.position).z)
				var_68_2.localEulerAngles.z = 0
				var_68_2.localEulerAngles.x = 0
				var_68_2.localEulerAngles = var_68_2.localEulerAngles
			end

			local var_68_4 = 0
			local var_68_5 = 0.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(318282016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 24 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 24)

				if (24 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 24)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282016", "story_v_out_318282.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282016", "story_v_out_318282.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_318282", "318282016", "story_v_out_318282.awb")

						arg_65_1:RecordAudio("318282016", var_68_11)
						arg_65_1:RecordAudio("318282016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318282", "318282016", "story_v_out_318282.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318282", "318282016", "story_v_out_318282.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318282017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318282017
		arg_69_1.duration_ = 8.87

		local var_69_0 = {
			zh = 8.866,
			ja = 6.666
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
				arg_69_0:Play318282018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065actionlink/10065action426")
			end

			local var_72_0 = 0
			local var_72_1 = 0.675

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(318282017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 27 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 27)

				if (27 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 27)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282017", "story_v_out_318282.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_out_318282", "318282017", "story_v_out_318282.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_out_318282", "318282017", "story_v_out_318282.awb")

						arg_69_1:RecordAudio("318282017", var_72_7)
						arg_69_1:RecordAudio("318282017", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_318282", "318282017", "story_v_out_318282.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_318282", "318282017", "story_v_out_318282.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play318282018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318282018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play318282019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10065ui_story = arg_73_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10065ui_story"].transform.position).z)
				arg_73_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10065ui_story"].transform.localEulerAngles = arg_73_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10065ui_story"].transform.position).z)
				arg_73_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10065ui_story"].transform.localEulerAngles = arg_73_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10065ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10065ui_story == nil then
				arg_73_1.var_.characterEffect10065ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect10065ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10065ui_story then
				arg_73_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_76_3 = 0
			local var_76_4 = 1.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(318282018).content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 50 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 50)

				if (50 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 50)) > 0 and var_76_4 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_8 and arg_73_1.time_ < var_76_3 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play318282019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318282019
		arg_77_1.duration_ = 5.23

		local var_77_0 = {
			zh = 3.333,
			ja = 5.233
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
				arg_77_0:Play318282020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10065ui_story"]) and arg_77_1.var_.characterEffect10065ui_story == nil then
				arg_77_1.var_.characterEffect10065ui_story = arg_77_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10065ui_story"]) then
				if arg_77_1.var_.characterEffect10065ui_story and not isNil(arg_77_1.actors_["10065ui_story"]) then
					arg_77_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10065ui_story"]) and arg_77_1.var_.characterEffect10065ui_story then
				arg_77_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action5_1")
			end

			local var_80_2 = arg_77_1.actors_["10065ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10065ui_story = var_80_2.localPosition
			end

			local var_80_3 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_77_1.time_ - 0) / var_80_3)
				var_80_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_2.position).x, (manager.ui.mainCamera.transform.position - var_80_2.position).y, (manager.ui.mainCamera.transform.position - var_80_2.position).z)
				var_80_2.localEulerAngles.z = 0
				var_80_2.localEulerAngles.x = 0
				var_80_2.localEulerAngles = var_80_2.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(0, -0.81, -6.19)
				var_80_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_2.position).x, (manager.ui.mainCamera.transform.position - var_80_2.position).y, (manager.ui.mainCamera.transform.position - var_80_2.position).z)
				var_80_2.localEulerAngles.z = 0
				var_80_2.localEulerAngles.x = 0
				var_80_2.localEulerAngles = var_80_2.localEulerAngles
			end

			local var_80_4 = 0
			local var_80_5 = 0.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(318282019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 5 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 5)

				if (5 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 5)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282019", "story_v_out_318282.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282019", "story_v_out_318282.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_318282", "318282019", "story_v_out_318282.awb")

						arg_77_1:RecordAudio("318282019", var_80_11)
						arg_77_1:RecordAudio("318282019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_318282", "318282019", "story_v_out_318282.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_318282", "318282019", "story_v_out_318282.awb")
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

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play318282020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318282020
		arg_81_1.duration_ = 7

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play318282021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.bgs_.LX0206 == nil then
				local var_84_0 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LX0206")
				var_84_0.name = "LX0206"
				var_84_0.transform.parent = arg_81_1.stage_.transform
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_.LX0206 = var_84_0
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				local var_84_1 = arg_81_1.bgs_.LX0206

				arg_81_1.bgs_.LX0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_2 = var_84_1:GetComponent("SpriteRenderer")

				if var_84_2 and var_84_2.sprite then
					local var_84_3 = 2 * (var_84_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_1.transform.localScale = Vector3.New(var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "LX0206" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_4 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_5 = 2

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_5 then
				local var_84_6 = Color.New(1, 1, 1)

				var_84_6.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_4) / var_84_5)
				arg_81_1.mask_.color = var_84_6
			end

			if arg_81_1.time_ >= var_84_4 + var_84_5 and arg_81_1.time_ < var_84_4 + var_84_5 + arg_84_0 then
				local var_84_7 = Color.New(1, 1, 1)

				arg_81_1.mask_.enabled = false
				var_84_7.a = 0
				arg_81_1.mask_.color = var_84_7
			end

			local var_84_8 = arg_81_1.actors_["10065ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10065ui_story = var_84_8.localPosition
			end

			local var_84_9 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 then
				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_9)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, 100, 0)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			local var_84_10 = arg_81_1.actors_["10065ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_10) and arg_81_1.var_.characterEffect10065ui_story == nil then
				arg_81_1.var_.characterEffect10065ui_story = var_84_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_11 and not isNil(var_84_10) then
				if arg_81_1.var_.characterEffect10065ui_story and not isNil(var_84_10) then
					arg_81_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_11)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_11 and arg_81_1.time_ < 0 + var_84_11 + arg_84_0 and not isNil(var_84_10) and arg_81_1.var_.characterEffect10065ui_story then
				arg_81_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_12 = 2
			local var_84_13 = 1.075

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_14 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_14:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_15 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(318282020).content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_17 = 43 <= 0 and var_84_13 or var_84_13 * (utf8.len(var_84_15) / 43)

				if (43 <= 0 and var_84_13 or var_84_13 * (utf8.len(var_84_15) / 43)) > 0 and var_84_13 < var_84_17 then
					arg_81_1.talkMaxDuration = var_84_17
					var_84_12 = var_84_12 + 0.3

					if var_84_17 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = var_84_12 + 0.3
			local var_84_19 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_18 + var_84_19 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_18) / var_84_19

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_18 + var_84_19 and arg_81_1.time_ < var_84_18 + var_84_19 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play318282021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 318282021
		arg_87_1.duration_ = 1.9

		local var_87_0 = {
			zh = 0.999999999999,
			ja = 1.9
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
				arg_87_0:Play318282022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.05

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(318282021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 2 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 2)

				if (2 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 2)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282021", "story_v_out_318282.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282021", "story_v_out_318282.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_318282", "318282021", "story_v_out_318282.awb")

						arg_87_1:RecordAudio("318282021", var_90_6)
						arg_87_1:RecordAudio("318282021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_318282", "318282021", "story_v_out_318282.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_318282", "318282021", "story_v_out_318282.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play318282022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 318282022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play318282023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.725

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(318282022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 29 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 29)

				if (29 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 29)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play318282023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 318282023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play318282024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.3

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(318282023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 52 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 52)

				if (52 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 52)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play318282024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 318282024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play318282025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.35

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(318282024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 54 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 54)

				if (54 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 54)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play318282025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 318282025
		arg_103_1.duration_ = 8.17

		local var_103_0 = {
			zh = 5.8,
			ja = 8.166
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
				arg_103_0:Play318282026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.45

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4016")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(318282025)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 18 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 18)

				if (18 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 18)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282025", "story_v_out_318282.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282025", "story_v_out_318282.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_318282", "318282025", "story_v_out_318282.awb")

						arg_103_1:RecordAudio("318282025", var_106_6)
						arg_103_1:RecordAudio("318282025", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_318282", "318282025", "story_v_out_318282.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_318282", "318282025", "story_v_out_318282.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play318282026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 318282026
		arg_107_1.duration_ = 9

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play318282027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 2 < arg_107_1.time_ and arg_107_1.time_ <= 2 + arg_110_0 then
				local var_110_0 = arg_107_1.bgs_.K16i

				arg_107_1.bgs_.K16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_110_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_110_1 = var_110_0:GetComponent("SpriteRenderer")

				if var_110_1 and var_110_1.sprite then
					local var_110_2 = 2 * (var_110_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_110_0.transform.localScale = Vector3.New(var_110_2 / var_110_1.sprite.bounds.size.y < var_110_2 * manager.ui.mainCameraCom_.aspect / var_110_1.sprite.bounds.size.x and var_110_2 * manager.ui.mainCameraCom_.aspect / var_110_1.sprite.bounds.size.x or var_110_2 / var_110_1.sprite.bounds.size.y, var_110_2 / var_110_1.sprite.bounds.size.y < var_110_2 * manager.ui.mainCameraCom_.aspect / var_110_1.sprite.bounds.size.x and var_110_2 * manager.ui.mainCameraCom_.aspect / var_110_1.sprite.bounds.size.x or var_110_2 / var_110_1.sprite.bounds.size.y, 0)
				end

				for iter_110_0, iter_110_1 in pairs(arg_107_1.bgs_) do
					if iter_110_0 ~= "K16i" then
						iter_110_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_110_3 = 0

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_4 = 2

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_4 then
				local var_110_5 = Color.New(0, 0, 0)

				var_110_5.a = Mathf.Lerp(0, 1, (arg_107_1.time_ - var_110_3) / var_110_4)
				arg_107_1.mask_.color = var_110_5
			end

			if arg_107_1.time_ >= var_110_3 + var_110_4 and arg_107_1.time_ < var_110_3 + var_110_4 + arg_110_0 then
				local var_110_6 = Color.New(0, 0, 0)

				var_110_6.a = 1
				arg_107_1.mask_.color = var_110_6
			end

			local var_110_7 = 2

			if 2 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_8 = 2

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_8 then
				local var_110_9 = Color.New(0, 0, 0)

				var_110_9.a = Mathf.Lerp(1, 0, (arg_107_1.time_ - var_110_7) / var_110_8)
				arg_107_1.mask_.color = var_110_9
			end

			if arg_107_1.time_ >= var_110_7 + var_110_8 and arg_107_1.time_ < var_110_7 + var_110_8 + arg_110_0 then
				local var_110_10 = Color.New(0, 0, 0)

				arg_107_1.mask_.enabled = false
				var_110_10.a = 0
				arg_107_1.mask_.color = var_110_10
			end

			if arg_107_1.frameCnt_ <= 1 then
				arg_107_1.dialog_:SetActive(false)
			end

			local var_110_11 = 4
			local var_110_12 = 1.325

			if 4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_13 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_13:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_14 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(318282026).content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 53 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 53)

				if (53 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 53)) > 0 and var_110_12 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16
					var_110_11 = var_110_11 + 0.3

					if var_110_16 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_17 = var_110_11 + 0.3
			local var_110_18 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 + 0.3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_18 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_17) / var_110_18

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_17 + var_110_18 and arg_107_1.time_ < var_110_17 + var_110_18 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play318282027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318282027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play318282028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy02", "")
			end

			local var_116_1 = 0
			local var_116_2 = 1.2

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(318282027).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 48 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 48)

				if (48 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 48)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play318282028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 318282028
		arg_117_1.duration_ = 2

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play318282029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1199ui_story = arg_117_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).z)
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles = arg_117_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_117_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).z)
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles = arg_117_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1199ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1199ui_story == nil then
				arg_117_1.var_.characterEffect1199ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1199ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1199ui_story then
				arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action5_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.1

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(318282028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 4 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 4)

				if (4 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 4)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282028", "story_v_out_318282.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282028", "story_v_out_318282.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_318282", "318282028", "story_v_out_318282.awb")

						arg_117_1:RecordAudio("318282028", var_120_11)
						arg_117_1:RecordAudio("318282028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_318282", "318282028", "story_v_out_318282.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_318282", "318282028", "story_v_out_318282.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play318282029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318282029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play318282030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1199ui_story = arg_121_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).z)
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles = arg_121_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).z)
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles = arg_121_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1199ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1199ui_story == nil then
				arg_121_1.var_.characterEffect1199ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1199ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1199ui_story then
				arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_124_3 = 0
			local var_124_4 = 1.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(318282029).content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 47 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 47)

				if (47 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 47)) > 0 and var_124_4 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_8 and arg_121_1.time_ < var_124_3 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play318282030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318282030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318282031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_vine", "")
			end

			local var_128_1 = 0
			local var_128_2 = 1.525

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(318282030).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 61 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 61)

				if (61 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 61)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play318282031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318282031
		arg_129_1.duration_ = 5.77

		local var_129_0 = {
			zh = 5.166,
			ja = 5.766
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318282032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if arg_129_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_132_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_129_1.stage_.transform)

				var_132_0.name = "10066ui_story"
				var_132_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["10066ui_story"] = var_132_0

				local var_132_1 = var_132_0:GetComponentInChildren(typeof(CharacterEffect))

				var_132_1.enabled = true

				local var_132_2 = GameObjectTools.GetOrAddComponent(var_132_0, typeof(DynamicBoneHelper))

				if var_132_2 then
					var_132_2:EnableDynamicBone(false)
				end

				arg_129_1:ShowWeapon(var_132_1.transform, false)

				arg_129_1.var_["10066ui_story" .. "Animator"] = var_132_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_129_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_129_1.var_["10066ui_story" .. "LipSync"] = var_132_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_132_3 = arg_129_1.actors_["10066ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10066ui_story = var_132_3.localPosition
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_3.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_129_1.time_ - 0) / var_132_4)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			local var_132_5 = arg_129_1.actors_["10066ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect10066ui_story == nil then
				arg_129_1.var_.characterEffect10066ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.characterEffect10066ui_story and not isNil(var_132_5) then
					arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect10066ui_story then
				arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_132_8 = 0
			local var_132_9 = 0.375

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(318282031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 15 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 15)

				if (15 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 15)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282031", "story_v_out_318282.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_318282", "318282031", "story_v_out_318282.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_318282", "318282031", "story_v_out_318282.awb")

						arg_129_1:RecordAudio("318282031", var_132_15)
						arg_129_1:RecordAudio("318282031", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318282", "318282031", "story_v_out_318282.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318282", "318282031", "story_v_out_318282.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play318282032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318282032
		arg_133_1.duration_ = 1

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"

			SetActive(arg_133_1.choicesGo_, true)

			for iter_134_0, iter_134_1 in ipairs(arg_133_1.choices_) do
				SetActive(iter_134_1.go, iter_134_0 <= 1)
			end

			arg_133_1.choices_[1].txt.text = arg_133_1:FormatText(StoryChoiceCfg[687].name)
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318282033(arg_133_1)
			end

			arg_133_1:RecordChoiceLog(318282032, 687)
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10066ui_story = arg_133_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10066ui_story"].transform.position).z)
				arg_133_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10066ui_story"].transform.localEulerAngles = arg_133_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_133_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10066ui_story"].transform.position).z)
				arg_133_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10066ui_story"].transform.localEulerAngles = arg_133_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10066ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10066ui_story == nil then
				arg_133_1.var_.characterEffect10066ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10066ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_2)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10066ui_story then
				arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_136_3 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			if arg_133_1.time_ >= var_136_3 + 0.5 and arg_133_1.time_ < var_136_3 + 0.5 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play318282033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318282033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318282034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10066ui_story = arg_137_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).z)
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles = arg_137_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).z)
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles = arg_137_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_140_1 = 0
			local var_140_2 = 1.025

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(318282033).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 41 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 41)

				if (41 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 41)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play318282034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318282034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play318282035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.15

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(318282034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 46 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 46)

				if (46 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 46)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play318282035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318282035
		arg_145_1.duration_ = 2.4

		local var_145_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318282036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10066ui_story = arg_145_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10066ui_story"].transform.position).z)
				arg_145_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10066ui_story"].transform.localEulerAngles = arg_145_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_145_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10066ui_story"].transform.position).z)
				arg_145_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10066ui_story"].transform.localEulerAngles = arg_145_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10066ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10066ui_story == nil then
				arg_145_1.var_.characterEffect10066ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10066ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10066ui_story then
				arg_145_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action474")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_148_4 = 0
			local var_148_5 = 0.125

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(318282035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 5 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 5)

				if (5 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 5)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282035", "story_v_out_318282.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282035", "story_v_out_318282.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_318282", "318282035", "story_v_out_318282.awb")

						arg_145_1:RecordAudio("318282035", var_148_11)
						arg_145_1:RecordAudio("318282035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_318282", "318282035", "story_v_out_318282.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_318282", "318282035", "story_v_out_318282.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play318282036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318282036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318282037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10066ui_story = arg_149_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10066ui_story"].transform.position).z)
				arg_149_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["10066ui_story"].transform.localEulerAngles = arg_149_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10066ui_story"].transform.position).z)
				arg_149_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["10066ui_story"].transform.localEulerAngles = arg_149_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["10066ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect10066ui_story == nil then
				arg_149_1.var_.characterEffect10066ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect10066ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_2)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect10066ui_story then
				arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_152_3 = 0
			local var_152_4 = 0.325

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_5 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(318282036).content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 13 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_5) / 13)

				if (13 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_5) / 13)) > 0 and var_152_4 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_3 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_3
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_4, arg_149_1.talkMaxDuration)

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_3) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_3 + var_152_8 and arg_149_1.time_ < var_152_3 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play318282037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318282037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play318282038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.55

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(318282037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 62 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 62)

				if (62 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 62)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318282038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318282038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318282039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.775

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(318282038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 31 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 31)

				if (31 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 31)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318282039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318282039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318282040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.2

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(318282039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 48 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 48)

				if (48 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 48)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play318282040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318282040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318282041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy03", "")
			end

			local var_168_1 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_2 = 0.6

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = Color.New(1, 1, 1)

				var_168_3.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - var_168_1) / var_168_2)
				arg_165_1.mask_.color = var_168_3
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				local var_168_4 = Color.New(1, 1, 1)

				arg_165_1.mask_.enabled = false
				var_168_4.a = 0
				arg_165_1.mask_.color = var_168_4
			end

			local var_168_5 = 0
			local var_168_6 = 1.675

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(318282040).content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 67 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_7) / 67)

				if (67 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_7) / 67)) > 0 and var_168_6 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_10 and arg_165_1.time_ < var_168_5 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play318282041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318282041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play318282042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.325

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(318282041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 53 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 53)

				if (53 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 53)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play318282042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318282042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play318282043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(318282042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 10 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 10)

				if (10 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 10)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play318282043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318282043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play318282044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.475

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(318282043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 23 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 23)

				if (23 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 23)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play318282044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318282044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play318282045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.75

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(318282044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 70 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 70)

				if (70 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 70)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play318282045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318282045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play318282046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(318282045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 54 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 54)

				if (54 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 54)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play318282046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318282046
		arg_189_1.duration_ = 9.17

		local var_189_0 = {
			zh = 8.3,
			ja = 9.166
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play318282047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10065ui_story"]) and arg_189_1.var_.characterEffect10065ui_story == nil then
				arg_189_1.var_.characterEffect10065ui_story = arg_189_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10065ui_story"]) then
				if arg_189_1.var_.characterEffect10065ui_story and not isNil(arg_189_1.actors_["10065ui_story"]) then
					arg_189_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10065ui_story"]) and arg_189_1.var_.characterEffect10065ui_story then
				arg_189_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action5_1")
			end

			local var_192_2 = arg_189_1.actors_["10065ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10065ui_story = var_192_2.localPosition
			end

			local var_192_3 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_189_1.time_ - 0) / var_192_3)
				var_192_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_2.position).x, (manager.ui.mainCamera.transform.position - var_192_2.position).y, (manager.ui.mainCamera.transform.position - var_192_2.position).z)
				var_192_2.localEulerAngles.z = 0
				var_192_2.localEulerAngles.x = 0
				var_192_2.localEulerAngles = var_192_2.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -0.81, -6.19)
				var_192_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_2.position).x, (manager.ui.mainCamera.transform.position - var_192_2.position).y, (manager.ui.mainCamera.transform.position - var_192_2.position).z)
				var_192_2.localEulerAngles.z = 0
				var_192_2.localEulerAngles.x = 0
				var_192_2.localEulerAngles = var_192_2.localEulerAngles
			end

			local var_192_4 = 0
			local var_192_5 = 0.6

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(318282046)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 24 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 24)

				if (24 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 24)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282046", "story_v_out_318282.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282046", "story_v_out_318282.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_318282", "318282046", "story_v_out_318282.awb")

						arg_189_1:RecordAudio("318282046", var_192_11)
						arg_189_1:RecordAudio("318282046", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_318282", "318282046", "story_v_out_318282.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_318282", "318282046", "story_v_out_318282.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play318282047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318282047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play318282048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10065ui_story = arg_193_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10065ui_story"].transform.position).z)
				arg_193_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10065ui_story"].transform.localEulerAngles = arg_193_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10065ui_story"].transform.position).z)
				arg_193_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10065ui_story"].transform.localEulerAngles = arg_193_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10065ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10065ui_story == nil then
				arg_193_1.var_.characterEffect10065ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10065ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_2)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10065ui_story then
				arg_193_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_196_3 = 0
			local var_196_4 = 0.675

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_3 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_5 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(318282047).content)

				arg_193_1.text_.text = var_196_5

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_7 = 27 <= 0 and var_196_4 or var_196_4 * (utf8.len(var_196_5) / 27)

				if (27 <= 0 and var_196_4 or var_196_4 * (utf8.len(var_196_5) / 27)) > 0 and var_196_4 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_3 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_3
					end
				end

				arg_193_1.text_.text = var_196_5
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_4, arg_193_1.talkMaxDuration)

			if var_196_3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_3 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_3) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_3 + var_196_8 and arg_193_1.time_ < var_196_3 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play318282048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318282048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play318282049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if arg_197_1.bgs_.K16i_blur == nil then
				local var_200_0 = Object.Instantiate(arg_197_1.blurPaintGo_)

				var_200_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16i_blur")
				var_200_0.name = "K16i_blur"
				var_200_0.transform.parent = arg_197_1.stage_.transform
				var_200_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_.K16i_blur = var_200_0
			end

			local var_200_1 = 0
			local var_200_2 = arg_197_1.bgs_.K16i_blur

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				var_200_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_3 = var_200_2:GetComponent("SpriteRenderer")

				if var_200_3 and var_200_3.sprite then
					local var_200_4 = 2 * (var_200_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_2.transform.localScale = Vector3.New(var_200_4 / var_200_3.sprite.bounds.size.y < var_200_4 * manager.ui.mainCameraCom_.aspect / var_200_3.sprite.bounds.size.x and var_200_4 * manager.ui.mainCameraCom_.aspect / var_200_3.sprite.bounds.size.x or var_200_4 / var_200_3.sprite.bounds.size.y, var_200_4 / var_200_3.sprite.bounds.size.y < var_200_4 * manager.ui.mainCameraCom_.aspect / var_200_3.sprite.bounds.size.x and var_200_4 * manager.ui.mainCameraCom_.aspect / var_200_3.sprite.bounds.size.x or var_200_4 / var_200_3.sprite.bounds.size.y, 0)
				end
			end

			local var_200_5 = 0.5

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_5 then
				local var_200_6 = Color.New(1, 1, 1)

				var_200_6.a = Mathf.Lerp(0, 1, (arg_197_1.time_ - var_200_1) / var_200_5)

				var_200_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_200_6)
			end

			local var_200_7 = "K16i_blur"

			if arg_197_1.bgs_.K16i_blur == nil then
				local var_200_8 = Object.Instantiate(arg_197_1.blurPaintGo_)

				var_200_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_7)
				var_200_8.name = var_200_7
				var_200_8.transform.parent = arg_197_1.stage_.transform
				var_200_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_7] = var_200_8
			end

			local var_200_9 = 0.5
			local var_200_10 = arg_197_1.bgs_[var_200_7]

			if 0.5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				var_200_10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_11 = var_200_10:GetComponent("SpriteRenderer")

				if var_200_11 and var_200_11.sprite then
					local var_200_12 = 2 * (var_200_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_10.transform.localScale = Vector3.New(var_200_12 / var_200_11.sprite.bounds.size.y < var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x and var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x or var_200_12 / var_200_11.sprite.bounds.size.y, var_200_12 / var_200_11.sprite.bounds.size.y < var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x and var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x or var_200_12 / var_200_11.sprite.bounds.size.y, 0)
				end
			end

			local var_200_13 = 1.5

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_13 then
				local var_200_14 = Color.New(1, 1, 1)

				var_200_14.a = Mathf.Lerp(1, 0, (arg_197_1.time_ - var_200_9) / var_200_13)

				var_200_10:GetComponent("SpriteRenderer").material:SetColor("_Color", var_200_14)
			end

			local var_200_15 = 0

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			if arg_197_1.time_ >= var_200_15 + 2 and arg_197_1.time_ < var_200_15 + 2 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_16 = 0
			local var_200_17 = 1.625

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_18 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_18:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_19 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(318282048).content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_21 = 65 <= 0 and var_200_17 or var_200_17 * (utf8.len(var_200_19) / 65)

				if (65 <= 0 and var_200_17 or var_200_17 * (utf8.len(var_200_19) / 65)) > 0 and var_200_17 < var_200_21 then
					arg_197_1.talkMaxDuration = var_200_21
					var_200_16 = var_200_16 + 0.3

					if var_200_21 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_21 + var_200_16
					end
				end

				arg_197_1.text_.text = var_200_19
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_22 = var_200_16 + 0.3
			local var_200_23 = math.max(var_200_17, arg_197_1.talkMaxDuration)

			if var_200_16 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_22 + var_200_23 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_22) / var_200_23

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_22 + var_200_23 and arg_197_1.time_ < var_200_22 + var_200_23 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play318282049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 318282049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play318282050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.35

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(318282049).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 14 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 14)

				if (14 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 14)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play318282050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 318282050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play318282051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun02", "")
			end

			local var_210_1 = 0
			local var_210_2 = 1.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(318282050).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 59 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 59)

				if (59 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 59)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play318282051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 318282051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play318282052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_214_0 = 0.6

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				local var_214_1, var_214_2 = math.modf((arg_211_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_214_2 * 0.13, var_214_2 * 0.13, var_214_2 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				manager.ui.mainCamera.transform.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_3 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_3 + 0.6 and arg_211_1.time_ < var_214_3 + 0.6 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_4 = 0
			local var_214_5 = 0.2

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_6 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(318282051).content)

				arg_211_1.text_.text = var_214_6

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_8 = 8 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_6) / 8)

				if (8 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_6) / 8)) > 0 and var_214_5 < var_214_8 then
					arg_211_1.talkMaxDuration = var_214_8

					if var_214_8 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_6
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_9 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_9 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_9

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_9 and arg_211_1.time_ < var_214_4 + var_214_9 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play318282052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 318282052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play318282053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.5

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(318282052).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 20 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 20)

				if (20 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 20)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play318282053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 318282053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play318282054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 1.3

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(318282053).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 52 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 52)

				if (52 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 52)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play318282054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 318282054
		arg_223_1.duration_ = 9

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play318282055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if arg_223_1.bgs_.STblack == nil then
				local var_226_0 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_226_0.name = "STblack"
				var_226_0.transform.parent = arg_223_1.stage_.transform
				var_226_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_.STblack = var_226_0
			end

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				local var_226_1 = arg_223_1.bgs_.STblack

				arg_223_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_2 = var_226_1:GetComponent("SpriteRenderer")

				if var_226_2 and var_226_2.sprite then
					local var_226_3 = 2 * (var_226_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_1.transform.localScale = Vector3.New(var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "STblack" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_4 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_5 = 2

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_5 then
				local var_226_6 = Color.New(0, 0, 0)

				var_226_6.a = Mathf.Lerp(0, 1, (arg_223_1.time_ - var_226_4) / var_226_5)
				arg_223_1.mask_.color = var_226_6
			end

			if arg_223_1.time_ >= var_226_4 + var_226_5 and arg_223_1.time_ < var_226_4 + var_226_5 + arg_226_0 then
				local var_226_7 = Color.New(0, 0, 0)

				var_226_7.a = 1
				arg_223_1.mask_.color = var_226_7
			end

			local var_226_8 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_9 = 2

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 then
				local var_226_10 = Color.New(0, 0, 0)

				var_226_10.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_8) / var_226_9)
				arg_223_1.mask_.color = var_226_10
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 then
				local var_226_11 = Color.New(0, 0, 0)

				arg_223_1.mask_.enabled = false
				var_226_11.a = 0
				arg_223_1.mask_.color = var_226_11
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_226_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_14 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_14

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_14
						arg_223_1.bgmTxt2_.text = var_226_14
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_15 = 4
			local var_226_16 = 1.425

			if 4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_17 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_17:setOnUpdate(LuaHelper.FloatAction(function(arg_228_0)
					arg_223_1.dialogCg_.alpha = arg_228_0
				end))
				var_226_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(318282054).content)

				arg_223_1.text_.text = var_226_18

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 57 <= 0 and var_226_16 or var_226_16 * (utf8.len(var_226_18) / 57)

				if (57 <= 0 and var_226_16 or var_226_16 * (utf8.len(var_226_18) / 57)) > 0 and var_226_16 < var_226_20 then
					arg_223_1.talkMaxDuration = var_226_20
					var_226_15 = var_226_15 + 0.3

					if var_226_20 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_20 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_18
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_21 = var_226_15 + 0.3
			local var_226_22 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_21 + var_226_22 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_21) / var_226_22

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_21 + var_226_22 and arg_223_1.time_ < var_226_21 + var_226_22 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play318282055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 318282055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play318282056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.1

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(318282055).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 44 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 44)

				if (44 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 44)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play318282056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 318282056
		arg_234_1.duration_ = 7.43

		local var_234_0 = {
			zh = 7.433,
			ja = 6.266
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play318282057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_237_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_2 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_2

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_2
						arg_234_1.bgmTxt2_.text = var_237_2
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_234_1.time_ and arg_234_1.time_ <= 0.8 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "bgm_activity_2_7_story_death", "bgm_activity_2_7_story_death", "bgm_activity_2_7_story_death.awb")

				local var_237_5 = manager.audio:GetAudioName("bgm_activity_2_7_story_death", "bgm_activity_2_7_story_death")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_5 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_5

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_5
						arg_234_1.bgmTxt2_.text = var_237_5
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_237_6 = 0
			local var_237_7 = 0.7

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10048")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_8 = arg_234_1:GetWordFromCfg(318282056)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 28 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 28)

				if (28 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 28)) > 0 and var_237_7 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282056", "story_v_out_318282.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_318282", "318282056", "story_v_out_318282.awb") / 1000

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end

					if var_237_8.prefab_name ~= "" and arg_234_1.actors_[var_237_8.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_8.prefab_name].transform, "story_v_out_318282", "318282056", "story_v_out_318282.awb")

						arg_234_1:RecordAudio("318282056", var_237_13)
						arg_234_1:RecordAudio("318282056", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_318282", "318282056", "story_v_out_318282.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_318282", "318282056", "story_v_out_318282.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play318282057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 318282057
		arg_240_1.duration_ = 11.8

		local var_240_0 = {
			zh = 7.366,
			ja = 11.8
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play318282058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.975

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:GetWordFromCfg(318282057)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 39 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 39)

				if (39 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 39)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282057", "story_v_out_318282.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282057", "story_v_out_318282.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_318282", "318282057", "story_v_out_318282.awb")

						arg_240_1:RecordAudio("318282057", var_243_6)
						arg_240_1:RecordAudio("318282057", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_318282", "318282057", "story_v_out_318282.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_318282", "318282057", "story_v_out_318282.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play318282058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 318282058
		arg_244_1.duration_ = 6.27

		local var_244_0 = {
			zh = 3.466,
			ja = 6.266
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play318282059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.25

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:GetWordFromCfg(318282058)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 10 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 10)

				if (10 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 10)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282058", "story_v_out_318282.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282058", "story_v_out_318282.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_318282", "318282058", "story_v_out_318282.awb")

						arg_244_1:RecordAudio("318282058", var_247_6)
						arg_244_1:RecordAudio("318282058", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_318282", "318282058", "story_v_out_318282.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_318282", "318282058", "story_v_out_318282.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play318282059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 318282059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play318282060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if arg_248_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_251_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_248_1.stage_.transform)

				var_251_0.name = "10053ui_story"
				var_251_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["10053ui_story"] = var_251_0

				local var_251_1 = var_251_0:GetComponentInChildren(typeof(CharacterEffect))

				var_251_1.enabled = true

				local var_251_2 = GameObjectTools.GetOrAddComponent(var_251_0, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(false)
				end

				arg_248_1:ShowWeapon(var_251_1.transform, false)

				arg_248_1.var_["10053ui_story" .. "Animator"] = var_251_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_248_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_248_1.var_["10053ui_story" .. "LipSync"] = var_251_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_251_3 = arg_248_1.actors_["10053ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10053ui_story = var_251_3.localPosition
			end

			local var_251_4 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				var_251_3.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_4)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				var_251_3.localPosition = Vector3.New(0, 100, 0)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			local var_251_5 = arg_248_1.actors_["10053ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect10053ui_story == nil then
				arg_248_1.var_.characterEffect10053ui_story = var_251_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_6 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_6 and not isNil(var_251_5) then
				if arg_248_1.var_.characterEffect10053ui_story and not isNil(var_251_5) then
					arg_248_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_6)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_6 and arg_248_1.time_ < 0 + var_251_6 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect10053ui_story then
				arg_248_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_251_7 = 0
			local var_251_8 = 1.175

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_7 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_9 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(318282059).content)

				arg_248_1.text_.text = var_251_9

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 47 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_9) / 47)

				if (47 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_9) / 47)) > 0 and var_251_8 < var_251_11 then
					arg_248_1.talkMaxDuration = var_251_11

					if var_251_11 + var_251_7 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_7
					end
				end

				arg_248_1.text_.text = var_251_9
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_8, arg_248_1.talkMaxDuration)

			if var_251_7 <= arg_248_1.time_ and arg_248_1.time_ < var_251_7 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_7) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_7 + var_251_12 and arg_248_1.time_ < var_251_7 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play318282060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 318282060
		arg_252_1.duration_ = 2.8

		local var_252_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play318282061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				local var_255_0 = arg_252_1.bgs_.STblack

				arg_252_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_1 = var_255_0:GetComponent("SpriteRenderer")

				if var_255_1 and var_255_1.sprite then
					local var_255_2 = 2 * (var_255_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_0.transform.localScale = Vector3.New(var_255_2 / var_255_1.sprite.bounds.size.y < var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x and var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x or var_255_2 / var_255_1.sprite.bounds.size.y, var_255_2 / var_255_1.sprite.bounds.size.y < var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x and var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x or var_255_2 / var_255_1.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "STblack" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_3 = "1015ui_story"

			if arg_252_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_255_4 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_252_1.stage_.transform)

				var_255_4.name = var_255_3
				var_255_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_[var_255_3] = var_255_4

				local var_255_5 = var_255_4:GetComponentInChildren(typeof(CharacterEffect))

				var_255_5.enabled = true

				local var_255_6 = GameObjectTools.GetOrAddComponent(var_255_4, typeof(DynamicBoneHelper))

				if var_255_6 then
					var_255_6:EnableDynamicBone(false)
				end

				arg_252_1:ShowWeapon(var_255_5.transform, false)

				arg_252_1.var_[var_255_3 .. "Animator"] = var_255_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_252_1.var_[var_255_3 .. "Animator"].applyRootMotion = true
				arg_252_1.var_[var_255_3 .. "LipSync"] = var_255_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_255_7 = arg_252_1.actors_["1015ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1015ui_story = var_255_7.localPosition
			end

			local var_255_8 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_8 then
				var_255_7.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_252_1.time_ - 0) / var_255_8)
				var_255_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_7.position).x, (manager.ui.mainCamera.transform.position - var_255_7.position).y, (manager.ui.mainCamera.transform.position - var_255_7.position).z)
				var_255_7.localEulerAngles.z = 0
				var_255_7.localEulerAngles.x = 0
				var_255_7.localEulerAngles = var_255_7.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_8 and arg_252_1.time_ < 0 + var_255_8 + arg_255_0 then
				var_255_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_255_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_7.position).x, (manager.ui.mainCamera.transform.position - var_255_7.position).y, (manager.ui.mainCamera.transform.position - var_255_7.position).z)
				var_255_7.localEulerAngles.z = 0
				var_255_7.localEulerAngles.x = 0
				var_255_7.localEulerAngles = var_255_7.localEulerAngles
			end

			local var_255_9 = arg_252_1.actors_["1015ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_9) and arg_252_1.var_.characterEffect1015ui_story == nil then
				arg_252_1.var_.characterEffect1015ui_story = var_255_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_10 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_10 and not isNil(var_255_9) then
				if arg_252_1.var_.characterEffect1015ui_story and not isNil(var_255_9) then
					arg_252_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_10 and arg_252_1.time_ < 0 + var_255_10 + arg_255_0 and not isNil(var_255_9) and arg_252_1.var_.characterEffect1015ui_story then
				arg_252_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_255_12 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_13 = 2

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_13 then
				local var_255_14 = Color.New(1, 1, 1)

				var_255_14.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_12) / var_255_13)
				arg_252_1.mask_.color = var_255_14
			end

			if arg_252_1.time_ >= var_255_12 + var_255_13 and arg_252_1.time_ < var_255_12 + var_255_13 + arg_255_0 then
				local var_255_15 = Color.New(1, 1, 1)

				arg_252_1.mask_.enabled = false
				var_255_15.a = 0
				arg_252_1.mask_.color = var_255_15
			end

			local var_255_16 = 0
			local var_255_17 = 0.125

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_18 = arg_252_1:GetWordFromCfg(318282060)
				local var_255_19 = arg_252_1:FormatText(var_255_18.content)

				arg_252_1.text_.text = var_255_19

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_21 = 5 <= 0 and var_255_17 or var_255_17 * (utf8.len(var_255_19) / 5)

				if (5 <= 0 and var_255_17 or var_255_17 * (utf8.len(var_255_19) / 5)) > 0 and var_255_17 < var_255_21 then
					arg_252_1.talkMaxDuration = var_255_21

					if var_255_21 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_21 + var_255_16
					end
				end

				arg_252_1.text_.text = var_255_19
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282060", "story_v_out_318282.awb") ~= 0 then
					local var_255_22 = manager.audio:GetVoiceLength("story_v_out_318282", "318282060", "story_v_out_318282.awb") / 1000

					if var_255_22 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_22 + var_255_16
					end

					if var_255_18.prefab_name ~= "" and arg_252_1.actors_[var_255_18.prefab_name] ~= nil then
						local var_255_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_18.prefab_name].transform, "story_v_out_318282", "318282060", "story_v_out_318282.awb")

						arg_252_1:RecordAudio("318282060", var_255_23)
						arg_252_1:RecordAudio("318282060", var_255_23)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_318282", "318282060", "story_v_out_318282.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_318282", "318282060", "story_v_out_318282.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_24 = math.max(var_255_17, arg_252_1.talkMaxDuration)

			if var_255_16 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_24 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_16) / var_255_24

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_16 + var_255_24 and arg_252_1.time_ < var_255_16 + var_255_24 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play318282061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 318282061
		arg_256_1.duration_ = 16.43

		local var_256_0 = {
			zh = 11.9,
			ja = 16.433
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play318282062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if arg_256_1.bgs_.I07 == nil then
				local var_259_0 = Object.Instantiate(arg_256_1.paintGo_)

				var_259_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07")
				var_259_0.name = "I07"
				var_259_0.transform.parent = arg_256_1.stage_.transform
				var_259_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.bgs_.I07 = var_259_0
			end

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 then
				local var_259_1 = arg_256_1.bgs_.I07

				arg_256_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_259_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_259_2 = var_259_1:GetComponent("SpriteRenderer")

				if var_259_2 and var_259_2.sprite then
					local var_259_3 = 2 * (var_259_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_259_1.transform.localScale = Vector3.New(var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, 0)
				end

				for iter_259_0, iter_259_1 in pairs(arg_256_1.bgs_) do
					if iter_259_0 ~= "I07" then
						iter_259_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_259_4 = 0

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_5 = 2

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_5 then
				local var_259_6 = Color.New(0, 0, 0)

				var_259_6.a = Mathf.Lerp(0, 1, (arg_256_1.time_ - var_259_4) / var_259_5)
				arg_256_1.mask_.color = var_259_6
			end

			if arg_256_1.time_ >= var_259_4 + var_259_5 and arg_256_1.time_ < var_259_4 + var_259_5 + arg_259_0 then
				local var_259_7 = Color.New(0, 0, 0)

				var_259_7.a = 1
				arg_256_1.mask_.color = var_259_7
			end

			local var_259_8 = 2

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_9 = 2

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_9 then
				local var_259_10 = Color.New(0, 0, 0)

				var_259_10.a = Mathf.Lerp(1, 0, (arg_256_1.time_ - var_259_8) / var_259_9)
				arg_256_1.mask_.color = var_259_10
			end

			if arg_256_1.time_ >= var_259_8 + var_259_9 and arg_256_1.time_ < var_259_8 + var_259_9 + arg_259_0 then
				local var_259_11 = Color.New(0, 0, 0)

				arg_256_1.mask_.enabled = false
				var_259_11.a = 0
				arg_256_1.mask_.color = var_259_11
			end

			local var_259_12 = "10014ui_story"

			if arg_256_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_259_13 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_256_1.stage_.transform)

				var_259_13.name = var_259_12
				var_259_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.actors_[var_259_12] = var_259_13

				local var_259_14 = var_259_13:GetComponentInChildren(typeof(CharacterEffect))

				var_259_14.enabled = true

				local var_259_15 = GameObjectTools.GetOrAddComponent(var_259_13, typeof(DynamicBoneHelper))

				if var_259_15 then
					var_259_15:EnableDynamicBone(false)
				end

				arg_256_1:ShowWeapon(var_259_14.transform, false)

				arg_256_1.var_[var_259_12 .. "Animator"] = var_259_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_256_1.var_[var_259_12 .. "Animator"].applyRootMotion = true
				arg_256_1.var_[var_259_12 .. "LipSync"] = var_259_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_259_16 = arg_256_1.actors_["10014ui_story"].transform

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 then
				arg_256_1.var_.moveOldPos10014ui_story = var_259_16.localPosition
			end

			local var_259_17 = 0.001

			if 2 <= arg_256_1.time_ and arg_256_1.time_ < 2 + var_259_17 then
				var_259_16.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_256_1.time_ - 2) / var_259_17)
				var_259_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_16.position).x, (manager.ui.mainCamera.transform.position - var_259_16.position).y, (manager.ui.mainCamera.transform.position - var_259_16.position).z)
				var_259_16.localEulerAngles.z = 0
				var_259_16.localEulerAngles.x = 0
				var_259_16.localEulerAngles = var_259_16.localEulerAngles
			end

			if arg_256_1.time_ >= 2 + var_259_17 and arg_256_1.time_ < 2 + var_259_17 + arg_259_0 then
				var_259_16.localPosition = Vector3.New(0, -1.06, -6.2)
				var_259_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_16.position).x, (manager.ui.mainCamera.transform.position - var_259_16.position).y, (manager.ui.mainCamera.transform.position - var_259_16.position).z)
				var_259_16.localEulerAngles.z = 0
				var_259_16.localEulerAngles.x = 0
				var_259_16.localEulerAngles = var_259_16.localEulerAngles
			end

			local var_259_18 = arg_256_1.actors_["10014ui_story"]

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 and not isNil(var_259_18) and arg_256_1.var_.characterEffect10014ui_story == nil then
				arg_256_1.var_.characterEffect10014ui_story = var_259_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_19 = 0.200000002980232

			if 2 <= arg_256_1.time_ and arg_256_1.time_ < 2 + var_259_19 and not isNil(var_259_18) then
				if arg_256_1.var_.characterEffect10014ui_story and not isNil(var_259_18) then
					arg_256_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 2 + var_259_19 and arg_256_1.time_ < 2 + var_259_19 + arg_259_0 and not isNil(var_259_18) and arg_256_1.var_.characterEffect10014ui_story then
				arg_256_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 then
				arg_256_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 then
				arg_256_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_259_21 = arg_256_1.actors_["1015ui_story"].transform

			if 1.96599999815226 < arg_256_1.time_ and arg_256_1.time_ <= 1.96599999815226 + arg_259_0 then
				arg_256_1.var_.moveOldPos1015ui_story = var_259_21.localPosition
			end

			local var_259_22 = 0.001

			if 1.96599999815226 <= arg_256_1.time_ and arg_256_1.time_ < 1.96599999815226 + var_259_22 then
				var_259_21.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_256_1.time_ - 1.96599999815226) / var_259_22)
				var_259_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_21.position).x, (manager.ui.mainCamera.transform.position - var_259_21.position).y, (manager.ui.mainCamera.transform.position - var_259_21.position).z)
				var_259_21.localEulerAngles.z = 0
				var_259_21.localEulerAngles.x = 0
				var_259_21.localEulerAngles = var_259_21.localEulerAngles
			end

			if arg_256_1.time_ >= 1.96599999815226 + var_259_22 and arg_256_1.time_ < 1.96599999815226 + var_259_22 + arg_259_0 then
				var_259_21.localPosition = Vector3.New(0, 100, 0)
				var_259_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_21.position).x, (manager.ui.mainCamera.transform.position - var_259_21.position).y, (manager.ui.mainCamera.transform.position - var_259_21.position).z)
				var_259_21.localEulerAngles.z = 0
				var_259_21.localEulerAngles.x = 0
				var_259_21.localEulerAngles = var_259_21.localEulerAngles
			end

			local var_259_23 = arg_256_1.actors_["1015ui_story"]

			if 1.96599999815226 < arg_256_1.time_ and arg_256_1.time_ <= 1.96599999815226 + arg_259_0 and not isNil(var_259_23) and arg_256_1.var_.characterEffect1015ui_story == nil then
				arg_256_1.var_.characterEffect1015ui_story = var_259_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_24 = 0.034000001847744

			if 1.96599999815226 <= arg_256_1.time_ and arg_256_1.time_ < 1.96599999815226 + var_259_24 and not isNil(var_259_23) then
				if arg_256_1.var_.characterEffect1015ui_story and not isNil(var_259_23) then
					arg_256_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 1.96599999815226) / var_259_24)
				end
			end

			if arg_256_1.time_ >= 1.96599999815226 + var_259_24 and arg_256_1.time_ < 1.96599999815226 + var_259_24 + arg_259_0 and not isNil(var_259_23) and arg_256_1.var_.characterEffect1015ui_story then
				arg_256_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_25 = 4
			local var_259_26 = 0.95

			if 4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_25 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_27 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_27:setOnUpdate(LuaHelper.FloatAction(function(arg_260_0)
					arg_256_1.dialogCg_.alpha = arg_260_0
				end))
				var_259_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_28 = arg_256_1:GetWordFromCfg(318282061)
				local var_259_29 = arg_256_1:FormatText(var_259_28.content)

				arg_256_1.text_.text = var_259_29

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_31 = 38 <= 0 and var_259_26 or var_259_26 * (utf8.len(var_259_29) / 38)

				if (38 <= 0 and var_259_26 or var_259_26 * (utf8.len(var_259_29) / 38)) > 0 and var_259_26 < var_259_31 then
					arg_256_1.talkMaxDuration = var_259_31
					var_259_25 = var_259_25 + 0.3

					if var_259_31 + var_259_25 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_31 + var_259_25
					end
				end

				arg_256_1.text_.text = var_259_29
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282061", "story_v_out_318282.awb") ~= 0 then
					local var_259_32 = manager.audio:GetVoiceLength("story_v_out_318282", "318282061", "story_v_out_318282.awb") / 1000

					if var_259_32 + var_259_25 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_32 + var_259_25
					end

					if var_259_28.prefab_name ~= "" and arg_256_1.actors_[var_259_28.prefab_name] ~= nil then
						local var_259_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_28.prefab_name].transform, "story_v_out_318282", "318282061", "story_v_out_318282.awb")

						arg_256_1:RecordAudio("318282061", var_259_33)
						arg_256_1:RecordAudio("318282061", var_259_33)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_318282", "318282061", "story_v_out_318282.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_318282", "318282061", "story_v_out_318282.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_34 = var_259_25 + 0.3
			local var_259_35 = math.max(var_259_26, arg_256_1.talkMaxDuration)

			if var_259_25 + 0.3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_34 + var_259_35 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_34) / var_259_35

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_34 + var_259_35 and arg_256_1.time_ < var_259_34 + var_259_35 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play318282062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 318282062
		arg_262_1.duration_ = 8.87

		local var_262_0 = {
			zh = 6.8,
			ja = 8.866
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play318282063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos10014ui_story = arg_262_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10014ui_story"].transform.position).z)
				arg_262_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["10014ui_story"].transform.localEulerAngles = arg_262_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_262_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10014ui_story"].transform.position).z)
				arg_262_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["10014ui_story"].transform.localEulerAngles = arg_262_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_265_1 = arg_262_1.actors_["10014ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect10014ui_story == nil then
				arg_262_1.var_.characterEffect10014ui_story = var_265_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 and not isNil(var_265_1) then
				if arg_262_1.var_.characterEffect10014ui_story and not isNil(var_265_1) then
					arg_262_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect10014ui_story then
				arg_262_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_265_4 = 0
			local var_265_5 = 0.875

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_6 = arg_262_1:GetWordFromCfg(318282062)
				local var_265_7 = arg_262_1:FormatText(var_265_6.content)

				arg_262_1.text_.text = var_265_7

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 35 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 35)

				if (35 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 35)) > 0 and var_265_5 < var_265_9 then
					arg_262_1.talkMaxDuration = var_265_9

					if var_265_9 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_4
					end
				end

				arg_262_1.text_.text = var_265_7
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282062", "story_v_out_318282.awb") ~= 0 then
					local var_265_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282062", "story_v_out_318282.awb") / 1000

					if var_265_10 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_4
					end

					if var_265_6.prefab_name ~= "" and arg_262_1.actors_[var_265_6.prefab_name] ~= nil then
						local var_265_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_6.prefab_name].transform, "story_v_out_318282", "318282062", "story_v_out_318282.awb")

						arg_262_1:RecordAudio("318282062", var_265_11)
						arg_262_1:RecordAudio("318282062", var_265_11)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_318282", "318282062", "story_v_out_318282.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_318282", "318282062", "story_v_out_318282.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_5, arg_262_1.talkMaxDuration)

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_4) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_4 + var_265_12 and arg_262_1.time_ < var_265_4 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play318282063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 318282063
		arg_266_1.duration_ = 8

		local var_266_0 = {
			zh = 8,
			ja = 4.966
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play318282064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1015ui_story = arg_266_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1015ui_story"].transform.position).z)
				arg_266_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1015ui_story"].transform.localEulerAngles = arg_266_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_266_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1015ui_story"].transform.position).z)
				arg_266_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1015ui_story"].transform.localEulerAngles = arg_266_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1015ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1015ui_story == nil then
				arg_266_1.var_.characterEffect1015ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1015ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1015ui_story then
				arg_266_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_269_4 = arg_266_1.actors_["10014ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos10014ui_story = var_269_4.localPosition
			end

			local var_269_5 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_5 then
				var_269_4.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_5)
				var_269_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_4.position).x, (manager.ui.mainCamera.transform.position - var_269_4.position).y, (manager.ui.mainCamera.transform.position - var_269_4.position).z)
				var_269_4.localEulerAngles.z = 0
				var_269_4.localEulerAngles.x = 0
				var_269_4.localEulerAngles = var_269_4.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_5 and arg_266_1.time_ < 0 + var_269_5 + arg_269_0 then
				var_269_4.localPosition = Vector3.New(0, 100, 0)
				var_269_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_4.position).x, (manager.ui.mainCamera.transform.position - var_269_4.position).y, (manager.ui.mainCamera.transform.position - var_269_4.position).z)
				var_269_4.localEulerAngles.z = 0
				var_269_4.localEulerAngles.x = 0
				var_269_4.localEulerAngles = var_269_4.localEulerAngles
			end

			local var_269_6 = arg_266_1.actors_["10014ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_6) and arg_266_1.var_.characterEffect10014ui_story == nil then
				arg_266_1.var_.characterEffect10014ui_story = var_269_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_7 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 and not isNil(var_269_6) then
				if arg_266_1.var_.characterEffect10014ui_story and not isNil(var_269_6) then
					arg_266_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_7)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 and not isNil(var_269_6) and arg_266_1.var_.characterEffect10014ui_story then
				arg_266_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_269_8 = 0
			local var_269_9 = 0.875

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_8 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_10 = arg_266_1:GetWordFromCfg(318282063)
				local var_269_11 = arg_266_1:FormatText(var_269_10.content)

				arg_266_1.text_.text = var_269_11

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_13 = 35 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 35)

				if (35 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 35)) > 0 and var_269_9 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_8
					end
				end

				arg_266_1.text_.text = var_269_11
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282063", "story_v_out_318282.awb") ~= 0 then
					local var_269_14 = manager.audio:GetVoiceLength("story_v_out_318282", "318282063", "story_v_out_318282.awb") / 1000

					if var_269_14 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_14 + var_269_8
					end

					if var_269_10.prefab_name ~= "" and arg_266_1.actors_[var_269_10.prefab_name] ~= nil then
						local var_269_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_10.prefab_name].transform, "story_v_out_318282", "318282063", "story_v_out_318282.awb")

						arg_266_1:RecordAudio("318282063", var_269_15)
						arg_266_1:RecordAudio("318282063", var_269_15)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_318282", "318282063", "story_v_out_318282.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_318282", "318282063", "story_v_out_318282.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_9, arg_266_1.talkMaxDuration)

			if var_269_8 <= arg_266_1.time_ and arg_266_1.time_ < var_269_8 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_8) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_8 + var_269_16 and arg_266_1.time_ < var_269_8 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play318282064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 318282064
		arg_270_1.duration_ = 4.4

		local var_270_0 = {
			zh = 3.5,
			ja = 4.4
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play318282065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_273_0 = 0
			local var_273_1 = 0.325

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_2 = arg_270_1:GetWordFromCfg(318282064)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 13 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_3) / 13)

				if (13 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_3) / 13)) > 0 and var_273_1 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282064", "story_v_out_318282.awb") ~= 0 then
					local var_273_6 = manager.audio:GetVoiceLength("story_v_out_318282", "318282064", "story_v_out_318282.awb") / 1000

					if var_273_6 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_0
					end

					if var_273_2.prefab_name ~= "" and arg_270_1.actors_[var_273_2.prefab_name] ~= nil then
						local var_273_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_2.prefab_name].transform, "story_v_out_318282", "318282064", "story_v_out_318282.awb")

						arg_270_1:RecordAudio("318282064", var_273_7)
						arg_270_1:RecordAudio("318282064", var_273_7)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_318282", "318282064", "story_v_out_318282.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_318282", "318282064", "story_v_out_318282.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play318282065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 318282065
		arg_274_1.duration_ = 1.7

		local var_274_0 = {
			zh = 1.233,
			ja = 1.7
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play318282066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos10014ui_story = arg_274_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10014ui_story"].transform.position).z)
				arg_274_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["10014ui_story"].transform.localEulerAngles = arg_274_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_274_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10014ui_story"].transform.position).z)
				arg_274_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["10014ui_story"].transform.localEulerAngles = arg_274_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["10014ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect10014ui_story == nil then
				arg_274_1.var_.characterEffect10014ui_story = var_277_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 and not isNil(var_277_1) then
				if arg_274_1.var_.characterEffect10014ui_story and not isNil(var_277_1) then
					arg_274_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect10014ui_story then
				arg_274_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_277_4 = arg_274_1.actors_["1015ui_story"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1015ui_story = var_277_4.localPosition
			end

			local var_277_5 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_5 then
				var_277_4.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_5)
				var_277_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_4.position).x, (manager.ui.mainCamera.transform.position - var_277_4.position).y, (manager.ui.mainCamera.transform.position - var_277_4.position).z)
				var_277_4.localEulerAngles.z = 0
				var_277_4.localEulerAngles.x = 0
				var_277_4.localEulerAngles = var_277_4.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_5 and arg_274_1.time_ < 0 + var_277_5 + arg_277_0 then
				var_277_4.localPosition = Vector3.New(0, 100, 0)
				var_277_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_4.position).x, (manager.ui.mainCamera.transform.position - var_277_4.position).y, (manager.ui.mainCamera.transform.position - var_277_4.position).z)
				var_277_4.localEulerAngles.z = 0
				var_277_4.localEulerAngles.x = 0
				var_277_4.localEulerAngles = var_277_4.localEulerAngles
			end

			local var_277_6 = arg_274_1.actors_["1015ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_6) and arg_274_1.var_.characterEffect1015ui_story == nil then
				arg_274_1.var_.characterEffect1015ui_story = var_277_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_7 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 and not isNil(var_277_6) then
				if arg_274_1.var_.characterEffect1015ui_story and not isNil(var_277_6) then
					arg_274_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_7)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 and not isNil(var_277_6) and arg_274_1.var_.characterEffect1015ui_story then
				arg_274_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_277_8 = 0
			local var_277_9 = 0.1

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_10 = arg_274_1:GetWordFromCfg(318282065)
				local var_277_11 = arg_274_1:FormatText(var_277_10.content)

				arg_274_1.text_.text = var_277_11

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_13 = 4 <= 0 and var_277_9 or var_277_9 * (utf8.len(var_277_11) / 4)

				if (4 <= 0 and var_277_9 or var_277_9 * (utf8.len(var_277_11) / 4)) > 0 and var_277_9 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_8
					end
				end

				arg_274_1.text_.text = var_277_11
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282065", "story_v_out_318282.awb") ~= 0 then
					local var_277_14 = manager.audio:GetVoiceLength("story_v_out_318282", "318282065", "story_v_out_318282.awb") / 1000

					if var_277_14 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_14 + var_277_8
					end

					if var_277_10.prefab_name ~= "" and arg_274_1.actors_[var_277_10.prefab_name] ~= nil then
						local var_277_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_10.prefab_name].transform, "story_v_out_318282", "318282065", "story_v_out_318282.awb")

						arg_274_1:RecordAudio("318282065", var_277_15)
						arg_274_1:RecordAudio("318282065", var_277_15)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_318282", "318282065", "story_v_out_318282.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_318282", "318282065", "story_v_out_318282.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_9, arg_274_1.talkMaxDuration)

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_8) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_8 + var_277_16 and arg_274_1.time_ < var_277_8 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play318282066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 318282066
		arg_278_1.duration_ = 9.33

		local var_278_0 = {
			zh = 7.7,
			ja = 9.333
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play318282067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1015ui_story = arg_278_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1015ui_story"].transform.position).z)
				arg_278_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1015ui_story"].transform.localEulerAngles = arg_278_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_278_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1015ui_story"].transform.position).z)
				arg_278_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1015ui_story"].transform.localEulerAngles = arg_278_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1015ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1015ui_story == nil then
				arg_278_1.var_.characterEffect1015ui_story = var_281_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_2 and not isNil(var_281_1) then
				if arg_278_1.var_.characterEffect1015ui_story and not isNil(var_281_1) then
					arg_278_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_2 and arg_278_1.time_ < 0 + var_281_2 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1015ui_story then
				arg_278_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_281_4 = arg_278_1.actors_["10014ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos10014ui_story = var_281_4.localPosition
			end

			local var_281_5 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_5 then
				var_281_4.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 0) / var_281_5)
				var_281_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_4.position).x, (manager.ui.mainCamera.transform.position - var_281_4.position).y, (manager.ui.mainCamera.transform.position - var_281_4.position).z)
				var_281_4.localEulerAngles.z = 0
				var_281_4.localEulerAngles.x = 0
				var_281_4.localEulerAngles = var_281_4.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_5 and arg_278_1.time_ < 0 + var_281_5 + arg_281_0 then
				var_281_4.localPosition = Vector3.New(0, 100, 0)
				var_281_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_4.position).x, (manager.ui.mainCamera.transform.position - var_281_4.position).y, (manager.ui.mainCamera.transform.position - var_281_4.position).z)
				var_281_4.localEulerAngles.z = 0
				var_281_4.localEulerAngles.x = 0
				var_281_4.localEulerAngles = var_281_4.localEulerAngles
			end

			local var_281_6 = arg_278_1.actors_["10014ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10014ui_story == nil then
				arg_278_1.var_.characterEffect10014ui_story = var_281_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_7 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 and not isNil(var_281_6) then
				if arg_278_1.var_.characterEffect10014ui_story and not isNil(var_281_6) then
					arg_278_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_278_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_7)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10014ui_story then
				arg_278_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_278_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_281_8 = 0
			local var_281_9 = 0.95

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_10 = arg_278_1:GetWordFromCfg(318282066)
				local var_281_11 = arg_278_1:FormatText(var_281_10.content)

				arg_278_1.text_.text = var_281_11

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_13 = 38 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 38)

				if (38 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 38)) > 0 and var_281_9 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_8
					end
				end

				arg_278_1.text_.text = var_281_11
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282066", "story_v_out_318282.awb") ~= 0 then
					local var_281_14 = manager.audio:GetVoiceLength("story_v_out_318282", "318282066", "story_v_out_318282.awb") / 1000

					if var_281_14 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_14 + var_281_8
					end

					if var_281_10.prefab_name ~= "" and arg_278_1.actors_[var_281_10.prefab_name] ~= nil then
						local var_281_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_10.prefab_name].transform, "story_v_out_318282", "318282066", "story_v_out_318282.awb")

						arg_278_1:RecordAudio("318282066", var_281_15)
						arg_278_1:RecordAudio("318282066", var_281_15)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_318282", "318282066", "story_v_out_318282.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_318282", "318282066", "story_v_out_318282.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_16 = math.max(var_281_9, arg_278_1.talkMaxDuration)

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_16 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_8) / var_281_16

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_8 + var_281_16 and arg_278_1.time_ < var_281_8 + var_281_16 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play318282067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 318282067
		arg_282_1.duration_ = 6.3

		local var_282_0 = {
			zh = 6.066,
			ja = 6.3
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play318282068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if arg_282_1.bgs_.ST69 == nil then
				local var_285_0 = Object.Instantiate(arg_282_1.paintGo_)

				var_285_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST69")
				var_285_0.name = "ST69"
				var_285_0.transform.parent = arg_282_1.stage_.transform
				var_285_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.bgs_.ST69 = var_285_0
			end

			if 2 < arg_282_1.time_ and arg_282_1.time_ <= 2 + arg_285_0 then
				local var_285_1 = arg_282_1.bgs_.ST69

				arg_282_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_285_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_2 = var_285_1:GetComponent("SpriteRenderer")

				if var_285_2 and var_285_2.sprite then
					local var_285_3 = 2 * (var_285_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_285_1.transform.localScale = Vector3.New(var_285_3 / var_285_2.sprite.bounds.size.y < var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x and var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x or var_285_3 / var_285_2.sprite.bounds.size.y, var_285_3 / var_285_2.sprite.bounds.size.y < var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x and var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x or var_285_3 / var_285_2.sprite.bounds.size.y, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "ST69" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_4 = 0

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_5 = 2

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_5 then
				local var_285_6 = Color.New(0, 0, 0)

				var_285_6.a = Mathf.Lerp(0, 1, (arg_282_1.time_ - var_285_4) / var_285_5)
				arg_282_1.mask_.color = var_285_6
			end

			if arg_282_1.time_ >= var_285_4 + var_285_5 and arg_282_1.time_ < var_285_4 + var_285_5 + arg_285_0 then
				local var_285_7 = Color.New(0, 0, 0)

				var_285_7.a = 1
				arg_282_1.mask_.color = var_285_7
			end

			local var_285_8 = 2

			if 2 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_9 = 2

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_9 then
				local var_285_10 = Color.New(0, 0, 0)

				var_285_10.a = Mathf.Lerp(1, 0, (arg_282_1.time_ - var_285_8) / var_285_9)
				arg_282_1.mask_.color = var_285_10
			end

			if arg_282_1.time_ >= var_285_8 + var_285_9 and arg_282_1.time_ < var_285_8 + var_285_9 + arg_285_0 then
				local var_285_11 = Color.New(0, 0, 0)

				arg_282_1.mask_.enabled = false
				var_285_11.a = 0
				arg_282_1.mask_.color = var_285_11
			end

			local var_285_12 = arg_282_1.actors_["1015ui_story"].transform

			if 1.96599999815226 < arg_282_1.time_ and arg_282_1.time_ <= 1.96599999815226 + arg_285_0 then
				arg_282_1.var_.moveOldPos1015ui_story = var_285_12.localPosition
			end

			local var_285_13 = 0.001

			if 1.96599999815226 <= arg_282_1.time_ and arg_282_1.time_ < 1.96599999815226 + var_285_13 then
				var_285_12.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 1.96599999815226) / var_285_13)
				var_285_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_12.position).x, (manager.ui.mainCamera.transform.position - var_285_12.position).y, (manager.ui.mainCamera.transform.position - var_285_12.position).z)
				var_285_12.localEulerAngles.z = 0
				var_285_12.localEulerAngles.x = 0
				var_285_12.localEulerAngles = var_285_12.localEulerAngles
			end

			if arg_282_1.time_ >= 1.96599999815226 + var_285_13 and arg_282_1.time_ < 1.96599999815226 + var_285_13 + arg_285_0 then
				var_285_12.localPosition = Vector3.New(0, 100, 0)
				var_285_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_12.position).x, (manager.ui.mainCamera.transform.position - var_285_12.position).y, (manager.ui.mainCamera.transform.position - var_285_12.position).z)
				var_285_12.localEulerAngles.z = 0
				var_285_12.localEulerAngles.x = 0
				var_285_12.localEulerAngles = var_285_12.localEulerAngles
			end

			local var_285_14 = arg_282_1.actors_["1015ui_story"]

			if 1.96599999815226 < arg_282_1.time_ and arg_282_1.time_ <= 1.96599999815226 + arg_285_0 and not isNil(var_285_14) and arg_282_1.var_.characterEffect1015ui_story == nil then
				arg_282_1.var_.characterEffect1015ui_story = var_285_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_15 = 0.034000001847744

			if 1.96599999815226 <= arg_282_1.time_ and arg_282_1.time_ < 1.96599999815226 + var_285_15 and not isNil(var_285_14) then
				if arg_282_1.var_.characterEffect1015ui_story and not isNil(var_285_14) then
					arg_282_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 1.96599999815226) / var_285_15)
				end
			end

			if arg_282_1.time_ >= 1.96599999815226 + var_285_15 and arg_282_1.time_ < 1.96599999815226 + var_285_15 + arg_285_0 and not isNil(var_285_14) and arg_282_1.var_.characterEffect1015ui_story then
				arg_282_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_16 = 4
			local var_285_17 = 0.25

			if 4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_18 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_18:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_19 = arg_282_1:GetWordFromCfg(318282067)
				local var_285_20 = arg_282_1:FormatText(var_285_19.content)

				arg_282_1.text_.text = var_285_20

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_22 = 10 <= 0 and var_285_17 or var_285_17 * (utf8.len(var_285_20) / 10)

				if (10 <= 0 and var_285_17 or var_285_17 * (utf8.len(var_285_20) / 10)) > 0 and var_285_17 < var_285_22 then
					arg_282_1.talkMaxDuration = var_285_22
					var_285_16 = var_285_16 + 0.3

					if var_285_22 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_22 + var_285_16
					end
				end

				arg_282_1.text_.text = var_285_20
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282067", "story_v_out_318282.awb") ~= 0 then
					local var_285_23 = manager.audio:GetVoiceLength("story_v_out_318282", "318282067", "story_v_out_318282.awb") / 1000

					if var_285_23 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_16
					end

					if var_285_19.prefab_name ~= "" and arg_282_1.actors_[var_285_19.prefab_name] ~= nil then
						local var_285_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_19.prefab_name].transform, "story_v_out_318282", "318282067", "story_v_out_318282.awb")

						arg_282_1:RecordAudio("318282067", var_285_24)
						arg_282_1:RecordAudio("318282067", var_285_24)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_318282", "318282067", "story_v_out_318282.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_318282", "318282067", "story_v_out_318282.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_25 = var_285_16 + 0.3
			local var_285_26 = math.max(var_285_17, arg_282_1.talkMaxDuration)

			if var_285_16 + 0.3 <= arg_282_1.time_ and arg_282_1.time_ < var_285_25 + var_285_26 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_25) / var_285_26

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_25 + var_285_26 and arg_282_1.time_ < var_285_25 + var_285_26 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play318282068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 318282068
		arg_288_1.duration_ = 2.7

		local var_288_0 = {
			zh = 1.6,
			ja = 2.7
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play318282069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1015ui_story = arg_288_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_291_0 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).z)
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles = arg_288_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_288_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).z)
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles = arg_288_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_291_1 = arg_288_1.actors_["1015ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1015ui_story == nil then
				arg_288_1.var_.characterEffect1015ui_story = var_291_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 and not isNil(var_291_1) then
				if arg_288_1.var_.characterEffect1015ui_story and not isNil(var_291_1) then
					arg_288_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1015ui_story then
				arg_288_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_291_4 = 0
			local var_291_5 = 0.125

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:GetWordFromCfg(318282068)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 5 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 5)

				if (5 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 5)) > 0 and var_291_5 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282068", "story_v_out_318282.awb") ~= 0 then
					local var_291_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282068", "story_v_out_318282.awb") / 1000

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end

					if var_291_6.prefab_name ~= "" and arg_288_1.actors_[var_291_6.prefab_name] ~= nil then
						local var_291_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_6.prefab_name].transform, "story_v_out_318282", "318282068", "story_v_out_318282.awb")

						arg_288_1:RecordAudio("318282068", var_291_11)
						arg_288_1:RecordAudio("318282068", var_291_11)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_318282", "318282068", "story_v_out_318282.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_318282", "318282068", "story_v_out_318282.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_12 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_12 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_12

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_12 and arg_288_1.time_ < var_291_4 + var_291_12 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play318282069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 318282069
		arg_292_1.duration_ = 3

		local var_292_0 = {
			zh = 2.6,
			ja = 3
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play318282070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1015ui_story = arg_292_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_295_0 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 then
				arg_292_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_0)
				arg_292_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1015ui_story"].transform.position).z)
				arg_292_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1015ui_story"].transform.localEulerAngles = arg_292_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 then
				arg_292_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1015ui_story"].transform.position).z)
				arg_292_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1015ui_story"].transform.localEulerAngles = arg_292_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_295_1 = arg_292_1.actors_["1015ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1015ui_story == nil then
				arg_292_1.var_.characterEffect1015ui_story = var_295_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_2 and not isNil(var_295_1) then
				if arg_292_1.var_.characterEffect1015ui_story and not isNil(var_295_1) then
					arg_292_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_2)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_2 and arg_292_1.time_ < 0 + var_295_2 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1015ui_story then
				arg_292_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_295_3 = 0
			local var_295_4 = 0.375

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_3 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_5 = arg_292_1:GetWordFromCfg(318282069)
				local var_295_6 = arg_292_1:FormatText(var_295_5.content)

				arg_292_1.text_.text = var_295_6

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_8 = 15 <= 0 and var_295_4 or var_295_4 * (utf8.len(var_295_6) / 15)

				if (15 <= 0 and var_295_4 or var_295_4 * (utf8.len(var_295_6) / 15)) > 0 and var_295_4 < var_295_8 then
					arg_292_1.talkMaxDuration = var_295_8

					if var_295_8 + var_295_3 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_3
					end
				end

				arg_292_1.text_.text = var_295_6
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282069", "story_v_out_318282.awb") ~= 0 then
					local var_295_9 = manager.audio:GetVoiceLength("story_v_out_318282", "318282069", "story_v_out_318282.awb") / 1000

					if var_295_9 + var_295_3 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_3
					end

					if var_295_5.prefab_name ~= "" and arg_292_1.actors_[var_295_5.prefab_name] ~= nil then
						local var_295_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_5.prefab_name].transform, "story_v_out_318282", "318282069", "story_v_out_318282.awb")

						arg_292_1:RecordAudio("318282069", var_295_10)
						arg_292_1:RecordAudio("318282069", var_295_10)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_318282", "318282069", "story_v_out_318282.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_318282", "318282069", "story_v_out_318282.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_11 = math.max(var_295_4, arg_292_1.talkMaxDuration)

			if var_295_3 <= arg_292_1.time_ and arg_292_1.time_ < var_295_3 + var_295_11 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_3) / var_295_11

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_3 + var_295_11 and arg_292_1.time_ < var_295_3 + var_295_11 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play318282070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 318282070
		arg_296_1.duration_ = 4.97

		local var_296_0 = {
			zh = 4.966,
			ja = 4.9
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play318282071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1015ui_story = arg_296_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1015ui_story"].transform.position).z)
				arg_296_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1015ui_story"].transform.localEulerAngles = arg_296_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_296_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1015ui_story"].transform.position).z)
				arg_296_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1015ui_story"].transform.localEulerAngles = arg_296_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1015ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1015ui_story == nil then
				arg_296_1.var_.characterEffect1015ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect1015ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1015ui_story then
				arg_296_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_4 = 0
			local var_299_5 = 0.575

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(318282070)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 23 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 23)

				if (23 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 23)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282070", "story_v_out_318282.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282070", "story_v_out_318282.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_out_318282", "318282070", "story_v_out_318282.awb")

						arg_296_1:RecordAudio("318282070", var_299_11)
						arg_296_1:RecordAudio("318282070", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_318282", "318282070", "story_v_out_318282.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_318282", "318282070", "story_v_out_318282.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play318282071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 318282071
		arg_300_1.duration_ = 6.7

		local var_300_0 = {
			zh = 6.666,
			ja = 6.7
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play318282072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_303_0 = 0
			local var_303_1 = 0.8

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(318282071)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 32 <= 0 and var_303_1 or var_303_1 * (utf8.len(var_303_3) / 32)

				if (32 <= 0 and var_303_1 or var_303_1 * (utf8.len(var_303_3) / 32)) > 0 and var_303_1 < var_303_5 then
					arg_300_1.talkMaxDuration = var_303_5

					if var_303_5 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282071", "story_v_out_318282.awb") ~= 0 then
					local var_303_6 = manager.audio:GetVoiceLength("story_v_out_318282", "318282071", "story_v_out_318282.awb") / 1000

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end

					if var_303_2.prefab_name ~= "" and arg_300_1.actors_[var_303_2.prefab_name] ~= nil then
						local var_303_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_2.prefab_name].transform, "story_v_out_318282", "318282071", "story_v_out_318282.awb")

						arg_300_1:RecordAudio("318282071", var_303_7)
						arg_300_1:RecordAudio("318282071", var_303_7)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_318282", "318282071", "story_v_out_318282.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_318282", "318282071", "story_v_out_318282.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_8 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_8 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_8

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_8 and arg_300_1.time_ < var_303_0 + var_303_8 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play318282072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 318282072
		arg_304_1.duration_ = 9

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play318282073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if arg_304_1.bgs_.K16f == nil then
				local var_307_0 = Object.Instantiate(arg_304_1.paintGo_)

				var_307_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16f")
				var_307_0.name = "K16f"
				var_307_0.transform.parent = arg_304_1.stage_.transform
				var_307_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.bgs_.K16f = var_307_0
			end

			if 2 < arg_304_1.time_ and arg_304_1.time_ <= 2 + arg_307_0 then
				local var_307_1 = arg_304_1.bgs_.K16f

				arg_304_1.bgs_.K16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_307_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_307_2 = var_307_1:GetComponent("SpriteRenderer")

				if var_307_2 and var_307_2.sprite then
					local var_307_3 = 2 * (var_307_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_307_1.transform.localScale = Vector3.New(var_307_3 / var_307_2.sprite.bounds.size.y < var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x and var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x or var_307_3 / var_307_2.sprite.bounds.size.y, var_307_3 / var_307_2.sprite.bounds.size.y < var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x and var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x or var_307_3 / var_307_2.sprite.bounds.size.y, 0)
				end

				for iter_307_0, iter_307_1 in pairs(arg_304_1.bgs_) do
					if iter_307_0 ~= "K16f" then
						iter_307_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_307_4 = 0

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_5 = 2

			if var_307_4 <= arg_304_1.time_ and arg_304_1.time_ < var_307_4 + var_307_5 then
				local var_307_6 = Color.New(0, 0, 0)

				var_307_6.a = Mathf.Lerp(0, 1, (arg_304_1.time_ - var_307_4) / var_307_5)
				arg_304_1.mask_.color = var_307_6
			end

			if arg_304_1.time_ >= var_307_4 + var_307_5 and arg_304_1.time_ < var_307_4 + var_307_5 + arg_307_0 then
				local var_307_7 = Color.New(0, 0, 0)

				var_307_7.a = 1
				arg_304_1.mask_.color = var_307_7
			end

			local var_307_8 = 2

			if 2 < arg_304_1.time_ and arg_304_1.time_ <= var_307_8 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_9 = 2

			if var_307_8 <= arg_304_1.time_ and arg_304_1.time_ < var_307_8 + var_307_9 then
				local var_307_10 = Color.New(0, 0, 0)

				var_307_10.a = Mathf.Lerp(1, 0, (arg_304_1.time_ - var_307_8) / var_307_9)
				arg_304_1.mask_.color = var_307_10
			end

			if arg_304_1.time_ >= var_307_8 + var_307_9 and arg_304_1.time_ < var_307_8 + var_307_9 + arg_307_0 then
				local var_307_11 = Color.New(0, 0, 0)

				arg_304_1.mask_.enabled = false
				var_307_11.a = 0
				arg_304_1.mask_.color = var_307_11
			end

			local var_307_12 = arg_304_1.actors_["1015ui_story"].transform

			if 1.96599999815226 < arg_304_1.time_ and arg_304_1.time_ <= 1.96599999815226 + arg_307_0 then
				arg_304_1.var_.moveOldPos1015ui_story = var_307_12.localPosition
			end

			local var_307_13 = 0.001

			if 1.96599999815226 <= arg_304_1.time_ and arg_304_1.time_ < 1.96599999815226 + var_307_13 then
				var_307_12.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_304_1.time_ - 1.96599999815226) / var_307_13)
				var_307_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_12.position).x, (manager.ui.mainCamera.transform.position - var_307_12.position).y, (manager.ui.mainCamera.transform.position - var_307_12.position).z)
				var_307_12.localEulerAngles.z = 0
				var_307_12.localEulerAngles.x = 0
				var_307_12.localEulerAngles = var_307_12.localEulerAngles
			end

			if arg_304_1.time_ >= 1.96599999815226 + var_307_13 and arg_304_1.time_ < 1.96599999815226 + var_307_13 + arg_307_0 then
				var_307_12.localPosition = Vector3.New(0, 100, 0)
				var_307_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_12.position).x, (manager.ui.mainCamera.transform.position - var_307_12.position).y, (manager.ui.mainCamera.transform.position - var_307_12.position).z)
				var_307_12.localEulerAngles.z = 0
				var_307_12.localEulerAngles.x = 0
				var_307_12.localEulerAngles = var_307_12.localEulerAngles
			end

			local var_307_14 = arg_304_1.actors_["1015ui_story"]

			if 1.96599999815226 < arg_304_1.time_ and arg_304_1.time_ <= 1.96599999815226 + arg_307_0 and not isNil(var_307_14) and arg_304_1.var_.characterEffect1015ui_story == nil then
				arg_304_1.var_.characterEffect1015ui_story = var_307_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_15 = 0.034000001847744

			if 1.96599999815226 <= arg_304_1.time_ and arg_304_1.time_ < 1.96599999815226 + var_307_15 and not isNil(var_307_14) then
				if arg_304_1.var_.characterEffect1015ui_story and not isNil(var_307_14) then
					arg_304_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 1.96599999815226) / var_307_15)
				end
			end

			if arg_304_1.time_ >= 1.96599999815226 + var_307_15 and arg_304_1.time_ < 1.96599999815226 + var_307_15 + arg_307_0 and not isNil(var_307_14) and arg_304_1.var_.characterEffect1015ui_story then
				arg_304_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if arg_304_1.frameCnt_ <= 1 then
				arg_304_1.dialog_:SetActive(false)
			end

			local var_307_16 = 4
			local var_307_17 = 0.325

			if 4 < arg_304_1.time_ and arg_304_1.time_ <= var_307_16 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				arg_304_1.dialog_:SetActive(true)

				arg_304_1.dialogCg_.alpha = 0

				local var_307_18 = LeanTween.value(arg_304_1.dialog_, 0, 1, 0.3)

				var_307_18:setOnUpdate(LuaHelper.FloatAction(function(arg_308_0)
					arg_304_1.dialogCg_.alpha = arg_308_0
				end))
				var_307_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_304_1.dialog_)
					var_307_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_304_1.duration_ = arg_304_1.duration_ + 0.3

				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_19 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(318282072).content)

				arg_304_1.text_.text = var_307_19

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_21 = 13 <= 0 and var_307_17 or var_307_17 * (utf8.len(var_307_19) / 13)

				if (13 <= 0 and var_307_17 or var_307_17 * (utf8.len(var_307_19) / 13)) > 0 and var_307_17 < var_307_21 then
					arg_304_1.talkMaxDuration = var_307_21
					var_307_16 = var_307_16 + 0.3

					if var_307_21 + var_307_16 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_21 + var_307_16
					end
				end

				arg_304_1.text_.text = var_307_19
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_22 = var_307_16 + 0.3
			local var_307_23 = math.max(var_307_17, arg_304_1.talkMaxDuration)

			if var_307_16 + 0.3 <= arg_304_1.time_ and arg_304_1.time_ < var_307_22 + var_307_23 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_22) / var_307_23

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_22 + var_307_23 and arg_304_1.time_ < var_307_22 + var_307_23 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play318282073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 318282073
		arg_310_1.duration_ = 3.3

		local var_310_0 = {
			zh = 3.3,
			ja = 3.166
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play318282074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1015ui_story = arg_310_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_313_0 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				arg_310_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_310_1.time_ - 0) / var_313_0)
				arg_310_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1015ui_story"].transform.position).z)
				arg_310_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1015ui_story"].transform.localEulerAngles = arg_310_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				arg_310_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_310_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1015ui_story"].transform.position).z)
				arg_310_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1015ui_story"].transform.localEulerAngles = arg_310_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_313_1 = arg_310_1.actors_["1015ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1015ui_story == nil then
				arg_310_1.var_.characterEffect1015ui_story = var_313_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_2 and not isNil(var_313_1) then
				if arg_310_1.var_.characterEffect1015ui_story and not isNil(var_313_1) then
					arg_310_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_2 and arg_310_1.time_ < 0 + var_313_2 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1015ui_story then
				arg_310_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_313_4 = 0
			local var_313_5 = 0.35

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_6 = arg_310_1:GetWordFromCfg(318282073)
				local var_313_7 = arg_310_1:FormatText(var_313_6.content)

				arg_310_1.text_.text = var_313_7

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 14 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 14)

				if (14 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 14)) > 0 and var_313_5 < var_313_9 then
					arg_310_1.talkMaxDuration = var_313_9

					if var_313_9 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_7
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282073", "story_v_out_318282.awb") ~= 0 then
					local var_313_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282073", "story_v_out_318282.awb") / 1000

					if var_313_10 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_4
					end

					if var_313_6.prefab_name ~= "" and arg_310_1.actors_[var_313_6.prefab_name] ~= nil then
						local var_313_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_6.prefab_name].transform, "story_v_out_318282", "318282073", "story_v_out_318282.awb")

						arg_310_1:RecordAudio("318282073", var_313_11)
						arg_310_1:RecordAudio("318282073", var_313_11)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_318282", "318282073", "story_v_out_318282.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_318282", "318282073", "story_v_out_318282.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_12 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_12 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_12

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_12 and arg_310_1.time_ < var_313_4 + var_313_12 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play318282074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 318282074
		arg_314_1.duration_ = 8.5

		local var_314_0 = {
			zh = 8,
			ja = 8.5
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play318282075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 2 < arg_314_1.time_ and arg_314_1.time_ <= 2 + arg_317_0 then
				local var_317_0 = arg_314_1.bgs_.STblack

				arg_314_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_317_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_317_1 = var_317_0:GetComponent("SpriteRenderer")

				if var_317_1 and var_317_1.sprite then
					local var_317_2 = 2 * (var_317_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_317_0.transform.localScale = Vector3.New(var_317_2 / var_317_1.sprite.bounds.size.y < var_317_2 * manager.ui.mainCameraCom_.aspect / var_317_1.sprite.bounds.size.x and var_317_2 * manager.ui.mainCameraCom_.aspect / var_317_1.sprite.bounds.size.x or var_317_2 / var_317_1.sprite.bounds.size.y, var_317_2 / var_317_1.sprite.bounds.size.y < var_317_2 * manager.ui.mainCameraCom_.aspect / var_317_1.sprite.bounds.size.x and var_317_2 * manager.ui.mainCameraCom_.aspect / var_317_1.sprite.bounds.size.x or var_317_2 / var_317_1.sprite.bounds.size.y, 0)
				end

				for iter_317_0, iter_317_1 in pairs(arg_314_1.bgs_) do
					if iter_317_0 ~= "STblack" then
						iter_317_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_317_3 = 0

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_3 + arg_317_0 then
				arg_314_1.mask_.enabled = true
				arg_314_1.mask_.raycastTarget = true

				arg_314_1:SetGaussion(false)
			end

			local var_317_4 = 2

			if var_317_3 <= arg_314_1.time_ and arg_314_1.time_ < var_317_3 + var_317_4 then
				local var_317_5 = Color.New(0, 0, 0)

				var_317_5.a = Mathf.Lerp(0, 1, (arg_314_1.time_ - var_317_3) / var_317_4)
				arg_314_1.mask_.color = var_317_5
			end

			if arg_314_1.time_ >= var_317_3 + var_317_4 and arg_314_1.time_ < var_317_3 + var_317_4 + arg_317_0 then
				local var_317_6 = Color.New(0, 0, 0)

				var_317_6.a = 1
				arg_314_1.mask_.color = var_317_6
			end

			local var_317_7 = 2

			if 2 < arg_314_1.time_ and arg_314_1.time_ <= var_317_7 + arg_317_0 then
				arg_314_1.mask_.enabled = true
				arg_314_1.mask_.raycastTarget = true

				arg_314_1:SetGaussion(false)
			end

			local var_317_8 = 2

			if var_317_7 <= arg_314_1.time_ and arg_314_1.time_ < var_317_7 + var_317_8 then
				local var_317_9 = Color.New(0, 0, 0)

				var_317_9.a = Mathf.Lerp(1, 0, (arg_314_1.time_ - var_317_7) / var_317_8)
				arg_314_1.mask_.color = var_317_9
			end

			if arg_314_1.time_ >= var_317_7 + var_317_8 and arg_314_1.time_ < var_317_7 + var_317_8 + arg_317_0 then
				local var_317_10 = Color.New(0, 0, 0)

				arg_314_1.mask_.enabled = false
				var_317_10.a = 0
				arg_314_1.mask_.color = var_317_10
			end

			local var_317_11 = arg_314_1.actors_["1015ui_story"].transform

			if 1.96599999815226 < arg_314_1.time_ and arg_314_1.time_ <= 1.96599999815226 + arg_317_0 then
				arg_314_1.var_.moveOldPos1015ui_story = var_317_11.localPosition
			end

			local var_317_12 = 0.001

			if 1.96599999815226 <= arg_314_1.time_ and arg_314_1.time_ < 1.96599999815226 + var_317_12 then
				var_317_11.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_314_1.time_ - 1.96599999815226) / var_317_12)
				var_317_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_11.position).x, (manager.ui.mainCamera.transform.position - var_317_11.position).y, (manager.ui.mainCamera.transform.position - var_317_11.position).z)
				var_317_11.localEulerAngles.z = 0
				var_317_11.localEulerAngles.x = 0
				var_317_11.localEulerAngles = var_317_11.localEulerAngles
			end

			if arg_314_1.time_ >= 1.96599999815226 + var_317_12 and arg_314_1.time_ < 1.96599999815226 + var_317_12 + arg_317_0 then
				var_317_11.localPosition = Vector3.New(0, 100, 0)
				var_317_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_11.position).x, (manager.ui.mainCamera.transform.position - var_317_11.position).y, (manager.ui.mainCamera.transform.position - var_317_11.position).z)
				var_317_11.localEulerAngles.z = 0
				var_317_11.localEulerAngles.x = 0
				var_317_11.localEulerAngles = var_317_11.localEulerAngles
			end

			local var_317_13 = arg_314_1.actors_["1015ui_story"].transform

			if 3.8 < arg_314_1.time_ and arg_314_1.time_ <= 3.8 + arg_317_0 then
				arg_314_1.var_.moveOldPos1015ui_story = var_317_13.localPosition
			end

			local var_317_14 = 0.001

			if 3.8 <= arg_314_1.time_ and arg_314_1.time_ < 3.8 + var_317_14 then
				var_317_13.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_314_1.time_ - 3.8) / var_317_14)
				var_317_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_13.position).x, (manager.ui.mainCamera.transform.position - var_317_13.position).y, (manager.ui.mainCamera.transform.position - var_317_13.position).z)
				var_317_13.localEulerAngles.z = 0
				var_317_13.localEulerAngles.x = 0
				var_317_13.localEulerAngles = var_317_13.localEulerAngles
			end

			if arg_314_1.time_ >= 3.8 + var_317_14 and arg_314_1.time_ < 3.8 + var_317_14 + arg_317_0 then
				var_317_13.localPosition = Vector3.New(0, -1.15, -6.2)
				var_317_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_13.position).x, (manager.ui.mainCamera.transform.position - var_317_13.position).y, (manager.ui.mainCamera.transform.position - var_317_13.position).z)
				var_317_13.localEulerAngles.z = 0
				var_317_13.localEulerAngles.x = 0
				var_317_13.localEulerAngles = var_317_13.localEulerAngles
			end

			local var_317_15 = arg_314_1.actors_["1015ui_story"]

			if 3.8 < arg_314_1.time_ and arg_314_1.time_ <= 3.8 + arg_317_0 and not isNil(var_317_15) and arg_314_1.var_.characterEffect1015ui_story == nil then
				arg_314_1.var_.characterEffect1015ui_story = var_317_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_16 = 0.200000002980232

			if 3.8 <= arg_314_1.time_ and arg_314_1.time_ < 3.8 + var_317_16 and not isNil(var_317_15) then
				if arg_314_1.var_.characterEffect1015ui_story and not isNil(var_317_15) then
					arg_314_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 3.8 + var_317_16 and arg_314_1.time_ < 3.8 + var_317_16 + arg_317_0 and not isNil(var_317_15) and arg_314_1.var_.characterEffect1015ui_story then
				arg_314_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 3.8 < arg_314_1.time_ and arg_314_1.time_ <= 3.8 + arg_317_0 then
				arg_314_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 3.8 < arg_314_1.time_ and arg_314_1.time_ <= 3.8 + arg_317_0 then
				arg_314_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_314_1.frameCnt_ <= 1 then
				arg_314_1.dialog_:SetActive(false)
			end

			local var_317_18 = 4
			local var_317_19 = 0.4

			if 4 < arg_314_1.time_ and arg_314_1.time_ <= var_317_18 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0

				arg_314_1.dialog_:SetActive(true)

				arg_314_1.dialogCg_.alpha = 0

				local var_317_20 = LeanTween.value(arg_314_1.dialog_, 0, 1, 0.3)

				var_317_20:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_314_1.dialogCg_.alpha = arg_318_0
				end))
				var_317_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_314_1.dialog_)
					var_317_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_314_1.duration_ = arg_314_1.duration_ + 0.3

				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_21 = arg_314_1:GetWordFromCfg(318282074)
				local var_317_22 = arg_314_1:FormatText(var_317_21.content)

				arg_314_1.text_.text = var_317_22

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_24 = 16 <= 0 and var_317_19 or var_317_19 * (utf8.len(var_317_22) / 16)

				if (16 <= 0 and var_317_19 or var_317_19 * (utf8.len(var_317_22) / 16)) > 0 and var_317_19 < var_317_24 then
					arg_314_1.talkMaxDuration = var_317_24
					var_317_18 = var_317_18 + 0.3

					if var_317_24 + var_317_18 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_24 + var_317_18
					end
				end

				arg_314_1.text_.text = var_317_22
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282074", "story_v_out_318282.awb") ~= 0 then
					local var_317_25 = manager.audio:GetVoiceLength("story_v_out_318282", "318282074", "story_v_out_318282.awb") / 1000

					if var_317_25 + var_317_18 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_25 + var_317_18
					end

					if var_317_21.prefab_name ~= "" and arg_314_1.actors_[var_317_21.prefab_name] ~= nil then
						local var_317_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_21.prefab_name].transform, "story_v_out_318282", "318282074", "story_v_out_318282.awb")

						arg_314_1:RecordAudio("318282074", var_317_26)
						arg_314_1:RecordAudio("318282074", var_317_26)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_318282", "318282074", "story_v_out_318282.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_318282", "318282074", "story_v_out_318282.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_27 = var_317_18 + 0.3
			local var_317_28 = math.max(var_317_19, arg_314_1.talkMaxDuration)

			if var_317_18 + 0.3 <= arg_314_1.time_ and arg_314_1.time_ < var_317_27 + var_317_28 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_27) / var_317_28

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_27 + var_317_28 and arg_314_1.time_ < var_317_27 + var_317_28 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play318282075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 318282075
		arg_320_1.duration_ = 5.8

		local var_320_0 = {
			zh = 5.8,
			ja = 5.766
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play318282076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_323_0 = 0
			local var_323_1 = 0.425

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_2 = arg_320_1:GetWordFromCfg(318282075)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 17 <= 0 and var_323_1 or var_323_1 * (utf8.len(var_323_3) / 17)

				if (17 <= 0 and var_323_1 or var_323_1 * (utf8.len(var_323_3) / 17)) > 0 and var_323_1 < var_323_5 then
					arg_320_1.talkMaxDuration = var_323_5

					if var_323_5 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282075", "story_v_out_318282.awb") ~= 0 then
					local var_323_6 = manager.audio:GetVoiceLength("story_v_out_318282", "318282075", "story_v_out_318282.awb") / 1000

					if var_323_6 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_0
					end

					if var_323_2.prefab_name ~= "" and arg_320_1.actors_[var_323_2.prefab_name] ~= nil then
						local var_323_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_2.prefab_name].transform, "story_v_out_318282", "318282075", "story_v_out_318282.awb")

						arg_320_1:RecordAudio("318282075", var_323_7)
						arg_320_1:RecordAudio("318282075", var_323_7)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_318282", "318282075", "story_v_out_318282.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_318282", "318282075", "story_v_out_318282.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_8 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_8 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_8

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_8 and arg_320_1.time_ < var_323_0 + var_323_8 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play318282076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 318282076
		arg_324_1.duration_ = 7

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play318282077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				local var_327_0 = arg_324_1.bgs_.K16i

				arg_324_1.bgs_.K16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_327_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_1 = var_327_0:GetComponent("SpriteRenderer")

				if var_327_1 and var_327_1.sprite then
					local var_327_2 = 2 * (var_327_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_327_0.transform.localScale = Vector3.New(var_327_2 / var_327_1.sprite.bounds.size.y < var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x and var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x or var_327_2 / var_327_1.sprite.bounds.size.y, var_327_2 / var_327_1.sprite.bounds.size.y < var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x and var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x or var_327_2 / var_327_1.sprite.bounds.size.y, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "K16i" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_3 = 2

			if 2 < arg_324_1.time_ and arg_324_1.time_ <= var_327_3 + arg_327_0 then
				arg_324_1.allBtn_.enabled = false
			end

			if arg_324_1.time_ >= var_327_3 + 0.3 and arg_324_1.time_ < var_327_3 + 0.3 + arg_327_0 then
				arg_324_1.allBtn_.enabled = true
			end

			local var_327_4 = 0

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_5 = 2

			if var_327_4 <= arg_324_1.time_ and arg_324_1.time_ < var_327_4 + var_327_5 then
				local var_327_6 = Color.New(1, 1, 1)

				var_327_6.a = Mathf.Lerp(1, 0, (arg_324_1.time_ - var_327_4) / var_327_5)
				arg_324_1.mask_.color = var_327_6
			end

			if arg_324_1.time_ >= var_327_4 + var_327_5 and arg_324_1.time_ < var_327_4 + var_327_5 + arg_327_0 then
				local var_327_7 = Color.New(1, 1, 1)

				arg_324_1.mask_.enabled = false
				var_327_7.a = 0
				arg_324_1.mask_.color = var_327_7
			end

			local var_327_8 = arg_324_1.actors_["1015ui_story"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1015ui_story = var_327_8.localPosition
			end

			local var_327_9 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_9 then
				var_327_8.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_324_1.time_ - 0) / var_327_9)
				var_327_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_8.position).x, (manager.ui.mainCamera.transform.position - var_327_8.position).y, (manager.ui.mainCamera.transform.position - var_327_8.position).z)
				var_327_8.localEulerAngles.z = 0
				var_327_8.localEulerAngles.x = 0
				var_327_8.localEulerAngles = var_327_8.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_9 and arg_324_1.time_ < 0 + var_327_9 + arg_327_0 then
				var_327_8.localPosition = Vector3.New(0, 100, 0)
				var_327_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_8.position).x, (manager.ui.mainCamera.transform.position - var_327_8.position).y, (manager.ui.mainCamera.transform.position - var_327_8.position).z)
				var_327_8.localEulerAngles.z = 0
				var_327_8.localEulerAngles.x = 0
				var_327_8.localEulerAngles = var_327_8.localEulerAngles
			end

			local var_327_10 = arg_324_1.actors_["1015ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_10) and arg_324_1.var_.characterEffect1015ui_story == nil then
				arg_324_1.var_.characterEffect1015ui_story = var_327_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_11 = 0.034000001847744

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_11 and not isNil(var_327_10) then
				if arg_324_1.var_.characterEffect1015ui_story and not isNil(var_327_10) then
					arg_324_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_11)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_11 and arg_324_1.time_ < 0 + var_327_11 + arg_327_0 and not isNil(var_327_10) and arg_324_1.var_.characterEffect1015ui_story then
				arg_324_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if arg_324_1.frameCnt_ <= 1 then
				arg_324_1.dialog_:SetActive(false)
			end

			local var_327_12 = 2
			local var_327_13 = 0.575

			if 2 < arg_324_1.time_ and arg_324_1.time_ <= var_327_12 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				arg_324_1.dialog_:SetActive(true)

				arg_324_1.dialogCg_.alpha = 0

				local var_327_14 = LeanTween.value(arg_324_1.dialog_, 0, 1, 0.3)

				var_327_14:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_324_1.dialogCg_.alpha = arg_328_0
				end))
				var_327_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_324_1.dialog_)
					var_327_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_324_1.duration_ = arg_324_1.duration_ + 0.3

				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_15 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(318282076).content)

				arg_324_1.text_.text = var_327_15

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_17 = 23 <= 0 and var_327_13 or var_327_13 * (utf8.len(var_327_15) / 23)

				if (23 <= 0 and var_327_13 or var_327_13 * (utf8.len(var_327_15) / 23)) > 0 and var_327_13 < var_327_17 then
					arg_324_1.talkMaxDuration = var_327_17
					var_327_12 = var_327_12 + 0.3

					if var_327_17 + var_327_12 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_17 + var_327_12
					end
				end

				arg_324_1.text_.text = var_327_15
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_18 = var_327_12 + 0.3
			local var_327_19 = math.max(var_327_13, arg_324_1.talkMaxDuration)

			if var_327_12 + 0.3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_18 + var_327_19 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_18) / var_327_19

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_18 + var_327_19 and arg_324_1.time_ < var_327_18 + var_327_19 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play318282077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 318282077
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play318282078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 1.25

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(318282077).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 50 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 50)

				if (50 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 50)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play318282078 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 318282078
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play318282079(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_337_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_334_1.bgmTxt_.text ~= var_337_2 and arg_334_1.bgmTxt_.text ~= "" then
						if arg_334_1.bgmTxt2_.text ~= "" then
							arg_334_1.bgmTxt_.text = arg_334_1.bgmTxt2_.text
						end

						arg_334_1.bgmTxt2_.text = var_337_2

						arg_334_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_334_1.bgmTxt_.text = var_337_2
						arg_334_1.bgmTxt2_.text = var_337_2
					end

					if arg_334_1.bgmTimer then
						arg_334_1.bgmTimer:Stop()

						arg_334_1.bgmTimer = nil
					end

					if arg_334_1.settingData.show_music_name == 1 then
						arg_334_1.musicController:SetSelectedState("show")
						arg_334_1.musicAnimator_:Play("open", 0, 0)

						if arg_334_1.settingData.music_time ~= 0 then
							arg_334_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_334_1.settingData.music_time), function()
								if arg_334_1 == nil or isNil(arg_334_1.bgmTxt_) then
									return
								end

								arg_334_1.musicController:SetSelectedState("hide")
								arg_334_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_337_3 = manager.ui.mainCamera.transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.shakeOldPos = var_337_3.localPosition
			end

			local var_337_4 = 0.6

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				local var_337_5, var_337_6 = math.modf((arg_334_1.time_ - 0) / 0.066)

				var_337_3.localPosition = Vector3.New(var_337_6 * 0.13, var_337_6 * 0.13, var_337_6 * 0.13) + arg_334_1.var_.shakeOldPos
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				var_337_3.localPosition = arg_334_1.var_.shakeOldPos
			end

			local var_337_7 = 0

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_7 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			if arg_334_1.time_ >= var_337_7 + 0.6 and arg_334_1.time_ < var_337_7 + 0.6 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_8 = 0
			local var_337_9 = 0.2

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_10 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(318282078).content)

				arg_334_1.text_.text = var_337_10

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_12 = 8 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_10) / 8)

				if (8 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_10) / 8)) > 0 and var_337_9 < var_337_12 then
					arg_334_1.talkMaxDuration = var_337_12

					if var_337_12 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_8
					end
				end

				arg_334_1.text_.text = var_337_10
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_9, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_13 and arg_334_1.time_ < var_337_8 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play318282079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 318282079
		arg_339_1.duration_ = 3.9

		local var_339_0 = {
			zh = 3.9,
			ja = 2.633
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play318282080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1015ui_story = arg_339_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).z)
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles = arg_339_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_339_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).z)
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles = arg_339_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1015ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1015ui_story == nil then
				arg_339_1.var_.characterEffect1015ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1015ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1015ui_story then
				arg_339_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_342_4 = 0
			local var_342_5 = 0.35

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(318282079)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 14 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 14)

				if (14 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 14)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282079", "story_v_out_318282.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_318282", "318282079", "story_v_out_318282.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_318282", "318282079", "story_v_out_318282.awb")

						arg_339_1:RecordAudio("318282079", var_342_11)
						arg_339_1:RecordAudio("318282079", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_318282", "318282079", "story_v_out_318282.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_318282", "318282079", "story_v_out_318282.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318282080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 318282080
		arg_343_1.duration_ = 3.37

		local var_343_0 = {
			zh = 3.366,
			ja = 2.166
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play318282081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_346_0 = 0
			local var_346_1 = 0.225

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_2 = arg_343_1:GetWordFromCfg(318282080)
				local var_346_3 = arg_343_1:FormatText(var_346_2.content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 9 <= 0 and var_346_1 or var_346_1 * (utf8.len(var_346_3) / 9)

				if (9 <= 0 and var_346_1 or var_346_1 * (utf8.len(var_346_3) / 9)) > 0 and var_346_1 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282080", "story_v_out_318282.awb") ~= 0 then
					local var_346_6 = manager.audio:GetVoiceLength("story_v_out_318282", "318282080", "story_v_out_318282.awb") / 1000

					if var_346_6 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_0
					end

					if var_346_2.prefab_name ~= "" and arg_343_1.actors_[var_346_2.prefab_name] ~= nil then
						local var_346_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_2.prefab_name].transform, "story_v_out_318282", "318282080", "story_v_out_318282.awb")

						arg_343_1:RecordAudio("318282080", var_346_7)
						arg_343_1:RecordAudio("318282080", var_346_7)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_318282", "318282080", "story_v_out_318282.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_318282", "318282080", "story_v_out_318282.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_8 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_8 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_8

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_8 and arg_343_1.time_ < var_346_0 + var_346_8 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play318282081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 318282081
		arg_347_1.duration_ = 7

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play318282082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_9000

			if arg_347_1.bgs_.LX0209 == nil then
				local var_350_0 = Object.Instantiate(arg_347_1.paintGo_)

				var_350_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LX0209")
				var_350_0.name = "LX0209"
				var_350_0.transform.parent = arg_347_1.stage_.transform
				var_350_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_347_1.bgs_.LX0209 = var_350_0
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				local var_350_1 = arg_347_1.bgs_.LX0209

				arg_347_1.bgs_.LX0209.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_350_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_350_2 = var_350_1:GetComponent("SpriteRenderer")

				if var_350_2 and var_350_2.sprite then
					local var_350_3 = 2 * (var_350_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_350_1.transform.localScale = Vector3.New(var_350_3 / var_350_2.sprite.bounds.size.y < var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x and var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x or var_350_3 / var_350_2.sprite.bounds.size.y, var_350_3 / var_350_2.sprite.bounds.size.y < var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x and var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x or var_350_3 / var_350_2.sprite.bounds.size.y, 0)
				end

				for iter_350_0, iter_350_1 in pairs(arg_347_1.bgs_) do
					if iter_350_0 ~= "LX0209" then
						iter_350_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_350_4 = 0

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.mask_.enabled = true
				arg_347_1.mask_.raycastTarget = true

				arg_347_1:SetGaussion(false)
			end

			local var_350_5 = 2

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_5 then
				local var_350_6 = Color.New(1, 1, 1)

				var_350_6.a = Mathf.Lerp(1, 0, (arg_347_1.time_ - var_350_4) / var_350_5)
				arg_347_1.mask_.color = var_350_6
			end

			if arg_347_1.time_ >= var_350_4 + var_350_5 and arg_347_1.time_ < var_350_4 + var_350_5 + arg_350_0 then
				local var_350_7 = Color.New(1, 1, 1)

				arg_347_1.mask_.enabled = false
				var_350_7.a = 0
				arg_347_1.mask_.color = var_350_7
			end

			local var_350_8 = arg_347_1.actors_["1015ui_story"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1015ui_story = var_350_8.localPosition
			end

			local var_350_9 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_9 then
				var_350_8.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_347_1.time_ - 0) / var_350_9)
				var_350_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_8.position).x, (manager.ui.mainCamera.transform.position - var_350_8.position).y, (manager.ui.mainCamera.transform.position - var_350_8.position).z)
				var_350_8.localEulerAngles.z = 0
				var_350_8.localEulerAngles.x = 0
				var_350_8.localEulerAngles = var_350_8.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_9 and arg_347_1.time_ < 0 + var_350_9 + arg_350_0 then
				var_350_8.localPosition = Vector3.New(0, 100, 0)
				var_350_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_8.position).x, (manager.ui.mainCamera.transform.position - var_350_8.position).y, (manager.ui.mainCamera.transform.position - var_350_8.position).z)
				var_350_8.localEulerAngles.z = 0
				var_350_8.localEulerAngles.x = 0
				var_350_8.localEulerAngles = var_350_8.localEulerAngles
			end

			local var_350_10 = arg_347_1.actors_["1015ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_10) and arg_347_1.var_.characterEffect1015ui_story == nil then
				arg_347_1.var_.characterEffect1015ui_story = var_350_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_11 = 0.034000001847744

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_11 and not isNil(var_350_10) then
				if arg_347_1.var_.characterEffect1015ui_story and not isNil(var_350_10) then
					arg_347_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_11)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_11 and arg_347_1.time_ < 0 + var_350_11 + arg_350_0 and not isNil(var_350_10) and arg_347_1.var_.characterEffect1015ui_story then
				arg_347_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_350_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_347_1.bgmTxt_.text ~= var_350_14 and arg_347_1.bgmTxt_.text ~= "" then
						if arg_347_1.bgmTxt2_.text ~= "" then
							arg_347_1.bgmTxt_.text = arg_347_1.bgmTxt2_.text
						end

						arg_347_1.bgmTxt2_.text = var_350_14

						arg_347_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_347_1.bgmTxt_.text = var_350_14
						arg_347_1.bgmTxt2_.text = var_350_14
					end

					if arg_347_1.bgmTimer then
						arg_347_1.bgmTimer:Stop()

						arg_347_1.bgmTimer = nil
					end

					if arg_347_1.settingData.show_music_name == 1 then
						arg_347_1.musicController:SetSelectedState("show")
						arg_347_1.musicAnimator_:Play("open", 0, 0)

						if arg_347_1.settingData.music_time ~= 0 then
							arg_347_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_347_1.settingData.music_time), function()
								if arg_347_1 == nil or isNil(arg_347_1.bgmTxt_) then
									return
								end

								arg_347_1.musicController:SetSelectedState("hide")
								arg_347_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_347_1.time_ and arg_347_1.time_ <= 0.8 + arg_350_0 then
				arg_347_1:AudioAction("play", "music", "bgm_activity_2_10_story_sekhmet", "bgm_activity_2_10_story_sekhmet", "bgm_activity_2_10_story_sekhmet.awb")

				local var_350_17 = manager.audio:GetAudioName("bgm_activity_2_10_story_sekhmet", "bgm_activity_2_10_story_sekhmet")

				if "" ~= "" then
					if arg_347_1.bgmTxt_.text ~= var_350_17 and arg_347_1.bgmTxt_.text ~= "" then
						if arg_347_1.bgmTxt2_.text ~= "" then
							arg_347_1.bgmTxt_.text = arg_347_1.bgmTxt2_.text
						end

						arg_347_1.bgmTxt2_.text = var_350_17

						arg_347_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_347_1.bgmTxt_.text = var_350_17
						arg_347_1.bgmTxt2_.text = var_350_17
					end

					if arg_347_1.bgmTimer then
						arg_347_1.bgmTimer:Stop()

						arg_347_1.bgmTimer = nil
					end

					if arg_347_1.settingData.show_music_name == 1 then
						arg_347_1.musicController:SetSelectedState("show")
						arg_347_1.musicAnimator_:Play("open", 0, 0)

						if arg_347_1.settingData.music_time ~= 0 then
							arg_347_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_347_1.settingData.music_time), function()
								if arg_347_1 == nil or isNil(arg_347_1.bgmTxt_) then
									return
								end

								arg_347_1.musicController:SetSelectedState("hide")
								arg_347_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				local var_350_18 = arg_347_1.var_.effect塞赫欧米伽

				if not arg_347_1.var_.effect塞赫欧米伽 then
					var_350_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), manager.ui.mainCamera.transform)
					var_350_18.name = "塞赫欧米伽"
					arg_347_1.var_.effect塞赫欧米伽 = var_350_18
				else
					var_350_18.transform:SetParent(var_350_9000)
				end

				var_350_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_350_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.6 < arg_347_1.time_ and arg_347_1.time_ <= 0.6 + arg_350_0 then
				if arg_347_1.var_.effect塞赫欧米伽 then
					Object.Destroy(arg_347_1.var_.effect塞赫欧米伽)

					arg_347_1.var_.effect塞赫欧米伽 = nil
				end
			end

			local var_350_21 = arg_347_1.bgs_.LX0209.transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPosLX0209 = var_350_21.localPosition
			end

			local var_350_22 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_22 then
				var_350_21.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPosLX0209, Vector3.New(0, 1, 9.5), (arg_347_1.time_ - 0) / var_350_22)
			end

			if arg_347_1.time_ >= 0 + var_350_22 and arg_347_1.time_ < 0 + var_350_22 + arg_350_0 then
				var_350_21.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_350_23 = arg_347_1.bgs_.LX0209.transform

			if 0.0166666666666667 < arg_347_1.time_ and arg_347_1.time_ <= 0.0166666666666667 + arg_350_0 then
				arg_347_1.var_.moveOldPosLX0209 = var_350_23.localPosition
			end

			local var_350_24 = 4.5

			if 0.0166666666666667 <= arg_347_1.time_ and arg_347_1.time_ < 0.0166666666666667 + var_350_24 then
				var_350_23.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPosLX0209, Vector3.New(0, 1, 10), (arg_347_1.time_ - 0.0166666666666667) / var_350_24)
			end

			if arg_347_1.time_ >= 0.0166666666666667 + var_350_24 and arg_347_1.time_ < 0.0166666666666667 + var_350_24 + arg_350_0 then
				var_350_23.localPosition = Vector3.New(0, 1, 10)
			end

			local var_350_25 = 1.8

			if 1.8 < arg_347_1.time_ and arg_347_1.time_ <= var_350_25 + arg_350_0 then
				arg_347_1.allBtn_.enabled = false
			end

			if arg_347_1.time_ >= var_350_25 + 2.71666666666667 and arg_347_1.time_ < var_350_25 + 2.71666666666667 + arg_350_0 then
				arg_347_1.allBtn_.enabled = true
			end

			if arg_347_1.frameCnt_ <= 1 then
				arg_347_1.dialog_:SetActive(false)
			end

			local var_350_26 = 2
			local var_350_27 = 0.6

			if 2 < arg_347_1.time_ and arg_347_1.time_ <= var_350_26 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0

				arg_347_1.dialog_:SetActive(true)

				arg_347_1.dialogCg_.alpha = 0

				local var_350_28 = LeanTween.value(arg_347_1.dialog_, 0, 1, 0.3)

				var_350_28:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_347_1.dialogCg_.alpha = arg_353_0
				end))
				var_350_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_347_1.dialog_)
					var_350_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_347_1.duration_ = arg_347_1.duration_ + 0.3

				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_29 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(318282081).content)

				arg_347_1.text_.text = var_350_29

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_31 = 24 <= 0 and var_350_27 or var_350_27 * (utf8.len(var_350_29) / 24)

				if (24 <= 0 and var_350_27 or var_350_27 * (utf8.len(var_350_29) / 24)) > 0 and var_350_27 < var_350_31 then
					arg_347_1.talkMaxDuration = var_350_31
					var_350_26 = var_350_26 + 0.3

					if var_350_31 + var_350_26 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_31 + var_350_26
					end
				end

				arg_347_1.text_.text = var_350_29
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_32 = var_350_26 + 0.3
			local var_350_33 = math.max(var_350_27, arg_347_1.talkMaxDuration)

			if var_350_26 + 0.3 <= arg_347_1.time_ and arg_347_1.time_ < var_350_32 + var_350_33 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_32) / var_350_33

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_32 + var_350_33 and arg_347_1.time_ < var_350_32 + var_350_33 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "LX0209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play318282082 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 318282082
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play318282083(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_attack1", "")
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

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(318282082).content)

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
	Play318282083 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 318282083
		arg_359_1.duration_ = 3.63

		local var_359_0 = {
			zh = 3.633,
			ja = 2
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play318282084(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.225

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(318282083)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 9 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 9)

				if (9 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 9)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282083", "story_v_out_318282.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282083", "story_v_out_318282.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_318282", "318282083", "story_v_out_318282.awb")

						arg_359_1:RecordAudio("318282083", var_362_6)
						arg_359_1:RecordAudio("318282083", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_318282", "318282083", "story_v_out_318282.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_318282", "318282083", "story_v_out_318282.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play318282084 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 318282084
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play318282085(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1.3

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(318282084).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 52 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 52)

				if (52 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 52)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play318282085 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 318282085
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play318282086(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1.125

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(318282085).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 45 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 45)

				if (45 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 45)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play318282086 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 318282086
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play318282087(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.15

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(318282086).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 46 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 46)

				if (46 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 46)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play318282087 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 318282087
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play318282088(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 1.225

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(318282087).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 49 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 49)

				if (49 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 49)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play318282088 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 318282088
		arg_379_1.duration_ = 13.4

		local var_379_0 = {
			zh = 4.5,
			ja = 13.4
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play318282089(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.425

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4016")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:GetWordFromCfg(318282088)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 17 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 17)

				if (17 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 17)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282088", "story_v_out_318282.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282088", "story_v_out_318282.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_out_318282", "318282088", "story_v_out_318282.awb")

						arg_379_1:RecordAudio("318282088", var_382_6)
						arg_379_1:RecordAudio("318282088", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_318282", "318282088", "story_v_out_318282.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_318282", "318282088", "story_v_out_318282.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play318282089 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 318282089
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play318282090(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1.1

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(318282089).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 44 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 44)

				if (44 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 44)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play318282090 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 318282090
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play318282091(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.875

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(318282090).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 35 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 35)

				if (35 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 35)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play318282091 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 318282091
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play318282092(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.1

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(318282091).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 4 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 4)

				if (4 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 4)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play318282092 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 318282092
		arg_395_1.duration_ = 5

		local var_395_0 = {
			zh = 5,
			ja = 4.3
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play318282093(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.5

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:GetWordFromCfg(318282092)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 20 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 20)

				if (20 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 20)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282092", "story_v_out_318282.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282092", "story_v_out_318282.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_318282", "318282092", "story_v_out_318282.awb")

						arg_395_1:RecordAudio("318282092", var_398_6)
						arg_395_1:RecordAudio("318282092", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_318282", "318282092", "story_v_out_318282.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_318282", "318282092", "story_v_out_318282.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play318282093 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 318282093
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play318282094(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.075

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(318282093).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 3 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 3)

				if (3 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 3)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play318282094 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 318282094
		arg_403_1.duration_ = 3.27

		local var_403_0 = {
			zh = 2.766,
			ja = 3.266
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play318282095(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.3

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:GetWordFromCfg(318282094)
				local var_406_2 = arg_403_1:FormatText(var_406_1.content)

				arg_403_1.text_.text = var_406_2

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_4 = 12 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 12)

				if (12 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 12)) > 0 and var_406_0 < var_406_4 then
					arg_403_1.talkMaxDuration = var_406_4

					if var_406_4 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_4 + 0
					end
				end

				arg_403_1.text_.text = var_406_2
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282094", "story_v_out_318282.awb") ~= 0 then
					local var_406_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282094", "story_v_out_318282.awb") / 1000

					if var_406_5 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + 0
					end

					if var_406_1.prefab_name ~= "" and arg_403_1.actors_[var_406_1.prefab_name] ~= nil then
						local var_406_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_1.prefab_name].transform, "story_v_out_318282", "318282094", "story_v_out_318282.awb")

						arg_403_1:RecordAudio("318282094", var_406_6)
						arg_403_1:RecordAudio("318282094", var_406_6)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_318282", "318282094", "story_v_out_318282.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_318282", "318282094", "story_v_out_318282.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_7 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_7 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_7

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_7 and arg_403_1.time_ < 0 + var_406_7 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play318282095 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 318282095
		arg_407_1.duration_ = 2.43

		local var_407_0 = {
			zh = 1.066,
			ja = 2.433
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play318282096(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.125

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_1 = arg_407_1:GetWordFromCfg(318282095)
				local var_410_2 = arg_407_1:FormatText(var_410_1.content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 5 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 5)

				if (5 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 5)) > 0 and var_410_0 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + 0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282095", "story_v_out_318282.awb") ~= 0 then
					local var_410_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282095", "story_v_out_318282.awb") / 1000

					if var_410_5 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + 0
					end

					if var_410_1.prefab_name ~= "" and arg_407_1.actors_[var_410_1.prefab_name] ~= nil then
						local var_410_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_1.prefab_name].transform, "story_v_out_318282", "318282095", "story_v_out_318282.awb")

						arg_407_1:RecordAudio("318282095", var_410_6)
						arg_407_1:RecordAudio("318282095", var_410_6)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_318282", "318282095", "story_v_out_318282.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_318282", "318282095", "story_v_out_318282.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play318282096 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 318282096
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play318282097(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 1.45

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(318282096).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 58 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 58)

				if (58 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 58)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play318282097 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 318282097
		arg_415_1.duration_ = 12.17

		local var_415_0 = {
			zh = 12.166,
			ja = 6.4
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play318282098(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 1

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:GetWordFromCfg(318282097)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 40 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 40)

				if (40 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 40)) > 0 and var_418_0 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + 0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282097", "story_v_out_318282.awb") ~= 0 then
					local var_418_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282097", "story_v_out_318282.awb") / 1000

					if var_418_5 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + 0
					end

					if var_418_1.prefab_name ~= "" and arg_415_1.actors_[var_418_1.prefab_name] ~= nil then
						local var_418_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_1.prefab_name].transform, "story_v_out_318282", "318282097", "story_v_out_318282.awb")

						arg_415_1:RecordAudio("318282097", var_418_6)
						arg_415_1:RecordAudio("318282097", var_418_6)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_318282", "318282097", "story_v_out_318282.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_318282", "318282097", "story_v_out_318282.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play318282098 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 318282098
		arg_419_1.duration_ = 4.6

		local var_419_0 = {
			zh = 3.966,
			ja = 4.6
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
			arg_419_1.auto_ = false
		end

		function arg_419_1.playNext_(arg_421_0)
			arg_419_1.onStoryFinished_()
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.325

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:GetWordFromCfg(318282098)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 13 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 13)

				if (13 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 13)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318282", "318282098", "story_v_out_318282.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_318282", "318282098", "story_v_out_318282.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_318282", "318282098", "story_v_out_318282.awb")

						arg_419_1:RecordAudio("318282098", var_422_6)
						arg_419_1:RecordAudio("318282098", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_318282", "318282098", "story_v_out_318282.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_318282", "318282098", "story_v_out_318282.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K16i",
		"TextureConfig/Background/LX0206",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/ST69",
		"TextureConfig/Background/K16f",
		"TextureConfig/Background/LX0209"
	},
	voices = {
		"story_v_out_318282.awb"
	}
}
