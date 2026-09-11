return {
	Play120411001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120411001
		arg_1_1.duration_ = 4.27

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120411002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST37 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_4_0.name = "ST37"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST37 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST37

				arg_1_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST37" then
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

			local var_4_8 = "1029ui_story"

			if arg_1_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1029ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1029ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_4_14 = arg_1_1.actors_["1029ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1029ui_story then
				arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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
			local var_4_24 = 0.1

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(120411001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 4 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 4)

				if (4 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 4)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411001", "story_v_out_120411.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_120411", "120411001", "story_v_out_120411.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_120411", "120411001", "story_v_out_120411.awb")

						arg_1_1:RecordAudio("120411001", var_4_31)
						arg_1_1:RecordAudio("120411001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120411", "120411001", "story_v_out_120411.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120411", "120411001", "story_v_out_120411.awb")
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
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120411002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120411002
		arg_9_1.duration_ = 6.23

		local var_9_0 = {
			zh = 5.066,
			ja = 6.233
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
				arg_9_0:Play120411003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1029ui_story"]) and arg_9_1.var_.characterEffect1029ui_story == nil then
				arg_9_1.var_.characterEffect1029ui_story = arg_9_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1029ui_story"]) then
				if arg_9_1.var_.characterEffect1029ui_story and not isNil(arg_9_1.actors_["1029ui_story"]) then
					arg_9_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1029ui_story"]) and arg_9_1.var_.characterEffect1029ui_story then
				arg_9_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_12_1 = "1084ui_story"

			if arg_9_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

				var_12_2.name = var_12_1
				var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_[var_12_1] = var_12_2

				local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

				var_12_3.enabled = true

				local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

				if var_12_4 then
					var_12_4:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_3.transform, false)

				arg_9_1.var_[var_12_1 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_[var_12_1 .. "Animator"].applyRootMotion = true
				arg_9_1.var_[var_12_1 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_5.localPosition
			end

			local var_12_6 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_9_1.time_ - 0) / var_12_6)
				var_12_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_5.position).x, (manager.ui.mainCamera.transform.position - var_12_5.position).y, (manager.ui.mainCamera.transform.position - var_12_5.position).z)
				var_12_5.localEulerAngles.z = 0
				var_12_5.localEulerAngles.x = 0
				var_12_5.localEulerAngles = var_12_5.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0.7, -0.97, -6)
				var_12_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_5.position).x, (manager.ui.mainCamera.transform.position - var_12_5.position).y, (manager.ui.mainCamera.transform.position - var_12_5.position).z)
				var_12_5.localEulerAngles.z = 0
				var_12_5.localEulerAngles.x = 0
				var_12_5.localEulerAngles = var_12_5.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_12_7 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_8 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 and not isNil(var_12_7) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_7) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_10 = 0
			local var_12_11 = 0.45

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
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

				local var_12_12 = arg_9_1:GetWordFromCfg(120411002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 18 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 18)

				if (18 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 18)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411002", "story_v_out_120411.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_120411", "120411002", "story_v_out_120411.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_120411", "120411002", "story_v_out_120411.awb")

						arg_9_1:RecordAudio("120411002", var_12_17)
						arg_9_1:RecordAudio("120411002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120411", "120411002", "story_v_out_120411.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120411", "120411002", "story_v_out_120411.awb")
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
	Play120411003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120411003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120411004(arg_13_1)
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

			local var_16_1 = 0
			local var_16_2 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(120411003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 21 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 21)

				if (21 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 21)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120411004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120411004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play120411005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1029ui_story"]) and arg_17_1.var_.characterEffect1029ui_story == nil then
				arg_17_1.var_.characterEffect1029ui_story = arg_17_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1029ui_story"]) then
				if arg_17_1.var_.characterEffect1029ui_story and not isNil(arg_17_1.actors_["1029ui_story"]) then
					arg_17_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1029ui_story"]) and arg_17_1.var_.characterEffect1029ui_story then
				arg_17_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(120411004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 3 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 3)

				if (3 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 3)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411004", "story_v_out_120411.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411004", "story_v_out_120411.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_120411", "120411004", "story_v_out_120411.awb")

						arg_17_1:RecordAudio("120411004", var_20_9)
						arg_17_1:RecordAudio("120411004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120411", "120411004", "story_v_out_120411.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120411", "120411004", "story_v_out_120411.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play120411005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120411005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play120411006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = arg_21_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).z)
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles = arg_21_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).z)
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles = arg_21_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1029ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1029ui_story = var_24_1.localPosition
			end

			local var_24_2 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 then
				var_24_1.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_2)
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
			local var_24_4 = 1.025

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(120411005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 41 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 41)

				if (41 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 41)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "1029ui_story",
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
	Play120411006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120411006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120411007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.725

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(120411006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 29)

				if (29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 29)) > 0 and var_28_0 < var_28_3 then
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
	Play120411007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120411007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play120411008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(120411007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 26 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 26)

				if (26 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 26)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play120411008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120411008
		arg_33_1.duration_ = 4.33

		local var_33_0 = {
			zh = 3.1,
			ja = 4.333
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
				arg_33_0:Play120411009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_36_0 = arg_33_1.actors_["1084ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_1 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(var_36_0) then
				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_36_3 = arg_33_1.actors_["1084ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1084ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -0.97, -6)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = 0
			local var_36_6 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(120411008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 21 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 21)

				if (21 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 21)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411008", "story_v_out_120411.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_120411", "120411008", "story_v_out_120411.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_120411", "120411008", "story_v_out_120411.awb")

						arg_33_1:RecordAudio("120411008", var_36_12)
						arg_33_1:RecordAudio("120411008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120411", "120411008", "story_v_out_120411.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120411", "120411008", "story_v_out_120411.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play120411009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120411009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play120411010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = arg_37_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) then
				if arg_37_1.var_.characterEffect1084ui_story and not isNil(arg_37_1.actors_["1084ui_story"]) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.975

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(120411009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 39 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 39)

				if (39 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 39)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120411010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120411010
		arg_41_1.duration_ = 2.7

		local var_41_0 = {
			zh = 2.533333333332,
			ja = 2.7
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play120411011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_44_0 = arg_41_1.actors_["1084ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_1 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 and not isNil(var_44_0) then
				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_44_3 = 0
			local var_44_4 = 0.35

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(120411010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 14 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 14)

				if (14 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 14)) > 0 and var_44_4 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411010", "story_v_out_120411.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_120411", "120411010", "story_v_out_120411.awb") / 1000

					if var_44_9 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_3
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_120411", "120411010", "story_v_out_120411.awb")

						arg_41_1:RecordAudio("120411010", var_44_10)
						arg_41_1:RecordAudio("120411010", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120411", "120411010", "story_v_out_120411.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120411", "120411010", "story_v_out_120411.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_11 and arg_41_1.time_ < var_44_3 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120411011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120411011
		arg_45_1.duration_ = 2.4

		local var_45_0 = {
			zh = 2.166,
			ja = 2.4
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play120411012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = arg_45_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) then
				if arg_45_1.var_.characterEffect1084ui_story and not isNil(arg_45_1.actors_["1084ui_story"]) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_48_1 = arg_45_1.actors_["1029ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1029ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1029ui_story then
				arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["1029ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1029ui_story = var_48_4.localPosition
			end

			local var_48_5 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 then
				var_48_4.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_45_1.time_ - 0) / var_48_5)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				var_48_4.localPosition = Vector3.New(0, -1.09, -6.2)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			local var_48_6 = arg_45_1.actors_["1084ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1084ui_story = var_48_6.localPosition
			end

			local var_48_7 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				var_48_6.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_7)
				var_48_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_6.position).x, (manager.ui.mainCamera.transform.position - var_48_6.position).y, (manager.ui.mainCamera.transform.position - var_48_6.position).z)
				var_48_6.localEulerAngles.z = 0
				var_48_6.localEulerAngles.x = 0
				var_48_6.localEulerAngles = var_48_6.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				var_48_6.localPosition = Vector3.New(0, 100, 0)
				var_48_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_6.position).x, (manager.ui.mainCamera.transform.position - var_48_6.position).y, (manager.ui.mainCamera.transform.position - var_48_6.position).z)
				var_48_6.localEulerAngles.z = 0
				var_48_6.localEulerAngles.x = 0
				var_48_6.localEulerAngles = var_48_6.localEulerAngles
			end

			local var_48_8 = 0
			local var_48_9 = 0.225

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(120411011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 9 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 9)

				if (9 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 9)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411011", "story_v_out_120411.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411011", "story_v_out_120411.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_120411", "120411011", "story_v_out_120411.awb")

						arg_45_1:RecordAudio("120411011", var_48_15)
						arg_45_1:RecordAudio("120411011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_120411", "120411011", "story_v_out_120411.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_120411", "120411011", "story_v_out_120411.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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

		arg_45_1:InitPlayNodeList()
	end,
	Play120411012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120411012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play120411013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1029ui_story"]) and arg_49_1.var_.characterEffect1029ui_story == nil then
				arg_49_1.var_.characterEffect1029ui_story = arg_49_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1029ui_story"]) then
				if arg_49_1.var_.characterEffect1029ui_story and not isNil(arg_49_1.actors_["1029ui_story"]) then
					arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1029ui_story"]) and arg_49_1.var_.characterEffect1029ui_story then
				arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.575

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(120411012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 23 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 23)

				if (23 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 23)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120411013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120411013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play120411014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(120411013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)

				if (27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120411014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120411014
		arg_57_1.duration_ = 4.3

		local var_57_0 = {
			zh = 4.3,
			ja = 4.066
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play120411015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1029ui_story"]) and arg_57_1.var_.characterEffect1029ui_story == nil then
				arg_57_1.var_.characterEffect1029ui_story = arg_57_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1029ui_story"]) then
				if arg_57_1.var_.characterEffect1029ui_story and not isNil(arg_57_1.actors_["1029ui_story"]) then
					arg_57_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1029ui_story"]) and arg_57_1.var_.characterEffect1029ui_story then
				arg_57_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_60_2 = 0
			local var_60_3 = 0.6

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(120411014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 24 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 24)

				if (24 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 24)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411014", "story_v_out_120411.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411014", "story_v_out_120411.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_120411", "120411014", "story_v_out_120411.awb")

						arg_57_1:RecordAudio("120411014", var_60_9)
						arg_57_1:RecordAudio("120411014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120411", "120411014", "story_v_out_120411.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120411", "120411014", "story_v_out_120411.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play120411015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120411015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120411016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1029ui_story"]) and arg_61_1.var_.characterEffect1029ui_story == nil then
				arg_61_1.var_.characterEffect1029ui_story = arg_61_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1029ui_story"]) then
				if arg_61_1.var_.characterEffect1029ui_story and not isNil(arg_61_1.actors_["1029ui_story"]) then
					arg_61_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1029ui_story"]) and arg_61_1.var_.characterEffect1029ui_story then
				arg_61_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.075

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(120411015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 3 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 3)

				if (3 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 3)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play120411016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120411016
		arg_65_1.duration_ = 5.47

		local var_65_0 = {
			zh = 5.466,
			ja = 5.433
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
				arg_65_0:Play120411017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1029ui_story"]) and arg_65_1.var_.characterEffect1029ui_story == nil then
				arg_65_1.var_.characterEffect1029ui_story = arg_65_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1029ui_story"]) then
				if arg_65_1.var_.characterEffect1029ui_story and not isNil(arg_65_1.actors_["1029ui_story"]) then
					arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1029ui_story"]) and arg_65_1.var_.characterEffect1029ui_story then
				arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_68_2 = 0
			local var_68_3 = 0.725

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(120411016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 29 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 29)

				if (29 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 29)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411016", "story_v_out_120411.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411016", "story_v_out_120411.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_120411", "120411016", "story_v_out_120411.awb")

						arg_65_1:RecordAudio("120411016", var_68_9)
						arg_65_1:RecordAudio("120411016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120411", "120411016", "story_v_out_120411.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120411", "120411016", "story_v_out_120411.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play120411017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120411017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play120411018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1029ui_story"]) and arg_69_1.var_.characterEffect1029ui_story == nil then
				arg_69_1.var_.characterEffect1029ui_story = arg_69_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1029ui_story"]) then
				if arg_69_1.var_.characterEffect1029ui_story and not isNil(arg_69_1.actors_["1029ui_story"]) then
					arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1029ui_story"]) and arg_69_1.var_.characterEffect1029ui_story then
				arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.75

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
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

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(120411017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 30 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 30)

				if (30 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 30)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play120411018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120411018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120411019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(120411018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 47 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 47)

				if (47 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 47)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play120411019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120411019
		arg_77_1.duration_ = 7.07

		local var_77_0 = {
			zh = 3.866,
			ja = 7.066
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
				arg_77_0:Play120411020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1029ui_story"]) and arg_77_1.var_.characterEffect1029ui_story == nil then
				arg_77_1.var_.characterEffect1029ui_story = arg_77_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1029ui_story"]) then
				if arg_77_1.var_.characterEffect1029ui_story and not isNil(arg_77_1.actors_["1029ui_story"]) then
					arg_77_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1029ui_story"]) and arg_77_1.var_.characterEffect1029ui_story then
				arg_77_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.35

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(120411019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 14 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 14)

				if (14 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 14)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411019", "story_v_out_120411.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411019", "story_v_out_120411.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_120411", "120411019", "story_v_out_120411.awb")

						arg_77_1:RecordAudio("120411019", var_80_9)
						arg_77_1:RecordAudio("120411019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_120411", "120411019", "story_v_out_120411.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_120411", "120411019", "story_v_out_120411.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120411020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120411020
		arg_81_1.duration_ = 7.5

		local var_81_0 = {
			zh = 4.4,
			ja = 7.5
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play120411021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1029ui_story"]) and arg_81_1.var_.characterEffect1029ui_story == nil then
				arg_81_1.var_.characterEffect1029ui_story = arg_81_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1029ui_story"]) then
				if arg_81_1.var_.characterEffect1029ui_story and not isNil(arg_81_1.actors_["1029ui_story"]) then
					arg_81_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1029ui_story"]) and arg_81_1.var_.characterEffect1029ui_story then
				arg_81_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_84_1 = arg_81_1.actors_["1084ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_84_4 = arg_81_1.actors_["1084ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = var_84_4.localPosition
			end

			local var_84_5 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 then
				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_81_1.time_ - 0) / var_84_5)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			local var_84_6 = arg_81_1.actors_["1029ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1029ui_story = var_84_6.localPosition
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_81_1.time_ - 0) / var_84_7)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(0.7, -1.09, -6.2)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			local var_84_8 = 0
			local var_84_9 = 0.575

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(120411020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 23 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 23)

				if (23 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 23)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411020", "story_v_out_120411.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411020", "story_v_out_120411.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_120411", "120411020", "story_v_out_120411.awb")

						arg_81_1:RecordAudio("120411020", var_84_15)
						arg_81_1:RecordAudio("120411020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_120411", "120411020", "story_v_out_120411.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_120411", "120411020", "story_v_out_120411.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play120411021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120411021
		arg_85_1.duration_ = 5.63

		local var_85_0 = {
			zh = 4.9,
			ja = 5.633
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play120411022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_88_0 = 0
			local var_88_1 = 0.675

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(120411021)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 27 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 27)

				if (27 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 27)) > 0 and var_88_1 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411021", "story_v_out_120411.awb") ~= 0 then
					local var_88_6 = manager.audio:GetVoiceLength("story_v_out_120411", "120411021", "story_v_out_120411.awb") / 1000

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end

					if var_88_2.prefab_name ~= "" and arg_85_1.actors_[var_88_2.prefab_name] ~= nil then
						local var_88_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_2.prefab_name].transform, "story_v_out_120411", "120411021", "story_v_out_120411.awb")

						arg_85_1:RecordAudio("120411021", var_88_7)
						arg_85_1:RecordAudio("120411021", var_88_7)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120411", "120411021", "story_v_out_120411.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120411", "120411021", "story_v_out_120411.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play120411022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120411022
		arg_89_1.duration_ = 12.6

		local var_89_0 = {
			zh = 8.8,
			ja = 12.6
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play120411023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1029ui_story"]) and arg_89_1.var_.characterEffect1029ui_story == nil then
				arg_89_1.var_.characterEffect1029ui_story = arg_89_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1029ui_story"]) then
				if arg_89_1.var_.characterEffect1029ui_story and not isNil(arg_89_1.actors_["1029ui_story"]) then
					arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1029ui_story"]) and arg_89_1.var_.characterEffect1029ui_story then
				arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["1084ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 1.1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(120411022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 44 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 44)

				if (44 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 44)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411022", "story_v_out_120411.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411022", "story_v_out_120411.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_120411", "120411022", "story_v_out_120411.awb")

						arg_89_1:RecordAudio("120411022", var_92_11)
						arg_89_1:RecordAudio("120411022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_120411", "120411022", "story_v_out_120411.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_120411", "120411022", "story_v_out_120411.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play120411023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120411023
		arg_93_1.duration_ = 3.03

		local var_93_0 = {
			zh = 3.033,
			ja = 2.533
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play120411024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.25

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(120411023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 10 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 10)

				if (10 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 10)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411023", "story_v_out_120411.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411023", "story_v_out_120411.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_120411", "120411023", "story_v_out_120411.awb")

						arg_93_1:RecordAudio("120411023", var_96_6)
						arg_93_1:RecordAudio("120411023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_120411", "120411023", "story_v_out_120411.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_120411", "120411023", "story_v_out_120411.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play120411024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120411024
		arg_97_1.duration_ = 1

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"

			SetActive(arg_97_1.choicesGo_, true)

			for iter_98_0, iter_98_1 in ipairs(arg_97_1.choices_) do
				SetActive(iter_98_1.go, iter_98_0 <= 3)
			end

			arg_97_1.choices_[1].txt.text = arg_97_1:FormatText(StoryChoiceCfg[383].name)
			arg_97_1.choices_[2].txt.text = arg_97_1:FormatText(StoryChoiceCfg[384].name)
			arg_97_1.choices_[3].txt.text = arg_97_1:FormatText(StoryChoiceCfg[385].name)
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play120411025(arg_97_1)
			end

			if arg_99_0 == 2 then
				arg_97_0:Play120411025(arg_97_1)
			end

			if arg_99_0 == 3 then
				arg_97_0:Play120411025(arg_97_1)
			end

			arg_97_1:RecordChoiceLog(120411024, 383, 384, 385)
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1029ui_story"]) and arg_97_1.var_.characterEffect1029ui_story == nil then
				arg_97_1.var_.characterEffect1029ui_story = arg_97_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1029ui_story"]) then
				if arg_97_1.var_.characterEffect1029ui_story and not isNil(arg_97_1.actors_["1029ui_story"]) then
					arg_97_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1029ui_story"]) and arg_97_1.var_.characterEffect1029ui_story then
				arg_97_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			if arg_97_1.time_ >= var_100_1 + 1 and arg_97_1.time_ < var_100_1 + 1 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play120411025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120411025
		arg_101_1.duration_ = 4.87

		local var_101_0 = {
			zh = 4.5,
			ja = 4.866
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play120411026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_104_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_101_1.stage_.transform)

				var_104_0.name = "1029ui_story"
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["1029ui_story"] = var_104_0

				local var_104_1 = var_104_0:GetComponentInChildren(typeof(CharacterEffect))

				var_104_1.enabled = true

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_0, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end

				arg_101_1:ShowWeapon(var_104_1.transform, false)

				arg_101_1.var_["1029ui_story" .. "Animator"] = var_104_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_101_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_101_1.var_["1029ui_story" .. "LipSync"] = var_104_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_104_3 = arg_101_1.actors_["1029ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1029ui_story == nil then
				arg_101_1.var_.characterEffect1029ui_story = var_104_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 and not isNil(var_104_3) then
				if arg_101_1.var_.characterEffect1029ui_story and not isNil(var_104_3) then
					arg_101_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1029ui_story then
				arg_101_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_104_6 = 0
			local var_104_7 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(120411025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 16 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 16)

				if (16 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 16)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411025", "story_v_out_120411.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_120411", "120411025", "story_v_out_120411.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_120411", "120411025", "story_v_out_120411.awb")

						arg_101_1:RecordAudio("120411025", var_104_13)
						arg_101_1:RecordAudio("120411025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_120411", "120411025", "story_v_out_120411.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_120411", "120411025", "story_v_out_120411.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play120411026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 120411026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play120411027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1029ui_story"]) and arg_105_1.var_.characterEffect1029ui_story == nil then
				arg_105_1.var_.characterEffect1029ui_story = arg_105_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1029ui_story"]) then
				if arg_105_1.var_.characterEffect1029ui_story and not isNil(arg_105_1.actors_["1029ui_story"]) then
					arg_105_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1029ui_story"]) and arg_105_1.var_.characterEffect1029ui_story then
				arg_105_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.55

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(120411026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 22 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 22)

				if (22 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 22)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play120411027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 120411027
		arg_109_1.duration_ = 7.9

		local var_109_0 = {
			zh = 4.333,
			ja = 7.9
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play120411028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = arg_109_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(arg_109_1.actors_["1084ui_story"]) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_112_2 = 0
			local var_112_3 = 0.6

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(120411027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 24 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 24)

				if (24 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 24)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411027", "story_v_out_120411.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411027", "story_v_out_120411.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_120411", "120411027", "story_v_out_120411.awb")

						arg_109_1:RecordAudio("120411027", var_112_9)
						arg_109_1:RecordAudio("120411027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_120411", "120411027", "story_v_out_120411.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_120411", "120411027", "story_v_out_120411.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play120411028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120411028
		arg_113_1.duration_ = 6.33

		local var_113_0 = {
			zh = 5.2,
			ja = 6.333
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play120411029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = arg_113_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) then
				if arg_113_1.var_.characterEffect1084ui_story and not isNil(arg_113_1.actors_["1084ui_story"]) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_116_1 = arg_113_1.actors_["1029ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1029ui_story == nil then
				arg_113_1.var_.characterEffect1029ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1029ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1029ui_story then
				arg_113_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_116_4 = 0
			local var_116_5 = 0.5

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(120411028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 20 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 20)

				if (20 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 20)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411028", "story_v_out_120411.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411028", "story_v_out_120411.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_120411", "120411028", "story_v_out_120411.awb")

						arg_113_1:RecordAudio("120411028", var_116_11)
						arg_113_1:RecordAudio("120411028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_120411", "120411028", "story_v_out_120411.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_120411", "120411028", "story_v_out_120411.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play120411029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120411029
		arg_117_1.duration_ = 10.2

		local var_117_0 = {
			zh = 4.3,
			ja = 10.2
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play120411030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1084ui_story"]) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = arg_117_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1084ui_story"]) then
				if arg_117_1.var_.characterEffect1084ui_story and not isNil(arg_117_1.actors_["1084ui_story"]) then
					arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1084ui_story"]) and arg_117_1.var_.characterEffect1084ui_story then
				arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_120_2 = arg_117_1.actors_["1029ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1029ui_story == nil then
				arg_117_1.var_.characterEffect1029ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1029ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1029ui_story then
				arg_117_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_120_4 = 0
			local var_120_5 = 0.575

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(120411029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 23 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 23)

				if (23 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 23)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411029", "story_v_out_120411.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411029", "story_v_out_120411.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_120411", "120411029", "story_v_out_120411.awb")

						arg_117_1:RecordAudio("120411029", var_120_11)
						arg_117_1:RecordAudio("120411029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_120411", "120411029", "story_v_out_120411.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_120411", "120411029", "story_v_out_120411.awb")
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

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play120411030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 120411030
		arg_121_1.duration_ = 8.43

		local var_121_0 = {
			zh = 5.333,
			ja = 8.433
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play120411031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1029ui_story"]) and arg_121_1.var_.characterEffect1029ui_story == nil then
				arg_121_1.var_.characterEffect1029ui_story = arg_121_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1029ui_story"]) then
				if arg_121_1.var_.characterEffect1029ui_story and not isNil(arg_121_1.actors_["1029ui_story"]) then
					arg_121_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1029ui_story"]) and arg_121_1.var_.characterEffect1029ui_story then
				arg_121_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1084ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.625

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(120411030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 25 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 25)

				if (25 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 25)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411030", "story_v_out_120411.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411030", "story_v_out_120411.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_120411", "120411030", "story_v_out_120411.awb")

						arg_121_1:RecordAudio("120411030", var_124_11)
						arg_121_1:RecordAudio("120411030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_120411", "120411030", "story_v_out_120411.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_120411", "120411030", "story_v_out_120411.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play120411031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 120411031
		arg_125_1.duration_ = 10.9

		local var_125_0 = {
			zh = 9.4,
			ja = 10.9
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play120411032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.975

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(120411031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 38 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 38)

				if (38 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 38)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411031", "story_v_out_120411.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411031", "story_v_out_120411.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_120411", "120411031", "story_v_out_120411.awb")

						arg_125_1:RecordAudio("120411031", var_128_6)
						arg_125_1:RecordAudio("120411031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_120411", "120411031", "story_v_out_120411.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_120411", "120411031", "story_v_out_120411.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play120411032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 120411032
		arg_129_1.duration_ = 7.37

		local var_129_0 = {
			zh = 4.966,
			ja = 7.366
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
				arg_129_0:Play120411033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = arg_129_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) then
				if arg_129_1.var_.characterEffect1084ui_story and not isNil(arg_129_1.actors_["1084ui_story"]) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_132_2 = arg_129_1.actors_["1029ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1029ui_story == nil then
				arg_129_1.var_.characterEffect1029ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1029ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1029ui_story then
				arg_129_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			local var_132_4 = 0
			local var_132_5 = 0.625

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(120411032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 25 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 25)

				if (25 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 25)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411032", "story_v_out_120411.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411032", "story_v_out_120411.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_120411", "120411032", "story_v_out_120411.awb")

						arg_129_1:RecordAudio("120411032", var_132_11)
						arg_129_1:RecordAudio("120411032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_120411", "120411032", "story_v_out_120411.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_120411", "120411032", "story_v_out_120411.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play120411033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120411033
		arg_133_1.duration_ = 11.83

		local var_133_0 = {
			zh = 6.3,
			ja = 11.833
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play120411034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.9

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(120411033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 37 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 37)

				if (37 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 37)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411033", "story_v_out_120411.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411033", "story_v_out_120411.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_120411", "120411033", "story_v_out_120411.awb")

						arg_133_1:RecordAudio("120411033", var_136_6)
						arg_133_1:RecordAudio("120411033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_120411", "120411033", "story_v_out_120411.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_120411", "120411033", "story_v_out_120411.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play120411034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 120411034
		arg_137_1.duration_ = 9.9

		local var_137_0 = {
			zh = 4.766,
			ja = 9.9
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play120411035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1029ui_story"]) and arg_137_1.var_.characterEffect1029ui_story == nil then
				arg_137_1.var_.characterEffect1029ui_story = arg_137_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1029ui_story"]) then
				if arg_137_1.var_.characterEffect1029ui_story and not isNil(arg_137_1.actors_["1029ui_story"]) then
					arg_137_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1029ui_story"]) and arg_137_1.var_.characterEffect1029ui_story then
				arg_137_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["1084ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect1084ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1084ui_story then
				arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_140_4 = 0
			local var_140_5 = 0.55

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(120411034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 22 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 22)

				if (22 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 22)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411034", "story_v_out_120411.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411034", "story_v_out_120411.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_120411", "120411034", "story_v_out_120411.awb")

						arg_137_1:RecordAudio("120411034", var_140_11)
						arg_137_1:RecordAudio("120411034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_120411", "120411034", "story_v_out_120411.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_120411", "120411034", "story_v_out_120411.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play120411035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120411035
		arg_141_1.duration_ = 8.67

		local var_141_0 = {
			zh = 6.2,
			ja = 8.666
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play120411036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.575

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(120411035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 23 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 23)

				if (23 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 23)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411035", "story_v_out_120411.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411035", "story_v_out_120411.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_120411", "120411035", "story_v_out_120411.awb")

						arg_141_1:RecordAudio("120411035", var_144_6)
						arg_141_1:RecordAudio("120411035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120411", "120411035", "story_v_out_120411.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120411", "120411035", "story_v_out_120411.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play120411036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120411036
		arg_145_1.duration_ = 2.37

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play120411037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1029ui_story"]) and arg_145_1.var_.characterEffect1029ui_story == nil then
				arg_145_1.var_.characterEffect1029ui_story = arg_145_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1029ui_story"]) then
				if arg_145_1.var_.characterEffect1029ui_story and not isNil(arg_145_1.actors_["1029ui_story"]) then
					arg_145_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1029ui_story"]) and arg_145_1.var_.characterEffect1029ui_story then
				arg_145_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_148_1 = arg_145_1.actors_["1084ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1084ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1084ui_story then
				arg_145_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4713")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_148_4 = 0
			local var_148_5 = 0.075

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(120411036)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 3 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 3)

				if (3 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 3)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411036", "story_v_out_120411.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411036", "story_v_out_120411.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_120411", "120411036", "story_v_out_120411.awb")

						arg_145_1:RecordAudio("120411036", var_148_11)
						arg_145_1:RecordAudio("120411036", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_120411", "120411036", "story_v_out_120411.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_120411", "120411036", "story_v_out_120411.awb")
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

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play120411037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120411037
		arg_149_1.duration_ = 7.63

		local var_149_0 = {
			zh = 5.6,
			ja = 7.633
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play120411038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1029ui_story"]) and arg_149_1.var_.characterEffect1029ui_story == nil then
				arg_149_1.var_.characterEffect1029ui_story = arg_149_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1029ui_story"]) then
				if arg_149_1.var_.characterEffect1029ui_story and not isNil(arg_149_1.actors_["1029ui_story"]) then
					arg_149_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1029ui_story"]) and arg_149_1.var_.characterEffect1029ui_story then
				arg_149_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["1084ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1084ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1084ui_story then
				arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.625

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(120411037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 25 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 25)

				if (25 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 25)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411037", "story_v_out_120411.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411037", "story_v_out_120411.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_120411", "120411037", "story_v_out_120411.awb")

						arg_149_1:RecordAudio("120411037", var_152_11)
						arg_149_1:RecordAudio("120411037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120411", "120411037", "story_v_out_120411.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120411", "120411037", "story_v_out_120411.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play120411038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120411038
		arg_153_1.duration_ = 13.07

		local var_153_0 = {
			zh = 7.966,
			ja = 13.066
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play120411039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.925

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(120411038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 37)

				if (37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 37)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411038", "story_v_out_120411.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411038", "story_v_out_120411.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_120411", "120411038", "story_v_out_120411.awb")

						arg_153_1:RecordAudio("120411038", var_156_6)
						arg_153_1:RecordAudio("120411038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_120411", "120411038", "story_v_out_120411.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_120411", "120411038", "story_v_out_120411.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play120411039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120411039
		arg_157_1.duration_ = 12.7

		local var_157_0 = {
			zh = 8.833,
			ja = 12.7
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play120411040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.9

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(120411039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 36)

				if (36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 36)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411039", "story_v_out_120411.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411039", "story_v_out_120411.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_120411", "120411039", "story_v_out_120411.awb")

						arg_157_1:RecordAudio("120411039", var_160_6)
						arg_157_1:RecordAudio("120411039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_120411", "120411039", "story_v_out_120411.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_120411", "120411039", "story_v_out_120411.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play120411040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120411040
		arg_161_1.duration_ = 13.13

		local var_161_0 = {
			zh = 9.533,
			ja = 13.133
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play120411041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.125

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(120411040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 45 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 45)

				if (45 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 45)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411040", "story_v_out_120411.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411040", "story_v_out_120411.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_120411", "120411040", "story_v_out_120411.awb")

						arg_161_1:RecordAudio("120411040", var_164_6)
						arg_161_1:RecordAudio("120411040", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120411", "120411040", "story_v_out_120411.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120411", "120411040", "story_v_out_120411.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play120411041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 120411041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play120411042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1029ui_story = arg_165_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1029ui_story"].transform.position).z)
				arg_165_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1029ui_story"].transform.localEulerAngles = arg_165_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1029ui_story"].transform.position).z)
				arg_165_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1029ui_story"].transform.localEulerAngles = arg_165_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1084ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1084ui_story = var_168_1.localPosition
			end

			local var_168_2 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 then
				var_168_1.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_2)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 then
				var_168_1.localPosition = Vector3.New(0, 100, 0)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			local var_168_3 = 0
			local var_168_4 = 0.775

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_5 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(120411041).content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 31 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 31)

				if (31 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 31)) > 0 and var_168_4 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_3
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_4, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_3) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_8 and arg_165_1.time_ < var_168_3 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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

		arg_165_1:InitPlayNodeList()
	end,
	Play120411042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 120411042
		arg_169_1.duration_ = 3.4

		local var_169_0 = {
			zh = 2.1,
			ja = 3.4
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play120411043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1029ui_story = arg_169_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1029ui_story"].transform.position).z)
				arg_169_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1029ui_story"].transform.localEulerAngles = arg_169_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, -1.09, -6.2)
				arg_169_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1029ui_story"].transform.position).z)
				arg_169_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1029ui_story"].transform.localEulerAngles = arg_169_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_172_1 = arg_169_1.actors_["1029ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1029ui_story == nil then
				arg_169_1.var_.characterEffect1029ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1029ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1029ui_story then
				arg_169_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_172_4 = 0
			local var_172_5 = 0.25

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(120411042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 10 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 10)

				if (10 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 10)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411042", "story_v_out_120411.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411042", "story_v_out_120411.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_120411", "120411042", "story_v_out_120411.awb")

						arg_169_1:RecordAudio("120411042", var_172_11)
						arg_169_1:RecordAudio("120411042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_120411", "120411042", "story_v_out_120411.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_120411", "120411042", "story_v_out_120411.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play120411043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 120411043
		arg_173_1.duration_ = 8.03

		local var_173_0 = {
			zh = 8.033,
			ja = 6.866
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play120411044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.775

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(120411043)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 31 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 31)

				if (31 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 31)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411043", "story_v_out_120411.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411043", "story_v_out_120411.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_120411", "120411043", "story_v_out_120411.awb")

						arg_173_1:RecordAudio("120411043", var_176_6)
						arg_173_1:RecordAudio("120411043", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_120411", "120411043", "story_v_out_120411.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_120411", "120411043", "story_v_out_120411.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play120411044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120411044
		arg_177_1.duration_ = 13.7

		local var_177_0 = {
			zh = 10.4,
			ja = 13.7
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play120411045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.4

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(120411044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 54 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 54)

				if (54 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 54)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411044", "story_v_out_120411.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411044", "story_v_out_120411.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_120411", "120411044", "story_v_out_120411.awb")

						arg_177_1:RecordAudio("120411044", var_180_6)
						arg_177_1:RecordAudio("120411044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_120411", "120411044", "story_v_out_120411.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_120411", "120411044", "story_v_out_120411.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play120411045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120411045
		arg_181_1.duration_ = 0.2

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"

			SetActive(arg_181_1.choicesGo_, true)

			for iter_182_0, iter_182_1 in ipairs(arg_181_1.choices_) do
				SetActive(iter_182_1.go, iter_182_0 <= 1)
			end

			arg_181_1.choices_[1].txt.text = arg_181_1:FormatText(StoryChoiceCfg[386].name)
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play120411046(arg_181_1)
			end

			arg_181_1:RecordChoiceLog(120411045, 386)
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1029ui_story"]) and arg_181_1.var_.characterEffect1029ui_story == nil then
				arg_181_1.var_.characterEffect1029ui_story = arg_181_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1029ui_story"]) then
				if arg_181_1.var_.characterEffect1029ui_story and not isNil(arg_181_1.actors_["1029ui_story"]) then
					arg_181_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1029ui_story"]) and arg_181_1.var_.characterEffect1029ui_story then
				arg_181_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play120411046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120411046
		arg_185_1.duration_ = 8.47

		local var_185_0 = {
			zh = 7.5,
			ja = 8.466
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play120411047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1029ui_story"]) and arg_185_1.var_.characterEffect1029ui_story == nil then
				arg_185_1.var_.characterEffect1029ui_story = arg_185_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1029ui_story"]) then
				if arg_185_1.var_.characterEffect1029ui_story and not isNil(arg_185_1.actors_["1029ui_story"]) then
					arg_185_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1029ui_story"]) and arg_185_1.var_.characterEffect1029ui_story then
				arg_185_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_188_2 = 0
			local var_188_3 = 0.775

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(120411046)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 31 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 31)

				if (31 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 31)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411046", "story_v_out_120411.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411046", "story_v_out_120411.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_out_120411", "120411046", "story_v_out_120411.awb")

						arg_185_1:RecordAudio("120411046", var_188_9)
						arg_185_1:RecordAudio("120411046", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_120411", "120411046", "story_v_out_120411.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_120411", "120411046", "story_v_out_120411.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play120411047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120411047
		arg_189_1.duration_ = 5

		local var_189_0 = {
			zh = 4.5,
			ja = 5
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
				arg_189_0:Play120411048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_192_0 = 0
			local var_192_1 = 0.35

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(120411047)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 14 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 14)

				if (14 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 14)) > 0 and var_192_1 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411047", "story_v_out_120411.awb") ~= 0 then
					local var_192_6 = manager.audio:GetVoiceLength("story_v_out_120411", "120411047", "story_v_out_120411.awb") / 1000

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end

					if var_192_2.prefab_name ~= "" and arg_189_1.actors_[var_192_2.prefab_name] ~= nil then
						local var_192_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_2.prefab_name].transform, "story_v_out_120411", "120411047", "story_v_out_120411.awb")

						arg_189_1:RecordAudio("120411047", var_192_7)
						arg_189_1:RecordAudio("120411047", var_192_7)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_120411", "120411047", "story_v_out_120411.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_120411", "120411047", "story_v_out_120411.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play120411048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120411048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play120411049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1029ui_story"]) and arg_193_1.var_.characterEffect1029ui_story == nil then
				arg_193_1.var_.characterEffect1029ui_story = arg_193_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1029ui_story"]) then
				if arg_193_1.var_.characterEffect1029ui_story and not isNil(arg_193_1.actors_["1029ui_story"]) then
					arg_193_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1029ui_story"]) and arg_193_1.var_.characterEffect1029ui_story then
				arg_193_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.15

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
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

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(120411048).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 6 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 6)

				if (6 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 6)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play120411049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120411049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play120411050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1029ui_story = arg_197_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1029ui_story"].transform.position).z)
				arg_197_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1029ui_story"].transform.localEulerAngles = arg_197_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1029ui_story"].transform.position).z)
				arg_197_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1029ui_story"].transform.localEulerAngles = arg_197_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_knock", "")
			end

			local var_200_2 = arg_197_1.actors_["1084ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1084ui_story = var_200_2.localPosition
			end

			local var_200_3 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 then
				var_200_2.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_3)
				var_200_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_2.position).x, (manager.ui.mainCamera.transform.position - var_200_2.position).y, (manager.ui.mainCamera.transform.position - var_200_2.position).z)
				var_200_2.localEulerAngles.z = 0
				var_200_2.localEulerAngles.x = 0
				var_200_2.localEulerAngles = var_200_2.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 then
				var_200_2.localPosition = Vector3.New(0, 100, 0)
				var_200_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_2.position).x, (manager.ui.mainCamera.transform.position - var_200_2.position).y, (manager.ui.mainCamera.transform.position - var_200_2.position).z)
				var_200_2.localEulerAngles.z = 0
				var_200_2.localEulerAngles.x = 0
				var_200_2.localEulerAngles = var_200_2.localEulerAngles
			end

			local var_200_4 = 0
			local var_200_5 = 0.1

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(120411049).content)

				arg_197_1.text_.text = var_200_6

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_8 = 4 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_6) / 4)

				if (4 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_6) / 4)) > 0 and var_200_5 < var_200_8 then
					arg_197_1.talkMaxDuration = var_200_8

					if var_200_8 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_6
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_9 and arg_197_1.time_ < var_200_4 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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

		arg_197_1:InitPlayNodeList()
	end,
	Play120411050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120411050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play120411051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.825

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(120411050).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 33 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 33)

				if (33 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 33)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play120411051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120411051
		arg_205_1.duration_ = 7

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play120411052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door06", "")
			end

			local var_208_1 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_2 = 2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = Color.New(0, 0, 0)

				var_208_3.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_1) / var_208_2)
				arg_205_1.mask_.color = var_208_3
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				local var_208_4 = Color.New(0, 0, 0)

				var_208_4.a = 1
				arg_205_1.mask_.color = var_208_4
			end

			local var_208_5 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_6 = 2

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 then
				local var_208_7 = Color.New(0, 0, 0)

				var_208_7.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_5) / var_208_6)
				arg_205_1.mask_.color = var_208_7
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 then
				local var_208_8 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_8.a = 0
				arg_205_1.mask_.color = var_208_8
			end

			local var_208_9 = "1076ui_story"

			if arg_205_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_208_10 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_205_1.stage_.transform)

				var_208_10.name = var_208_9
				var_208_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_[var_208_9] = var_208_10

				local var_208_11 = var_208_10:GetComponentInChildren(typeof(CharacterEffect))

				var_208_11.enabled = true

				local var_208_12 = GameObjectTools.GetOrAddComponent(var_208_10, typeof(DynamicBoneHelper))

				if var_208_12 then
					var_208_12:EnableDynamicBone(false)
				end

				arg_205_1:ShowWeapon(var_208_11.transform, false)

				arg_205_1.var_[var_208_9 .. "Animator"] = var_208_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_205_1.var_[var_208_9 .. "Animator"].applyRootMotion = true
				arg_205_1.var_[var_208_9 .. "LipSync"] = var_208_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_208_13 = arg_205_1.actors_["1076ui_story"].transform

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				arg_205_1.var_.moveOldPos1076ui_story = var_208_13.localPosition
			end

			local var_208_14 = 0.001

			if 2 <= arg_205_1.time_ and arg_205_1.time_ < 2 + var_208_14 then
				var_208_13.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_205_1.time_ - 2) / var_208_14)
				var_208_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_13.position).x, (manager.ui.mainCamera.transform.position - var_208_13.position).y, (manager.ui.mainCamera.transform.position - var_208_13.position).z)
				var_208_13.localEulerAngles.z = 0
				var_208_13.localEulerAngles.x = 0
				var_208_13.localEulerAngles = var_208_13.localEulerAngles
			end

			if arg_205_1.time_ >= 2 + var_208_14 and arg_205_1.time_ < 2 + var_208_14 + arg_208_0 then
				var_208_13.localPosition = Vector3.New(0, -1.06, -6.2)
				var_208_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_13.position).x, (manager.ui.mainCamera.transform.position - var_208_13.position).y, (manager.ui.mainCamera.transform.position - var_208_13.position).z)
				var_208_13.localEulerAngles.z = 0
				var_208_13.localEulerAngles.x = 0
				var_208_13.localEulerAngles = var_208_13.localEulerAngles
			end

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				arg_205_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				arg_205_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_208_15 = arg_205_1.actors_["1076ui_story"]

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.characterEffect1076ui_story == nil then
				arg_205_1.var_.characterEffect1076ui_story = var_208_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_16 = 0.0166666666666667

			if 2 <= arg_205_1.time_ and arg_205_1.time_ < 2 + var_208_16 and not isNil(var_208_15) then
				if arg_205_1.var_.characterEffect1076ui_story and not isNil(var_208_15) then
					arg_205_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 2) / var_208_16)
				end
			end

			if arg_205_1.time_ >= 2 + var_208_16 and arg_205_1.time_ < 2 + var_208_16 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.characterEffect1076ui_story then
				arg_205_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_17 = 2
			local var_208_18 = 0.05

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_19 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_19:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_20 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(120411051).content)

				arg_205_1.text_.text = var_208_20

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_22 = 2 <= 0 and var_208_18 or var_208_18 * (utf8.len(var_208_20) / 2)

				if (2 <= 0 and var_208_18 or var_208_18 * (utf8.len(var_208_20) / 2)) > 0 and var_208_18 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22
					var_208_17 = var_208_17 + 0.3

					if var_208_22 + var_208_17 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_17
					end
				end

				arg_205_1.text_.text = var_208_20
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_23 = var_208_17 + 0.3
			local var_208_24 = math.max(var_208_18, arg_205_1.talkMaxDuration)

			if var_208_17 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_23) / var_208_24

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play120411052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 120411052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play120411053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.125

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
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

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(120411052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 5 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 5)

				if (5 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 5)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play120411053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 120411053
		arg_215_1.duration_ = 3

		local var_215_0 = {
			zh = 2.366,
			ja = 3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play120411054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1076ui_story"]) and arg_215_1.var_.characterEffect1076ui_story == nil then
				arg_215_1.var_.characterEffect1076ui_story = arg_215_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1076ui_story"]) then
				if arg_215_1.var_.characterEffect1076ui_story and not isNil(arg_215_1.actors_["1076ui_story"]) then
					arg_215_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1076ui_story"]) and arg_215_1.var_.characterEffect1076ui_story then
				arg_215_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_218_2 = 0
			local var_218_3 = 0.45

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:GetWordFromCfg(120411053)
				local var_218_5 = arg_215_1:FormatText(var_218_4.content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 18 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 18)

				if (18 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 18)) > 0 and var_218_3 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_2
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411053", "story_v_out_120411.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411053", "story_v_out_120411.awb") / 1000

					if var_218_8 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_2
					end

					if var_218_4.prefab_name ~= "" and arg_215_1.actors_[var_218_4.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_4.prefab_name].transform, "story_v_out_120411", "120411053", "story_v_out_120411.awb")

						arg_215_1:RecordAudio("120411053", var_218_9)
						arg_215_1:RecordAudio("120411053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_120411", "120411053", "story_v_out_120411.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_120411", "120411053", "story_v_out_120411.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_3, arg_215_1.talkMaxDuration)

			if var_218_2 <= arg_215_1.time_ and arg_215_1.time_ < var_218_2 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_2) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_2 + var_218_10 and arg_215_1.time_ < var_218_2 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play120411054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 120411054
		arg_219_1.duration_ = 2.07

		local var_219_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play120411055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1076ui_story"]) and arg_219_1.var_.characterEffect1076ui_story == nil then
				arg_219_1.var_.characterEffect1076ui_story = arg_219_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1076ui_story"]) then
				if arg_219_1.var_.characterEffect1076ui_story and not isNil(arg_219_1.actors_["1076ui_story"]) then
					arg_219_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1076ui_story"]) and arg_219_1.var_.characterEffect1076ui_story then
				arg_219_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_222_1 = arg_219_1.actors_["1076ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1076ui_story = var_222_1.localPosition
			end

			local var_222_2 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 then
				var_222_1.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_219_1.time_ - 0) / var_222_2)
				var_222_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_1.position).x, (manager.ui.mainCamera.transform.position - var_222_1.position).y, (manager.ui.mainCamera.transform.position - var_222_1.position).z)
				var_222_1.localEulerAngles.z = 0
				var_222_1.localEulerAngles.x = 0
				var_222_1.localEulerAngles = var_222_1.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 then
				var_222_1.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_222_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_1.position).x, (manager.ui.mainCamera.transform.position - var_222_1.position).y, (manager.ui.mainCamera.transform.position - var_222_1.position).z)
				var_222_1.localEulerAngles.z = 0
				var_222_1.localEulerAngles.x = 0
				var_222_1.localEulerAngles = var_222_1.localEulerAngles
			end

			local var_222_3 = arg_219_1.actors_["1084ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_3.localPosition
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_3.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_219_1.time_ - 0) / var_222_4)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_222_5 = arg_219_1.actors_["1084ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_6 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 and not isNil(var_222_5) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_5) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_222_8 = 0
			local var_222_9 = 0.125

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:GetWordFromCfg(120411054)
				local var_222_11 = arg_219_1:FormatText(var_222_10.content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 5 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 5)

				if (5 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 5)) > 0 and var_222_9 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411054", "story_v_out_120411.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411054", "story_v_out_120411.awb") / 1000

					if var_222_14 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_8
					end

					if var_222_10.prefab_name ~= "" and arg_219_1.actors_[var_222_10.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_10.prefab_name].transform, "story_v_out_120411", "120411054", "story_v_out_120411.awb")

						arg_219_1:RecordAudio("120411054", var_222_15)
						arg_219_1:RecordAudio("120411054", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_120411", "120411054", "story_v_out_120411.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_120411", "120411054", "story_v_out_120411.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_16 and arg_219_1.time_ < var_222_8 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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

		arg_219_1:InitPlayNodeList()
	end,
	Play120411055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 120411055
		arg_223_1.duration_ = 2.67

		local var_223_0 = {
			zh = 1.466,
			ja = 2.666
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play120411056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) and arg_223_1.var_.characterEffect1084ui_story == nil then
				arg_223_1.var_.characterEffect1084ui_story = arg_223_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) then
				if arg_223_1.var_.characterEffect1084ui_story and not isNil(arg_223_1.actors_["1084ui_story"]) then
					arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) and arg_223_1.var_.characterEffect1084ui_story then
				arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_226_1 = arg_223_1.actors_["1076ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1076ui_story == nil then
				arg_223_1.var_.characterEffect1076ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1076ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1076ui_story then
				arg_223_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_226_4 = 0
			local var_226_5 = 0.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(120411055)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)

				if (8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411055", "story_v_out_120411.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411055", "story_v_out_120411.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_120411", "120411055", "story_v_out_120411.awb")

						arg_223_1:RecordAudio("120411055", var_226_11)
						arg_223_1:RecordAudio("120411055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_120411", "120411055", "story_v_out_120411.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_120411", "120411055", "story_v_out_120411.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play120411056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 120411056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play120411057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1076ui_story"]) and arg_227_1.var_.characterEffect1076ui_story == nil then
				arg_227_1.var_.characterEffect1076ui_story = arg_227_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1076ui_story"]) then
				if arg_227_1.var_.characterEffect1076ui_story and not isNil(arg_227_1.actors_["1076ui_story"]) then
					arg_227_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1076ui_story"]) and arg_227_1.var_.characterEffect1076ui_story then
				arg_227_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.325

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(120411056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 13 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 13)

				if (13 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 13)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play120411057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 120411057
		arg_231_1.duration_ = 5.87

		local var_231_0 = {
			zh = 3.933,
			ja = 5.866
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play120411058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = arg_231_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).z)
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles = arg_231_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).z)
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles = arg_231_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1029ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1029ui_story = var_234_1.localPosition
			end

			local var_234_2 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 then
				var_234_1.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_231_1.time_ - 0) / var_234_2)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 then
				var_234_1.localPosition = Vector3.New(0.7, -1.09, -6.2)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_234_3 = arg_231_1.actors_["1029ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1029ui_story == nil then
				arg_231_1.var_.characterEffect1029ui_story = var_234_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_4 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 and not isNil(var_234_3) then
				if arg_231_1.var_.characterEffect1029ui_story and not isNil(var_234_3) then
					arg_231_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1029ui_story then
				arg_231_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_234_6 = 0
			local var_234_7 = 0.525

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_8 = arg_231_1:GetWordFromCfg(120411057)
				local var_234_9 = arg_231_1:FormatText(var_234_8.content)

				arg_231_1.text_.text = var_234_9

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 21 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 21)

				if (21 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 21)) > 0 and var_234_7 < var_234_11 then
					arg_231_1.talkMaxDuration = var_234_11

					if var_234_11 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_9
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411057", "story_v_out_120411.awb") ~= 0 then
					local var_234_12 = manager.audio:GetVoiceLength("story_v_out_120411", "120411057", "story_v_out_120411.awb") / 1000

					if var_234_12 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_6
					end

					if var_234_8.prefab_name ~= "" and arg_231_1.actors_[var_234_8.prefab_name] ~= nil then
						local var_234_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_8.prefab_name].transform, "story_v_out_120411", "120411057", "story_v_out_120411.awb")

						arg_231_1:RecordAudio("120411057", var_234_13)
						arg_231_1:RecordAudio("120411057", var_234_13)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_120411", "120411057", "story_v_out_120411.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_120411", "120411057", "story_v_out_120411.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play120411058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 120411058
		arg_235_1.duration_ = 7.5

		local var_235_0 = {
			zh = 5.166,
			ja = 7.5
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play120411059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1076ui_story"]) and arg_235_1.var_.characterEffect1076ui_story == nil then
				arg_235_1.var_.characterEffect1076ui_story = arg_235_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1076ui_story"]) then
				if arg_235_1.var_.characterEffect1076ui_story and not isNil(arg_235_1.actors_["1076ui_story"]) then
					arg_235_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1076ui_story"]) and arg_235_1.var_.characterEffect1076ui_story then
				arg_235_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_238_2 = arg_235_1.actors_["1029ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1029ui_story == nil then
				arg_235_1.var_.characterEffect1029ui_story = var_238_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_3 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.characterEffect1029ui_story and not isNil(var_238_2) then
					arg_235_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_3)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1029ui_story then
				arg_235_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_238_4 = 0
			local var_238_5 = 0.6

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(120411058)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 23 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 23)

				if (23 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 23)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411058", "story_v_out_120411.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411058", "story_v_out_120411.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_out_120411", "120411058", "story_v_out_120411.awb")

						arg_235_1:RecordAudio("120411058", var_238_11)
						arg_235_1:RecordAudio("120411058", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_120411", "120411058", "story_v_out_120411.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_120411", "120411058", "story_v_out_120411.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play120411059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 120411059
		arg_239_1.duration_ = 8.1

		local var_239_0 = {
			zh = 6.6,
			ja = 8.1
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play120411060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1076ui_story"]) and arg_239_1.var_.characterEffect1076ui_story == nil then
				arg_239_1.var_.characterEffect1076ui_story = arg_239_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1076ui_story"]) then
				if arg_239_1.var_.characterEffect1076ui_story and not isNil(arg_239_1.actors_["1076ui_story"]) then
					arg_239_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1076ui_story"]) and arg_239_1.var_.characterEffect1076ui_story then
				arg_239_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_242_1 = arg_239_1.actors_["1029ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1029ui_story == nil then
				arg_239_1.var_.characterEffect1029ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1029ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1029ui_story then
				arg_239_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_242_4 = 0
			local var_242_5 = 0.725

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(120411059)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 28 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 28)

				if (28 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 28)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411059", "story_v_out_120411.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411059", "story_v_out_120411.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_120411", "120411059", "story_v_out_120411.awb")

						arg_239_1:RecordAudio("120411059", var_242_11)
						arg_239_1:RecordAudio("120411059", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_120411", "120411059", "story_v_out_120411.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_120411", "120411059", "story_v_out_120411.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play120411060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 120411060
		arg_243_1.duration_ = 5.63

		local var_243_0 = {
			zh = 5.333,
			ja = 5.633
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play120411061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.7

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(120411060)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 28 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 28)

				if (28 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 28)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411060", "story_v_out_120411.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411060", "story_v_out_120411.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_120411", "120411060", "story_v_out_120411.awb")

						arg_243_1:RecordAudio("120411060", var_246_6)
						arg_243_1:RecordAudio("120411060", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_120411", "120411060", "story_v_out_120411.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_120411", "120411060", "story_v_out_120411.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play120411061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 120411061
		arg_247_1.duration_ = 2.97

		local var_247_0 = {
			zh = 2.966,
			ja = 2.333
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play120411062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1076ui_story"]) and arg_247_1.var_.characterEffect1076ui_story == nil then
				arg_247_1.var_.characterEffect1076ui_story = arg_247_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1076ui_story"]) then
				if arg_247_1.var_.characterEffect1076ui_story and not isNil(arg_247_1.actors_["1076ui_story"]) then
					arg_247_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1076ui_story"]) and arg_247_1.var_.characterEffect1076ui_story then
				arg_247_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_250_2 = arg_247_1.actors_["1029ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect1029ui_story == nil then
				arg_247_1.var_.characterEffect1029ui_story = var_250_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_3 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.characterEffect1029ui_story and not isNil(var_250_2) then
					arg_247_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_3)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect1029ui_story then
				arg_247_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_250_4 = 0
			local var_250_5 = 0.275

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(120411061)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 11 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 11)

				if (11 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 11)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411061", "story_v_out_120411.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411061", "story_v_out_120411.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_120411", "120411061", "story_v_out_120411.awb")

						arg_247_1:RecordAudio("120411061", var_250_11)
						arg_247_1:RecordAudio("120411061", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_120411", "120411061", "story_v_out_120411.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_120411", "120411061", "story_v_out_120411.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play120411062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 120411062
		arg_251_1.duration_ = 6.8

		local var_251_0 = {
			zh = 3.166,
			ja = 6.8
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play120411063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.375

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(120411062)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 15 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 15)

				if (15 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 15)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411062", "story_v_out_120411.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411062", "story_v_out_120411.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_120411", "120411062", "story_v_out_120411.awb")

						arg_251_1:RecordAudio("120411062", var_254_6)
						arg_251_1:RecordAudio("120411062", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_120411", "120411062", "story_v_out_120411.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_120411", "120411062", "story_v_out_120411.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play120411063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 120411063
		arg_255_1.duration_ = 11.53

		local var_255_0 = {
			zh = 5.033,
			ja = 11.533
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play120411064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1076ui_story"]) and arg_255_1.var_.characterEffect1076ui_story == nil then
				arg_255_1.var_.characterEffect1076ui_story = arg_255_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1076ui_story"]) then
				if arg_255_1.var_.characterEffect1076ui_story and not isNil(arg_255_1.actors_["1076ui_story"]) then
					arg_255_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1076ui_story"]) and arg_255_1.var_.characterEffect1076ui_story then
				arg_255_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_258_1 = arg_255_1.actors_["1029ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1029ui_story == nil then
				arg_255_1.var_.characterEffect1029ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1029ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1029ui_story then
				arg_255_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_2")
			end

			local var_258_4 = 0
			local var_258_5 = 0.55

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(120411063)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 22 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 22)

				if (22 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 22)) > 0 and var_258_5 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9

					if var_258_9 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411063", "story_v_out_120411.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411063", "story_v_out_120411.awb") / 1000

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end

					if var_258_6.prefab_name ~= "" and arg_255_1.actors_[var_258_6.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_6.prefab_name].transform, "story_v_out_120411", "120411063", "story_v_out_120411.awb")

						arg_255_1:RecordAudio("120411063", var_258_11)
						arg_255_1:RecordAudio("120411063", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_120411", "120411063", "story_v_out_120411.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_120411", "120411063", "story_v_out_120411.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_12 and arg_255_1.time_ < var_258_4 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play120411064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 120411064
		arg_259_1.duration_ = 7.77

		local var_259_0 = {
			zh = 3.866,
			ja = 7.766
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play120411065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1076ui_story"]) and arg_259_1.var_.characterEffect1076ui_story == nil then
				arg_259_1.var_.characterEffect1076ui_story = arg_259_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1076ui_story"]) then
				if arg_259_1.var_.characterEffect1076ui_story and not isNil(arg_259_1.actors_["1076ui_story"]) then
					arg_259_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1076ui_story"]) and arg_259_1.var_.characterEffect1076ui_story then
				arg_259_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_262_2 = arg_259_1.actors_["1029ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1029ui_story == nil then
				arg_259_1.var_.characterEffect1029ui_story = var_262_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_3 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.characterEffect1029ui_story and not isNil(var_262_2) then
					arg_259_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_3)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1029ui_story then
				arg_259_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_262_4 = 0
			local var_262_5 = 0.35

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(120411064)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 14 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 14)

				if (14 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 14)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411064", "story_v_out_120411.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411064", "story_v_out_120411.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_120411", "120411064", "story_v_out_120411.awb")

						arg_259_1:RecordAudio("120411064", var_262_11)
						arg_259_1:RecordAudio("120411064", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_120411", "120411064", "story_v_out_120411.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_120411", "120411064", "story_v_out_120411.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play120411065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 120411065
		arg_263_1.duration_ = 5.77

		local var_263_0 = {
			zh = 3.933,
			ja = 5.766
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play120411066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1076ui_story"]) and arg_263_1.var_.characterEffect1076ui_story == nil then
				arg_263_1.var_.characterEffect1076ui_story = arg_263_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1076ui_story"]) then
				if arg_263_1.var_.characterEffect1076ui_story and not isNil(arg_263_1.actors_["1076ui_story"]) then
					arg_263_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1076ui_story"]) and arg_263_1.var_.characterEffect1076ui_story then
				arg_263_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_266_1 = arg_263_1.actors_["1029ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1029ui_story == nil then
				arg_263_1.var_.characterEffect1029ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1029ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1029ui_story then
				arg_263_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_266_4 = 0
			local var_266_5 = 0.25

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(120411065)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 10 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 10)

				if (10 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 10)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411065", "story_v_out_120411.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411065", "story_v_out_120411.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_120411", "120411065", "story_v_out_120411.awb")

						arg_263_1:RecordAudio("120411065", var_266_11)
						arg_263_1:RecordAudio("120411065", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_120411", "120411065", "story_v_out_120411.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_120411", "120411065", "story_v_out_120411.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play120411066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 120411066
		arg_267_1.duration_ = 9

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play120411067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if arg_267_1.bgs_.J05f == nil then
				local var_270_0 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J05f")
				var_270_0.name = "J05f"
				var_270_0.transform.parent = arg_267_1.stage_.transform
				var_270_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_.J05f = var_270_0
			end

			if 2 < arg_267_1.time_ and arg_267_1.time_ <= 2 + arg_270_0 then
				local var_270_1 = arg_267_1.bgs_.J05f

				arg_267_1.bgs_.J05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_2 = var_270_1:GetComponent("SpriteRenderer")

				if var_270_2 and var_270_2.sprite then
					local var_270_3 = 2 * (var_270_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_1.transform.localScale = Vector3.New(var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "J05f" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_4 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_5 = 2

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_5 then
				local var_270_6 = Color.New(0, 0, 0)

				var_270_6.a = Mathf.Lerp(0, 1, (arg_267_1.time_ - var_270_4) / var_270_5)
				arg_267_1.mask_.color = var_270_6
			end

			if arg_267_1.time_ >= var_270_4 + var_270_5 and arg_267_1.time_ < var_270_4 + var_270_5 + arg_270_0 then
				local var_270_7 = Color.New(0, 0, 0)

				var_270_7.a = 1
				arg_267_1.mask_.color = var_270_7
			end

			local var_270_8 = 2

			if 2 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_9 = 2

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_9 then
				local var_270_10 = Color.New(0, 0, 0)

				var_270_10.a = Mathf.Lerp(1, 0, (arg_267_1.time_ - var_270_8) / var_270_9)
				arg_267_1.mask_.color = var_270_10
			end

			if arg_267_1.time_ >= var_270_8 + var_270_9 and arg_267_1.time_ < var_270_8 + var_270_9 + arg_270_0 then
				local var_270_11 = Color.New(0, 0, 0)

				arg_267_1.mask_.enabled = false
				var_270_11.a = 0
				arg_267_1.mask_.color = var_270_11
			end

			local var_270_12 = arg_267_1.actors_["1029ui_story"].transform

			if 1.966 < arg_267_1.time_ and arg_267_1.time_ <= 1.966 + arg_270_0 then
				arg_267_1.var_.moveOldPos1029ui_story = var_270_12.localPosition
			end

			local var_270_13 = 0.001

			if 1.966 <= arg_267_1.time_ and arg_267_1.time_ < 1.966 + var_270_13 then
				var_270_12.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 1.966) / var_270_13)
				var_270_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_12.position).x, (manager.ui.mainCamera.transform.position - var_270_12.position).y, (manager.ui.mainCamera.transform.position - var_270_12.position).z)
				var_270_12.localEulerAngles.z = 0
				var_270_12.localEulerAngles.x = 0
				var_270_12.localEulerAngles = var_270_12.localEulerAngles
			end

			if arg_267_1.time_ >= 1.966 + var_270_13 and arg_267_1.time_ < 1.966 + var_270_13 + arg_270_0 then
				var_270_12.localPosition = Vector3.New(0, 100, 0)
				var_270_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_12.position).x, (manager.ui.mainCamera.transform.position - var_270_12.position).y, (manager.ui.mainCamera.transform.position - var_270_12.position).z)
				var_270_12.localEulerAngles.z = 0
				var_270_12.localEulerAngles.x = 0
				var_270_12.localEulerAngles = var_270_12.localEulerAngles
			end

			local var_270_14 = arg_267_1.actors_["1076ui_story"].transform

			if 1.966 < arg_267_1.time_ and arg_267_1.time_ <= 1.966 + arg_270_0 then
				arg_267_1.var_.moveOldPos1076ui_story = var_270_14.localPosition
			end

			local var_270_15 = 0.001

			if 1.966 <= arg_267_1.time_ and arg_267_1.time_ < 1.966 + var_270_15 then
				var_270_14.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 1.966) / var_270_15)
				var_270_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_14.position).x, (manager.ui.mainCamera.transform.position - var_270_14.position).y, (manager.ui.mainCamera.transform.position - var_270_14.position).z)
				var_270_14.localEulerAngles.z = 0
				var_270_14.localEulerAngles.x = 0
				var_270_14.localEulerAngles = var_270_14.localEulerAngles
			end

			if arg_267_1.time_ >= 1.966 + var_270_15 and arg_267_1.time_ < 1.966 + var_270_15 + arg_270_0 then
				var_270_14.localPosition = Vector3.New(0, 100, 0)
				var_270_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_14.position).x, (manager.ui.mainCamera.transform.position - var_270_14.position).y, (manager.ui.mainCamera.transform.position - var_270_14.position).z)
				var_270_14.localEulerAngles.z = 0
				var_270_14.localEulerAngles.x = 0
				var_270_14.localEulerAngles = var_270_14.localEulerAngles
			end

			if 0.466666666666667 < arg_267_1.time_ and arg_267_1.time_ <= 0.466666666666667 + arg_270_0 then
				arg_267_1:AudioAction("play", "music", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_270_18 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

				if "" ~= "" then
					if arg_267_1.bgmTxt_.text ~= var_270_18 and arg_267_1.bgmTxt_.text ~= "" then
						if arg_267_1.bgmTxt2_.text ~= "" then
							arg_267_1.bgmTxt_.text = arg_267_1.bgmTxt2_.text
						end

						arg_267_1.bgmTxt2_.text = var_270_18

						arg_267_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_267_1.bgmTxt_.text = var_270_18
						arg_267_1.bgmTxt2_.text = var_270_18
					end

					if arg_267_1.bgmTimer then
						arg_267_1.bgmTimer:Stop()

						arg_267_1.bgmTimer = nil
					end

					if arg_267_1.settingData.show_music_name == 1 then
						arg_267_1.musicController:SetSelectedState("show")
						arg_267_1.musicAnimator_:Play("open", 0, 0)

						if arg_267_1.settingData.music_time ~= 0 then
							arg_267_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_267_1.settingData.music_time), function()
								if arg_267_1 == nil or isNil(arg_267_1.bgmTxt_) then
									return
								end

								arg_267_1.musicController:SetSelectedState("hide")
								arg_267_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_270_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_267_1.bgmTxt_.text ~= var_270_21 and arg_267_1.bgmTxt_.text ~= "" then
						if arg_267_1.bgmTxt2_.text ~= "" then
							arg_267_1.bgmTxt_.text = arg_267_1.bgmTxt2_.text
						end

						arg_267_1.bgmTxt2_.text = var_270_21

						arg_267_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_267_1.bgmTxt_.text = var_270_21
						arg_267_1.bgmTxt2_.text = var_270_21
					end

					if arg_267_1.bgmTimer then
						arg_267_1.bgmTimer:Stop()

						arg_267_1.bgmTimer = nil
					end

					if arg_267_1.settingData.show_music_name == 1 then
						arg_267_1.musicController:SetSelectedState("show")
						arg_267_1.musicAnimator_:Play("open", 0, 0)

						if arg_267_1.settingData.music_time ~= 0 then
							arg_267_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_267_1.settingData.music_time), function()
								if arg_267_1 == nil or isNil(arg_267_1.bgmTxt_) then
									return
								end

								arg_267_1.musicController:SetSelectedState("hide")
								arg_267_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_22 = 4
			local var_270_23 = 1.125

			if 4 < arg_267_1.time_ and arg_267_1.time_ <= var_270_22 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_24 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_24:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_267_1.dialogCg_.alpha = arg_273_0
				end))
				var_270_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_25 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(120411066).content)

				arg_267_1.text_.text = var_270_25

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_27 = 45 <= 0 and var_270_23 or var_270_23 * (utf8.len(var_270_25) / 45)

				if (45 <= 0 and var_270_23 or var_270_23 * (utf8.len(var_270_25) / 45)) > 0 and var_270_23 < var_270_27 then
					arg_267_1.talkMaxDuration = var_270_27
					var_270_22 = var_270_22 + 0.3

					if var_270_27 + var_270_22 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_27 + var_270_22
					end
				end

				arg_267_1.text_.text = var_270_25
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_28 = var_270_22 + 0.3
			local var_270_29 = math.max(var_270_23, arg_267_1.talkMaxDuration)

			if var_270_22 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_28 + var_270_29 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_28) / var_270_29

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_28 + var_270_29 and arg_267_1.time_ < var_270_28 + var_270_29 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play120411067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 120411067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play120411068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 1.45

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(120411067).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 58 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 58)

				if (58 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 58)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play120411068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 120411068
		arg_279_1.duration_ = 1.63

		local var_279_0 = {
			zh = 0.999999999999,
			ja = 1.633
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play120411069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.05

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_1 = arg_279_1:GetWordFromCfg(120411068)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 2 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 2)

				if (2 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 2)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411068", "story_v_out_120411.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411068", "story_v_out_120411.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_out_120411", "120411068", "story_v_out_120411.awb")

						arg_279_1:RecordAudio("120411068", var_282_6)
						arg_279_1:RecordAudio("120411068", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_120411", "120411068", "story_v_out_120411.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_120411", "120411068", "story_v_out_120411.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play120411069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 120411069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play120411070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.075

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(120411069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 43 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 43)

				if (43 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 43)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play120411070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 120411070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play120411071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.775

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(120411070).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 31 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 31)

				if (31 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 31)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play120411071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 120411071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play120411072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.75

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(120411071).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 30 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 30)

				if (30 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 30)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play120411072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 120411072
		arg_295_1.duration_ = 3.87

		local var_295_0 = {
			zh = 2.4,
			ja = 3.866
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play120411073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.1

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(120411072)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 4 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 4)

				if (4 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 4)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411072", "story_v_out_120411.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411072", "story_v_out_120411.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_120411", "120411072", "story_v_out_120411.awb")

						arg_295_1:RecordAudio("120411072", var_298_6)
						arg_295_1:RecordAudio("120411072", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_120411", "120411072", "story_v_out_120411.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_120411", "120411072", "story_v_out_120411.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play120411073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 120411073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play120411074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.9

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(120411073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 36 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 36)

				if (36 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 36)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play120411074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 120411074
		arg_303_1.duration_ = 7.97

		local var_303_0 = {
			zh = 7.966,
			ja = 7.333
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play120411075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if arg_303_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_306_0 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_303_1.stage_.transform)

				var_306_0.name = "1069ui_story"
				var_306_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.actors_["1069ui_story"] = var_306_0

				local var_306_1 = var_306_0:GetComponentInChildren(typeof(CharacterEffect))

				var_306_1.enabled = true

				local var_306_2 = GameObjectTools.GetOrAddComponent(var_306_0, typeof(DynamicBoneHelper))

				if var_306_2 then
					var_306_2:EnableDynamicBone(false)
				end

				arg_303_1:ShowWeapon(var_306_1.transform, false)

				arg_303_1.var_["1069ui_story" .. "Animator"] = var_306_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_303_1.var_["1069ui_story" .. "Animator"].applyRootMotion = true
				arg_303_1.var_["1069ui_story" .. "LipSync"] = var_306_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_306_3 = arg_303_1.actors_["1069ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1069ui_story = var_306_3.localPosition
			end

			local var_306_4 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				var_306_3.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_303_1.time_ - 0) / var_306_4)
				var_306_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_3.position).x, (manager.ui.mainCamera.transform.position - var_306_3.position).y, (manager.ui.mainCamera.transform.position - var_306_3.position).z)
				var_306_3.localEulerAngles.z = 0
				var_306_3.localEulerAngles.x = 0
				var_306_3.localEulerAngles = var_306_3.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				var_306_3.localPosition = Vector3.New(-0.7, -1, -6)
				var_306_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_3.position).x, (manager.ui.mainCamera.transform.position - var_306_3.position).y, (manager.ui.mainCamera.transform.position - var_306_3.position).z)
				var_306_3.localEulerAngles.z = 0
				var_306_3.localEulerAngles.x = 0
				var_306_3.localEulerAngles = var_306_3.localEulerAngles
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_306_5 = arg_303_1.actors_["1069ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.characterEffect1069ui_story == nil then
				arg_303_1.var_.characterEffect1069ui_story = var_306_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_6 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_6 and not isNil(var_306_5) then
				if arg_303_1.var_.characterEffect1069ui_story and not isNil(var_306_5) then
					arg_303_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_6 and arg_303_1.time_ < 0 + var_306_6 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.characterEffect1069ui_story then
				arg_303_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_306_8 = "1071ui_story"

			if arg_303_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_306_9 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_303_1.stage_.transform)

				var_306_9.name = var_306_8
				var_306_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.actors_[var_306_8] = var_306_9

				local var_306_10 = var_306_9:GetComponentInChildren(typeof(CharacterEffect))

				var_306_10.enabled = true

				local var_306_11 = GameObjectTools.GetOrAddComponent(var_306_9, typeof(DynamicBoneHelper))

				if var_306_11 then
					var_306_11:EnableDynamicBone(false)
				end

				arg_303_1:ShowWeapon(var_306_10.transform, false)

				arg_303_1.var_[var_306_8 .. "Animator"] = var_306_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_303_1.var_[var_306_8 .. "Animator"].applyRootMotion = true
				arg_303_1.var_[var_306_8 .. "LipSync"] = var_306_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_306_12 = 0
			local var_306_13 = 1.025

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_12 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_14 = arg_303_1:GetWordFromCfg(120411074)
				local var_306_15 = arg_303_1:FormatText(var_306_14.content)

				arg_303_1.text_.text = var_306_15

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_17 = 41 <= 0 and var_306_13 or var_306_13 * (utf8.len(var_306_15) / 41)

				if (41 <= 0 and var_306_13 or var_306_13 * (utf8.len(var_306_15) / 41)) > 0 and var_306_13 < var_306_17 then
					arg_303_1.talkMaxDuration = var_306_17

					if var_306_17 + var_306_12 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_17 + var_306_12
					end
				end

				arg_303_1.text_.text = var_306_15
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411074", "story_v_out_120411.awb") ~= 0 then
					local var_306_18 = manager.audio:GetVoiceLength("story_v_out_120411", "120411074", "story_v_out_120411.awb") / 1000

					if var_306_18 + var_306_12 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_18 + var_306_12
					end

					if var_306_14.prefab_name ~= "" and arg_303_1.actors_[var_306_14.prefab_name] ~= nil then
						local var_306_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_14.prefab_name].transform, "story_v_out_120411", "120411074", "story_v_out_120411.awb")

						arg_303_1:RecordAudio("120411074", var_306_19)
						arg_303_1:RecordAudio("120411074", var_306_19)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_120411", "120411074", "story_v_out_120411.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_120411", "120411074", "story_v_out_120411.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_20 = math.max(var_306_13, arg_303_1.talkMaxDuration)

			if var_306_12 <= arg_303_1.time_ and arg_303_1.time_ < var_306_12 + var_306_20 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_12) / var_306_20

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_12 + var_306_20 and arg_303_1.time_ < var_306_12 + var_306_20 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play120411075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 120411075
		arg_307_1.duration_ = 4.13

		local var_307_0 = {
			zh = 3.933,
			ja = 4.133
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play120411076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1069ui_story"]) and arg_307_1.var_.characterEffect1069ui_story == nil then
				arg_307_1.var_.characterEffect1069ui_story = arg_307_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1069ui_story"]) then
				if arg_307_1.var_.characterEffect1069ui_story and not isNil(arg_307_1.actors_["1069ui_story"]) then
					arg_307_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1069ui_story"]) and arg_307_1.var_.characterEffect1069ui_story then
				arg_307_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_310_1 = arg_307_1.actors_["1071ui_story"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1071ui_story = var_310_1.localPosition
			end

			local var_310_2 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 then
				var_310_1.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_307_1.time_ - 0) / var_310_2)
				var_310_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_1.position).x, (manager.ui.mainCamera.transform.position - var_310_1.position).y, (manager.ui.mainCamera.transform.position - var_310_1.position).z)
				var_310_1.localEulerAngles.z = 0
				var_310_1.localEulerAngles.x = 0
				var_310_1.localEulerAngles = var_310_1.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 then
				var_310_1.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_310_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_1.position).x, (manager.ui.mainCamera.transform.position - var_310_1.position).y, (manager.ui.mainCamera.transform.position - var_310_1.position).z)
				var_310_1.localEulerAngles.z = 0
				var_310_1.localEulerAngles.x = 0
				var_310_1.localEulerAngles = var_310_1.localEulerAngles
			end

			local var_310_3 = arg_307_1.actors_["1071ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_3) and arg_307_1.var_.characterEffect1071ui_story == nil then
				arg_307_1.var_.characterEffect1071ui_story = var_310_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_4 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 and not isNil(var_310_3) then
				if arg_307_1.var_.characterEffect1071ui_story and not isNil(var_310_3) then
					arg_307_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 and not isNil(var_310_3) and arg_307_1.var_.characterEffect1071ui_story then
				arg_307_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_310_6 = 0
			local var_310_7 = 0.45

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_8 = arg_307_1:GetWordFromCfg(120411075)
				local var_310_9 = arg_307_1:FormatText(var_310_8.content)

				arg_307_1.text_.text = var_310_9

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 18 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 18)

				if (18 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 18)) > 0 and var_310_7 < var_310_11 then
					arg_307_1.talkMaxDuration = var_310_11

					if var_310_11 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_9
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411075", "story_v_out_120411.awb") ~= 0 then
					local var_310_12 = manager.audio:GetVoiceLength("story_v_out_120411", "120411075", "story_v_out_120411.awb") / 1000

					if var_310_12 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_6
					end

					if var_310_8.prefab_name ~= "" and arg_307_1.actors_[var_310_8.prefab_name] ~= nil then
						local var_310_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_8.prefab_name].transform, "story_v_out_120411", "120411075", "story_v_out_120411.awb")

						arg_307_1:RecordAudio("120411075", var_310_13)
						arg_307_1:RecordAudio("120411075", var_310_13)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_120411", "120411075", "story_v_out_120411.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_120411", "120411075", "story_v_out_120411.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_14 and arg_307_1.time_ < var_310_6 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play120411076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 120411076
		arg_311_1.duration_ = 6.6

		local var_311_0 = {
			zh = 6.6,
			ja = 5.333
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play120411077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.75

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(120411076)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 30 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 30)

				if (30 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 30)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411076", "story_v_out_120411.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411076", "story_v_out_120411.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_120411", "120411076", "story_v_out_120411.awb")

						arg_311_1:RecordAudio("120411076", var_314_6)
						arg_311_1:RecordAudio("120411076", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_120411", "120411076", "story_v_out_120411.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_120411", "120411076", "story_v_out_120411.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play120411077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 120411077
		arg_315_1.duration_ = 9.1

		local var_315_0 = {
			zh = 3.6,
			ja = 9.1
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play120411078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1069ui_story"]) and arg_315_1.var_.characterEffect1069ui_story == nil then
				arg_315_1.var_.characterEffect1069ui_story = arg_315_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1069ui_story"]) then
				if arg_315_1.var_.characterEffect1069ui_story and not isNil(arg_315_1.actors_["1069ui_story"]) then
					arg_315_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1069ui_story"]) and arg_315_1.var_.characterEffect1069ui_story then
				arg_315_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_318_2 = arg_315_1.actors_["1071ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.characterEffect1071ui_story == nil then
				arg_315_1.var_.characterEffect1071ui_story = var_318_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_3 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.characterEffect1071ui_story and not isNil(var_318_2) then
					arg_315_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_3)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.characterEffect1071ui_story then
				arg_315_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_318_4 = 0
			local var_318_5 = 0.4

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_6 = arg_315_1:GetWordFromCfg(120411077)
				local var_318_7 = arg_315_1:FormatText(var_318_6.content)

				arg_315_1.text_.text = var_318_7

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_9 = 16 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 16)

				if (16 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 16)) > 0 and var_318_5 < var_318_9 then
					arg_315_1.talkMaxDuration = var_318_9

					if var_318_9 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_4
					end
				end

				arg_315_1.text_.text = var_318_7
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411077", "story_v_out_120411.awb") ~= 0 then
					local var_318_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411077", "story_v_out_120411.awb") / 1000

					if var_318_10 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_4
					end

					if var_318_6.prefab_name ~= "" and arg_315_1.actors_[var_318_6.prefab_name] ~= nil then
						local var_318_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_6.prefab_name].transform, "story_v_out_120411", "120411077", "story_v_out_120411.awb")

						arg_315_1:RecordAudio("120411077", var_318_11)
						arg_315_1:RecordAudio("120411077", var_318_11)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_120411", "120411077", "story_v_out_120411.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_120411", "120411077", "story_v_out_120411.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_12 = math.max(var_318_5, arg_315_1.talkMaxDuration)

			if var_318_4 <= arg_315_1.time_ and arg_315_1.time_ < var_318_4 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_4) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_4 + var_318_12 and arg_315_1.time_ < var_318_4 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play120411078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 120411078
		arg_319_1.duration_ = 9.87

		local var_319_0 = {
			zh = 5.966,
			ja = 9.866
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play120411079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_322_0 = 0
			local var_322_1 = 0.8

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_2 = arg_319_1:GetWordFromCfg(120411078)
				local var_322_3 = arg_319_1:FormatText(var_322_2.content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 32 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 32)

				if (32 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 32)) > 0 and var_322_1 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411078", "story_v_out_120411.awb") ~= 0 then
					local var_322_6 = manager.audio:GetVoiceLength("story_v_out_120411", "120411078", "story_v_out_120411.awb") / 1000

					if var_322_6 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_0
					end

					if var_322_2.prefab_name ~= "" and arg_319_1.actors_[var_322_2.prefab_name] ~= nil then
						local var_322_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_2.prefab_name].transform, "story_v_out_120411", "120411078", "story_v_out_120411.awb")

						arg_319_1:RecordAudio("120411078", var_322_7)
						arg_319_1:RecordAudio("120411078", var_322_7)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_120411", "120411078", "story_v_out_120411.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_120411", "120411078", "story_v_out_120411.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_8 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_8 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_8

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_8 and arg_319_1.time_ < var_322_0 + var_322_8 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play120411079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 120411079
		arg_323_1.duration_ = 5.13

		local var_323_0 = {
			zh = 4.033,
			ja = 5.133
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play120411080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1069ui_story"]) and arg_323_1.var_.characterEffect1069ui_story == nil then
				arg_323_1.var_.characterEffect1069ui_story = arg_323_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1069ui_story"]) then
				if arg_323_1.var_.characterEffect1069ui_story and not isNil(arg_323_1.actors_["1069ui_story"]) then
					arg_323_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1069ui_story"]) and arg_323_1.var_.characterEffect1069ui_story then
				arg_323_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_326_1 = arg_323_1.actors_["1071ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1071ui_story == nil then
				arg_323_1.var_.characterEffect1071ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1071ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1071ui_story then
				arg_323_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_326_4 = 0
			local var_326_5 = 0.55

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(120411079)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 22 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 22)

				if (22 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 22)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411079", "story_v_out_120411.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411079", "story_v_out_120411.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_out_120411", "120411079", "story_v_out_120411.awb")

						arg_323_1:RecordAudio("120411079", var_326_11)
						arg_323_1:RecordAudio("120411079", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_120411", "120411079", "story_v_out_120411.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_120411", "120411079", "story_v_out_120411.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play120411080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 120411080
		arg_327_1.duration_ = 4.1

		local var_327_0 = {
			zh = 3.366,
			ja = 4.1
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play120411081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1069ui_story"]) and arg_327_1.var_.characterEffect1069ui_story == nil then
				arg_327_1.var_.characterEffect1069ui_story = arg_327_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1069ui_story"]) then
				if arg_327_1.var_.characterEffect1069ui_story and not isNil(arg_327_1.actors_["1069ui_story"]) then
					arg_327_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1069ui_story"]) and arg_327_1.var_.characterEffect1069ui_story then
				arg_327_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_330_2 = arg_327_1.actors_["1071ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1071ui_story == nil then
				arg_327_1.var_.characterEffect1071ui_story = var_330_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_3 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.characterEffect1071ui_story and not isNil(var_330_2) then
					arg_327_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_3)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1071ui_story then
				arg_327_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_2")
			end

			local var_330_4 = 0
			local var_330_5 = 0.425

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(120411080)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 17 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 17)

				if (17 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 17)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411080", "story_v_out_120411.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411080", "story_v_out_120411.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_120411", "120411080", "story_v_out_120411.awb")

						arg_327_1:RecordAudio("120411080", var_330_11)
						arg_327_1:RecordAudio("120411080", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_120411", "120411080", "story_v_out_120411.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_120411", "120411080", "story_v_out_120411.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play120411081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 120411081
		arg_331_1.duration_ = 3.33

		local var_331_0 = {
			zh = 2.7,
			ja = 3.333
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play120411082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.3

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(120411081)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 12 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 12)

				if (12 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 12)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411081", "story_v_out_120411.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411081", "story_v_out_120411.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_120411", "120411081", "story_v_out_120411.awb")

						arg_331_1:RecordAudio("120411081", var_334_6)
						arg_331_1:RecordAudio("120411081", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_120411", "120411081", "story_v_out_120411.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_120411", "120411081", "story_v_out_120411.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play120411082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 120411082
		arg_335_1.duration_ = 7.57

		local var_335_0 = {
			zh = 4.333,
			ja = 7.566
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play120411083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1069ui_story"]) and arg_335_1.var_.characterEffect1069ui_story == nil then
				arg_335_1.var_.characterEffect1069ui_story = arg_335_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1069ui_story"]) then
				if arg_335_1.var_.characterEffect1069ui_story and not isNil(arg_335_1.actors_["1069ui_story"]) then
					arg_335_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1069ui_story"]) and arg_335_1.var_.characterEffect1069ui_story then
				arg_335_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_338_1 = arg_335_1.actors_["1071ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1071ui_story == nil then
				arg_335_1.var_.characterEffect1071ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1071ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1071ui_story then
				arg_335_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_338_4 = 0
			local var_338_5 = 0.525

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_6 = arg_335_1:GetWordFromCfg(120411082)
				local var_338_7 = arg_335_1:FormatText(var_338_6.content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 21 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 21)

				if (21 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 21)) > 0 and var_338_5 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411082", "story_v_out_120411.awb") ~= 0 then
					local var_338_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411082", "story_v_out_120411.awb") / 1000

					if var_338_10 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_4
					end

					if var_338_6.prefab_name ~= "" and arg_335_1.actors_[var_338_6.prefab_name] ~= nil then
						local var_338_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_6.prefab_name].transform, "story_v_out_120411", "120411082", "story_v_out_120411.awb")

						arg_335_1:RecordAudio("120411082", var_338_11)
						arg_335_1:RecordAudio("120411082", var_338_11)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_120411", "120411082", "story_v_out_120411.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_120411", "120411082", "story_v_out_120411.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_12 and arg_335_1.time_ < var_338_4 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play120411083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 120411083
		arg_339_1.duration_ = 7.6

		local var_339_0 = {
			zh = 7.6,
			ja = 7.533
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
				arg_339_0:Play120411084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.85

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:GetWordFromCfg(120411083)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 34 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 34)

				if (34 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 34)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411083", "story_v_out_120411.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411083", "story_v_out_120411.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_120411", "120411083", "story_v_out_120411.awb")

						arg_339_1:RecordAudio("120411083", var_342_6)
						arg_339_1:RecordAudio("120411083", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_120411", "120411083", "story_v_out_120411.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_120411", "120411083", "story_v_out_120411.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play120411084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 120411084
		arg_343_1.duration_ = 7.13

		local var_343_0 = {
			zh = 5.166,
			ja = 7.133
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
				arg_343_0:Play120411085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1071ui_story"]) and arg_343_1.var_.characterEffect1071ui_story == nil then
				arg_343_1.var_.characterEffect1071ui_story = arg_343_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1071ui_story"]) then
				if arg_343_1.var_.characterEffect1071ui_story and not isNil(arg_343_1.actors_["1071ui_story"]) then
					arg_343_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1071ui_story"]) and arg_343_1.var_.characterEffect1071ui_story then
				arg_343_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_346_1 = arg_343_1.actors_["1069ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1069ui_story == nil then
				arg_343_1.var_.characterEffect1069ui_story = var_346_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 and not isNil(var_346_1) then
				if arg_343_1.var_.characterEffect1069ui_story and not isNil(var_346_1) then
					arg_343_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1069ui_story then
				arg_343_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_346_4 = 0
			local var_346_5 = 0.475

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_6 = arg_343_1:GetWordFromCfg(120411084)
				local var_346_7 = arg_343_1:FormatText(var_346_6.content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 19 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 19)

				if (19 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 19)) > 0 and var_346_5 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411084", "story_v_out_120411.awb") ~= 0 then
					local var_346_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411084", "story_v_out_120411.awb") / 1000

					if var_346_10 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_4
					end

					if var_346_6.prefab_name ~= "" and arg_343_1.actors_[var_346_6.prefab_name] ~= nil then
						local var_346_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_6.prefab_name].transform, "story_v_out_120411", "120411084", "story_v_out_120411.awb")

						arg_343_1:RecordAudio("120411084", var_346_11)
						arg_343_1:RecordAudio("120411084", var_346_11)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_120411", "120411084", "story_v_out_120411.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_120411", "120411084", "story_v_out_120411.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_12 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_12 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_12

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_12 and arg_343_1.time_ < var_346_4 + var_346_12 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play120411085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 120411085
		arg_347_1.duration_ = 9.17

		local var_347_0 = {
			zh = 6.966,
			ja = 9.166
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play120411086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1071ui_story"]) and arg_347_1.var_.characterEffect1071ui_story == nil then
				arg_347_1.var_.characterEffect1071ui_story = arg_347_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1071ui_story"]) then
				if arg_347_1.var_.characterEffect1071ui_story and not isNil(arg_347_1.actors_["1071ui_story"]) then
					arg_347_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1071ui_story"]) and arg_347_1.var_.characterEffect1071ui_story then
				arg_347_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_350_2 = arg_347_1.actors_["1069ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect1069ui_story == nil then
				arg_347_1.var_.characterEffect1069ui_story = var_350_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_3 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.characterEffect1069ui_story and not isNil(var_350_2) then
					arg_347_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_3)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect1069ui_story then
				arg_347_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_350_4 = 0
			local var_350_5 = 0.7

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(120411085)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 28 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 28)

				if (28 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 28)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411085", "story_v_out_120411.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411085", "story_v_out_120411.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_out_120411", "120411085", "story_v_out_120411.awb")

						arg_347_1:RecordAudio("120411085", var_350_11)
						arg_347_1:RecordAudio("120411085", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_120411", "120411085", "story_v_out_120411.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_120411", "120411085", "story_v_out_120411.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play120411086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 120411086
		arg_351_1.duration_ = 7

		local var_351_0 = {
			zh = 2.866,
			ja = 7
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play120411087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1071ui_story"]) and arg_351_1.var_.characterEffect1071ui_story == nil then
				arg_351_1.var_.characterEffect1071ui_story = arg_351_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1071ui_story"]) then
				if arg_351_1.var_.characterEffect1071ui_story and not isNil(arg_351_1.actors_["1071ui_story"]) then
					arg_351_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1071ui_story"]) and arg_351_1.var_.characterEffect1071ui_story then
				arg_351_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_354_1 = arg_351_1.actors_["1069ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1069ui_story == nil then
				arg_351_1.var_.characterEffect1069ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1069ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1069ui_story then
				arg_351_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_354_4 = 0
			local var_354_5 = 0.25

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(120411086)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 10 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 10)

				if (10 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 10)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411086", "story_v_out_120411.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411086", "story_v_out_120411.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_out_120411", "120411086", "story_v_out_120411.awb")

						arg_351_1:RecordAudio("120411086", var_354_11)
						arg_351_1:RecordAudio("120411086", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_120411", "120411086", "story_v_out_120411.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_120411", "120411086", "story_v_out_120411.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play120411087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 120411087
		arg_355_1.duration_ = 5.57

		local var_355_0 = {
			zh = 5.566,
			ja = 5.433
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play120411088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1069ui_story"]) and arg_355_1.var_.characterEffect1069ui_story == nil then
				arg_355_1.var_.characterEffect1069ui_story = arg_355_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1069ui_story"]) then
				if arg_355_1.var_.characterEffect1069ui_story and not isNil(arg_355_1.actors_["1069ui_story"]) then
					arg_355_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1069ui_story"]) and arg_355_1.var_.characterEffect1069ui_story then
				arg_355_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_358_1 = arg_355_1.actors_["1071ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1071ui_story == nil then
				arg_355_1.var_.characterEffect1071ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect1071ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1071ui_story then
				arg_355_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_358_4 = 0
			local var_358_5 = 0.575

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(120411087)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 23 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 23)

				if (23 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 23)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411087", "story_v_out_120411.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411087", "story_v_out_120411.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_120411", "120411087", "story_v_out_120411.awb")

						arg_355_1:RecordAudio("120411087", var_358_11)
						arg_355_1:RecordAudio("120411087", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_120411", "120411087", "story_v_out_120411.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_120411", "120411087", "story_v_out_120411.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play120411088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 120411088
		arg_359_1.duration_ = 7.6

		local var_359_0 = {
			zh = 6,
			ja = 7.6
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
				arg_359_0:Play120411089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.85

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(120411088)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 33 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 33)

				if (33 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 33)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411088", "story_v_out_120411.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411088", "story_v_out_120411.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_120411", "120411088", "story_v_out_120411.awb")

						arg_359_1:RecordAudio("120411088", var_362_6)
						arg_359_1:RecordAudio("120411088", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_120411", "120411088", "story_v_out_120411.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_120411", "120411088", "story_v_out_120411.awb")
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
	Play120411089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 120411089
		arg_363_1.duration_ = 4.93

		local var_363_0 = {
			zh = 4.933,
			ja = 4.533
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play120411090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1071ui_story"]) and arg_363_1.var_.characterEffect1071ui_story == nil then
				arg_363_1.var_.characterEffect1071ui_story = arg_363_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1071ui_story"]) then
				if arg_363_1.var_.characterEffect1071ui_story and not isNil(arg_363_1.actors_["1071ui_story"]) then
					arg_363_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1071ui_story"]) and arg_363_1.var_.characterEffect1071ui_story then
				arg_363_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_366_1 = arg_363_1.actors_["1069ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1069ui_story == nil then
				arg_363_1.var_.characterEffect1069ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect1069ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1069ui_story then
				arg_363_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_366_4 = 0
			local var_366_5 = 0.65

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(120411089)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 26 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 26)

				if (26 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 26)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411089", "story_v_out_120411.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411089", "story_v_out_120411.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_out_120411", "120411089", "story_v_out_120411.awb")

						arg_363_1:RecordAudio("120411089", var_366_11)
						arg_363_1:RecordAudio("120411089", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_120411", "120411089", "story_v_out_120411.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_120411", "120411089", "story_v_out_120411.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play120411090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 120411090
		arg_367_1.duration_ = 11.93

		local var_367_0 = {
			zh = 7.5,
			ja = 11.933
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play120411091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1071ui_story"]) and arg_367_1.var_.characterEffect1071ui_story == nil then
				arg_367_1.var_.characterEffect1071ui_story = arg_367_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1071ui_story"]) then
				if arg_367_1.var_.characterEffect1071ui_story and not isNil(arg_367_1.actors_["1071ui_story"]) then
					arg_367_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1071ui_story"]) and arg_367_1.var_.characterEffect1071ui_story then
				arg_367_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_370_2 = arg_367_1.actors_["1069ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.characterEffect1069ui_story == nil then
				arg_367_1.var_.characterEffect1069ui_story = var_370_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_3 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.characterEffect1069ui_story and not isNil(var_370_2) then
					arg_367_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_3)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.characterEffect1069ui_story then
				arg_367_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_370_4 = 0
			local var_370_5 = 0.8

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(120411090)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 32 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 32)

				if (32 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 32)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411090", "story_v_out_120411.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411090", "story_v_out_120411.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_out_120411", "120411090", "story_v_out_120411.awb")

						arg_367_1:RecordAudio("120411090", var_370_11)
						arg_367_1:RecordAudio("120411090", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_120411", "120411090", "story_v_out_120411.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_120411", "120411090", "story_v_out_120411.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play120411091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 120411091
		arg_371_1.duration_ = 13.6

		local var_371_0 = {
			zh = 13.433,
			ja = 13.6
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play120411092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.55

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:GetWordFromCfg(120411091)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 62 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 62)

				if (62 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 62)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411091", "story_v_out_120411.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411091", "story_v_out_120411.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_120411", "120411091", "story_v_out_120411.awb")

						arg_371_1:RecordAudio("120411091", var_374_6)
						arg_371_1:RecordAudio("120411091", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_120411", "120411091", "story_v_out_120411.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_120411", "120411091", "story_v_out_120411.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play120411092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 120411092
		arg_375_1.duration_ = 4.93

		local var_375_0 = {
			zh = 3.833,
			ja = 4.933
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play120411093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1071ui_story"]) and arg_375_1.var_.characterEffect1071ui_story == nil then
				arg_375_1.var_.characterEffect1071ui_story = arg_375_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1071ui_story"]) then
				if arg_375_1.var_.characterEffect1071ui_story and not isNil(arg_375_1.actors_["1071ui_story"]) then
					arg_375_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_0)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1071ui_story"]) and arg_375_1.var_.characterEffect1071ui_story then
				arg_375_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_378_1 = arg_375_1.actors_["1069ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1069ui_story == nil then
				arg_375_1.var_.characterEffect1069ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1069ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1069ui_story then
				arg_375_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_378_4 = 0
			local var_378_5 = 0.375

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(120411092)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 15 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 15)

				if (15 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 15)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411092", "story_v_out_120411.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411092", "story_v_out_120411.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_120411", "120411092", "story_v_out_120411.awb")

						arg_375_1:RecordAudio("120411092", var_378_11)
						arg_375_1:RecordAudio("120411092", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_120411", "120411092", "story_v_out_120411.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_120411", "120411092", "story_v_out_120411.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play120411093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 120411093
		arg_379_1.duration_ = 8.2

		local var_379_0 = {
			zh = 5.233,
			ja = 8.2
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
				arg_379_0:Play120411094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1071ui_story"]) and arg_379_1.var_.characterEffect1071ui_story == nil then
				arg_379_1.var_.characterEffect1071ui_story = arg_379_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1071ui_story"]) then
				if arg_379_1.var_.characterEffect1071ui_story and not isNil(arg_379_1.actors_["1071ui_story"]) then
					arg_379_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1071ui_story"]) and arg_379_1.var_.characterEffect1071ui_story then
				arg_379_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action463")
			end

			local var_382_2 = arg_379_1.actors_["1069ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.characterEffect1069ui_story == nil then
				arg_379_1.var_.characterEffect1069ui_story = var_382_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_3 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_3 and not isNil(var_382_2) then
				if arg_379_1.var_.characterEffect1069ui_story and not isNil(var_382_2) then
					arg_379_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_3)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_3 and arg_379_1.time_ < 0 + var_382_3 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.characterEffect1069ui_story then
				arg_379_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_382_4 = 0
			local var_382_5 = 0.65

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(120411093)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 26 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 26)

				if (26 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 26)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411093", "story_v_out_120411.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411093", "story_v_out_120411.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_out_120411", "120411093", "story_v_out_120411.awb")

						arg_379_1:RecordAudio("120411093", var_382_11)
						arg_379_1:RecordAudio("120411093", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_120411", "120411093", "story_v_out_120411.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_120411", "120411093", "story_v_out_120411.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play120411094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 120411094
		arg_383_1.duration_ = 4.53

		local var_383_0 = {
			zh = 4.533,
			ja = 3.966
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play120411095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.55

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:GetWordFromCfg(120411094)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 22 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 22)

				if (22 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 22)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411094", "story_v_out_120411.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411094", "story_v_out_120411.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_120411", "120411094", "story_v_out_120411.awb")

						arg_383_1:RecordAudio("120411094", var_386_6)
						arg_383_1:RecordAudio("120411094", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_120411", "120411094", "story_v_out_120411.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_120411", "120411094", "story_v_out_120411.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play120411095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 120411095
		arg_387_1.duration_ = 10.3

		local var_387_0 = {
			zh = 8.8,
			ja = 10.3
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play120411096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1071ui_story"]) and arg_387_1.var_.characterEffect1071ui_story == nil then
				arg_387_1.var_.characterEffect1071ui_story = arg_387_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1071ui_story"]) then
				if arg_387_1.var_.characterEffect1071ui_story and not isNil(arg_387_1.actors_["1071ui_story"]) then
					arg_387_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1071ui_story"]) and arg_387_1.var_.characterEffect1071ui_story then
				arg_387_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_390_1 = arg_387_1.actors_["1069ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1069ui_story == nil then
				arg_387_1.var_.characterEffect1069ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1069ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1069ui_story then
				arg_387_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_2")
			end

			local var_390_4 = 0
			local var_390_5 = 0.825

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_4 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_6 = arg_387_1:GetWordFromCfg(120411095)
				local var_390_7 = arg_387_1:FormatText(var_390_6.content)

				arg_387_1.text_.text = var_390_7

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_9 = 33 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 33)

				if (33 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 33)) > 0 and var_390_5 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_4
					end
				end

				arg_387_1.text_.text = var_390_7
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411095", "story_v_out_120411.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411095", "story_v_out_120411.awb") / 1000

					if var_390_10 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_4
					end

					if var_390_6.prefab_name ~= "" and arg_387_1.actors_[var_390_6.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_6.prefab_name].transform, "story_v_out_120411", "120411095", "story_v_out_120411.awb")

						arg_387_1:RecordAudio("120411095", var_390_11)
						arg_387_1:RecordAudio("120411095", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_120411", "120411095", "story_v_out_120411.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_120411", "120411095", "story_v_out_120411.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_5, arg_387_1.talkMaxDuration)

			if var_390_4 <= arg_387_1.time_ and arg_387_1.time_ < var_390_4 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_4) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_4 + var_390_12 and arg_387_1.time_ < var_390_4 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play120411096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 120411096
		arg_391_1.duration_ = 6.6

		local var_391_0 = {
			zh = 4.3,
			ja = 6.6
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play120411097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.6

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:GetWordFromCfg(120411096)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 24 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 24)

				if (24 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 24)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411096", "story_v_out_120411.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411096", "story_v_out_120411.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_120411", "120411096", "story_v_out_120411.awb")

						arg_391_1:RecordAudio("120411096", var_394_6)
						arg_391_1:RecordAudio("120411096", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_120411", "120411096", "story_v_out_120411.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_120411", "120411096", "story_v_out_120411.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play120411097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 120411097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play120411098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1069ui_story = arg_395_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1069ui_story"].transform.position).z)
				arg_395_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1069ui_story"].transform.localEulerAngles = arg_395_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1069ui_story"].transform.position).z)
				arg_395_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1069ui_story"].transform.localEulerAngles = arg_395_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1071ui_story"].transform

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1071ui_story = var_398_1.localPosition
			end

			local var_398_2 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 then
				var_398_1.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_395_1.time_ - 0) / var_398_2)
				var_398_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_398_1.position).x, (manager.ui.mainCamera.transform.position - var_398_1.position).y, (manager.ui.mainCamera.transform.position - var_398_1.position).z)
				var_398_1.localEulerAngles.z = 0
				var_398_1.localEulerAngles.x = 0
				var_398_1.localEulerAngles = var_398_1.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 then
				var_398_1.localPosition = Vector3.New(0, 100, 0)
				var_398_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_398_1.position).x, (manager.ui.mainCamera.transform.position - var_398_1.position).y, (manager.ui.mainCamera.transform.position - var_398_1.position).z)
				var_398_1.localEulerAngles.z = 0
				var_398_1.localEulerAngles.x = 0
				var_398_1.localEulerAngles = var_398_1.localEulerAngles
			end

			local var_398_3 = 0
			local var_398_4 = 0.825

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_3 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_5 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(120411097).content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 33 <= 0 and var_398_4 or var_398_4 * (utf8.len(var_398_5) / 33)

				if (33 <= 0 and var_398_4 or var_398_4 * (utf8.len(var_398_5) / 33)) > 0 and var_398_4 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_3 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_3
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_8 = math.max(var_398_4, arg_395_1.talkMaxDuration)

			if var_398_3 <= arg_395_1.time_ and arg_395_1.time_ < var_398_3 + var_398_8 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_3) / var_398_8

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_3 + var_398_8 and arg_395_1.time_ < var_398_3 + var_398_8 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play120411098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 120411098
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play120411099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 1.25

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(120411098).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 50 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 50)

				if (50 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 50)) > 0 and var_402_0 < var_402_3 then
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
	Play120411099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 120411099
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play120411100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.775

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(120411099).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 31 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 31)

				if (31 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 31)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play120411100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 120411100
		arg_407_1.duration_ = 9.43

		local var_407_0 = {
			zh = 8.3,
			ja = 9.433
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
				arg_407_0:Play120411101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1069ui_story = arg_407_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1069ui_story"].transform.position).z)
				arg_407_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1069ui_story"].transform.localEulerAngles = arg_407_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_407_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1069ui_story"].transform.position).z)
				arg_407_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1069ui_story"].transform.localEulerAngles = arg_407_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["1071ui_story"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1071ui_story = var_410_1.localPosition
			end

			local var_410_2 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 then
				var_410_1.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_407_1.time_ - 0) / var_410_2)
				var_410_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_1.position).x, (manager.ui.mainCamera.transform.position - var_410_1.position).y, (manager.ui.mainCamera.transform.position - var_410_1.position).z)
				var_410_1.localEulerAngles.z = 0
				var_410_1.localEulerAngles.x = 0
				var_410_1.localEulerAngles = var_410_1.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 then
				var_410_1.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_410_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_1.position).x, (manager.ui.mainCamera.transform.position - var_410_1.position).y, (manager.ui.mainCamera.transform.position - var_410_1.position).z)
				var_410_1.localEulerAngles.z = 0
				var_410_1.localEulerAngles.x = 0
				var_410_1.localEulerAngles = var_410_1.localEulerAngles
			end

			local var_410_3 = arg_407_1.actors_["1071ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_3) and arg_407_1.var_.characterEffect1071ui_story == nil then
				arg_407_1.var_.characterEffect1071ui_story = var_410_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_4 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 and not isNil(var_410_3) then
				if arg_407_1.var_.characterEffect1071ui_story and not isNil(var_410_3) then
					arg_407_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_4)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 and not isNil(var_410_3) and arg_407_1.var_.characterEffect1071ui_story then
				arg_407_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_410_5 = arg_407_1.actors_["1069ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.characterEffect1069ui_story == nil then
				arg_407_1.var_.characterEffect1069ui_story = var_410_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_6 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_6 and not isNil(var_410_5) then
				if arg_407_1.var_.characterEffect1069ui_story and not isNil(var_410_5) then
					arg_407_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_6 and arg_407_1.time_ < 0 + var_410_6 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.characterEffect1069ui_story then
				arg_407_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_410_8 = 0
			local var_410_9 = 0.85

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_10 = arg_407_1:GetWordFromCfg(120411100)
				local var_410_11 = arg_407_1:FormatText(var_410_10.content)

				arg_407_1.text_.text = var_410_11

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_13 = 34 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 34)

				if (34 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 34)) > 0 and var_410_9 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_8
					end
				end

				arg_407_1.text_.text = var_410_11
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411100", "story_v_out_120411.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411100", "story_v_out_120411.awb") / 1000

					if var_410_14 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_8
					end

					if var_410_10.prefab_name ~= "" and arg_407_1.actors_[var_410_10.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_10.prefab_name].transform, "story_v_out_120411", "120411100", "story_v_out_120411.awb")

						arg_407_1:RecordAudio("120411100", var_410_15)
						arg_407_1:RecordAudio("120411100", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_120411", "120411100", "story_v_out_120411.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_120411", "120411100", "story_v_out_120411.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_9, arg_407_1.talkMaxDuration)

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_8) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_8 + var_410_16 and arg_407_1.time_ < var_410_8 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play120411101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 120411101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play120411102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1069ui_story = arg_411_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1069ui_story"].transform.position).z)
				arg_411_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1069ui_story"].transform.localEulerAngles = arg_411_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_411_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1069ui_story"].transform.position).z)
				arg_411_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1069ui_story"].transform.localEulerAngles = arg_411_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1071ui_story"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1071ui_story = var_414_1.localPosition
			end

			local var_414_2 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 then
				var_414_1.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_411_1.time_ - 0) / var_414_2)
				var_414_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_1.position).x, (manager.ui.mainCamera.transform.position - var_414_1.position).y, (manager.ui.mainCamera.transform.position - var_414_1.position).z)
				var_414_1.localEulerAngles.z = 0
				var_414_1.localEulerAngles.x = 0
				var_414_1.localEulerAngles = var_414_1.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 then
				var_414_1.localPosition = Vector3.New(0, 100, 0)
				var_414_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_1.position).x, (manager.ui.mainCamera.transform.position - var_414_1.position).y, (manager.ui.mainCamera.transform.position - var_414_1.position).z)
				var_414_1.localEulerAngles.z = 0
				var_414_1.localEulerAngles.x = 0
				var_414_1.localEulerAngles = var_414_1.localEulerAngles
			end

			local var_414_3 = "J05f_blur"

			if arg_411_1.bgs_.J05f_blur == nil then
				local var_414_4 = Object.Instantiate(arg_411_1.blurPaintGo_)

				var_414_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_414_3)
				var_414_4.name = var_414_3
				var_414_4.transform.parent = arg_411_1.stage_.transform
				var_414_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_411_1.bgs_[var_414_3] = var_414_4
			end

			local var_414_5 = 0
			local var_414_6 = arg_411_1.bgs_[var_414_3]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				var_414_6.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_414_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_414_7 = var_414_6:GetComponent("SpriteRenderer")

				if var_414_7 and var_414_7.sprite then
					local var_414_8 = 2 * (var_414_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_414_6.transform.localScale = Vector3.New(var_414_8 / var_414_7.sprite.bounds.size.y < var_414_8 * manager.ui.mainCameraCom_.aspect / var_414_7.sprite.bounds.size.x and var_414_8 * manager.ui.mainCameraCom_.aspect / var_414_7.sprite.bounds.size.x or var_414_8 / var_414_7.sprite.bounds.size.y, var_414_8 / var_414_7.sprite.bounds.size.y < var_414_8 * manager.ui.mainCameraCom_.aspect / var_414_7.sprite.bounds.size.x and var_414_8 * manager.ui.mainCameraCom_.aspect / var_414_7.sprite.bounds.size.x or var_414_8 / var_414_7.sprite.bounds.size.y, 0)
				end
			end

			local var_414_9 = 5

			if var_414_5 <= arg_411_1.time_ and arg_411_1.time_ < var_414_5 + var_414_9 then
				local var_414_10 = Color.New(1, 1, 1)

				var_414_10.a = Mathf.Lerp(0, 1, (arg_411_1.time_ - var_414_5) / var_414_9)

				var_414_6:GetComponent("SpriteRenderer").material:SetColor("_Color", var_414_10)
			end

			local var_414_11 = 0
			local var_414_12 = 0.875

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_11 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_13 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(120411101).content)

				arg_411_1.text_.text = var_414_13

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_15 = 35 <= 0 and var_414_12 or var_414_12 * (utf8.len(var_414_13) / 35)

				if (35 <= 0 and var_414_12 or var_414_12 * (utf8.len(var_414_13) / 35)) > 0 and var_414_12 < var_414_15 then
					arg_411_1.talkMaxDuration = var_414_15

					if var_414_15 + var_414_11 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_15 + var_414_11
					end
				end

				arg_411_1.text_.text = var_414_13
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_12, arg_411_1.talkMaxDuration)

			if var_414_11 <= arg_411_1.time_ and arg_411_1.time_ < var_414_11 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_11) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_11 + var_414_16 and arg_411_1.time_ < var_414_11 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play120411102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 120411102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play120411103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.65

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(120411102).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 26 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 26)

				if (26 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 26)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play120411103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 120411103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play120411104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_422_0 = 0.6

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				local var_422_1, var_422_2 = math.modf((arg_419_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_422_2 * 0.13, var_422_2 * 0.13, var_422_2 * 0.13) + arg_419_1.var_.shakeOldPos
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				manager.ui.mainCamera.transform.localPosition = arg_419_1.var_.shakeOldPos
			end

			local var_422_3 = "J05f_blur"

			if arg_419_1.bgs_.J05f_blur == nil then
				local var_422_4 = Object.Instantiate(arg_419_1.blurPaintGo_)

				var_422_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_422_3)
				var_422_4.name = var_422_3
				var_422_4.transform.parent = arg_419_1.stage_.transform
				var_422_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.bgs_[var_422_3] = var_422_4
			end

			local var_422_5 = 0
			local var_422_6 = arg_419_1.bgs_[var_422_3]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_5 + arg_422_0 then
				var_422_6.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_422_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_422_7 = var_422_6:GetComponent("SpriteRenderer")

				if var_422_7 and var_422_7.sprite then
					local var_422_8 = 2 * (var_422_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_422_6.transform.localScale = Vector3.New(var_422_8 / var_422_7.sprite.bounds.size.y < var_422_8 * manager.ui.mainCameraCom_.aspect / var_422_7.sprite.bounds.size.x and var_422_8 * manager.ui.mainCameraCom_.aspect / var_422_7.sprite.bounds.size.x or var_422_8 / var_422_7.sprite.bounds.size.y, var_422_8 / var_422_7.sprite.bounds.size.y < var_422_8 * manager.ui.mainCameraCom_.aspect / var_422_7.sprite.bounds.size.x and var_422_8 * manager.ui.mainCameraCom_.aspect / var_422_7.sprite.bounds.size.x or var_422_8 / var_422_7.sprite.bounds.size.y, 0)
				end
			end

			local var_422_9 = 1.5

			if var_422_5 <= arg_419_1.time_ and arg_419_1.time_ < var_422_5 + var_422_9 then
				local var_422_10 = Color.New(1, 1, 1)

				var_422_10.a = Mathf.Lerp(1, 0, (arg_419_1.time_ - var_422_5) / var_422_9)

				var_422_6:GetComponent("SpriteRenderer").material:SetColor("_Color", var_422_10)
			end

			if arg_419_1.frameCnt_ <= 1 then
				arg_419_1.dialog_:SetActive(false)
			end

			local var_422_11 = 1
			local var_422_12 = 0.075

			if 1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_11 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				arg_419_1.dialog_:SetActive(true)

				arg_419_1.dialogCg_.alpha = 0

				local var_422_13 = LeanTween.value(arg_419_1.dialog_, 0, 1, 0.3)

				var_422_13:setOnUpdate(LuaHelper.FloatAction(function(arg_423_0)
					arg_419_1.dialogCg_.alpha = arg_423_0
				end))
				var_422_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_419_1.dialog_)
					var_422_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_419_1.duration_ = arg_419_1.duration_ + 0.3

				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_14 = arg_419_1:GetWordFromCfg(120411103)
				local var_422_15 = arg_419_1:FormatText(var_422_14.content)

				arg_419_1.text_.text = var_422_15

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_17 = 3 <= 0 and var_422_12 or var_422_12 * (utf8.len(var_422_15) / 3)

				if (3 <= 0 and var_422_12 or var_422_12 * (utf8.len(var_422_15) / 3)) > 0 and var_422_12 < var_422_17 then
					arg_419_1.talkMaxDuration = var_422_17
					var_422_11 = var_422_11 + 0.3

					if var_422_17 + var_422_11 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_17 + var_422_11
					end
				end

				arg_419_1.text_.text = var_422_15
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411103", "story_v_out_120411.awb") ~= 0 then
					local var_422_18 = manager.audio:GetVoiceLength("story_v_out_120411", "120411103", "story_v_out_120411.awb") / 1000

					if var_422_18 + var_422_11 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_18 + var_422_11
					end

					if var_422_14.prefab_name ~= "" and arg_419_1.actors_[var_422_14.prefab_name] ~= nil then
						local var_422_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_14.prefab_name].transform, "story_v_out_120411", "120411103", "story_v_out_120411.awb")

						arg_419_1:RecordAudio("120411103", var_422_19)
						arg_419_1:RecordAudio("120411103", var_422_19)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_120411", "120411103", "story_v_out_120411.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_120411", "120411103", "story_v_out_120411.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_20 = var_422_11 + 0.3
			local var_422_21 = math.max(var_422_12, arg_419_1.talkMaxDuration)

			if var_422_11 + 0.3 <= arg_419_1.time_ and arg_419_1.time_ < var_422_20 + var_422_21 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_20) / var_422_21

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_20 + var_422_21 and arg_419_1.time_ < var_422_20 + var_422_21 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play120411104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 120411104
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play120411105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.95

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(120411104).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 38 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 38)

				if (38 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 38)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play120411105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 120411105
		arg_429_1.duration_ = 11.1

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play120411106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_0 = 3

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				local var_432_1 = Color.New(0, 0, 0)

				var_432_1.a = Mathf.Lerp(0, 1, (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.mask_.color = var_432_1
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				local var_432_2 = Color.New(0, 0, 0)

				var_432_2.a = 1
				arg_429_1.mask_.color = var_432_2
			end

			local var_432_3 = 3

			if 3 < arg_429_1.time_ and arg_429_1.time_ <= var_432_3 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_4 = 3.1

			if var_432_3 <= arg_429_1.time_ and arg_429_1.time_ < var_432_3 + var_432_4 then
				local var_432_5 = Color.New(0, 0, 0)

				var_432_5.a = Mathf.Lerp(1, 0, (arg_429_1.time_ - var_432_3) / var_432_4)
				arg_429_1.mask_.color = var_432_5
			end

			if arg_429_1.time_ >= var_432_3 + var_432_4 and arg_429_1.time_ < var_432_3 + var_432_4 + arg_432_0 then
				local var_432_6 = Color.New(0, 0, 0)

				arg_429_1.mask_.enabled = false
				var_432_6.a = 0
				arg_429_1.mask_.color = var_432_6
			end

			local var_432_7 = "ST29"

			if arg_429_1.bgs_.ST29 == nil then
				local var_432_8 = Object.Instantiate(arg_429_1.paintGo_)

				var_432_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_432_7)
				var_432_8.name = var_432_7
				var_432_8.transform.parent = arg_429_1.stage_.transform
				var_432_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.bgs_[var_432_7] = var_432_8
			end

			if 3 < arg_429_1.time_ and arg_429_1.time_ <= 3 + arg_432_0 then
				local var_432_9 = arg_429_1.bgs_.ST29

				arg_429_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_432_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_432_10 = var_432_9:GetComponent("SpriteRenderer")

				if var_432_10 and var_432_10.sprite then
					local var_432_11 = 2 * (var_432_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_432_9.transform.localScale = Vector3.New(var_432_11 / var_432_10.sprite.bounds.size.y < var_432_11 * manager.ui.mainCameraCom_.aspect / var_432_10.sprite.bounds.size.x and var_432_11 * manager.ui.mainCameraCom_.aspect / var_432_10.sprite.bounds.size.x or var_432_11 / var_432_10.sprite.bounds.size.y, var_432_11 / var_432_10.sprite.bounds.size.y < var_432_11 * manager.ui.mainCameraCom_.aspect / var_432_10.sprite.bounds.size.x and var_432_11 * manager.ui.mainCameraCom_.aspect / var_432_10.sprite.bounds.size.x or var_432_11 / var_432_10.sprite.bounds.size.y, 0)
				end

				for iter_432_0, iter_432_1 in pairs(arg_429_1.bgs_) do
					if iter_432_0 ~= "ST29" then
						iter_432_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_429_1.frameCnt_ <= 1 then
				arg_429_1.dialog_:SetActive(false)
			end

			local var_432_12 = 6.1
			local var_432_13 = 1.775

			if 6.1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_12 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0

				arg_429_1.dialog_:SetActive(true)

				arg_429_1.dialogCg_.alpha = 0

				local var_432_14 = LeanTween.value(arg_429_1.dialog_, 0, 1, 0.3)

				var_432_14:setOnUpdate(LuaHelper.FloatAction(function(arg_433_0)
					arg_429_1.dialogCg_.alpha = arg_433_0
				end))
				var_432_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_429_1.dialog_)
					var_432_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_429_1.duration_ = arg_429_1.duration_ + 0.3

				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_15 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(120411105).content)

				arg_429_1.text_.text = var_432_15

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_17 = 71 <= 0 and var_432_13 or var_432_13 * (utf8.len(var_432_15) / 71)

				if (71 <= 0 and var_432_13 or var_432_13 * (utf8.len(var_432_15) / 71)) > 0 and var_432_13 < var_432_17 then
					arg_429_1.talkMaxDuration = var_432_17
					var_432_12 = var_432_12 + 0.3

					if var_432_17 + var_432_12 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_17 + var_432_12
					end
				end

				arg_429_1.text_.text = var_432_15
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_18 = var_432_12 + 0.3
			local var_432_19 = math.max(var_432_13, arg_429_1.talkMaxDuration)

			if var_432_12 + 0.3 <= arg_429_1.time_ and arg_429_1.time_ < var_432_18 + var_432_19 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_18) / var_432_19

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_18 + var_432_19 and arg_429_1.time_ < var_432_18 + var_432_19 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play120411106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 120411106
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play120411107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 1.425

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(120411106).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 57 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 57)

				if (57 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 57)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play120411107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 120411107
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play120411108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.7

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(120411107).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 28 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 28)

				if (28 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 28)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play120411108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 120411108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play120411109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.6

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(120411108).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 24 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 24)

				if (24 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 24)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play120411109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 120411109
		arg_447_1.duration_ = 2.53

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play120411110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1076ui_story = arg_447_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_450_0 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				arg_447_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_447_1.time_ - 0) / var_450_0)
				arg_447_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).z)
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles = arg_447_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_447_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).z)
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles = arg_447_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_450_1 = arg_447_1.actors_["1076ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1076ui_story == nil then
				arg_447_1.var_.characterEffect1076ui_story = var_450_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_2 and not isNil(var_450_1) then
				if arg_447_1.var_.characterEffect1076ui_story and not isNil(var_450_1) then
					arg_447_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_2 and arg_447_1.time_ < 0 + var_450_2 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1076ui_story then
				arg_447_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_450_4 = 0
			local var_450_5 = 0.225

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_6 = arg_447_1:GetWordFromCfg(120411109)
				local var_450_7 = arg_447_1:FormatText(var_450_6.content)

				arg_447_1.text_.text = var_450_7

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_9 = 9 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 9)

				if (9 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 9)) > 0 and var_450_5 < var_450_9 then
					arg_447_1.talkMaxDuration = var_450_9

					if var_450_9 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_4
					end
				end

				arg_447_1.text_.text = var_450_7
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411109", "story_v_out_120411.awb") ~= 0 then
					local var_450_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411109", "story_v_out_120411.awb") / 1000

					if var_450_10 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_4
					end

					if var_450_6.prefab_name ~= "" and arg_447_1.actors_[var_450_6.prefab_name] ~= nil then
						local var_450_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_6.prefab_name].transform, "story_v_out_120411", "120411109", "story_v_out_120411.awb")

						arg_447_1:RecordAudio("120411109", var_450_11)
						arg_447_1:RecordAudio("120411109", var_450_11)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_120411", "120411109", "story_v_out_120411.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_120411", "120411109", "story_v_out_120411.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_12 = math.max(var_450_5, arg_447_1.talkMaxDuration)

			if var_450_4 <= arg_447_1.time_ and arg_447_1.time_ < var_450_4 + var_450_12 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_4) / var_450_12

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_4 + var_450_12 and arg_447_1.time_ < var_450_4 + var_450_12 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play120411110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 120411110
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play120411111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1076ui_story"]) and arg_451_1.var_.characterEffect1076ui_story == nil then
				arg_451_1.var_.characterEffect1076ui_story = arg_451_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_0 = 0.2

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1076ui_story"]) then
				if arg_451_1.var_.characterEffect1076ui_story and not isNil(arg_451_1.actors_["1076ui_story"]) then
					arg_451_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_0)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1076ui_story"]) and arg_451_1.var_.characterEffect1076ui_story then
				arg_451_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_454_1 = 0
			local var_454_2 = 0.625

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(120411110).content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 25 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 25)

				if (25 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 25)) > 0 and var_454_2 < var_454_5 then
					arg_451_1.talkMaxDuration = var_454_5

					if var_454_5 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + var_454_1
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_6 = math.max(var_454_2, arg_451_1.talkMaxDuration)

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_6 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_1) / var_454_6

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_1 + var_454_6 and arg_451_1.time_ < var_454_1 + var_454_6 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play120411111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 120411111
		arg_455_1.duration_ = 11.73

		local var_455_0 = {
			zh = 5.8,
			ja = 11.733
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play120411112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["1076ui_story"]) and arg_455_1.var_.characterEffect1076ui_story == nil then
				arg_455_1.var_.characterEffect1076ui_story = arg_455_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.2

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["1076ui_story"]) then
				if arg_455_1.var_.characterEffect1076ui_story and not isNil(arg_455_1.actors_["1076ui_story"]) then
					arg_455_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["1076ui_story"]) and arg_455_1.var_.characterEffect1076ui_story then
				arg_455_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			local var_458_2 = 0
			local var_458_3 = 0.525

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_2 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_4 = arg_455_1:GetWordFromCfg(120411111)
				local var_458_5 = arg_455_1:FormatText(var_458_4.content)

				arg_455_1.text_.text = var_458_5

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_7 = 21 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_5) / 21)

				if (21 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_5) / 21)) > 0 and var_458_3 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_2
					end
				end

				arg_455_1.text_.text = var_458_5
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411111", "story_v_out_120411.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411111", "story_v_out_120411.awb") / 1000

					if var_458_8 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_2
					end

					if var_458_4.prefab_name ~= "" and arg_455_1.actors_[var_458_4.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_4.prefab_name].transform, "story_v_out_120411", "120411111", "story_v_out_120411.awb")

						arg_455_1:RecordAudio("120411111", var_458_9)
						arg_455_1:RecordAudio("120411111", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_120411", "120411111", "story_v_out_120411.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_120411", "120411111", "story_v_out_120411.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_3, arg_455_1.talkMaxDuration)

			if var_458_2 <= arg_455_1.time_ and arg_455_1.time_ < var_458_2 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_2) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_2 + var_458_10 and arg_455_1.time_ < var_458_2 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play120411112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 120411112
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play120411113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["1076ui_story"]) and arg_459_1.var_.characterEffect1076ui_story == nil then
				arg_459_1.var_.characterEffect1076ui_story = arg_459_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.2

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["1076ui_story"]) then
				if arg_459_1.var_.characterEffect1076ui_story and not isNil(arg_459_1.actors_["1076ui_story"]) then
					arg_459_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_459_1.time_ - 0) / var_462_0)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["1076ui_story"]) and arg_459_1.var_.characterEffect1076ui_story then
				arg_459_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_462_1 = 0
			local var_462_2 = 0.925

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_3 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(120411112).content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 37 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 37)

				if (37 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 37)) > 0 and var_462_2 < var_462_5 then
					arg_459_1.talkMaxDuration = var_462_5

					if var_462_5 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + var_462_1
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_6 = math.max(var_462_2, arg_459_1.talkMaxDuration)

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_6 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_1) / var_462_6

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_1 + var_462_6 and arg_459_1.time_ < var_462_1 + var_462_6 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play120411113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 120411113
		arg_463_1.duration_ = 8.63

		local var_463_0 = {
			zh = 8.3,
			ja = 8.633
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play120411114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["1076ui_story"]) and arg_463_1.var_.characterEffect1076ui_story == nil then
				arg_463_1.var_.characterEffect1076ui_story = arg_463_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["1076ui_story"]) then
				if arg_463_1.var_.characterEffect1076ui_story and not isNil(arg_463_1.actors_["1076ui_story"]) then
					arg_463_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["1076ui_story"]) and arg_463_1.var_.characterEffect1076ui_story then
				arg_463_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076actionlink/1076action456")
			end

			local var_466_2 = 0
			local var_466_3 = 0.625

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_2 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_4 = arg_463_1:GetWordFromCfg(120411113)
				local var_466_5 = arg_463_1:FormatText(var_466_4.content)

				arg_463_1.text_.text = var_466_5

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_7 = 24 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 24)

				if (24 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 24)) > 0 and var_466_3 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_2
					end
				end

				arg_463_1.text_.text = var_466_5
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411113", "story_v_out_120411.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411113", "story_v_out_120411.awb") / 1000

					if var_466_8 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_2
					end

					if var_466_4.prefab_name ~= "" and arg_463_1.actors_[var_466_4.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_4.prefab_name].transform, "story_v_out_120411", "120411113", "story_v_out_120411.awb")

						arg_463_1:RecordAudio("120411113", var_466_9)
						arg_463_1:RecordAudio("120411113", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_120411", "120411113", "story_v_out_120411.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_120411", "120411113", "story_v_out_120411.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_3, arg_463_1.talkMaxDuration)

			if var_466_2 <= arg_463_1.time_ and arg_463_1.time_ < var_466_2 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_2) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_2 + var_466_10 and arg_463_1.time_ < var_466_2 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play120411114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 120411114
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play120411115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos1076ui_story = arg_467_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_470_0 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 then
				arg_467_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_467_1.time_ - 0) / var_470_0)
				arg_467_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1076ui_story"].transform.position).z)
				arg_467_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1076ui_story"].transform.localEulerAngles = arg_467_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 then
				arg_467_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_467_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1076ui_story"].transform.position).z)
				arg_467_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1076ui_story"].transform.localEulerAngles = arg_467_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_470_1 = 0
			local var_470_2 = 1.25

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_3 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(120411114).content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 50 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 50)

				if (50 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 50)) > 0 and var_470_2 < var_470_5 then
					arg_467_1.talkMaxDuration = var_470_5

					if var_470_5 + var_470_1 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + var_470_1
					end
				end

				arg_467_1.text_.text = var_470_3
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_6 = math.max(var_470_2, arg_467_1.talkMaxDuration)

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_6 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_1) / var_470_6

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_1 + var_470_6 and arg_467_1.time_ < var_470_1 + var_470_6 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play120411115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 120411115
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play120411116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.95

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_1 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(120411115).content)

				arg_471_1.text_.text = var_474_1

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_3 = 38 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 38)

				if (38 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 38)) > 0 and var_474_0 < var_474_3 then
					arg_471_1.talkMaxDuration = var_474_3

					if var_474_3 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_3 + 0
					end
				end

				arg_471_1.text_.text = var_474_1
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_4 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_4 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_4

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_4 and arg_471_1.time_ < 0 + var_474_4 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play120411116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 120411116
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play120411117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.975

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_1 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(120411116).content)

				arg_475_1.text_.text = var_478_1

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_3 = 39 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 39)

				if (39 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 39)) > 0 and var_478_0 < var_478_3 then
					arg_475_1.talkMaxDuration = var_478_3

					if var_478_3 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_3 + 0
					end
				end

				arg_475_1.text_.text = var_478_1
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_4 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_4

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play120411117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 120411117
		arg_479_1.duration_ = 14.33

		local var_479_0 = {
			zh = 10.4,
			ja = 14.333
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play120411118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 1.35

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:GetWordFromCfg(120411117)
				local var_482_2 = arg_479_1:FormatText(var_482_1.content)

				arg_479_1.text_.text = var_482_2

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 54 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 54)

				if (54 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 54)) > 0 and var_482_0 < var_482_4 then
					arg_479_1.talkMaxDuration = var_482_4

					if var_482_4 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_4 + 0
					end
				end

				arg_479_1.text_.text = var_482_2
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411117", "story_v_out_120411.awb") ~= 0 then
					local var_482_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411117", "story_v_out_120411.awb") / 1000

					if var_482_5 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + 0
					end

					if var_482_1.prefab_name ~= "" and arg_479_1.actors_[var_482_1.prefab_name] ~= nil then
						local var_482_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_1.prefab_name].transform, "story_v_out_120411", "120411117", "story_v_out_120411.awb")

						arg_479_1:RecordAudio("120411117", var_482_6)
						arg_479_1:RecordAudio("120411117", var_482_6)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_120411", "120411117", "story_v_out_120411.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_120411", "120411117", "story_v_out_120411.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play120411118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 120411118
		arg_483_1.duration_ = 8.07

		local var_483_0 = {
			zh = 7,
			ja = 8.066
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play120411119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.825

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_1 = arg_483_1:GetWordFromCfg(120411118)
				local var_486_2 = arg_483_1:FormatText(var_486_1.content)

				arg_483_1.text_.text = var_486_2

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 33 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 33)

				if (33 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 33)) > 0 and var_486_0 < var_486_4 then
					arg_483_1.talkMaxDuration = var_486_4

					if var_486_4 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_4 + 0
					end
				end

				arg_483_1.text_.text = var_486_2
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411118", "story_v_out_120411.awb") ~= 0 then
					local var_486_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411118", "story_v_out_120411.awb") / 1000

					if var_486_5 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + 0
					end

					if var_486_1.prefab_name ~= "" and arg_483_1.actors_[var_486_1.prefab_name] ~= nil then
						local var_486_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_1.prefab_name].transform, "story_v_out_120411", "120411118", "story_v_out_120411.awb")

						arg_483_1:RecordAudio("120411118", var_486_6)
						arg_483_1:RecordAudio("120411118", var_486_6)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_120411", "120411118", "story_v_out_120411.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_120411", "120411118", "story_v_out_120411.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_7 and arg_483_1.time_ < 0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play120411119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 120411119
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play120411120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos1076ui_story = arg_487_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_490_0 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 then
				arg_487_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_487_1.time_ - 0) / var_490_0)
				arg_487_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1076ui_story"].transform.position).z)
				arg_487_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1076ui_story"].transform.localEulerAngles = arg_487_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 then
				arg_487_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_487_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1076ui_story"].transform.position).z)
				arg_487_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1076ui_story"].transform.localEulerAngles = arg_487_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_490_1 = arg_487_1.actors_["1076ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1076ui_story == nil then
				arg_487_1.var_.characterEffect1076ui_story = var_490_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_2 = 0.0166666666666667

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_2 and not isNil(var_490_1) then
				if arg_487_1.var_.characterEffect1076ui_story and not isNil(var_490_1) then
					arg_487_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_2)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_2 and arg_487_1.time_ < 0 + var_490_2 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1076ui_story then
				arg_487_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_490_3 = 0
			local var_490_4 = 0.475

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_3 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_5 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(120411119).content)

				arg_487_1.text_.text = var_490_5

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_7 = 19 <= 0 and var_490_4 or var_490_4 * (utf8.len(var_490_5) / 19)

				if (19 <= 0 and var_490_4 or var_490_4 * (utf8.len(var_490_5) / 19)) > 0 and var_490_4 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_3 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_3
					end
				end

				arg_487_1.text_.text = var_490_5
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_8 = math.max(var_490_4, arg_487_1.talkMaxDuration)

			if var_490_3 <= arg_487_1.time_ and arg_487_1.time_ < var_490_3 + var_490_8 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_3) / var_490_8

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_3 + var_490_8 and arg_487_1.time_ < var_490_3 + var_490_8 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play120411120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 120411120
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play120411121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.375

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_1 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(120411120).content)

				arg_491_1.text_.text = var_494_1

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_3 = 15 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 15)

				if (15 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 15)) > 0 and var_494_0 < var_494_3 then
					arg_491_1.talkMaxDuration = var_494_3

					if var_494_3 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_3 + 0
					end
				end

				arg_491_1.text_.text = var_494_1
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_4 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_4

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play120411121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 120411121
		arg_495_1.duration_ = 2

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play120411122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["1076ui_story"]) and arg_495_1.var_.characterEffect1076ui_story == nil then
				arg_495_1.var_.characterEffect1076ui_story = arg_495_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_0 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["1076ui_story"]) then
				if arg_495_1.var_.characterEffect1076ui_story and not isNil(arg_495_1.actors_["1076ui_story"]) then
					arg_495_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["1076ui_story"]) and arg_495_1.var_.characterEffect1076ui_story then
				arg_495_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_498_2 = 0
			local var_498_3 = 0.05

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_2 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_4 = arg_495_1:GetWordFromCfg(120411121)
				local var_498_5 = arg_495_1:FormatText(var_498_4.content)

				arg_495_1.text_.text = var_498_5

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_7 = 2 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_5) / 2)

				if (2 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_5) / 2)) > 0 and var_498_3 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_2 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_2
					end
				end

				arg_495_1.text_.text = var_498_5
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411121", "story_v_out_120411.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411121", "story_v_out_120411.awb") / 1000

					if var_498_8 + var_498_2 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_2
					end

					if var_498_4.prefab_name ~= "" and arg_495_1.actors_[var_498_4.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_4.prefab_name].transform, "story_v_out_120411", "120411121", "story_v_out_120411.awb")

						arg_495_1:RecordAudio("120411121", var_498_9)
						arg_495_1:RecordAudio("120411121", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_120411", "120411121", "story_v_out_120411.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_120411", "120411121", "story_v_out_120411.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_3, arg_495_1.talkMaxDuration)

			if var_498_2 <= arg_495_1.time_ and arg_495_1.time_ < var_498_2 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_2) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_2 + var_498_10 and arg_495_1.time_ < var_498_2 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play120411122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 120411122
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play120411123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1076ui_story"]) and arg_499_1.var_.characterEffect1076ui_story == nil then
				arg_499_1.var_.characterEffect1076ui_story = arg_499_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1076ui_story"]) then
				if arg_499_1.var_.characterEffect1076ui_story and not isNil(arg_499_1.actors_["1076ui_story"]) then
					arg_499_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_0)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1076ui_story"]) and arg_499_1.var_.characterEffect1076ui_story then
				arg_499_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_502_1 = 0
			local var_502_2 = 0.95

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_3 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(120411122).content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 38 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_3) / 38)

				if (38 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_3) / 38)) > 0 and var_502_2 < var_502_5 then
					arg_499_1.talkMaxDuration = var_502_5

					if var_502_5 + var_502_1 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + var_502_1
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_6 = math.max(var_502_2, arg_499_1.talkMaxDuration)

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_6 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_1) / var_502_6

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_1 + var_502_6 and arg_499_1.time_ < var_502_1 + var_502_6 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play120411123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 120411123
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play120411124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.7

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(120411123).content)

				arg_503_1.text_.text = var_506_1

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_3 = 28 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 28)

				if (28 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 28)) > 0 and var_506_0 < var_506_3 then
					arg_503_1.talkMaxDuration = var_506_3

					if var_506_3 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_3 + 0
					end
				end

				arg_503_1.text_.text = var_506_1
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_4 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_4

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play120411124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 120411124
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play120411125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.15

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(120411124).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 6 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 6)

				if (6 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 6)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play120411125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 120411125
		arg_511_1.duration_ = 4

		local var_511_0 = {
			zh = 1.999999999999,
			ja = 4
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play120411126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1076ui_story"]) and arg_511_1.var_.characterEffect1076ui_story == nil then
				arg_511_1.var_.characterEffect1076ui_story = arg_511_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1076ui_story"]) then
				if arg_511_1.var_.characterEffect1076ui_story and not isNil(arg_511_1.actors_["1076ui_story"]) then
					arg_511_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1076ui_story"]) and arg_511_1.var_.characterEffect1076ui_story then
				arg_511_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_514_2 = 0
			local var_514_3 = 0.075

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_4 = arg_511_1:GetWordFromCfg(120411125)
				local var_514_5 = arg_511_1:FormatText(var_514_4.content)

				arg_511_1.text_.text = var_514_5

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_7 = 3 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 3)

				if (3 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 3)) > 0 and var_514_3 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_2
					end
				end

				arg_511_1.text_.text = var_514_5
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411125", "story_v_out_120411.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411125", "story_v_out_120411.awb") / 1000

					if var_514_8 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_2
					end

					if var_514_4.prefab_name ~= "" and arg_511_1.actors_[var_514_4.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_4.prefab_name].transform, "story_v_out_120411", "120411125", "story_v_out_120411.awb")

						arg_511_1:RecordAudio("120411125", var_514_9)
						arg_511_1:RecordAudio("120411125", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_120411", "120411125", "story_v_out_120411.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_120411", "120411125", "story_v_out_120411.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_3, arg_511_1.talkMaxDuration)

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_2) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_2 + var_514_10 and arg_511_1.time_ < var_514_2 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play120411126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 120411126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play120411127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["1076ui_story"]) and arg_515_1.var_.characterEffect1076ui_story == nil then
				arg_515_1.var_.characterEffect1076ui_story = arg_515_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["1076ui_story"]) then
				if arg_515_1.var_.characterEffect1076ui_story and not isNil(arg_515_1.actors_["1076ui_story"]) then
					arg_515_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_0)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["1076ui_story"]) and arg_515_1.var_.characterEffect1076ui_story then
				arg_515_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_518_1 = 0
			local var_518_2 = 0.575

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_3 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(120411126).content)

				arg_515_1.text_.text = var_518_3

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 23 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 23)

				if (23 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 23)) > 0 and var_518_2 < var_518_5 then
					arg_515_1.talkMaxDuration = var_518_5

					if var_518_5 + var_518_1 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + var_518_1
					end
				end

				arg_515_1.text_.text = var_518_3
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_6 = math.max(var_518_2, arg_515_1.talkMaxDuration)

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_6 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_1) / var_518_6

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_1 + var_518_6 and arg_515_1.time_ < var_518_1 + var_518_6 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play120411127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 120411127
		arg_519_1.duration_ = 2.7

		local var_519_0 = {
			zh = 2.133,
			ja = 2.7
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play120411128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["1076ui_story"]) and arg_519_1.var_.characterEffect1076ui_story == nil then
				arg_519_1.var_.characterEffect1076ui_story = arg_519_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_0 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["1076ui_story"]) then
				if arg_519_1.var_.characterEffect1076ui_story and not isNil(arg_519_1.actors_["1076ui_story"]) then
					arg_519_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["1076ui_story"]) and arg_519_1.var_.characterEffect1076ui_story then
				arg_519_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_522_2 = 0
			local var_522_3 = 0.275

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_2 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_4 = arg_519_1:GetWordFromCfg(120411127)
				local var_522_5 = arg_519_1:FormatText(var_522_4.content)

				arg_519_1.text_.text = var_522_5

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_7 = 11 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 11)

				if (11 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 11)) > 0 and var_522_3 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_2
					end
				end

				arg_519_1.text_.text = var_522_5
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411127", "story_v_out_120411.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411127", "story_v_out_120411.awb") / 1000

					if var_522_8 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_2
					end

					if var_522_4.prefab_name ~= "" and arg_519_1.actors_[var_522_4.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_4.prefab_name].transform, "story_v_out_120411", "120411127", "story_v_out_120411.awb")

						arg_519_1:RecordAudio("120411127", var_522_9)
						arg_519_1:RecordAudio("120411127", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_120411", "120411127", "story_v_out_120411.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_120411", "120411127", "story_v_out_120411.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_3, arg_519_1.talkMaxDuration)

			if var_522_2 <= arg_519_1.time_ and arg_519_1.time_ < var_522_2 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_2) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_2 + var_522_10 and arg_519_1.time_ < var_522_2 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play120411128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 120411128
		arg_523_1.duration_ = 8.53

		local var_523_0 = {
			zh = 6.7,
			ja = 8.533
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play120411129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_526_0 = 0
			local var_526_1 = 0.7

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_2 = arg_523_1:GetWordFromCfg(120411128)
				local var_526_3 = arg_523_1:FormatText(var_526_2.content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 28 <= 0 and var_526_1 or var_526_1 * (utf8.len(var_526_3) / 28)

				if (28 <= 0 and var_526_1 or var_526_1 * (utf8.len(var_526_3) / 28)) > 0 and var_526_1 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411128", "story_v_out_120411.awb") ~= 0 then
					local var_526_6 = manager.audio:GetVoiceLength("story_v_out_120411", "120411128", "story_v_out_120411.awb") / 1000

					if var_526_6 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_6 + var_526_0
					end

					if var_526_2.prefab_name ~= "" and arg_523_1.actors_[var_526_2.prefab_name] ~= nil then
						local var_526_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_2.prefab_name].transform, "story_v_out_120411", "120411128", "story_v_out_120411.awb")

						arg_523_1:RecordAudio("120411128", var_526_7)
						arg_523_1:RecordAudio("120411128", var_526_7)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_120411", "120411128", "story_v_out_120411.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_120411", "120411128", "story_v_out_120411.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_8 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_8 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_8

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_8 and arg_523_1.time_ < var_526_0 + var_526_8 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play120411129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 120411129
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play120411130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["1076ui_story"]) and arg_527_1.var_.characterEffect1076ui_story == nil then
				arg_527_1.var_.characterEffect1076ui_story = arg_527_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.2

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["1076ui_story"]) then
				if arg_527_1.var_.characterEffect1076ui_story and not isNil(arg_527_1.actors_["1076ui_story"]) then
					arg_527_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_0)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["1076ui_story"]) and arg_527_1.var_.characterEffect1076ui_story then
				arg_527_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_530_1 = 0
			local var_530_2 = 0.15

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_3 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(120411129).content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 6 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 6)

				if (6 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 6)) > 0 and var_530_2 < var_530_5 then
					arg_527_1.talkMaxDuration = var_530_5

					if var_530_5 + var_530_1 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + var_530_1
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_6 = math.max(var_530_2, arg_527_1.talkMaxDuration)

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_6 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_1) / var_530_6

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_1 + var_530_6 and arg_527_1.time_ < var_530_1 + var_530_6 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play120411130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 120411130
		arg_531_1.duration_ = 1.27

		local var_531_0 = {
			zh = 0.999999999999,
			ja = 1.266
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play120411131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1076ui_story"]) and arg_531_1.var_.characterEffect1076ui_story == nil then
				arg_531_1.var_.characterEffect1076ui_story = arg_531_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1076ui_story"]) then
				if arg_531_1.var_.characterEffect1076ui_story and not isNil(arg_531_1.actors_["1076ui_story"]) then
					arg_531_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1076ui_story"]) and arg_531_1.var_.characterEffect1076ui_story then
				arg_531_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_534_2 = 0
			local var_534_3 = 0.05

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_4 = arg_531_1:GetWordFromCfg(120411130)
				local var_534_5 = arg_531_1:FormatText(var_534_4.content)

				arg_531_1.text_.text = var_534_5

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_7 = 2 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 2)

				if (2 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 2)) > 0 and var_534_3 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_2
					end
				end

				arg_531_1.text_.text = var_534_5
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411130", "story_v_out_120411.awb") ~= 0 then
					local var_534_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411130", "story_v_out_120411.awb") / 1000

					if var_534_8 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_8 + var_534_2
					end

					if var_534_4.prefab_name ~= "" and arg_531_1.actors_[var_534_4.prefab_name] ~= nil then
						local var_534_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_4.prefab_name].transform, "story_v_out_120411", "120411130", "story_v_out_120411.awb")

						arg_531_1:RecordAudio("120411130", var_534_9)
						arg_531_1:RecordAudio("120411130", var_534_9)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_120411", "120411130", "story_v_out_120411.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_120411", "120411130", "story_v_out_120411.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_10 = math.max(var_534_3, arg_531_1.talkMaxDuration)

			if var_534_2 <= arg_531_1.time_ and arg_531_1.time_ < var_534_2 + var_534_10 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_2) / var_534_10

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_2 + var_534_10 and arg_531_1.time_ < var_534_2 + var_534_10 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play120411131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 120411131
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play120411132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1076ui_story"]) and arg_535_1.var_.characterEffect1076ui_story == nil then
				arg_535_1.var_.characterEffect1076ui_story = arg_535_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.2

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1076ui_story"]) then
				if arg_535_1.var_.characterEffect1076ui_story and not isNil(arg_535_1.actors_["1076ui_story"]) then
					arg_535_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_0)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1076ui_story"]) and arg_535_1.var_.characterEffect1076ui_story then
				arg_535_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_538_1 = 0
			local var_538_2 = 0.625

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_3 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(120411131).content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 25 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 25)

				if (25 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 25)) > 0 and var_538_2 < var_538_5 then
					arg_535_1.talkMaxDuration = var_538_5

					if var_538_5 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_6 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_6 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_6

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_6 and arg_535_1.time_ < var_538_1 + var_538_6 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play120411132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 120411132
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play120411133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.var_.moveOldPos1076ui_story = arg_539_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_542_0 = 0.001

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 then
				arg_539_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_539_1.time_ - 0) / var_542_0)
				arg_539_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1076ui_story"].transform.position).z)
				arg_539_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["1076ui_story"].transform.localEulerAngles = arg_539_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 then
				arg_539_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_539_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1076ui_story"].transform.position).z)
				arg_539_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["1076ui_story"].transform.localEulerAngles = arg_539_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_542_1 = 0
			local var_542_2 = 1.325

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_3 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(120411132).content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 53 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 53)

				if (53 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 53)) > 0 and var_542_2 < var_542_5 then
					arg_539_1.talkMaxDuration = var_542_5

					if var_542_5 + var_542_1 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + var_542_1
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_6 = math.max(var_542_2, arg_539_1.talkMaxDuration)

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_6 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_1) / var_542_6

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_1 + var_542_6 and arg_539_1.time_ < var_542_1 + var_542_6 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play120411133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 120411133
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play120411134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.725

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(120411133).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 29 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 29)

				if (29 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 29)) > 0 and var_546_0 < var_546_3 then
					arg_543_1.talkMaxDuration = var_546_3

					if var_546_3 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_3 + 0
					end
				end

				arg_543_1.text_.text = var_546_1
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_4 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_4

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play120411134 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 120411134
		arg_547_1.duration_ = 5.2

		local var_547_0 = {
			zh = 3.133,
			ja = 5.2
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play120411135(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0.4

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[397].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_1 = arg_547_1:GetWordFromCfg(120411134)
				local var_550_2 = arg_547_1:FormatText(var_550_1.content)

				arg_547_1.text_.text = var_550_2

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_4 = 16 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 16)

				if (16 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 16)) > 0 and var_550_0 < var_550_4 then
					arg_547_1.talkMaxDuration = var_550_4

					if var_550_4 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_4 + 0
					end
				end

				arg_547_1.text_.text = var_550_2
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411134", "story_v_out_120411.awb") ~= 0 then
					local var_550_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411134", "story_v_out_120411.awb") / 1000

					if var_550_5 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + 0
					end

					if var_550_1.prefab_name ~= "" and arg_547_1.actors_[var_550_1.prefab_name] ~= nil then
						local var_550_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_1.prefab_name].transform, "story_v_out_120411", "120411134", "story_v_out_120411.awb")

						arg_547_1:RecordAudio("120411134", var_550_6)
						arg_547_1:RecordAudio("120411134", var_550_6)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_120411", "120411134", "story_v_out_120411.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_120411", "120411134", "story_v_out_120411.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_7 = math.max(var_550_0, arg_547_1.talkMaxDuration)

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_7 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - 0) / var_550_7

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= 0 + var_550_7 and arg_547_1.time_ < 0 + var_550_7 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play120411135 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 120411135
		arg_551_1.duration_ = 4.6

		local var_551_0 = {
			zh = 3.8,
			ja = 4.6
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play120411136(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.475

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[398].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:GetWordFromCfg(120411135)
				local var_554_2 = arg_551_1:FormatText(var_554_1.content)

				arg_551_1.text_.text = var_554_2

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_4 = 19 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 19)

				if (19 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 19)) > 0 and var_554_0 < var_554_4 then
					arg_551_1.talkMaxDuration = var_554_4

					if var_554_4 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_4 + 0
					end
				end

				arg_551_1.text_.text = var_554_2
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411135", "story_v_out_120411.awb") ~= 0 then
					local var_554_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411135", "story_v_out_120411.awb") / 1000

					if var_554_5 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + 0
					end

					if var_554_1.prefab_name ~= "" and arg_551_1.actors_[var_554_1.prefab_name] ~= nil then
						local var_554_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_1.prefab_name].transform, "story_v_out_120411", "120411135", "story_v_out_120411.awb")

						arg_551_1:RecordAudio("120411135", var_554_6)
						arg_551_1:RecordAudio("120411135", var_554_6)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_120411", "120411135", "story_v_out_120411.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_120411", "120411135", "story_v_out_120411.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_7 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_7 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_7

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_7 and arg_551_1.time_ < 0 + var_554_7 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play120411136 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 120411136
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play120411137(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.85

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(120411136).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 34 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 34)

				if (34 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 34)) > 0 and var_558_0 < var_558_3 then
					arg_555_1.talkMaxDuration = var_558_3

					if var_558_3 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_3 + 0
					end
				end

				arg_555_1.text_.text = var_558_1
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_4 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_4 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_4

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_4 and arg_555_1.time_ < 0 + var_558_4 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play120411137 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 120411137
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play120411138(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 1.575

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(120411137).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 63 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 63)

				if (63 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 63)) > 0 and var_562_0 < var_562_3 then
					arg_559_1.talkMaxDuration = var_562_3

					if var_562_3 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_3 + 0
					end
				end

				arg_559_1.text_.text = var_562_1
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_4 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_4 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_4

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_4 and arg_559_1.time_ < 0 + var_562_4 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play120411138 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 120411138
		arg_563_1.duration_ = 3.9

		local var_563_0 = {
			zh = 3.9,
			ja = 3.833
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play120411139(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 1 < arg_563_1.time_ and arg_563_1.time_ <= 1 + arg_566_0 then
				arg_563_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_566_0 = 0.6

			if 1 <= arg_563_1.time_ and arg_563_1.time_ < 1 + var_566_0 then
				local var_566_1, var_566_2 = math.modf((arg_563_1.time_ - 1) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_566_2 * 0.13, var_566_2 * 0.13, var_566_2 * 0.13) + arg_563_1.var_.shakeOldPos
			end

			if arg_563_1.time_ >= 1 + var_566_0 and arg_563_1.time_ < 1 + var_566_0 + arg_566_0 then
				manager.ui.mainCamera.transform.localPosition = arg_563_1.var_.shakeOldPos
			end

			local var_566_3 = 0

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_3 + arg_566_0 then
				arg_563_1.allBtn_.enabled = false
			end

			if arg_563_1.time_ >= var_566_3 + 1.6 and arg_563_1.time_ < var_566_3 + 1.6 + arg_566_0 then
				arg_563_1.allBtn_.enabled = true
			end

			local var_566_4 = 0
			local var_566_5 = 0.5

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_4 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_6 = arg_563_1:GetWordFromCfg(120411138)
				local var_566_7 = arg_563_1:FormatText(var_566_6.content)

				arg_563_1.text_.text = var_566_7

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_9 = 20 <= 0 and var_566_5 or var_566_5 * (utf8.len(var_566_7) / 20)

				if (20 <= 0 and var_566_5 or var_566_5 * (utf8.len(var_566_7) / 20)) > 0 and var_566_5 < var_566_9 then
					arg_563_1.talkMaxDuration = var_566_9

					if var_566_9 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_9 + var_566_4
					end
				end

				arg_563_1.text_.text = var_566_7
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411138", "story_v_out_120411.awb") ~= 0 then
					local var_566_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411138", "story_v_out_120411.awb") / 1000

					if var_566_10 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_10 + var_566_4
					end

					if var_566_6.prefab_name ~= "" and arg_563_1.actors_[var_566_6.prefab_name] ~= nil then
						local var_566_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_6.prefab_name].transform, "story_v_out_120411", "120411138", "story_v_out_120411.awb")

						arg_563_1:RecordAudio("120411138", var_566_11)
						arg_563_1:RecordAudio("120411138", var_566_11)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_120411", "120411138", "story_v_out_120411.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_120411", "120411138", "story_v_out_120411.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_12 = math.max(var_566_5, arg_563_1.talkMaxDuration)

			if var_566_4 <= arg_563_1.time_ and arg_563_1.time_ < var_566_4 + var_566_12 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_4) / var_566_12

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_4 + var_566_12 and arg_563_1.time_ < var_566_4 + var_566_12 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play120411139 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 120411139
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play120411140(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 1.25

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_1 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(120411139).content)

				arg_567_1.text_.text = var_570_1

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_3 = 50 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 50)

				if (50 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 50)) > 0 and var_570_0 < var_570_3 then
					arg_567_1.talkMaxDuration = var_570_3

					if var_570_3 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_3 + 0
					end
				end

				arg_567_1.text_.text = var_570_1
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_4 = math.max(var_570_0, arg_567_1.talkMaxDuration)

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_4 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - 0) / var_570_4

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= 0 + var_570_4 and arg_567_1.time_ < 0 + var_570_4 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play120411140 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 120411140
		arg_571_1.duration_ = 2.17

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play120411141(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.var_.moveOldPos1069ui_story = arg_571_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_574_0 = 0.001

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 then
				arg_571_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_571_1.time_ - 0) / var_574_0)
				arg_571_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1069ui_story"].transform.position).z)
				arg_571_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["1069ui_story"].transform.localEulerAngles = arg_571_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 then
				arg_571_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_571_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1069ui_story"].transform.position).z)
				arg_571_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["1069ui_story"].transform.localEulerAngles = arg_571_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if 0.6 < arg_571_1.time_ and arg_571_1.time_ <= 0.6 + arg_574_0 then
				arg_571_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_porcelain_break", "")
			end

			local var_574_2 = arg_571_1.actors_["1069ui_story"]

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(var_574_2) and arg_571_1.var_.characterEffect1069ui_story == nil then
				arg_571_1.var_.characterEffect1069ui_story = var_574_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_3 = 0.2

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_3 and not isNil(var_574_2) then
				if arg_571_1.var_.characterEffect1069ui_story and not isNil(var_574_2) then
					arg_571_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_3 and arg_571_1.time_ < 0 + var_574_3 + arg_574_0 and not isNil(var_574_2) and arg_571_1.var_.characterEffect1069ui_story then
				arg_571_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action5_1")
			end

			local var_574_5 = 0
			local var_574_6 = 0.2

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_5 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_7 = arg_571_1:GetWordFromCfg(120411140)
				local var_574_8 = arg_571_1:FormatText(var_574_7.content)

				arg_571_1.text_.text = var_574_8

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_10 = 8 <= 0 and var_574_6 or var_574_6 * (utf8.len(var_574_8) / 8)

				if (8 <= 0 and var_574_6 or var_574_6 * (utf8.len(var_574_8) / 8)) > 0 and var_574_6 < var_574_10 then
					arg_571_1.talkMaxDuration = var_574_10

					if var_574_10 + var_574_5 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_10 + var_574_5
					end
				end

				arg_571_1.text_.text = var_574_8
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411140", "story_v_out_120411.awb") ~= 0 then
					local var_574_11 = manager.audio:GetVoiceLength("story_v_out_120411", "120411140", "story_v_out_120411.awb") / 1000

					if var_574_11 + var_574_5 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_11 + var_574_5
					end

					if var_574_7.prefab_name ~= "" and arg_571_1.actors_[var_574_7.prefab_name] ~= nil then
						local var_574_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_7.prefab_name].transform, "story_v_out_120411", "120411140", "story_v_out_120411.awb")

						arg_571_1:RecordAudio("120411140", var_574_12)
						arg_571_1:RecordAudio("120411140", var_574_12)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_120411", "120411140", "story_v_out_120411.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_120411", "120411140", "story_v_out_120411.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_13 = math.max(var_574_6, arg_571_1.talkMaxDuration)

			if var_574_5 <= arg_571_1.time_ and arg_571_1.time_ < var_574_5 + var_574_13 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_5) / var_574_13

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_5 + var_574_13 and arg_571_1.time_ < var_574_5 + var_574_13 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play120411141 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 120411141
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play120411142(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos1069ui_story = arg_575_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_578_0 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				arg_575_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1069ui_story"].transform.position).z)
				arg_575_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["1069ui_story"].transform.localEulerAngles = arg_575_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				arg_575_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_575_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1069ui_story"].transform.position).z)
				arg_575_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["1069ui_story"].transform.localEulerAngles = arg_575_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_578_1 = 0
			local var_578_2 = 1.65

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_3 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(120411141).content)

				arg_575_1.text_.text = var_578_3

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 66 <= 0 and var_578_2 or var_578_2 * (utf8.len(var_578_3) / 66)

				if (66 <= 0 and var_578_2 or var_578_2 * (utf8.len(var_578_3) / 66)) > 0 and var_578_2 < var_578_5 then
					arg_575_1.talkMaxDuration = var_578_5

					if var_578_5 + var_578_1 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + var_578_1
					end
				end

				arg_575_1.text_.text = var_578_3
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_6 = math.max(var_578_2, arg_575_1.talkMaxDuration)

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_6 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_1) / var_578_6

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_1 + var_578_6 and arg_575_1.time_ < var_578_1 + var_578_6 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play120411142 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 120411142
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play120411143(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 1.075

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_1 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(120411142).content)

				arg_579_1.text_.text = var_582_1

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_3 = 43 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 43)

				if (43 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 43)) > 0 and var_582_0 < var_582_3 then
					arg_579_1.talkMaxDuration = var_582_3

					if var_582_3 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_3 + 0
					end
				end

				arg_579_1.text_.text = var_582_1
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_4 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_4 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_4

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_4 and arg_579_1.time_ < 0 + var_582_4 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play120411143 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 120411143
		arg_583_1.duration_ = 4.73

		local var_583_0 = {
			zh = 4.733,
			ja = 3.266
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play120411144(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if arg_583_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_586_0 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_583_1.stage_.transform)

				var_586_0.name = "1072ui_story"
				var_586_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_583_1.actors_["1072ui_story"] = var_586_0

				local var_586_1 = var_586_0:GetComponentInChildren(typeof(CharacterEffect))

				var_586_1.enabled = true

				local var_586_2 = GameObjectTools.GetOrAddComponent(var_586_0, typeof(DynamicBoneHelper))

				if var_586_2 then
					var_586_2:EnableDynamicBone(false)
				end

				arg_583_1:ShowWeapon(var_586_1.transform, false)

				arg_583_1.var_["1072ui_story" .. "Animator"] = var_586_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_583_1.var_["1072ui_story" .. "Animator"].applyRootMotion = true
				arg_583_1.var_["1072ui_story" .. "LipSync"] = var_586_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_586_3 = arg_583_1.actors_["1072ui_story"].transform

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.var_.moveOldPos1072ui_story = var_586_3.localPosition
			end

			local var_586_4 = 0.001

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_4 then
				var_586_3.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_583_1.time_ - 0) / var_586_4)
				var_586_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_586_3.position).x, (manager.ui.mainCamera.transform.position - var_586_3.position).y, (manager.ui.mainCamera.transform.position - var_586_3.position).z)
				var_586_3.localEulerAngles.z = 0
				var_586_3.localEulerAngles.x = 0
				var_586_3.localEulerAngles = var_586_3.localEulerAngles
			end

			if arg_583_1.time_ >= 0 + var_586_4 and arg_583_1.time_ < 0 + var_586_4 + arg_586_0 then
				var_586_3.localPosition = Vector3.New(0, -0.71, -6)
				var_586_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_586_3.position).x, (manager.ui.mainCamera.transform.position - var_586_3.position).y, (manager.ui.mainCamera.transform.position - var_586_3.position).z)
				var_586_3.localEulerAngles.z = 0
				var_586_3.localEulerAngles.x = 0
				var_586_3.localEulerAngles = var_586_3.localEulerAngles
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_586_5 = arg_583_1.actors_["1072ui_story"]

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(var_586_5) and arg_583_1.var_.characterEffect1072ui_story == nil then
				arg_583_1.var_.characterEffect1072ui_story = var_586_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_6 = 0.2

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_6 and not isNil(var_586_5) then
				if arg_583_1.var_.characterEffect1072ui_story and not isNil(var_586_5) then
					arg_583_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= 0 + var_586_6 and arg_583_1.time_ < 0 + var_586_6 + arg_586_0 and not isNil(var_586_5) and arg_583_1.var_.characterEffect1072ui_story then
				arg_583_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_586_8 = 0
			local var_586_9 = 0.2

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_8 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_10 = arg_583_1:GetWordFromCfg(120411143)
				local var_586_11 = arg_583_1:FormatText(var_586_10.content)

				arg_583_1.text_.text = var_586_11

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_13 = 8 <= 0 and var_586_9 or var_586_9 * (utf8.len(var_586_11) / 8)

				if (8 <= 0 and var_586_9 or var_586_9 * (utf8.len(var_586_11) / 8)) > 0 and var_586_9 < var_586_13 then
					arg_583_1.talkMaxDuration = var_586_13

					if var_586_13 + var_586_8 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_13 + var_586_8
					end
				end

				arg_583_1.text_.text = var_586_11
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411143", "story_v_out_120411.awb") ~= 0 then
					local var_586_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411143", "story_v_out_120411.awb") / 1000

					if var_586_14 + var_586_8 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_14 + var_586_8
					end

					if var_586_10.prefab_name ~= "" and arg_583_1.actors_[var_586_10.prefab_name] ~= nil then
						local var_586_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_10.prefab_name].transform, "story_v_out_120411", "120411143", "story_v_out_120411.awb")

						arg_583_1:RecordAudio("120411143", var_586_15)
						arg_583_1:RecordAudio("120411143", var_586_15)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_120411", "120411143", "story_v_out_120411.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_120411", "120411143", "story_v_out_120411.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_16 = math.max(var_586_9, arg_583_1.talkMaxDuration)

			if var_586_8 <= arg_583_1.time_ and arg_583_1.time_ < var_586_8 + var_586_16 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_8) / var_586_16

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_8 + var_586_16 and arg_583_1.time_ < var_586_8 + var_586_16 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play120411144 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 120411144
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play120411145(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["1072ui_story"]) and arg_587_1.var_.characterEffect1072ui_story == nil then
				arg_587_1.var_.characterEffect1072ui_story = arg_587_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_0 = 0.2

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["1072ui_story"]) then
				if arg_587_1.var_.characterEffect1072ui_story and not isNil(arg_587_1.actors_["1072ui_story"]) then
					arg_587_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_587_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_587_1.time_ - 0) / var_590_0)
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["1072ui_story"]) and arg_587_1.var_.characterEffect1072ui_story then
				arg_587_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_587_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_590_1 = 0
			local var_590_2 = 0.825

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_3 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(120411144).content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 33 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 33)

				if (33 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 33)) > 0 and var_590_2 < var_590_5 then
					arg_587_1.talkMaxDuration = var_590_5

					if var_590_5 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + var_590_1
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_6 = math.max(var_590_2, arg_587_1.talkMaxDuration)

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_6 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_1) / var_590_6

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_1 + var_590_6 and arg_587_1.time_ < var_590_1 + var_590_6 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play120411145 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 120411145
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play120411146(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.65

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(120411145).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 26 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 26)

				if (26 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 26)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play120411146 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 120411146
		arg_595_1.duration_ = 7.8

		local var_595_0 = {
			zh = 7.8,
			ja = 6.8
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play120411147(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.var_.moveOldPos1072ui_story = arg_595_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_598_0 = 0.001

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 then
				arg_595_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_595_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_595_1.time_ - 0) / var_598_0)
				arg_595_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_595_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1072ui_story"].transform.position).z)
				arg_595_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_595_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_595_1.actors_["1072ui_story"].transform.localEulerAngles = arg_595_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 then
				arg_595_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_595_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_595_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1072ui_story"].transform.position).z)
				arg_595_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_595_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_595_1.actors_["1072ui_story"].transform.localEulerAngles = arg_595_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_598_1 = arg_595_1.actors_["1071ui_story"]

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(var_598_1) and arg_595_1.var_.characterEffect1071ui_story == nil then
				arg_595_1.var_.characterEffect1071ui_story = var_598_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_2 = 0.2

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_2 and not isNil(var_598_1) then
				if arg_595_1.var_.characterEffect1071ui_story and not isNil(var_598_1) then
					arg_595_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_595_1.time_ >= 0 + var_598_2 and arg_595_1.time_ < 0 + var_598_2 + arg_598_0 and not isNil(var_598_1) and arg_595_1.var_.characterEffect1071ui_story then
				arg_595_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_598_4 = arg_595_1.actors_["1071ui_story"].transform

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.var_.moveOldPos1071ui_story = var_598_4.localPosition
			end

			local var_598_5 = 0.001

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_5 then
				var_598_4.localPosition = Vector3.Lerp(arg_595_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_595_1.time_ - 0) / var_598_5)
				var_598_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_598_4.position).x, (manager.ui.mainCamera.transform.position - var_598_4.position).y, (manager.ui.mainCamera.transform.position - var_598_4.position).z)
				var_598_4.localEulerAngles.z = 0
				var_598_4.localEulerAngles.x = 0
				var_598_4.localEulerAngles = var_598_4.localEulerAngles
			end

			if arg_595_1.time_ >= 0 + var_598_5 and arg_595_1.time_ < 0 + var_598_5 + arg_598_0 then
				var_598_4.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_598_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_598_4.position).x, (manager.ui.mainCamera.transform.position - var_598_4.position).y, (manager.ui.mainCamera.transform.position - var_598_4.position).z)
				var_598_4.localEulerAngles.z = 0
				var_598_4.localEulerAngles.x = 0
				var_598_4.localEulerAngles = var_598_4.localEulerAngles
			end

			local var_598_6 = 0
			local var_598_7 = 0.625

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_6 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_8 = arg_595_1:GetWordFromCfg(120411146)
				local var_598_9 = arg_595_1:FormatText(var_598_8.content)

				arg_595_1.text_.text = var_598_9

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_11 = 25 <= 0 and var_598_7 or var_598_7 * (utf8.len(var_598_9) / 25)

				if (25 <= 0 and var_598_7 or var_598_7 * (utf8.len(var_598_9) / 25)) > 0 and var_598_7 < var_598_11 then
					arg_595_1.talkMaxDuration = var_598_11

					if var_598_11 + var_598_6 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_11 + var_598_6
					end
				end

				arg_595_1.text_.text = var_598_9
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411146", "story_v_out_120411.awb") ~= 0 then
					local var_598_12 = manager.audio:GetVoiceLength("story_v_out_120411", "120411146", "story_v_out_120411.awb") / 1000

					if var_598_12 + var_598_6 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_12 + var_598_6
					end

					if var_598_8.prefab_name ~= "" and arg_595_1.actors_[var_598_8.prefab_name] ~= nil then
						local var_598_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_8.prefab_name].transform, "story_v_out_120411", "120411146", "story_v_out_120411.awb")

						arg_595_1:RecordAudio("120411146", var_598_13)
						arg_595_1:RecordAudio("120411146", var_598_13)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_120411", "120411146", "story_v_out_120411.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_120411", "120411146", "story_v_out_120411.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_14 = math.max(var_598_7, arg_595_1.talkMaxDuration)

			if var_598_6 <= arg_595_1.time_ and arg_595_1.time_ < var_598_6 + var_598_14 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_6) / var_598_14

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_6 + var_598_14 and arg_595_1.time_ < var_598_6 + var_598_14 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_595_1:InitPlayNodeList()
	end,
	Play120411147 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 120411147
		arg_599_1.duration_ = 5.3

		local var_599_0 = {
			zh = 2.4,
			ja = 5.3
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play120411148(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(arg_599_1.actors_["1071ui_story"]) and arg_599_1.var_.characterEffect1071ui_story == nil then
				arg_599_1.var_.characterEffect1071ui_story = arg_599_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_0 = 0.2

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 and not isNil(arg_599_1.actors_["1071ui_story"]) then
				if arg_599_1.var_.characterEffect1071ui_story and not isNil(arg_599_1.actors_["1071ui_story"]) then
					arg_599_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_599_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_599_1.time_ - 0) / var_602_0)
				end
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 and not isNil(arg_599_1.actors_["1071ui_story"]) and arg_599_1.var_.characterEffect1071ui_story then
				arg_599_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_599_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_602_1 = arg_599_1.actors_["1069ui_story"].transform

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.var_.moveOldPos1069ui_story = var_602_1.localPosition
			end

			local var_602_2 = 0.001

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_2 then
				var_602_1.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_599_1.time_ - 0) / var_602_2)
				var_602_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_602_1.position).x, (manager.ui.mainCamera.transform.position - var_602_1.position).y, (manager.ui.mainCamera.transform.position - var_602_1.position).z)
				var_602_1.localEulerAngles.z = 0
				var_602_1.localEulerAngles.x = 0
				var_602_1.localEulerAngles = var_602_1.localEulerAngles
			end

			if arg_599_1.time_ >= 0 + var_602_2 and arg_599_1.time_ < 0 + var_602_2 + arg_602_0 then
				var_602_1.localPosition = Vector3.New(0.7, -1, -6)
				var_602_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_602_1.position).x, (manager.ui.mainCamera.transform.position - var_602_1.position).y, (manager.ui.mainCamera.transform.position - var_602_1.position).z)
				var_602_1.localEulerAngles.z = 0
				var_602_1.localEulerAngles.x = 0
				var_602_1.localEulerAngles = var_602_1.localEulerAngles
			end

			local var_602_3 = arg_599_1.actors_["1069ui_story"]

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(var_602_3) and arg_599_1.var_.characterEffect1069ui_story == nil then
				arg_599_1.var_.characterEffect1069ui_story = var_602_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_4 = 0.2

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_4 and not isNil(var_602_3) then
				if arg_599_1.var_.characterEffect1069ui_story and not isNil(var_602_3) then
					arg_599_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= 0 + var_602_4 and arg_599_1.time_ < 0 + var_602_4 + arg_602_0 and not isNil(var_602_3) and arg_599_1.var_.characterEffect1069ui_story then
				arg_599_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_602_6 = 0
			local var_602_7 = 0.2

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_6 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_8 = arg_599_1:GetWordFromCfg(120411147)
				local var_602_9 = arg_599_1:FormatText(var_602_8.content)

				arg_599_1.text_.text = var_602_9

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_11 = 8 <= 0 and var_602_7 or var_602_7 * (utf8.len(var_602_9) / 8)

				if (8 <= 0 and var_602_7 or var_602_7 * (utf8.len(var_602_9) / 8)) > 0 and var_602_7 < var_602_11 then
					arg_599_1.talkMaxDuration = var_602_11

					if var_602_11 + var_602_6 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_11 + var_602_6
					end
				end

				arg_599_1.text_.text = var_602_9
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411147", "story_v_out_120411.awb") ~= 0 then
					local var_602_12 = manager.audio:GetVoiceLength("story_v_out_120411", "120411147", "story_v_out_120411.awb") / 1000

					if var_602_12 + var_602_6 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_12 + var_602_6
					end

					if var_602_8.prefab_name ~= "" and arg_599_1.actors_[var_602_8.prefab_name] ~= nil then
						local var_602_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_8.prefab_name].transform, "story_v_out_120411", "120411147", "story_v_out_120411.awb")

						arg_599_1:RecordAudio("120411147", var_602_13)
						arg_599_1:RecordAudio("120411147", var_602_13)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_out_120411", "120411147", "story_v_out_120411.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_out_120411", "120411147", "story_v_out_120411.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_14 = math.max(var_602_7, arg_599_1.talkMaxDuration)

			if var_602_6 <= arg_599_1.time_ and arg_599_1.time_ < var_602_6 + var_602_14 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_6) / var_602_14

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_6 + var_602_14 and arg_599_1.time_ < var_602_6 + var_602_14 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play120411148 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 120411148
		arg_603_1.duration_ = 10.2

		local var_603_0 = {
			zh = 8.633,
			ja = 10.2
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play120411149(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["1069ui_story"]) and arg_603_1.var_.characterEffect1069ui_story == nil then
				arg_603_1.var_.characterEffect1069ui_story = arg_603_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_0 = 0.2

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["1069ui_story"]) then
				if arg_603_1.var_.characterEffect1069ui_story and not isNil(arg_603_1.actors_["1069ui_story"]) then
					arg_603_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_603_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_603_1.time_ - 0) / var_606_0)
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["1069ui_story"]) and arg_603_1.var_.characterEffect1069ui_story then
				arg_603_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_603_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_2")
			end

			local var_606_1 = arg_603_1.actors_["1071ui_story"]

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(var_606_1) and arg_603_1.var_.characterEffect1071ui_story == nil then
				arg_603_1.var_.characterEffect1071ui_story = var_606_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.2

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_2 and not isNil(var_606_1) then
				if arg_603_1.var_.characterEffect1071ui_story and not isNil(var_606_1) then
					arg_603_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_603_1.time_ >= 0 + var_606_2 and arg_603_1.time_ < 0 + var_606_2 + arg_606_0 and not isNil(var_606_1) and arg_603_1.var_.characterEffect1071ui_story then
				arg_603_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_606_4 = 0
			local var_606_5 = 0.875

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_4 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_6 = arg_603_1:GetWordFromCfg(120411148)
				local var_606_7 = arg_603_1:FormatText(var_606_6.content)

				arg_603_1.text_.text = var_606_7

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_9 = 35 <= 0 and var_606_5 or var_606_5 * (utf8.len(var_606_7) / 35)

				if (35 <= 0 and var_606_5 or var_606_5 * (utf8.len(var_606_7) / 35)) > 0 and var_606_5 < var_606_9 then
					arg_603_1.talkMaxDuration = var_606_9

					if var_606_9 + var_606_4 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_9 + var_606_4
					end
				end

				arg_603_1.text_.text = var_606_7
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411148", "story_v_out_120411.awb") ~= 0 then
					local var_606_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411148", "story_v_out_120411.awb") / 1000

					if var_606_10 + var_606_4 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_10 + var_606_4
					end

					if var_606_6.prefab_name ~= "" and arg_603_1.actors_[var_606_6.prefab_name] ~= nil then
						local var_606_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_6.prefab_name].transform, "story_v_out_120411", "120411148", "story_v_out_120411.awb")

						arg_603_1:RecordAudio("120411148", var_606_11)
						arg_603_1:RecordAudio("120411148", var_606_11)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_120411", "120411148", "story_v_out_120411.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_120411", "120411148", "story_v_out_120411.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_12 = math.max(var_606_5, arg_603_1.talkMaxDuration)

			if var_606_4 <= arg_603_1.time_ and arg_603_1.time_ < var_606_4 + var_606_12 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_4) / var_606_12

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_4 + var_606_12 and arg_603_1.time_ < var_606_4 + var_606_12 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play120411149 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 120411149
		arg_607_1.duration_ = 11.03

		local var_607_0 = {
			zh = 7.566,
			ja = 11.033
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play120411150(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.725

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_1 = arg_607_1:GetWordFromCfg(120411149)
				local var_610_2 = arg_607_1:FormatText(var_610_1.content)

				arg_607_1.text_.text = var_610_2

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_4 = 29 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 29)

				if (29 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 29)) > 0 and var_610_0 < var_610_4 then
					arg_607_1.talkMaxDuration = var_610_4

					if var_610_4 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_4 + 0
					end
				end

				arg_607_1.text_.text = var_610_2
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411149", "story_v_out_120411.awb") ~= 0 then
					local var_610_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411149", "story_v_out_120411.awb") / 1000

					if var_610_5 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_5 + 0
					end

					if var_610_1.prefab_name ~= "" and arg_607_1.actors_[var_610_1.prefab_name] ~= nil then
						local var_610_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_1.prefab_name].transform, "story_v_out_120411", "120411149", "story_v_out_120411.awb")

						arg_607_1:RecordAudio("120411149", var_610_6)
						arg_607_1:RecordAudio("120411149", var_610_6)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_120411", "120411149", "story_v_out_120411.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_120411", "120411149", "story_v_out_120411.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_7 and arg_607_1.time_ < 0 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play120411150 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 120411150
		arg_611_1.duration_ = 2

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play120411151(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1069ui_story"]) and arg_611_1.var_.characterEffect1069ui_story == nil then
				arg_611_1.var_.characterEffect1069ui_story = arg_611_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.2

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["1069ui_story"]) then
				if arg_611_1.var_.characterEffect1069ui_story and not isNil(arg_611_1.actors_["1069ui_story"]) then
					arg_611_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_611_1.time_ - 0) / var_614_0)
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["1069ui_story"]) and arg_611_1.var_.characterEffect1069ui_story then
				arg_611_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_614_1 = arg_611_1.actors_["1071ui_story"].transform

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos1071ui_story = var_614_1.localPosition
			end

			local var_614_2 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_2 then
				var_614_1.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_611_1.time_ - 0) / var_614_2)
				var_614_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_614_1.position).x, (manager.ui.mainCamera.transform.position - var_614_1.position).y, (manager.ui.mainCamera.transform.position - var_614_1.position).z)
				var_614_1.localEulerAngles.z = 0
				var_614_1.localEulerAngles.x = 0
				var_614_1.localEulerAngles = var_614_1.localEulerAngles
			end

			if arg_611_1.time_ >= 0 + var_614_2 and arg_611_1.time_ < 0 + var_614_2 + arg_614_0 then
				var_614_1.localPosition = Vector3.New(0, 100, 0)
				var_614_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_614_1.position).x, (manager.ui.mainCamera.transform.position - var_614_1.position).y, (manager.ui.mainCamera.transform.position - var_614_1.position).z)
				var_614_1.localEulerAngles.z = 0
				var_614_1.localEulerAngles.x = 0
				var_614_1.localEulerAngles = var_614_1.localEulerAngles
			end

			local var_614_3 = arg_611_1.actors_["1069ui_story"].transform

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos1069ui_story = var_614_3.localPosition
			end

			local var_614_4 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_4 then
				var_614_3.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_611_1.time_ - 0) / var_614_4)
				var_614_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_614_3.position).x, (manager.ui.mainCamera.transform.position - var_614_3.position).y, (manager.ui.mainCamera.transform.position - var_614_3.position).z)
				var_614_3.localEulerAngles.z = 0
				var_614_3.localEulerAngles.x = 0
				var_614_3.localEulerAngles = var_614_3.localEulerAngles
			end

			if arg_611_1.time_ >= 0 + var_614_4 and arg_611_1.time_ < 0 + var_614_4 + arg_614_0 then
				var_614_3.localPosition = Vector3.New(0, 100, 0)
				var_614_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_614_3.position).x, (manager.ui.mainCamera.transform.position - var_614_3.position).y, (manager.ui.mainCamera.transform.position - var_614_3.position).z)
				var_614_3.localEulerAngles.z = 0
				var_614_3.localEulerAngles.x = 0
				var_614_3.localEulerAngles = var_614_3.localEulerAngles
			end

			local var_614_5 = arg_611_1.actors_["1076ui_story"].transform

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos1076ui_story = var_614_5.localPosition
			end

			local var_614_6 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_6 then
				var_614_5.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_611_1.time_ - 0) / var_614_6)
				var_614_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_614_5.position).x, (manager.ui.mainCamera.transform.position - var_614_5.position).y, (manager.ui.mainCamera.transform.position - var_614_5.position).z)
				var_614_5.localEulerAngles.z = 0
				var_614_5.localEulerAngles.x = 0
				var_614_5.localEulerAngles = var_614_5.localEulerAngles
			end

			if arg_611_1.time_ >= 0 + var_614_6 and arg_611_1.time_ < 0 + var_614_6 + arg_614_0 then
				var_614_5.localPosition = Vector3.New(0, -1.06, -6.2)
				var_614_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_614_5.position).x, (manager.ui.mainCamera.transform.position - var_614_5.position).y, (manager.ui.mainCamera.transform.position - var_614_5.position).z)
				var_614_5.localEulerAngles.z = 0
				var_614_5.localEulerAngles.x = 0
				var_614_5.localEulerAngles = var_614_5.localEulerAngles
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			local var_614_7 = arg_611_1.actors_["1076ui_story"]

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(var_614_7) and arg_611_1.var_.characterEffect1076ui_story == nil then
				arg_611_1.var_.characterEffect1076ui_story = var_614_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_8 = 0.2

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_8 and not isNil(var_614_7) then
				if arg_611_1.var_.characterEffect1076ui_story and not isNil(var_614_7) then
					arg_611_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= 0 + var_614_8 and arg_611_1.time_ < 0 + var_614_8 + arg_614_0 and not isNil(var_614_7) and arg_611_1.var_.characterEffect1076ui_story then
				arg_611_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_614_10 = 0
			local var_614_11 = 0.05

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_10 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_12 = arg_611_1:GetWordFromCfg(120411150)
				local var_614_13 = arg_611_1:FormatText(var_614_12.content)

				arg_611_1.text_.text = var_614_13

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_15 = 2 <= 0 and var_614_11 or var_614_11 * (utf8.len(var_614_13) / 2)

				if (2 <= 0 and var_614_11 or var_614_11 * (utf8.len(var_614_13) / 2)) > 0 and var_614_11 < var_614_15 then
					arg_611_1.talkMaxDuration = var_614_15

					if var_614_15 + var_614_10 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_15 + var_614_10
					end
				end

				arg_611_1.text_.text = var_614_13
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411150", "story_v_out_120411.awb") ~= 0 then
					local var_614_16 = manager.audio:GetVoiceLength("story_v_out_120411", "120411150", "story_v_out_120411.awb") / 1000

					if var_614_16 + var_614_10 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_16 + var_614_10
					end

					if var_614_12.prefab_name ~= "" and arg_611_1.actors_[var_614_12.prefab_name] ~= nil then
						local var_614_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_12.prefab_name].transform, "story_v_out_120411", "120411150", "story_v_out_120411.awb")

						arg_611_1:RecordAudio("120411150", var_614_17)
						arg_611_1:RecordAudio("120411150", var_614_17)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_out_120411", "120411150", "story_v_out_120411.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_out_120411", "120411150", "story_v_out_120411.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_18 = math.max(var_614_11, arg_611_1.talkMaxDuration)

			if var_614_10 <= arg_611_1.time_ and arg_611_1.time_ < var_614_10 + var_614_18 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_10) / var_614_18

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_10 + var_614_18 and arg_611_1.time_ < var_614_10 + var_614_18 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_611_1:InitPlayNodeList()
	end,
	Play120411151 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 120411151
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play120411152(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.var_.moveOldPos1076ui_story = arg_615_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_618_0 = 0.001

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 then
				arg_615_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_615_1.time_ - 0) / var_618_0)
				arg_615_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_615_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1076ui_story"].transform.position).z)
				arg_615_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_615_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_615_1.actors_["1076ui_story"].transform.localEulerAngles = arg_615_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 then
				arg_615_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_615_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_615_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1076ui_story"].transform.position).z)
				arg_615_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_615_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_615_1.actors_["1076ui_story"].transform.localEulerAngles = arg_615_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_618_1 = 0
			local var_618_2 = 1.475

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_3 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(120411151).content)

				arg_615_1.text_.text = var_618_3

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 59 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 59)

				if (59 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 59)) > 0 and var_618_2 < var_618_5 then
					arg_615_1.talkMaxDuration = var_618_5

					if var_618_5 + var_618_1 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_5 + var_618_1
					end
				end

				arg_615_1.text_.text = var_618_3
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_6 = math.max(var_618_2, arg_615_1.talkMaxDuration)

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_6 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_1) / var_618_6

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_1 + var_618_6 and arg_615_1.time_ < var_618_1 + var_618_6 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_615_1:InitPlayNodeList()
	end,
	Play120411152 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 120411152
		arg_619_1.duration_ = 9.5

		local var_619_0 = {
			zh = 3.9,
			ja = 9.5
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play120411153(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(arg_619_1.actors_["1069ui_story"]) and arg_619_1.var_.characterEffect1069ui_story == nil then
				arg_619_1.var_.characterEffect1069ui_story = arg_619_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_0 = 0.2

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 and not isNil(arg_619_1.actors_["1069ui_story"]) then
				if arg_619_1.var_.characterEffect1069ui_story and not isNil(arg_619_1.actors_["1069ui_story"]) then
					arg_619_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 and not isNil(arg_619_1.actors_["1069ui_story"]) and arg_619_1.var_.characterEffect1069ui_story then
				arg_619_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_622_2 = arg_619_1.actors_["1071ui_story"].transform

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos1071ui_story = var_622_2.localPosition
			end

			local var_622_3 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_3 then
				var_622_2.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_619_1.time_ - 0) / var_622_3)
				var_622_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_2.position).x, (manager.ui.mainCamera.transform.position - var_622_2.position).y, (manager.ui.mainCamera.transform.position - var_622_2.position).z)
				var_622_2.localEulerAngles.z = 0
				var_622_2.localEulerAngles.x = 0
				var_622_2.localEulerAngles = var_622_2.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_3 and arg_619_1.time_ < 0 + var_622_3 + arg_622_0 then
				var_622_2.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_622_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_2.position).x, (manager.ui.mainCamera.transform.position - var_622_2.position).y, (manager.ui.mainCamera.transform.position - var_622_2.position).z)
				var_622_2.localEulerAngles.z = 0
				var_622_2.localEulerAngles.x = 0
				var_622_2.localEulerAngles = var_622_2.localEulerAngles
			end

			local var_622_4 = arg_619_1.actors_["1069ui_story"].transform

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos1069ui_story = var_622_4.localPosition
			end

			local var_622_5 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_5 then
				var_622_4.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_619_1.time_ - 0) / var_622_5)
				var_622_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_4.position).x, (manager.ui.mainCamera.transform.position - var_622_4.position).y, (manager.ui.mainCamera.transform.position - var_622_4.position).z)
				var_622_4.localEulerAngles.z = 0
				var_622_4.localEulerAngles.x = 0
				var_622_4.localEulerAngles = var_622_4.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_5 and arg_619_1.time_ < 0 + var_622_5 + arg_622_0 then
				var_622_4.localPosition = Vector3.New(0.7, -1, -6)
				var_622_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_4.position).x, (manager.ui.mainCamera.transform.position - var_622_4.position).y, (manager.ui.mainCamera.transform.position - var_622_4.position).z)
				var_622_4.localEulerAngles.z = 0
				var_622_4.localEulerAngles.x = 0
				var_622_4.localEulerAngles = var_622_4.localEulerAngles
			end

			local var_622_6 = arg_619_1.actors_["1071ui_story"]

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(var_622_6) and arg_619_1.var_.characterEffect1071ui_story == nil then
				arg_619_1.var_.characterEffect1071ui_story = var_622_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_7 = 0.0166666666666667

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_7 and not isNil(var_622_6) then
				if arg_619_1.var_.characterEffect1071ui_story and not isNil(var_622_6) then
					arg_619_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_619_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_619_1.time_ - 0) / var_622_7)
				end
			end

			if arg_619_1.time_ >= 0 + var_622_7 and arg_619_1.time_ < 0 + var_622_7 + arg_622_0 and not isNil(var_622_6) and arg_619_1.var_.characterEffect1071ui_story then
				arg_619_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_619_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_622_8 = 0
			local var_622_9 = 0.425

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_8 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_10 = arg_619_1:GetWordFromCfg(120411152)
				local var_622_11 = arg_619_1:FormatText(var_622_10.content)

				arg_619_1.text_.text = var_622_11

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_13 = 17 <= 0 and var_622_9 or var_622_9 * (utf8.len(var_622_11) / 17)

				if (17 <= 0 and var_622_9 or var_622_9 * (utf8.len(var_622_11) / 17)) > 0 and var_622_9 < var_622_13 then
					arg_619_1.talkMaxDuration = var_622_13

					if var_622_13 + var_622_8 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_13 + var_622_8
					end
				end

				arg_619_1.text_.text = var_622_11
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411152", "story_v_out_120411.awb") ~= 0 then
					local var_622_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411152", "story_v_out_120411.awb") / 1000

					if var_622_14 + var_622_8 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_14 + var_622_8
					end

					if var_622_10.prefab_name ~= "" and arg_619_1.actors_[var_622_10.prefab_name] ~= nil then
						local var_622_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_10.prefab_name].transform, "story_v_out_120411", "120411152", "story_v_out_120411.awb")

						arg_619_1:RecordAudio("120411152", var_622_15)
						arg_619_1:RecordAudio("120411152", var_622_15)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_out_120411", "120411152", "story_v_out_120411.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_out_120411", "120411152", "story_v_out_120411.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_16 = math.max(var_622_9, arg_619_1.talkMaxDuration)

			if var_622_8 <= arg_619_1.time_ and arg_619_1.time_ < var_622_8 + var_622_16 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_8) / var_622_16

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_8 + var_622_16 and arg_619_1.time_ < var_622_8 + var_622_16 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play120411153 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 120411153
		arg_623_1.duration_ = 5.67

		local var_623_0 = {
			zh = 1.999999999999,
			ja = 5.666
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play120411154(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1071ui_story = arg_623_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_626_0 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 then
				arg_623_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_623_1.time_ - 0) / var_626_0)
				arg_623_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1071ui_story"].transform.position).z)
				arg_623_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1071ui_story"].transform.localEulerAngles = arg_623_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 then
				arg_623_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_623_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1071ui_story"].transform.position).z)
				arg_623_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1071ui_story"].transform.localEulerAngles = arg_623_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_626_1 = arg_623_1.actors_["1072ui_story"].transform

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1072ui_story = var_626_1.localPosition
			end

			local var_626_2 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_2 then
				var_626_1.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_623_1.time_ - 0) / var_626_2)
				var_626_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_1.position).x, (manager.ui.mainCamera.transform.position - var_626_1.position).y, (manager.ui.mainCamera.transform.position - var_626_1.position).z)
				var_626_1.localEulerAngles.z = 0
				var_626_1.localEulerAngles.x = 0
				var_626_1.localEulerAngles = var_626_1.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_2 and arg_623_1.time_ < 0 + var_626_2 + arg_626_0 then
				var_626_1.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_626_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_1.position).x, (manager.ui.mainCamera.transform.position - var_626_1.position).y, (manager.ui.mainCamera.transform.position - var_626_1.position).z)
				var_626_1.localEulerAngles.z = 0
				var_626_1.localEulerAngles.x = 0
				var_626_1.localEulerAngles = var_626_1.localEulerAngles
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_626_3 = arg_623_1.actors_["1072ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_3) and arg_623_1.var_.characterEffect1072ui_story == nil then
				arg_623_1.var_.characterEffect1072ui_story = var_626_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_4 = 0.2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_4 and not isNil(var_626_3) then
				if arg_623_1.var_.characterEffect1072ui_story and not isNil(var_626_3) then
					arg_623_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_4 and arg_623_1.time_ < 0 + var_626_4 + arg_626_0 and not isNil(var_626_3) and arg_623_1.var_.characterEffect1072ui_story then
				arg_623_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_626_6 = arg_623_1.actors_["1069ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_6) and arg_623_1.var_.characterEffect1069ui_story == nil then
				arg_623_1.var_.characterEffect1069ui_story = var_626_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_7 = 0.2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_7 and not isNil(var_626_6) then
				if arg_623_1.var_.characterEffect1069ui_story and not isNil(var_626_6) then
					arg_623_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_623_1.time_ - 0) / var_626_7)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_7 and arg_623_1.time_ < 0 + var_626_7 + arg_626_0 and not isNil(var_626_6) and arg_623_1.var_.characterEffect1069ui_story then
				arg_623_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_626_8 = 0
			local var_626_9 = 0.15

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_8 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_10 = arg_623_1:GetWordFromCfg(120411153)
				local var_626_11 = arg_623_1:FormatText(var_626_10.content)

				arg_623_1.text_.text = var_626_11

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_13 = 6 <= 0 and var_626_9 or var_626_9 * (utf8.len(var_626_11) / 6)

				if (6 <= 0 and var_626_9 or var_626_9 * (utf8.len(var_626_11) / 6)) > 0 and var_626_9 < var_626_13 then
					arg_623_1.talkMaxDuration = var_626_13

					if var_626_13 + var_626_8 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_13 + var_626_8
					end
				end

				arg_623_1.text_.text = var_626_11
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411153", "story_v_out_120411.awb") ~= 0 then
					local var_626_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411153", "story_v_out_120411.awb") / 1000

					if var_626_14 + var_626_8 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_14 + var_626_8
					end

					if var_626_10.prefab_name ~= "" and arg_623_1.actors_[var_626_10.prefab_name] ~= nil then
						local var_626_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_10.prefab_name].transform, "story_v_out_120411", "120411153", "story_v_out_120411.awb")

						arg_623_1:RecordAudio("120411153", var_626_15)
						arg_623_1:RecordAudio("120411153", var_626_15)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_120411", "120411153", "story_v_out_120411.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_120411", "120411153", "story_v_out_120411.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_16 = math.max(var_626_9, arg_623_1.talkMaxDuration)

			if var_626_8 <= arg_623_1.time_ and arg_623_1.time_ < var_626_8 + var_626_16 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_8) / var_626_16

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_8 + var_626_16 and arg_623_1.time_ < var_626_8 + var_626_16 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play120411154 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 120411154
		arg_627_1.duration_ = 13.87

		local var_627_0 = {
			zh = 7.366,
			ja = 13.866
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play120411155(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1072ui_story"]) and arg_627_1.var_.characterEffect1072ui_story == nil then
				arg_627_1.var_.characterEffect1072ui_story = arg_627_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1072ui_story"]) then
				if arg_627_1.var_.characterEffect1072ui_story and not isNil(arg_627_1.actors_["1072ui_story"]) then
					arg_627_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_627_1.time_ - 0) / var_630_0)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1072ui_story"]) and arg_627_1.var_.characterEffect1072ui_story then
				arg_627_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_630_1 = arg_627_1.actors_["1069ui_story"].transform

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.var_.moveOldPos1069ui_story = var_630_1.localPosition
			end

			local var_630_2 = 0.001

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_2 then
				var_630_1.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_627_1.time_ - 0) / var_630_2)
				var_630_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_1.position).x, (manager.ui.mainCamera.transform.position - var_630_1.position).y, (manager.ui.mainCamera.transform.position - var_630_1.position).z)
				var_630_1.localEulerAngles.z = 0
				var_630_1.localEulerAngles.x = 0
				var_630_1.localEulerAngles = var_630_1.localEulerAngles
			end

			if arg_627_1.time_ >= 0 + var_630_2 and arg_627_1.time_ < 0 + var_630_2 + arg_630_0 then
				var_630_1.localPosition = Vector3.New(0, 100, 0)
				var_630_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_1.position).x, (manager.ui.mainCamera.transform.position - var_630_1.position).y, (manager.ui.mainCamera.transform.position - var_630_1.position).z)
				var_630_1.localEulerAngles.z = 0
				var_630_1.localEulerAngles.x = 0
				var_630_1.localEulerAngles = var_630_1.localEulerAngles
			end

			local var_630_3 = arg_627_1.actors_["1072ui_story"].transform

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.var_.moveOldPos1072ui_story = var_630_3.localPosition
			end

			local var_630_4 = 0.001

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_4 then
				var_630_3.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_627_1.time_ - 0) / var_630_4)
				var_630_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_3.position).x, (manager.ui.mainCamera.transform.position - var_630_3.position).y, (manager.ui.mainCamera.transform.position - var_630_3.position).z)
				var_630_3.localEulerAngles.z = 0
				var_630_3.localEulerAngles.x = 0
				var_630_3.localEulerAngles = var_630_3.localEulerAngles
			end

			if arg_627_1.time_ >= 0 + var_630_4 and arg_627_1.time_ < 0 + var_630_4 + arg_630_0 then
				var_630_3.localPosition = Vector3.New(0, 100, 0)
				var_630_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_3.position).x, (manager.ui.mainCamera.transform.position - var_630_3.position).y, (manager.ui.mainCamera.transform.position - var_630_3.position).z)
				var_630_3.localEulerAngles.z = 0
				var_630_3.localEulerAngles.x = 0
				var_630_3.localEulerAngles = var_630_3.localEulerAngles
			end

			local var_630_5 = arg_627_1.actors_["1076ui_story"].transform

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.var_.moveOldPos1076ui_story = var_630_5.localPosition
			end

			local var_630_6 = 0.001

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_6 then
				var_630_5.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_627_1.time_ - 0) / var_630_6)
				var_630_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_5.position).x, (manager.ui.mainCamera.transform.position - var_630_5.position).y, (manager.ui.mainCamera.transform.position - var_630_5.position).z)
				var_630_5.localEulerAngles.z = 0
				var_630_5.localEulerAngles.x = 0
				var_630_5.localEulerAngles = var_630_5.localEulerAngles
			end

			if arg_627_1.time_ >= 0 + var_630_6 and arg_627_1.time_ < 0 + var_630_6 + arg_630_0 then
				var_630_5.localPosition = Vector3.New(0, -1.06, -6.2)
				var_630_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_5.position).x, (manager.ui.mainCamera.transform.position - var_630_5.position).y, (manager.ui.mainCamera.transform.position - var_630_5.position).z)
				var_630_5.localEulerAngles.z = 0
				var_630_5.localEulerAngles.x = 0
				var_630_5.localEulerAngles = var_630_5.localEulerAngles
			end

			local var_630_7 = arg_627_1.actors_["1076ui_story"]

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(var_630_7) and arg_627_1.var_.characterEffect1076ui_story == nil then
				arg_627_1.var_.characterEffect1076ui_story = var_630_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_8 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_8 and not isNil(var_630_7) then
				if arg_627_1.var_.characterEffect1076ui_story and not isNil(var_630_7) then
					arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= 0 + var_630_8 and arg_627_1.time_ < 0 + var_630_8 + arg_630_0 and not isNil(var_630_7) and arg_627_1.var_.characterEffect1076ui_story then
				arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_630_10 = 0
			local var_630_11 = 0.625

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_10 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_12 = arg_627_1:GetWordFromCfg(120411154)
				local var_630_13 = arg_627_1:FormatText(var_630_12.content)

				arg_627_1.text_.text = var_630_13

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_15 = 25 <= 0 and var_630_11 or var_630_11 * (utf8.len(var_630_13) / 25)

				if (25 <= 0 and var_630_11 or var_630_11 * (utf8.len(var_630_13) / 25)) > 0 and var_630_11 < var_630_15 then
					arg_627_1.talkMaxDuration = var_630_15

					if var_630_15 + var_630_10 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_15 + var_630_10
					end
				end

				arg_627_1.text_.text = var_630_13
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411154", "story_v_out_120411.awb") ~= 0 then
					local var_630_16 = manager.audio:GetVoiceLength("story_v_out_120411", "120411154", "story_v_out_120411.awb") / 1000

					if var_630_16 + var_630_10 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_16 + var_630_10
					end

					if var_630_12.prefab_name ~= "" and arg_627_1.actors_[var_630_12.prefab_name] ~= nil then
						local var_630_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_12.prefab_name].transform, "story_v_out_120411", "120411154", "story_v_out_120411.awb")

						arg_627_1:RecordAudio("120411154", var_630_17)
						arg_627_1:RecordAudio("120411154", var_630_17)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_120411", "120411154", "story_v_out_120411.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_120411", "120411154", "story_v_out_120411.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_18 = math.max(var_630_11, arg_627_1.talkMaxDuration)

			if var_630_10 <= arg_627_1.time_ and arg_627_1.time_ < var_630_10 + var_630_18 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_10) / var_630_18

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_10 + var_630_18 and arg_627_1.time_ < var_630_10 + var_630_18 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play120411155 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 120411155
		arg_631_1.duration_ = 7.07

		local var_631_0 = {
			zh = 5.066,
			ja = 7.066
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play120411156(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1069ui_story"]) and arg_631_1.var_.characterEffect1069ui_story == nil then
				arg_631_1.var_.characterEffect1069ui_story = arg_631_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.2

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1069ui_story"]) then
				if arg_631_1.var_.characterEffect1069ui_story and not isNil(arg_631_1.actors_["1069ui_story"]) then
					arg_631_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1069ui_story"]) and arg_631_1.var_.characterEffect1069ui_story then
				arg_631_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_634_2 = arg_631_1.actors_["1069ui_story"].transform

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.var_.moveOldPos1069ui_story = var_634_2.localPosition
			end

			local var_634_3 = 0.001

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_3 then
				var_634_2.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_631_1.time_ - 0) / var_634_3)
				var_634_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_2.position).x, (manager.ui.mainCamera.transform.position - var_634_2.position).y, (manager.ui.mainCamera.transform.position - var_634_2.position).z)
				var_634_2.localEulerAngles.z = 0
				var_634_2.localEulerAngles.x = 0
				var_634_2.localEulerAngles = var_634_2.localEulerAngles
			end

			if arg_631_1.time_ >= 0 + var_634_3 and arg_631_1.time_ < 0 + var_634_3 + arg_634_0 then
				var_634_2.localPosition = Vector3.New(0, -1, -6)
				var_634_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_2.position).x, (manager.ui.mainCamera.transform.position - var_634_2.position).y, (manager.ui.mainCamera.transform.position - var_634_2.position).z)
				var_634_2.localEulerAngles.z = 0
				var_634_2.localEulerAngles.x = 0
				var_634_2.localEulerAngles = var_634_2.localEulerAngles
			end

			local var_634_4 = arg_631_1.actors_["1076ui_story"].transform

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.var_.moveOldPos1076ui_story = var_634_4.localPosition
			end

			local var_634_5 = 0.001

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_5 then
				var_634_4.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_631_1.time_ - 0) / var_634_5)
				var_634_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_4.position).x, (manager.ui.mainCamera.transform.position - var_634_4.position).y, (manager.ui.mainCamera.transform.position - var_634_4.position).z)
				var_634_4.localEulerAngles.z = 0
				var_634_4.localEulerAngles.x = 0
				var_634_4.localEulerAngles = var_634_4.localEulerAngles
			end

			if arg_631_1.time_ >= 0 + var_634_5 and arg_631_1.time_ < 0 + var_634_5 + arg_634_0 then
				var_634_4.localPosition = Vector3.New(0, 100, 0)
				var_634_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_4.position).x, (manager.ui.mainCamera.transform.position - var_634_4.position).y, (manager.ui.mainCamera.transform.position - var_634_4.position).z)
				var_634_4.localEulerAngles.z = 0
				var_634_4.localEulerAngles.x = 0
				var_634_4.localEulerAngles = var_634_4.localEulerAngles
			end

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_634_6 = 0
			local var_634_7 = 0.725

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_6 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_8 = arg_631_1:GetWordFromCfg(120411155)
				local var_634_9 = arg_631_1:FormatText(var_634_8.content)

				arg_631_1.text_.text = var_634_9

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_11 = 29 <= 0 and var_634_7 or var_634_7 * (utf8.len(var_634_9) / 29)

				if (29 <= 0 and var_634_7 or var_634_7 * (utf8.len(var_634_9) / 29)) > 0 and var_634_7 < var_634_11 then
					arg_631_1.talkMaxDuration = var_634_11

					if var_634_11 + var_634_6 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_11 + var_634_6
					end
				end

				arg_631_1.text_.text = var_634_9
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411155", "story_v_out_120411.awb") ~= 0 then
					local var_634_12 = manager.audio:GetVoiceLength("story_v_out_120411", "120411155", "story_v_out_120411.awb") / 1000

					if var_634_12 + var_634_6 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_12 + var_634_6
					end

					if var_634_8.prefab_name ~= "" and arg_631_1.actors_[var_634_8.prefab_name] ~= nil then
						local var_634_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_8.prefab_name].transform, "story_v_out_120411", "120411155", "story_v_out_120411.awb")

						arg_631_1:RecordAudio("120411155", var_634_13)
						arg_631_1:RecordAudio("120411155", var_634_13)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_out_120411", "120411155", "story_v_out_120411.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_out_120411", "120411155", "story_v_out_120411.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_14 = math.max(var_634_7, arg_631_1.talkMaxDuration)

			if var_634_6 <= arg_631_1.time_ and arg_631_1.time_ < var_634_6 + var_634_14 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_6) / var_634_14

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_6 + var_634_14 and arg_631_1.time_ < var_634_6 + var_634_14 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_631_1:InitPlayNodeList()
	end,
	Play120411156 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 120411156
		arg_635_1.duration_ = 6.1

		local var_635_0 = {
			zh = 3.466,
			ja = 6.1
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play120411157(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(arg_635_1.actors_["1072ui_story"]) and arg_635_1.var_.characterEffect1072ui_story == nil then
				arg_635_1.var_.characterEffect1072ui_story = arg_635_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_0 = 0.2

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 and not isNil(arg_635_1.actors_["1072ui_story"]) then
				if arg_635_1.var_.characterEffect1072ui_story and not isNil(arg_635_1.actors_["1072ui_story"]) then
					arg_635_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 and not isNil(arg_635_1.actors_["1072ui_story"]) and arg_635_1.var_.characterEffect1072ui_story then
				arg_635_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_638_2 = arg_635_1.actors_["1069ui_story"]

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(var_638_2) and arg_635_1.var_.characterEffect1069ui_story == nil then
				arg_635_1.var_.characterEffect1069ui_story = var_638_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_3 = 0.2

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_3 and not isNil(var_638_2) then
				if arg_635_1.var_.characterEffect1069ui_story and not isNil(var_638_2) then
					arg_635_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_635_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_635_1.time_ - 0) / var_638_3)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_3 and arg_635_1.time_ < 0 + var_638_3 + arg_638_0 and not isNil(var_638_2) and arg_635_1.var_.characterEffect1069ui_story then
				arg_635_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_635_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			local var_638_4 = arg_635_1.actors_["1072ui_story"].transform

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1072ui_story = var_638_4.localPosition
			end

			local var_638_5 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_5 then
				var_638_4.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_635_1.time_ - 0) / var_638_5)
				var_638_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_638_4.position).x, (manager.ui.mainCamera.transform.position - var_638_4.position).y, (manager.ui.mainCamera.transform.position - var_638_4.position).z)
				var_638_4.localEulerAngles.z = 0
				var_638_4.localEulerAngles.x = 0
				var_638_4.localEulerAngles = var_638_4.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_5 and arg_635_1.time_ < 0 + var_638_5 + arg_638_0 then
				var_638_4.localPosition = Vector3.New(0, -0.71, -6)
				var_638_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_638_4.position).x, (manager.ui.mainCamera.transform.position - var_638_4.position).y, (manager.ui.mainCamera.transform.position - var_638_4.position).z)
				var_638_4.localEulerAngles.z = 0
				var_638_4.localEulerAngles.x = 0
				var_638_4.localEulerAngles = var_638_4.localEulerAngles
			end

			local var_638_6 = arg_635_1.actors_["1069ui_story"].transform

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1069ui_story = var_638_6.localPosition
			end

			local var_638_7 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_7 then
				var_638_6.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_635_1.time_ - 0) / var_638_7)
				var_638_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_638_6.position).x, (manager.ui.mainCamera.transform.position - var_638_6.position).y, (manager.ui.mainCamera.transform.position - var_638_6.position).z)
				var_638_6.localEulerAngles.z = 0
				var_638_6.localEulerAngles.x = 0
				var_638_6.localEulerAngles = var_638_6.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_7 and arg_635_1.time_ < 0 + var_638_7 + arg_638_0 then
				var_638_6.localPosition = Vector3.New(0, 100, 0)
				var_638_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_638_6.position).x, (manager.ui.mainCamera.transform.position - var_638_6.position).y, (manager.ui.mainCamera.transform.position - var_638_6.position).z)
				var_638_6.localEulerAngles.z = 0
				var_638_6.localEulerAngles.x = 0
				var_638_6.localEulerAngles = var_638_6.localEulerAngles
			end

			local var_638_8 = 0
			local var_638_9 = 0.375

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_8 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_10 = arg_635_1:GetWordFromCfg(120411156)
				local var_638_11 = arg_635_1:FormatText(var_638_10.content)

				arg_635_1.text_.text = var_638_11

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_13 = 15 <= 0 and var_638_9 or var_638_9 * (utf8.len(var_638_11) / 15)

				if (15 <= 0 and var_638_9 or var_638_9 * (utf8.len(var_638_11) / 15)) > 0 and var_638_9 < var_638_13 then
					arg_635_1.talkMaxDuration = var_638_13

					if var_638_13 + var_638_8 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_13 + var_638_8
					end
				end

				arg_635_1.text_.text = var_638_11
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411156", "story_v_out_120411.awb") ~= 0 then
					local var_638_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411156", "story_v_out_120411.awb") / 1000

					if var_638_14 + var_638_8 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_14 + var_638_8
					end

					if var_638_10.prefab_name ~= "" and arg_635_1.actors_[var_638_10.prefab_name] ~= nil then
						local var_638_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_10.prefab_name].transform, "story_v_out_120411", "120411156", "story_v_out_120411.awb")

						arg_635_1:RecordAudio("120411156", var_638_15)
						arg_635_1:RecordAudio("120411156", var_638_15)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_out_120411", "120411156", "story_v_out_120411.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_out_120411", "120411156", "story_v_out_120411.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_16 = math.max(var_638_9, arg_635_1.talkMaxDuration)

			if var_638_8 <= arg_635_1.time_ and arg_635_1.time_ < var_638_8 + var_638_16 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_8) / var_638_16

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_8 + var_638_16 and arg_635_1.time_ < var_638_8 + var_638_16 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_635_1:InitPlayNodeList()
	end,
	Play120411157 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 120411157
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play120411158(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["1072ui_story"]) and arg_639_1.var_.characterEffect1072ui_story == nil then
				arg_639_1.var_.characterEffect1072ui_story = arg_639_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_0 = 0.2

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["1072ui_story"]) then
				if arg_639_1.var_.characterEffect1072ui_story and not isNil(arg_639_1.actors_["1072ui_story"]) then
					arg_639_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_639_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_639_1.time_ - 0) / var_642_0)
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["1072ui_story"]) and arg_639_1.var_.characterEffect1072ui_story then
				arg_639_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_639_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_642_1 = 0
			local var_642_2 = 1.325

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_3 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(120411157).content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 53 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_3) / 53)

				if (53 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_3) / 53)) > 0 and var_642_2 < var_642_5 then
					arg_639_1.talkMaxDuration = var_642_5

					if var_642_5 + var_642_1 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_5 + var_642_1
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_6 = math.max(var_642_2, arg_639_1.talkMaxDuration)

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_6 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_1) / var_642_6

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_1 + var_642_6 and arg_639_1.time_ < var_642_1 + var_642_6 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play120411158 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 120411158
		arg_643_1.duration_ = 11.67

		local var_643_0 = {
			zh = 9.4,
			ja = 11.666
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play120411159(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(arg_643_1.actors_["1072ui_story"]) and arg_643_1.var_.characterEffect1072ui_story == nil then
				arg_643_1.var_.characterEffect1072ui_story = arg_643_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_0 = 0.2

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 and not isNil(arg_643_1.actors_["1072ui_story"]) then
				if arg_643_1.var_.characterEffect1072ui_story and not isNil(arg_643_1.actors_["1072ui_story"]) then
					arg_643_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 and not isNil(arg_643_1.actors_["1072ui_story"]) and arg_643_1.var_.characterEffect1072ui_story then
				arg_643_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			local var_646_2 = 0
			local var_646_3 = 1.05

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_2 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_4 = arg_643_1:GetWordFromCfg(120411158)
				local var_646_5 = arg_643_1:FormatText(var_646_4.content)

				arg_643_1.text_.text = var_646_5

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_7 = 42 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_5) / 42)

				if (42 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_5) / 42)) > 0 and var_646_3 < var_646_7 then
					arg_643_1.talkMaxDuration = var_646_7

					if var_646_7 + var_646_2 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_7 + var_646_2
					end
				end

				arg_643_1.text_.text = var_646_5
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411158", "story_v_out_120411.awb") ~= 0 then
					local var_646_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411158", "story_v_out_120411.awb") / 1000

					if var_646_8 + var_646_2 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_8 + var_646_2
					end

					if var_646_4.prefab_name ~= "" and arg_643_1.actors_[var_646_4.prefab_name] ~= nil then
						local var_646_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_4.prefab_name].transform, "story_v_out_120411", "120411158", "story_v_out_120411.awb")

						arg_643_1:RecordAudio("120411158", var_646_9)
						arg_643_1:RecordAudio("120411158", var_646_9)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_out_120411", "120411158", "story_v_out_120411.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_out_120411", "120411158", "story_v_out_120411.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_10 = math.max(var_646_3, arg_643_1.talkMaxDuration)

			if var_646_2 <= arg_643_1.time_ and arg_643_1.time_ < var_646_2 + var_646_10 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_2) / var_646_10

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_2 + var_646_10 and arg_643_1.time_ < var_646_2 + var_646_10 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play120411159 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 120411159
		arg_647_1.duration_ = 1

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play120411160(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0.05

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_1 = arg_647_1:GetWordFromCfg(120411159)
				local var_650_2 = arg_647_1:FormatText(var_650_1.content)

				arg_647_1.text_.text = var_650_2

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 2 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 2)

				if (2 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 2)) > 0 and var_650_0 < var_650_4 then
					arg_647_1.talkMaxDuration = var_650_4

					if var_650_4 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_4 + 0
					end
				end

				arg_647_1.text_.text = var_650_2
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411159", "story_v_out_120411.awb") ~= 0 then
					local var_650_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411159", "story_v_out_120411.awb") / 1000

					if var_650_5 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_5 + 0
					end

					if var_650_1.prefab_name ~= "" and arg_647_1.actors_[var_650_1.prefab_name] ~= nil then
						local var_650_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_1.prefab_name].transform, "story_v_out_120411", "120411159", "story_v_out_120411.awb")

						arg_647_1:RecordAudio("120411159", var_650_6)
						arg_647_1:RecordAudio("120411159", var_650_6)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_120411", "120411159", "story_v_out_120411.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_120411", "120411159", "story_v_out_120411.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_7 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_7 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_7

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_7 and arg_647_1.time_ < 0 + var_650_7 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play120411160 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 120411160
		arg_651_1.duration_ = 3.2

		local var_651_0 = {
			zh = 2.7,
			ja = 3.2
		}
		local var_651_1 = manager.audio:GetLocalizationFlag()

		if var_651_0[var_651_1] ~= nil then
			arg_651_1.duration_ = var_651_0[var_651_1]
		end

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play120411161(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			local var_654_0 = 0
			local var_654_1 = 0.275

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_2 = arg_651_1:GetWordFromCfg(120411160)
				local var_654_3 = arg_651_1:FormatText(var_654_2.content)

				arg_651_1.text_.text = var_654_3

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 11 <= 0 and var_654_1 or var_654_1 * (utf8.len(var_654_3) / 11)

				if (11 <= 0 and var_654_1 or var_654_1 * (utf8.len(var_654_3) / 11)) > 0 and var_654_1 < var_654_5 then
					arg_651_1.talkMaxDuration = var_654_5

					if var_654_5 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + var_654_0
					end
				end

				arg_651_1.text_.text = var_654_3
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411160", "story_v_out_120411.awb") ~= 0 then
					local var_654_6 = manager.audio:GetVoiceLength("story_v_out_120411", "120411160", "story_v_out_120411.awb") / 1000

					if var_654_6 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_6 + var_654_0
					end

					if var_654_2.prefab_name ~= "" and arg_651_1.actors_[var_654_2.prefab_name] ~= nil then
						local var_654_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_2.prefab_name].transform, "story_v_out_120411", "120411160", "story_v_out_120411.awb")

						arg_651_1:RecordAudio("120411160", var_654_7)
						arg_651_1:RecordAudio("120411160", var_654_7)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_out_120411", "120411160", "story_v_out_120411.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_out_120411", "120411160", "story_v_out_120411.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_8 = math.max(var_654_1, arg_651_1.talkMaxDuration)

			if var_654_0 <= arg_651_1.time_ and arg_651_1.time_ < var_654_0 + var_654_8 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_0) / var_654_8

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_0 + var_654_8 and arg_651_1.time_ < var_654_0 + var_654_8 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play120411161 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 120411161
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play120411162(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1.var_.moveOldPos1072ui_story = arg_655_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_658_0 = 0.001

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 then
				arg_655_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_655_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_655_1.time_ - 0) / var_658_0)
				arg_655_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_655_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1072ui_story"].transform.position).z)
				arg_655_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_655_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_655_1.actors_["1072ui_story"].transform.localEulerAngles = arg_655_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 then
				arg_655_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_655_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_655_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1072ui_story"].transform.position).z)
				arg_655_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_655_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_655_1.actors_["1072ui_story"].transform.localEulerAngles = arg_655_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_658_1 = 0
			local var_658_2 = 1.2

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, false)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_3 = arg_655_1:FormatText(arg_655_1:GetWordFromCfg(120411161).content)

				arg_655_1.text_.text = var_658_3

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 48 <= 0 and var_658_2 or var_658_2 * (utf8.len(var_658_3) / 48)

				if (48 <= 0 and var_658_2 or var_658_2 * (utf8.len(var_658_3) / 48)) > 0 and var_658_2 < var_658_5 then
					arg_655_1.talkMaxDuration = var_658_5

					if var_658_5 + var_658_1 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_5 + var_658_1
					end
				end

				arg_655_1.text_.text = var_658_3
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_6 = math.max(var_658_2, arg_655_1.talkMaxDuration)

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_6 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_1) / var_658_6

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_1 + var_658_6 and arg_655_1.time_ < var_658_1 + var_658_6 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_655_1:InitPlayNodeList()
	end,
	Play120411162 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 120411162
		arg_659_1.duration_ = 5.37

		local var_659_0 = {
			zh = 3.533,
			ja = 5.366
		}
		local var_659_1 = manager.audio:GetLocalizationFlag()

		if var_659_0[var_659_1] ~= nil then
			arg_659_1.duration_ = var_659_0[var_659_1]
		end

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play120411163(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1.var_.moveOldPos1071ui_story = arg_659_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_662_0 = 0.001

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_0 then
				arg_659_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_659_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_659_1.time_ - 0) / var_662_0)
				arg_659_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_659_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1071ui_story"].transform.position).z)
				arg_659_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_659_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_659_1.actors_["1071ui_story"].transform.localEulerAngles = arg_659_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_659_1.time_ >= 0 + var_662_0 and arg_659_1.time_ < 0 + var_662_0 + arg_662_0 then
				arg_659_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_659_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_659_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1071ui_story"].transform.position).z)
				arg_659_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_659_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_659_1.actors_["1071ui_story"].transform.localEulerAngles = arg_659_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_662_1 = arg_659_1.actors_["1071ui_story"]

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(var_662_1) and arg_659_1.var_.characterEffect1071ui_story == nil then
				arg_659_1.var_.characterEffect1071ui_story = var_662_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_2 = 0.2

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_2 and not isNil(var_662_1) then
				if arg_659_1.var_.characterEffect1071ui_story and not isNil(var_662_1) then
					arg_659_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_659_1.time_ >= 0 + var_662_2 and arg_659_1.time_ < 0 + var_662_2 + arg_662_0 and not isNil(var_662_1) and arg_659_1.var_.characterEffect1071ui_story then
				arg_659_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_662_4 = 0
			local var_662_5 = 0.35

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_4 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_6 = arg_659_1:GetWordFromCfg(120411162)
				local var_662_7 = arg_659_1:FormatText(var_662_6.content)

				arg_659_1.text_.text = var_662_7

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_9 = 14 <= 0 and var_662_5 or var_662_5 * (utf8.len(var_662_7) / 14)

				if (14 <= 0 and var_662_5 or var_662_5 * (utf8.len(var_662_7) / 14)) > 0 and var_662_5 < var_662_9 then
					arg_659_1.talkMaxDuration = var_662_9

					if var_662_9 + var_662_4 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_9 + var_662_4
					end
				end

				arg_659_1.text_.text = var_662_7
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411162", "story_v_out_120411.awb") ~= 0 then
					local var_662_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411162", "story_v_out_120411.awb") / 1000

					if var_662_10 + var_662_4 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_10 + var_662_4
					end

					if var_662_6.prefab_name ~= "" and arg_659_1.actors_[var_662_6.prefab_name] ~= nil then
						local var_662_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_6.prefab_name].transform, "story_v_out_120411", "120411162", "story_v_out_120411.awb")

						arg_659_1:RecordAudio("120411162", var_662_11)
						arg_659_1:RecordAudio("120411162", var_662_11)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_out_120411", "120411162", "story_v_out_120411.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_out_120411", "120411162", "story_v_out_120411.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_12 = math.max(var_662_5, arg_659_1.talkMaxDuration)

			if var_662_4 <= arg_659_1.time_ and arg_659_1.time_ < var_662_4 + var_662_12 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_4) / var_662_12

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_4 + var_662_12 and arg_659_1.time_ < var_662_4 + var_662_12 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_659_1:InitPlayNodeList()
	end,
	Play120411163 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 120411163
		arg_663_1.duration_ = 6.7

		local var_663_0 = {
			zh = 2.9,
			ja = 6.7
		}
		local var_663_1 = manager.audio:GetLocalizationFlag()

		if var_663_0[var_663_1] ~= nil then
			arg_663_1.duration_ = var_663_0[var_663_1]
		end

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play120411164(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_666_0 = arg_663_1.actors_["1076ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect1076ui_story == nil then
				arg_663_1.var_.characterEffect1076ui_story = var_666_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_1 = 0.2

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_1 and not isNil(var_666_0) then
				if arg_663_1.var_.characterEffect1076ui_story and not isNil(var_666_0) then
					arg_663_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_663_1.time_ >= 0 + var_666_1 and arg_663_1.time_ < 0 + var_666_1 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect1076ui_story then
				arg_663_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_666_3 = arg_663_1.actors_["1076ui_story"].transform

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos1076ui_story = var_666_3.localPosition
			end

			local var_666_4 = 0.001

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_4 then
				var_666_3.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_663_1.time_ - 0) / var_666_4)
				var_666_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_666_3.position).x, (manager.ui.mainCamera.transform.position - var_666_3.position).y, (manager.ui.mainCamera.transform.position - var_666_3.position).z)
				var_666_3.localEulerAngles.z = 0
				var_666_3.localEulerAngles.x = 0
				var_666_3.localEulerAngles = var_666_3.localEulerAngles
			end

			if arg_663_1.time_ >= 0 + var_666_4 and arg_663_1.time_ < 0 + var_666_4 + arg_666_0 then
				var_666_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_666_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_666_3.position).x, (manager.ui.mainCamera.transform.position - var_666_3.position).y, (manager.ui.mainCamera.transform.position - var_666_3.position).z)
				var_666_3.localEulerAngles.z = 0
				var_666_3.localEulerAngles.x = 0
				var_666_3.localEulerAngles = var_666_3.localEulerAngles
			end

			local var_666_5 = arg_663_1.actors_["1071ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_5) and arg_663_1.var_.characterEffect1071ui_story == nil then
				arg_663_1.var_.characterEffect1071ui_story = var_666_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_6 = 0.2

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_6 and not isNil(var_666_5) then
				if arg_663_1.var_.characterEffect1071ui_story and not isNil(var_666_5) then
					arg_663_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_663_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_663_1.time_ - 0) / var_666_6)
				end
			end

			if arg_663_1.time_ >= 0 + var_666_6 and arg_663_1.time_ < 0 + var_666_6 + arg_666_0 and not isNil(var_666_5) and arg_663_1.var_.characterEffect1071ui_story then
				arg_663_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_663_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_666_7 = 0
			local var_666_8 = 0.225

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_7 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_9 = arg_663_1:GetWordFromCfg(120411163)
				local var_666_10 = arg_663_1:FormatText(var_666_9.content)

				arg_663_1.text_.text = var_666_10

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_12 = 9 <= 0 and var_666_8 or var_666_8 * (utf8.len(var_666_10) / 9)

				if (9 <= 0 and var_666_8 or var_666_8 * (utf8.len(var_666_10) / 9)) > 0 and var_666_8 < var_666_12 then
					arg_663_1.talkMaxDuration = var_666_12

					if var_666_12 + var_666_7 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_12 + var_666_7
					end
				end

				arg_663_1.text_.text = var_666_10
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411163", "story_v_out_120411.awb") ~= 0 then
					local var_666_13 = manager.audio:GetVoiceLength("story_v_out_120411", "120411163", "story_v_out_120411.awb") / 1000

					if var_666_13 + var_666_7 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_13 + var_666_7
					end

					if var_666_9.prefab_name ~= "" and arg_663_1.actors_[var_666_9.prefab_name] ~= nil then
						local var_666_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_9.prefab_name].transform, "story_v_out_120411", "120411163", "story_v_out_120411.awb")

						arg_663_1:RecordAudio("120411163", var_666_14)
						arg_663_1:RecordAudio("120411163", var_666_14)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_out_120411", "120411163", "story_v_out_120411.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_out_120411", "120411163", "story_v_out_120411.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_15 = math.max(var_666_8, arg_663_1.talkMaxDuration)

			if var_666_7 <= arg_663_1.time_ and arg_663_1.time_ < var_666_7 + var_666_15 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_7) / var_666_15

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_7 + var_666_15 and arg_663_1.time_ < var_666_7 + var_666_15 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_663_1:InitPlayNodeList()
	end,
	Play120411164 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 120411164
		arg_667_1.duration_ = 7.8

		local var_667_0 = {
			zh = 4.3,
			ja = 7.8
		}
		local var_667_1 = manager.audio:GetLocalizationFlag()

		if var_667_0[var_667_1] ~= nil then
			arg_667_1.duration_ = var_667_0[var_667_1]
		end

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play120411165(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(arg_667_1.actors_["1076ui_story"]) and arg_667_1.var_.characterEffect1076ui_story == nil then
				arg_667_1.var_.characterEffect1076ui_story = arg_667_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_0 = 0.2

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_0 and not isNil(arg_667_1.actors_["1076ui_story"]) then
				if arg_667_1.var_.characterEffect1076ui_story and not isNil(arg_667_1.actors_["1076ui_story"]) then
					arg_667_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_667_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_667_1.time_ - 0) / var_670_0)
				end
			end

			if arg_667_1.time_ >= 0 + var_670_0 and arg_667_1.time_ < 0 + var_670_0 + arg_670_0 and not isNil(arg_667_1.actors_["1076ui_story"]) and arg_667_1.var_.characterEffect1076ui_story then
				arg_667_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_667_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_670_1 = arg_667_1.actors_["1071ui_story"]

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect1071ui_story == nil then
				arg_667_1.var_.characterEffect1071ui_story = var_670_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_2 = 0.2

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_2 and not isNil(var_670_1) then
				if arg_667_1.var_.characterEffect1071ui_story and not isNil(var_670_1) then
					arg_667_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= 0 + var_670_2 and arg_667_1.time_ < 0 + var_670_2 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect1071ui_story then
				arg_667_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_670_4 = 0
			local var_670_5 = 0.425

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_4 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_6 = arg_667_1:GetWordFromCfg(120411164)
				local var_670_7 = arg_667_1:FormatText(var_670_6.content)

				arg_667_1.text_.text = var_670_7

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_9 = 17 <= 0 and var_670_5 or var_670_5 * (utf8.len(var_670_7) / 17)

				if (17 <= 0 and var_670_5 or var_670_5 * (utf8.len(var_670_7) / 17)) > 0 and var_670_5 < var_670_9 then
					arg_667_1.talkMaxDuration = var_670_9

					if var_670_9 + var_670_4 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_9 + var_670_4
					end
				end

				arg_667_1.text_.text = var_670_7
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411164", "story_v_out_120411.awb") ~= 0 then
					local var_670_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411164", "story_v_out_120411.awb") / 1000

					if var_670_10 + var_670_4 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_10 + var_670_4
					end

					if var_670_6.prefab_name ~= "" and arg_667_1.actors_[var_670_6.prefab_name] ~= nil then
						local var_670_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_6.prefab_name].transform, "story_v_out_120411", "120411164", "story_v_out_120411.awb")

						arg_667_1:RecordAudio("120411164", var_670_11)
						arg_667_1:RecordAudio("120411164", var_670_11)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_out_120411", "120411164", "story_v_out_120411.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_out_120411", "120411164", "story_v_out_120411.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_12 = math.max(var_670_5, arg_667_1.talkMaxDuration)

			if var_670_4 <= arg_667_1.time_ and arg_667_1.time_ < var_670_4 + var_670_12 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_4) / var_670_12

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_4 + var_670_12 and arg_667_1.time_ < var_670_4 + var_670_12 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play120411165 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 120411165
		arg_671_1.duration_ = 8.4

		local var_671_0 = {
			zh = 4.066,
			ja = 8.4
		}
		local var_671_1 = manager.audio:GetLocalizationFlag()

		if var_671_0[var_671_1] ~= nil then
			arg_671_1.duration_ = var_671_0[var_671_1]
		end

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play120411166(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_1")
			end

			local var_674_0 = 0
			local var_674_1 = 0.45

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_2 = arg_671_1:GetWordFromCfg(120411165)
				local var_674_3 = arg_671_1:FormatText(var_674_2.content)

				arg_671_1.text_.text = var_674_3

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_5 = 18 <= 0 and var_674_1 or var_674_1 * (utf8.len(var_674_3) / 18)

				if (18 <= 0 and var_674_1 or var_674_1 * (utf8.len(var_674_3) / 18)) > 0 and var_674_1 < var_674_5 then
					arg_671_1.talkMaxDuration = var_674_5

					if var_674_5 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_5 + var_674_0
					end
				end

				arg_671_1.text_.text = var_674_3
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411165", "story_v_out_120411.awb") ~= 0 then
					local var_674_6 = manager.audio:GetVoiceLength("story_v_out_120411", "120411165", "story_v_out_120411.awb") / 1000

					if var_674_6 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_6 + var_674_0
					end

					if var_674_2.prefab_name ~= "" and arg_671_1.actors_[var_674_2.prefab_name] ~= nil then
						local var_674_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_2.prefab_name].transform, "story_v_out_120411", "120411165", "story_v_out_120411.awb")

						arg_671_1:RecordAudio("120411165", var_674_7)
						arg_671_1:RecordAudio("120411165", var_674_7)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_out_120411", "120411165", "story_v_out_120411.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_out_120411", "120411165", "story_v_out_120411.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_8 = math.max(var_674_1, arg_671_1.talkMaxDuration)

			if var_674_0 <= arg_671_1.time_ and arg_671_1.time_ < var_674_0 + var_674_8 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_0) / var_674_8

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_0 + var_674_8 and arg_671_1.time_ < var_674_0 + var_674_8 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play120411166 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 120411166
		arg_675_1.duration_ = 7

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play120411167(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.mask_.enabled = true
				arg_675_1.mask_.raycastTarget = true

				arg_675_1:SetGaussion(false)
			end

			local var_678_0 = 2

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 then
				local var_678_1 = Color.New(1, 1, 1)

				var_678_1.a = Mathf.Lerp(1, 0, (arg_675_1.time_ - 0) / var_678_0)
				arg_675_1.mask_.color = var_678_1
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 then
				local var_678_2 = Color.New(1, 1, 1)

				arg_675_1.mask_.enabled = false
				var_678_2.a = 0
				arg_675_1.mask_.color = var_678_2
			end

			local var_678_3 = "XH0203"

			if arg_675_1.bgs_.XH0203 == nil then
				local var_678_4 = Object.Instantiate(arg_675_1.paintGo_)

				var_678_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_678_3)
				var_678_4.name = var_678_3
				var_678_4.transform.parent = arg_675_1.stage_.transform
				var_678_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_675_1.bgs_[var_678_3] = var_678_4
			end

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				local var_678_5 = arg_675_1.bgs_.XH0203

				arg_675_1.bgs_.XH0203.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_678_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_678_6 = var_678_5:GetComponent("SpriteRenderer")

				if var_678_6 and var_678_6.sprite then
					local var_678_7 = 2 * (var_678_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_678_5.transform.localScale = Vector3.New(var_678_7 / var_678_6.sprite.bounds.size.y < var_678_7 * manager.ui.mainCameraCom_.aspect / var_678_6.sprite.bounds.size.x and var_678_7 * manager.ui.mainCameraCom_.aspect / var_678_6.sprite.bounds.size.x or var_678_7 / var_678_6.sprite.bounds.size.y, var_678_7 / var_678_6.sprite.bounds.size.y < var_678_7 * manager.ui.mainCameraCom_.aspect / var_678_6.sprite.bounds.size.x and var_678_7 * manager.ui.mainCameraCom_.aspect / var_678_6.sprite.bounds.size.x or var_678_7 / var_678_6.sprite.bounds.size.y, 0)
				end

				for iter_678_0, iter_678_1 in pairs(arg_675_1.bgs_) do
					if iter_678_0 ~= "XH0203" then
						iter_678_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_678_8 = arg_675_1.actors_["1071ui_story"].transform

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPos1071ui_story = var_678_8.localPosition
			end

			local var_678_9 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_9 then
				var_678_8.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_675_1.time_ - 0) / var_678_9)
				var_678_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_678_8.position).x, (manager.ui.mainCamera.transform.position - var_678_8.position).y, (manager.ui.mainCamera.transform.position - var_678_8.position).z)
				var_678_8.localEulerAngles.z = 0
				var_678_8.localEulerAngles.x = 0
				var_678_8.localEulerAngles = var_678_8.localEulerAngles
			end

			if arg_675_1.time_ >= 0 + var_678_9 and arg_675_1.time_ < 0 + var_678_9 + arg_678_0 then
				var_678_8.localPosition = Vector3.New(0, 100, 0)
				var_678_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_678_8.position).x, (manager.ui.mainCamera.transform.position - var_678_8.position).y, (manager.ui.mainCamera.transform.position - var_678_8.position).z)
				var_678_8.localEulerAngles.z = 0
				var_678_8.localEulerAngles.x = 0
				var_678_8.localEulerAngles = var_678_8.localEulerAngles
			end

			local var_678_10 = arg_675_1.actors_["1076ui_story"].transform

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPos1076ui_story = var_678_10.localPosition
			end

			local var_678_11 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_11 then
				var_678_10.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_675_1.time_ - 0) / var_678_11)
				var_678_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_678_10.position).x, (manager.ui.mainCamera.transform.position - var_678_10.position).y, (manager.ui.mainCamera.transform.position - var_678_10.position).z)
				var_678_10.localEulerAngles.z = 0
				var_678_10.localEulerAngles.x = 0
				var_678_10.localEulerAngles = var_678_10.localEulerAngles
			end

			if arg_675_1.time_ >= 0 + var_678_11 and arg_675_1.time_ < 0 + var_678_11 + arg_678_0 then
				var_678_10.localPosition = Vector3.New(0, 100, 0)
				var_678_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_678_10.position).x, (manager.ui.mainCamera.transform.position - var_678_10.position).y, (manager.ui.mainCamera.transform.position - var_678_10.position).z)
				var_678_10.localEulerAngles.z = 0
				var_678_10.localEulerAngles.x = 0
				var_678_10.localEulerAngles = var_678_10.localEulerAngles
			end

			local var_678_12 = arg_675_1.bgs_.XH0203.transform

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPosXH0203 = var_678_12.localPosition
			end

			local var_678_13 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_13 then
				var_678_12.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPosXH0203, Vector3.New(0, 1, 9.5), (arg_675_1.time_ - 0) / var_678_13)
			end

			if arg_675_1.time_ >= 0 + var_678_13 and arg_675_1.time_ < 0 + var_678_13 + arg_678_0 then
				var_678_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_678_14 = arg_675_1.bgs_.XH0203.transform

			if 0.034 < arg_675_1.time_ and arg_675_1.time_ <= 0.034 + arg_678_0 then
				arg_675_1.var_.moveOldPosXH0203 = var_678_14.localPosition
			end

			local var_678_15 = 3.5

			if 0.034 <= arg_675_1.time_ and arg_675_1.time_ < 0.034 + var_678_15 then
				var_678_14.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPosXH0203, Vector3.New(0, 1, 10), (arg_675_1.time_ - 0.034) / var_678_15)
			end

			if arg_675_1.time_ >= 0.034 + var_678_15 and arg_675_1.time_ < 0.034 + var_678_15 + arg_678_0 then
				var_678_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_678_16 = 2

			if 2 < arg_675_1.time_ and arg_675_1.time_ <= var_678_16 + arg_678_0 then
				arg_675_1.allBtn_.enabled = false
			end

			if arg_675_1.time_ >= var_678_16 + 1.534 and arg_675_1.time_ < var_678_16 + 1.534 + arg_678_0 then
				arg_675_1.allBtn_.enabled = true
			end

			if arg_675_1.frameCnt_ <= 1 then
				arg_675_1.dialog_:SetActive(false)
			end

			local var_678_17 = 2
			local var_678_18 = 0.55

			if 2 < arg_675_1.time_ and arg_675_1.time_ <= var_678_17 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0

				arg_675_1.dialog_:SetActive(true)

				arg_675_1.dialogCg_.alpha = 0

				local var_678_19 = LeanTween.value(arg_675_1.dialog_, 0, 1, 0.3)

				var_678_19:setOnUpdate(LuaHelper.FloatAction(function(arg_679_0)
					arg_675_1.dialogCg_.alpha = arg_679_0
				end))
				var_678_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_675_1.dialog_)
					var_678_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_675_1.duration_ = arg_675_1.duration_ + 0.3

				SetActive(arg_675_1.leftNameGo_, false)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_20 = arg_675_1:FormatText(arg_675_1:GetWordFromCfg(120411166).content)

				arg_675_1.text_.text = var_678_20

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_22 = 22 <= 0 and var_678_18 or var_678_18 * (utf8.len(var_678_20) / 22)

				if (22 <= 0 and var_678_18 or var_678_18 * (utf8.len(var_678_20) / 22)) > 0 and var_678_18 < var_678_22 then
					arg_675_1.talkMaxDuration = var_678_22
					var_678_17 = var_678_17 + 0.3

					if var_678_22 + var_678_17 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_22 + var_678_17
					end
				end

				arg_675_1.text_.text = var_678_20
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_23 = var_678_17 + 0.3
			local var_678_24 = math.max(var_678_18, arg_675_1.talkMaxDuration)

			if var_678_17 + 0.3 <= arg_675_1.time_ and arg_675_1.time_ < var_678_23 + var_678_24 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_23) / var_678_24

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_23 + var_678_24 and arg_675_1.time_ < var_678_23 + var_678_24 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0203",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0203",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play120411167 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 120411167
		arg_681_1.duration_ = 4.83

		local var_681_0 = {
			zh = 3.366,
			ja = 4.833
		}
		local var_681_1 = manager.audio:GetLocalizationFlag()

		if var_681_0[var_681_1] ~= nil then
			arg_681_1.duration_ = var_681_0[var_681_1]
		end

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play120411168(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_684_0 = 1

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_0 then
				local var_684_1, var_684_2 = math.modf((arg_681_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_684_2 * 0.13, var_684_2 * 0.13, var_684_2 * 0.13) + arg_681_1.var_.shakeOldPos
			end

			if arg_681_1.time_ >= 0 + var_684_0 and arg_681_1.time_ < 0 + var_684_0 + arg_684_0 then
				manager.ui.mainCamera.transform.localPosition = arg_681_1.var_.shakeOldPos
			end

			local var_684_3 = 0

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_3 + arg_684_0 then
				arg_681_1.allBtn_.enabled = false
			end

			if arg_681_1.time_ >= var_684_3 + 1 and arg_681_1.time_ < var_684_3 + 1 + arg_684_0 then
				arg_681_1.allBtn_.enabled = true
			end

			local var_684_4 = 0
			local var_684_5 = 0.3

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_4 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				arg_681_1.leftNameTxt_.text = arg_681_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_6 = arg_681_1:GetWordFromCfg(120411167)
				local var_684_7 = arg_681_1:FormatText(var_684_6.content)

				arg_681_1.text_.text = var_684_7

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_9 = 12 <= 0 and var_684_5 or var_684_5 * (utf8.len(var_684_7) / 12)

				if (12 <= 0 and var_684_5 or var_684_5 * (utf8.len(var_684_7) / 12)) > 0 and var_684_5 < var_684_9 then
					arg_681_1.talkMaxDuration = var_684_9

					if var_684_9 + var_684_4 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_9 + var_684_4
					end
				end

				arg_681_1.text_.text = var_684_7
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411167", "story_v_out_120411.awb") ~= 0 then
					local var_684_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411167", "story_v_out_120411.awb") / 1000

					if var_684_10 + var_684_4 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_10 + var_684_4
					end

					if var_684_6.prefab_name ~= "" and arg_681_1.actors_[var_684_6.prefab_name] ~= nil then
						local var_684_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_6.prefab_name].transform, "story_v_out_120411", "120411167", "story_v_out_120411.awb")

						arg_681_1:RecordAudio("120411167", var_684_11)
						arg_681_1:RecordAudio("120411167", var_684_11)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_out_120411", "120411167", "story_v_out_120411.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_out_120411", "120411167", "story_v_out_120411.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_12 = math.max(var_684_5, arg_681_1.talkMaxDuration)

			if var_684_4 <= arg_681_1.time_ and arg_681_1.time_ < var_684_4 + var_684_12 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_4) / var_684_12

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_4 + var_684_12 and arg_681_1.time_ < var_684_4 + var_684_12 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play120411168 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 120411168
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play120411169(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0.775

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, false)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_1 = arg_685_1:FormatText(arg_685_1:GetWordFromCfg(120411168).content)

				arg_685_1.text_.text = var_688_1

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_3 = 31 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 31)

				if (31 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 31)) > 0 and var_688_0 < var_688_3 then
					arg_685_1.talkMaxDuration = var_688_3

					if var_688_3 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_3 + 0
					end
				end

				arg_685_1.text_.text = var_688_1
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_4 = math.max(var_688_0, arg_685_1.talkMaxDuration)

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_4 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - 0) / var_688_4

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= 0 + var_688_4 and arg_685_1.time_ < 0 + var_688_4 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play120411169 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 120411169
		arg_689_1.duration_ = 4.77

		local var_689_0 = {
			zh = 4.766,
			ja = 4.7
		}
		local var_689_1 = manager.audio:GetLocalizationFlag()

		if var_689_0[var_689_1] ~= nil then
			arg_689_1.duration_ = var_689_0[var_689_1]
		end

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play120411170(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = 0.475

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_1 = arg_689_1:GetWordFromCfg(120411169)
				local var_692_2 = arg_689_1:FormatText(var_692_1.content)

				arg_689_1.text_.text = var_692_2

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_4 = 19 <= 0 and var_692_0 or var_692_0 * (utf8.len(var_692_2) / 19)

				if (19 <= 0 and var_692_0 or var_692_0 * (utf8.len(var_692_2) / 19)) > 0 and var_692_0 < var_692_4 then
					arg_689_1.talkMaxDuration = var_692_4

					if var_692_4 + 0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_4 + 0
					end
				end

				arg_689_1.text_.text = var_692_2
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411169", "story_v_out_120411.awb") ~= 0 then
					local var_692_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411169", "story_v_out_120411.awb") / 1000

					if var_692_5 + 0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_5 + 0
					end

					if var_692_1.prefab_name ~= "" and arg_689_1.actors_[var_692_1.prefab_name] ~= nil then
						local var_692_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_1.prefab_name].transform, "story_v_out_120411", "120411169", "story_v_out_120411.awb")

						arg_689_1:RecordAudio("120411169", var_692_6)
						arg_689_1:RecordAudio("120411169", var_692_6)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_out_120411", "120411169", "story_v_out_120411.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_out_120411", "120411169", "story_v_out_120411.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_7 = math.max(var_692_0, arg_689_1.talkMaxDuration)

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_7 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - 0) / var_692_7

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= 0 + var_692_7 and arg_689_1.time_ < 0 + var_692_7 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play120411170 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 120411170
		arg_693_1.duration_ = 5

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play120411171(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = 0.3

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, true)
				arg_693_1.iconController_:SetSelectedState("hero")

				arg_693_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_693_1.callingController_:SetSelectedState("normal")

				arg_693_1.keyicon_.color = Color.New(1, 1, 1)
				arg_693_1.icon_.color = Color.New(1, 1, 1)

				local var_696_1 = arg_693_1:FormatText(arg_693_1:GetWordFromCfg(120411170).content)

				arg_693_1.text_.text = var_696_1

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_3 = 12 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_1) / 12)

				if (12 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_1) / 12)) > 0 and var_696_0 < var_696_3 then
					arg_693_1.talkMaxDuration = var_696_3

					if var_696_3 + 0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_3 + 0
					end
				end

				arg_693_1.text_.text = var_696_1
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)
				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_4 = math.max(var_696_0, arg_693_1.talkMaxDuration)

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_4 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - 0) / var_696_4

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= 0 + var_696_4 and arg_693_1.time_ < 0 + var_696_4 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play120411171 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 120411171
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play120411172(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = 0.575

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, false)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_1 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(120411171).content)

				arg_697_1.text_.text = var_700_1

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_3 = 23 <= 0 and var_700_0 or var_700_0 * (utf8.len(var_700_1) / 23)

				if (23 <= 0 and var_700_0 or var_700_0 * (utf8.len(var_700_1) / 23)) > 0 and var_700_0 < var_700_3 then
					arg_697_1.talkMaxDuration = var_700_3

					if var_700_3 + 0 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_3 + 0
					end
				end

				arg_697_1.text_.text = var_700_1
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_4 = math.max(var_700_0, arg_697_1.talkMaxDuration)

			if 0 <= arg_697_1.time_ and arg_697_1.time_ < 0 + var_700_4 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - 0) / var_700_4

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= 0 + var_700_4 and arg_697_1.time_ < 0 + var_700_4 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play120411172 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 120411172
		arg_701_1.duration_ = 3.4

		local var_701_0 = {
			zh = 2.1,
			ja = 3.4
		}
		local var_701_1 = manager.audio:GetLocalizationFlag()

		if var_701_0[var_701_1] ~= nil then
			arg_701_1.duration_ = var_701_0[var_701_1]
		end

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play120411173(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0.25

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_1 = arg_701_1:GetWordFromCfg(120411172)
				local var_704_2 = arg_701_1:FormatText(var_704_1.content)

				arg_701_1.text_.text = var_704_2

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_4 = 10 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_2) / 10)

				if (10 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_2) / 10)) > 0 and var_704_0 < var_704_4 then
					arg_701_1.talkMaxDuration = var_704_4

					if var_704_4 + 0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_4 + 0
					end
				end

				arg_701_1.text_.text = var_704_2
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411172", "story_v_out_120411.awb") ~= 0 then
					local var_704_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411172", "story_v_out_120411.awb") / 1000

					if var_704_5 + 0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_5 + 0
					end

					if var_704_1.prefab_name ~= "" and arg_701_1.actors_[var_704_1.prefab_name] ~= nil then
						local var_704_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_701_1.actors_[var_704_1.prefab_name].transform, "story_v_out_120411", "120411172", "story_v_out_120411.awb")

						arg_701_1:RecordAudio("120411172", var_704_6)
						arg_701_1:RecordAudio("120411172", var_704_6)
					else
						arg_701_1:AudioAction("play", "voice", "story_v_out_120411", "120411172", "story_v_out_120411.awb")
					end

					arg_701_1:RecordHistoryTalkVoice("story_v_out_120411", "120411172", "story_v_out_120411.awb")
				end

				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_7 = math.max(var_704_0, arg_701_1.talkMaxDuration)

			if 0 <= arg_701_1.time_ and arg_701_1.time_ < 0 + var_704_7 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - 0) / var_704_7

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= 0 + var_704_7 and arg_701_1.time_ < 0 + var_704_7 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play120411173 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 120411173
		arg_705_1.duration_ = 7.7

		local var_705_0 = {
			zh = 4.1,
			ja = 7.7
		}
		local var_705_1 = manager.audio:GetLocalizationFlag()

		if var_705_0[var_705_1] ~= nil then
			arg_705_1.duration_ = var_705_0[var_705_1]
		end

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play120411174(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = 0.25

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				arg_705_1.leftNameTxt_.text = arg_705_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_1 = arg_705_1:GetWordFromCfg(120411173)
				local var_708_2 = arg_705_1:FormatText(var_708_1.content)

				arg_705_1.text_.text = var_708_2

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_4 = 10 <= 0 and var_708_0 or var_708_0 * (utf8.len(var_708_2) / 10)

				if (10 <= 0 and var_708_0 or var_708_0 * (utf8.len(var_708_2) / 10)) > 0 and var_708_0 < var_708_4 then
					arg_705_1.talkMaxDuration = var_708_4

					if var_708_4 + 0 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_4 + 0
					end
				end

				arg_705_1.text_.text = var_708_2
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411173", "story_v_out_120411.awb") ~= 0 then
					local var_708_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411173", "story_v_out_120411.awb") / 1000

					if var_708_5 + 0 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_5 + 0
					end

					if var_708_1.prefab_name ~= "" and arg_705_1.actors_[var_708_1.prefab_name] ~= nil then
						local var_708_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_705_1.actors_[var_708_1.prefab_name].transform, "story_v_out_120411", "120411173", "story_v_out_120411.awb")

						arg_705_1:RecordAudio("120411173", var_708_6)
						arg_705_1:RecordAudio("120411173", var_708_6)
					else
						arg_705_1:AudioAction("play", "voice", "story_v_out_120411", "120411173", "story_v_out_120411.awb")
					end

					arg_705_1:RecordHistoryTalkVoice("story_v_out_120411", "120411173", "story_v_out_120411.awb")
				end

				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_7 = math.max(var_708_0, arg_705_1.talkMaxDuration)

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_7 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - 0) / var_708_7

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= 0 + var_708_7 and arg_705_1.time_ < 0 + var_708_7 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play120411174 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 120411174
		arg_709_1.duration_ = 3.4

		local var_709_0 = {
			zh = 2.766,
			ja = 3.4
		}
		local var_709_1 = manager.audio:GetLocalizationFlag()

		if var_709_0[var_709_1] ~= nil then
			arg_709_1.duration_ = var_709_0[var_709_1]
		end

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play120411175(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = 0.25

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				arg_709_1.leftNameTxt_.text = arg_709_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_1 = arg_709_1:GetWordFromCfg(120411174)
				local var_712_2 = arg_709_1:FormatText(var_712_1.content)

				arg_709_1.text_.text = var_712_2

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_4 = 10 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_2) / 10)

				if (10 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_2) / 10)) > 0 and var_712_0 < var_712_4 then
					arg_709_1.talkMaxDuration = var_712_4

					if var_712_4 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_4 + 0
					end
				end

				arg_709_1.text_.text = var_712_2
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411174", "story_v_out_120411.awb") ~= 0 then
					local var_712_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411174", "story_v_out_120411.awb") / 1000

					if var_712_5 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_5 + 0
					end

					if var_712_1.prefab_name ~= "" and arg_709_1.actors_[var_712_1.prefab_name] ~= nil then
						local var_712_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_709_1.actors_[var_712_1.prefab_name].transform, "story_v_out_120411", "120411174", "story_v_out_120411.awb")

						arg_709_1:RecordAudio("120411174", var_712_6)
						arg_709_1:RecordAudio("120411174", var_712_6)
					else
						arg_709_1:AudioAction("play", "voice", "story_v_out_120411", "120411174", "story_v_out_120411.awb")
					end

					arg_709_1:RecordHistoryTalkVoice("story_v_out_120411", "120411174", "story_v_out_120411.awb")
				end

				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_7 = math.max(var_712_0, arg_709_1.talkMaxDuration)

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_7 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - 0) / var_712_7

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= 0 + var_712_7 and arg_709_1.time_ < 0 + var_712_7 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play120411175 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 120411175
		arg_713_1.duration_ = 4.1

		local var_713_0 = {
			zh = 4.1,
			ja = 2.9
		}
		local var_713_1 = manager.audio:GetLocalizationFlag()

		if var_713_0[var_713_1] ~= nil then
			arg_713_1.duration_ = var_713_0[var_713_1]
		end

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play120411176(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.225

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, false)
				arg_713_1.callingController_:SetSelectedState("normal")

				local var_716_1 = arg_713_1:GetWordFromCfg(120411175)
				local var_716_2 = arg_713_1:FormatText(var_716_1.content)

				arg_713_1.text_.text = var_716_2

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_4 = 9 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_2) / 9)

				if (9 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_2) / 9)) > 0 and var_716_0 < var_716_4 then
					arg_713_1.talkMaxDuration = var_716_4

					if var_716_4 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_4 + 0
					end
				end

				arg_713_1.text_.text = var_716_2
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411175", "story_v_out_120411.awb") ~= 0 then
					local var_716_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411175", "story_v_out_120411.awb") / 1000

					if var_716_5 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_5 + 0
					end

					if var_716_1.prefab_name ~= "" and arg_713_1.actors_[var_716_1.prefab_name] ~= nil then
						local var_716_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_713_1.actors_[var_716_1.prefab_name].transform, "story_v_out_120411", "120411175", "story_v_out_120411.awb")

						arg_713_1:RecordAudio("120411175", var_716_6)
						arg_713_1:RecordAudio("120411175", var_716_6)
					else
						arg_713_1:AudioAction("play", "voice", "story_v_out_120411", "120411175", "story_v_out_120411.awb")
					end

					arg_713_1:RecordHistoryTalkVoice("story_v_out_120411", "120411175", "story_v_out_120411.awb")
				end

				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_7 = math.max(var_716_0, arg_713_1.talkMaxDuration)

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_7 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - 0) / var_716_7

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= 0 + var_716_7 and arg_713_1.time_ < 0 + var_716_7 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play120411176 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 120411176
		arg_717_1.duration_ = 5.2

		local var_717_0 = {
			zh = 2.766,
			ja = 5.2
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play120411177(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 0.325

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_1 = arg_717_1:GetWordFromCfg(120411176)
				local var_720_2 = arg_717_1:FormatText(var_720_1.content)

				arg_717_1.text_.text = var_720_2

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_4 = 13 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_2) / 13)

				if (13 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_2) / 13)) > 0 and var_720_0 < var_720_4 then
					arg_717_1.talkMaxDuration = var_720_4

					if var_720_4 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_4 + 0
					end
				end

				arg_717_1.text_.text = var_720_2
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411176", "story_v_out_120411.awb") ~= 0 then
					local var_720_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411176", "story_v_out_120411.awb") / 1000

					if var_720_5 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_5 + 0
					end

					if var_720_1.prefab_name ~= "" and arg_717_1.actors_[var_720_1.prefab_name] ~= nil then
						local var_720_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_1.prefab_name].transform, "story_v_out_120411", "120411176", "story_v_out_120411.awb")

						arg_717_1:RecordAudio("120411176", var_720_6)
						arg_717_1:RecordAudio("120411176", var_720_6)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_out_120411", "120411176", "story_v_out_120411.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_out_120411", "120411176", "story_v_out_120411.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_7 = math.max(var_720_0, arg_717_1.talkMaxDuration)

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_7 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - 0) / var_720_7

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= 0 + var_720_7 and arg_717_1.time_ < 0 + var_720_7 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play120411177 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 120411177
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play120411178(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = 1

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, false)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_1 = arg_721_1:FormatText(arg_721_1:GetWordFromCfg(120411177).content)

				arg_721_1.text_.text = var_724_1

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_3 = 40 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 40)

				if (40 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 40)) > 0 and var_724_0 < var_724_3 then
					arg_721_1.talkMaxDuration = var_724_3

					if var_724_3 + 0 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_3 + 0
					end
				end

				arg_721_1.text_.text = var_724_1
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_4 = math.max(var_724_0, arg_721_1.talkMaxDuration)

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_4 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - 0) / var_724_4

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= 0 + var_724_4 and arg_721_1.time_ < 0 + var_724_4 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play120411178 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 120411178
		arg_725_1.duration_ = 9

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play120411179(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			if 2 < arg_725_1.time_ and arg_725_1.time_ <= 2 + arg_728_0 then
				local var_728_0 = arg_725_1.bgs_.ST29

				arg_725_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_728_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_728_1 = var_728_0:GetComponent("SpriteRenderer")

				if var_728_1 and var_728_1.sprite then
					local var_728_2 = 2 * (var_728_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_728_0.transform.localScale = Vector3.New(var_728_2 / var_728_1.sprite.bounds.size.y < var_728_2 * manager.ui.mainCameraCom_.aspect / var_728_1.sprite.bounds.size.x and var_728_2 * manager.ui.mainCameraCom_.aspect / var_728_1.sprite.bounds.size.x or var_728_2 / var_728_1.sprite.bounds.size.y, var_728_2 / var_728_1.sprite.bounds.size.y < var_728_2 * manager.ui.mainCameraCom_.aspect / var_728_1.sprite.bounds.size.x and var_728_2 * manager.ui.mainCameraCom_.aspect / var_728_1.sprite.bounds.size.x or var_728_2 / var_728_1.sprite.bounds.size.y, 0)
				end

				for iter_728_0, iter_728_1 in pairs(arg_725_1.bgs_) do
					if iter_728_0 ~= "ST29" then
						iter_728_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_728_3 = 0

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= var_728_3 + arg_728_0 then
				arg_725_1.mask_.enabled = true
				arg_725_1.mask_.raycastTarget = true

				arg_725_1:SetGaussion(false)
			end

			local var_728_4 = 2

			if var_728_3 <= arg_725_1.time_ and arg_725_1.time_ < var_728_3 + var_728_4 then
				local var_728_5 = Color.New(0, 0, 0)

				var_728_5.a = Mathf.Lerp(0, 1, (arg_725_1.time_ - var_728_3) / var_728_4)
				arg_725_1.mask_.color = var_728_5
			end

			if arg_725_1.time_ >= var_728_3 + var_728_4 and arg_725_1.time_ < var_728_3 + var_728_4 + arg_728_0 then
				local var_728_6 = Color.New(0, 0, 0)

				var_728_6.a = 1
				arg_725_1.mask_.color = var_728_6
			end

			local var_728_7 = 2

			if 2 < arg_725_1.time_ and arg_725_1.time_ <= var_728_7 + arg_728_0 then
				arg_725_1.mask_.enabled = true
				arg_725_1.mask_.raycastTarget = true

				arg_725_1:SetGaussion(false)
			end

			local var_728_8 = 2

			if var_728_7 <= arg_725_1.time_ and arg_725_1.time_ < var_728_7 + var_728_8 then
				local var_728_9 = Color.New(0, 0, 0)

				var_728_9.a = Mathf.Lerp(1, 0, (arg_725_1.time_ - var_728_7) / var_728_8)
				arg_725_1.mask_.color = var_728_9
			end

			if arg_725_1.time_ >= var_728_7 + var_728_8 and arg_725_1.time_ < var_728_7 + var_728_8 + arg_728_0 then
				local var_728_10 = Color.New(0, 0, 0)

				arg_725_1.mask_.enabled = false
				var_728_10.a = 0
				arg_725_1.mask_.color = var_728_10
			end

			if arg_725_1.frameCnt_ <= 1 then
				arg_725_1.dialog_:SetActive(false)
			end

			local var_728_11 = 4
			local var_728_12 = 0.85

			if 4 < arg_725_1.time_ and arg_725_1.time_ <= var_728_11 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0

				arg_725_1.dialog_:SetActive(true)

				arg_725_1.dialogCg_.alpha = 0

				local var_728_13 = LeanTween.value(arg_725_1.dialog_, 0, 1, 0.3)

				var_728_13:setOnUpdate(LuaHelper.FloatAction(function(arg_729_0)
					arg_725_1.dialogCg_.alpha = arg_729_0
				end))
				var_728_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_725_1.dialog_)
					var_728_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_725_1.duration_ = arg_725_1.duration_ + 0.3

				SetActive(arg_725_1.leftNameGo_, false)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_14 = arg_725_1:FormatText(arg_725_1:GetWordFromCfg(120411178).content)

				arg_725_1.text_.text = var_728_14

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_16 = 34 <= 0 and var_728_12 or var_728_12 * (utf8.len(var_728_14) / 34)

				if (34 <= 0 and var_728_12 or var_728_12 * (utf8.len(var_728_14) / 34)) > 0 and var_728_12 < var_728_16 then
					arg_725_1.talkMaxDuration = var_728_16
					var_728_11 = var_728_11 + 0.3

					if var_728_16 + var_728_11 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_16 + var_728_11
					end
				end

				arg_725_1.text_.text = var_728_14
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_17 = var_728_11 + 0.3
			local var_728_18 = math.max(var_728_12, arg_725_1.talkMaxDuration)

			if var_728_11 + 0.3 <= arg_725_1.time_ and arg_725_1.time_ < var_728_17 + var_728_18 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_17) / var_728_18

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_17 + var_728_18 and arg_725_1.time_ < var_728_17 + var_728_18 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play120411179 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 120411179
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play120411180(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0.725

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, false)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_1 = arg_731_1:FormatText(arg_731_1:GetWordFromCfg(120411179).content)

				arg_731_1.text_.text = var_734_1

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_3 = 29 <= 0 and var_734_0 or var_734_0 * (utf8.len(var_734_1) / 29)

				if (29 <= 0 and var_734_0 or var_734_0 * (utf8.len(var_734_1) / 29)) > 0 and var_734_0 < var_734_3 then
					arg_731_1.talkMaxDuration = var_734_3

					if var_734_3 + 0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_3 + 0
					end
				end

				arg_731_1.text_.text = var_734_1
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_4 = math.max(var_734_0, arg_731_1.talkMaxDuration)

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_4 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - 0) / var_734_4

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= 0 + var_734_4 and arg_731_1.time_ < 0 + var_734_4 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play120411180 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 120411180
		arg_735_1.duration_ = 4

		local var_735_0 = {
			zh = 3.566,
			ja = 4
		}
		local var_735_1 = manager.audio:GetLocalizationFlag()

		if var_735_0[var_735_1] ~= nil then
			arg_735_1.duration_ = var_735_0[var_735_1]
		end

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play120411181(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 then
				arg_735_1.var_.moveOldPos1072ui_story = arg_735_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_738_0 = 0.001

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_0 then
				arg_735_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_735_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_735_1.time_ - 0) / var_738_0)
				arg_735_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_735_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_735_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_735_1.actors_["1072ui_story"].transform.position).z)
				arg_735_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_735_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_735_1.actors_["1072ui_story"].transform.localEulerAngles = arg_735_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_735_1.time_ >= 0 + var_738_0 and arg_735_1.time_ < 0 + var_738_0 + arg_738_0 then
				arg_735_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_735_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_735_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_735_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_735_1.actors_["1072ui_story"].transform.position).z)
				arg_735_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_735_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_735_1.actors_["1072ui_story"].transform.localEulerAngles = arg_735_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 then
				arg_735_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 then
				arg_735_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_738_1 = arg_735_1.actors_["1072ui_story"]

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 and not isNil(var_738_1) and arg_735_1.var_.characterEffect1072ui_story == nil then
				arg_735_1.var_.characterEffect1072ui_story = var_738_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_2 = 0.2

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_2 and not isNil(var_738_1) then
				if arg_735_1.var_.characterEffect1072ui_story and not isNil(var_738_1) then
					arg_735_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_735_1.time_ >= 0 + var_738_2 and arg_735_1.time_ < 0 + var_738_2 + arg_738_0 and not isNil(var_738_1) and arg_735_1.var_.characterEffect1072ui_story then
				arg_735_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_738_4 = 0
			local var_738_5 = 0.475

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_4 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				arg_735_1.leftNameTxt_.text = arg_735_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_6 = arg_735_1:GetWordFromCfg(120411180)
				local var_738_7 = arg_735_1:FormatText(var_738_6.content)

				arg_735_1.text_.text = var_738_7

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_9 = 19 <= 0 and var_738_5 or var_738_5 * (utf8.len(var_738_7) / 19)

				if (19 <= 0 and var_738_5 or var_738_5 * (utf8.len(var_738_7) / 19)) > 0 and var_738_5 < var_738_9 then
					arg_735_1.talkMaxDuration = var_738_9

					if var_738_9 + var_738_4 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_9 + var_738_4
					end
				end

				arg_735_1.text_.text = var_738_7
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411180", "story_v_out_120411.awb") ~= 0 then
					local var_738_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411180", "story_v_out_120411.awb") / 1000

					if var_738_10 + var_738_4 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_10 + var_738_4
					end

					if var_738_6.prefab_name ~= "" and arg_735_1.actors_[var_738_6.prefab_name] ~= nil then
						local var_738_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_735_1.actors_[var_738_6.prefab_name].transform, "story_v_out_120411", "120411180", "story_v_out_120411.awb")

						arg_735_1:RecordAudio("120411180", var_738_11)
						arg_735_1:RecordAudio("120411180", var_738_11)
					else
						arg_735_1:AudioAction("play", "voice", "story_v_out_120411", "120411180", "story_v_out_120411.awb")
					end

					arg_735_1:RecordHistoryTalkVoice("story_v_out_120411", "120411180", "story_v_out_120411.awb")
				end

				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_12 = math.max(var_738_5, arg_735_1.talkMaxDuration)

			if var_738_4 <= arg_735_1.time_ and arg_735_1.time_ < var_738_4 + var_738_12 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_4) / var_738_12

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_4 + var_738_12 and arg_735_1.time_ < var_738_4 + var_738_12 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_735_1:InitPlayNodeList()
	end,
	Play120411181 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 120411181
		arg_739_1.duration_ = 6.33

		local var_739_0 = {
			zh = 4.666,
			ja = 6.333
		}
		local var_739_1 = manager.audio:GetLocalizationFlag()

		if var_739_0[var_739_1] ~= nil then
			arg_739_1.duration_ = var_739_0[var_739_1]
		end

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play120411182(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = 0.9

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				arg_739_1.leftNameTxt_.text = arg_739_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_1 = arg_739_1:GetWordFromCfg(120411181)
				local var_742_2 = arg_739_1:FormatText(var_742_1.content)

				arg_739_1.text_.text = var_742_2

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_4 = 36 <= 0 and var_742_0 or var_742_0 * (utf8.len(var_742_2) / 36)

				if (36 <= 0 and var_742_0 or var_742_0 * (utf8.len(var_742_2) / 36)) > 0 and var_742_0 < var_742_4 then
					arg_739_1.talkMaxDuration = var_742_4

					if var_742_4 + 0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_4 + 0
					end
				end

				arg_739_1.text_.text = var_742_2
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411181", "story_v_out_120411.awb") ~= 0 then
					local var_742_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411181", "story_v_out_120411.awb") / 1000

					if var_742_5 + 0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_5 + 0
					end

					if var_742_1.prefab_name ~= "" and arg_739_1.actors_[var_742_1.prefab_name] ~= nil then
						local var_742_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_739_1.actors_[var_742_1.prefab_name].transform, "story_v_out_120411", "120411181", "story_v_out_120411.awb")

						arg_739_1:RecordAudio("120411181", var_742_6)
						arg_739_1:RecordAudio("120411181", var_742_6)
					else
						arg_739_1:AudioAction("play", "voice", "story_v_out_120411", "120411181", "story_v_out_120411.awb")
					end

					arg_739_1:RecordHistoryTalkVoice("story_v_out_120411", "120411181", "story_v_out_120411.awb")
				end

				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_7 = math.max(var_742_0, arg_739_1.talkMaxDuration)

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_7 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - 0) / var_742_7

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= 0 + var_742_7 and arg_739_1.time_ < 0 + var_742_7 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play120411182 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 120411182
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play120411183(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 and not isNil(arg_743_1.actors_["1072ui_story"]) and arg_743_1.var_.characterEffect1072ui_story == nil then
				arg_743_1.var_.characterEffect1072ui_story = arg_743_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_0 = 0.2

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_0 and not isNil(arg_743_1.actors_["1072ui_story"]) then
				if arg_743_1.var_.characterEffect1072ui_story and not isNil(arg_743_1.actors_["1072ui_story"]) then
					arg_743_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_743_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_743_1.time_ - 0) / var_746_0)
				end
			end

			if arg_743_1.time_ >= 0 + var_746_0 and arg_743_1.time_ < 0 + var_746_0 + arg_746_0 and not isNil(arg_743_1.actors_["1072ui_story"]) and arg_743_1.var_.characterEffect1072ui_story then
				arg_743_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_743_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_746_1 = 0
			local var_746_2 = 0.3

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= var_746_1 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				arg_743_1.leftNameTxt_.text = arg_743_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, true)
				arg_743_1.iconController_:SetSelectedState("hero")

				arg_743_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_743_1.callingController_:SetSelectedState("normal")

				arg_743_1.keyicon_.color = Color.New(1, 1, 1)
				arg_743_1.icon_.color = Color.New(1, 1, 1)

				local var_746_3 = arg_743_1:FormatText(arg_743_1:GetWordFromCfg(120411182).content)

				arg_743_1.text_.text = var_746_3

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_5 = 12 <= 0 and var_746_2 or var_746_2 * (utf8.len(var_746_3) / 12)

				if (12 <= 0 and var_746_2 or var_746_2 * (utf8.len(var_746_3) / 12)) > 0 and var_746_2 < var_746_5 then
					arg_743_1.talkMaxDuration = var_746_5

					if var_746_5 + var_746_1 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_5 + var_746_1
					end
				end

				arg_743_1.text_.text = var_746_3
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_6 = math.max(var_746_2, arg_743_1.talkMaxDuration)

			if var_746_1 <= arg_743_1.time_ and arg_743_1.time_ < var_746_1 + var_746_6 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_1) / var_746_6

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_1 + var_746_6 and arg_743_1.time_ < var_746_1 + var_746_6 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	Play120411183 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 120411183
		arg_747_1.duration_ = 13.8

		local var_747_0 = {
			zh = 6.333,
			ja = 13.8
		}
		local var_747_1 = manager.audio:GetLocalizationFlag()

		if var_747_0[var_747_1] ~= nil then
			arg_747_1.duration_ = var_747_0[var_747_1]
		end

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play120411184(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 and not isNil(arg_747_1.actors_["1072ui_story"]) and arg_747_1.var_.characterEffect1072ui_story == nil then
				arg_747_1.var_.characterEffect1072ui_story = arg_747_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_0 = 0.2

			if 0 <= arg_747_1.time_ and arg_747_1.time_ < 0 + var_750_0 and not isNil(arg_747_1.actors_["1072ui_story"]) then
				if arg_747_1.var_.characterEffect1072ui_story and not isNil(arg_747_1.actors_["1072ui_story"]) then
					arg_747_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_747_1.time_ >= 0 + var_750_0 and arg_747_1.time_ < 0 + var_750_0 + arg_750_0 and not isNil(arg_747_1.actors_["1072ui_story"]) and arg_747_1.var_.characterEffect1072ui_story then
				arg_747_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 then
				arg_747_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 then
				arg_747_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_750_2 = 0
			local var_750_3 = 0.75

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= var_750_2 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				arg_747_1.leftNameTxt_.text = arg_747_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, false)
				arg_747_1.callingController_:SetSelectedState("normal")

				local var_750_4 = arg_747_1:GetWordFromCfg(120411183)
				local var_750_5 = arg_747_1:FormatText(var_750_4.content)

				arg_747_1.text_.text = var_750_5

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_7 = 29 <= 0 and var_750_3 or var_750_3 * (utf8.len(var_750_5) / 29)

				if (29 <= 0 and var_750_3 or var_750_3 * (utf8.len(var_750_5) / 29)) > 0 and var_750_3 < var_750_7 then
					arg_747_1.talkMaxDuration = var_750_7

					if var_750_7 + var_750_2 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_7 + var_750_2
					end
				end

				arg_747_1.text_.text = var_750_5
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411183", "story_v_out_120411.awb") ~= 0 then
					local var_750_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411183", "story_v_out_120411.awb") / 1000

					if var_750_8 + var_750_2 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_8 + var_750_2
					end

					if var_750_4.prefab_name ~= "" and arg_747_1.actors_[var_750_4.prefab_name] ~= nil then
						local var_750_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_747_1.actors_[var_750_4.prefab_name].transform, "story_v_out_120411", "120411183", "story_v_out_120411.awb")

						arg_747_1:RecordAudio("120411183", var_750_9)
						arg_747_1:RecordAudio("120411183", var_750_9)
					else
						arg_747_1:AudioAction("play", "voice", "story_v_out_120411", "120411183", "story_v_out_120411.awb")
					end

					arg_747_1:RecordHistoryTalkVoice("story_v_out_120411", "120411183", "story_v_out_120411.awb")
				end

				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_10 = math.max(var_750_3, arg_747_1.talkMaxDuration)

			if var_750_2 <= arg_747_1.time_ and arg_747_1.time_ < var_750_2 + var_750_10 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_2) / var_750_10

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_2 + var_750_10 and arg_747_1.time_ < var_750_2 + var_750_10 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	Play120411184 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 120411184
		arg_751_1.duration_ = 13.7

		local var_751_0 = {
			zh = 9.833,
			ja = 13.7
		}
		local var_751_1 = manager.audio:GetLocalizationFlag()

		if var_751_0[var_751_1] ~= nil then
			arg_751_1.duration_ = var_751_0[var_751_1]
		end

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play120411185(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			local var_754_0 = 1.175

			if 0 < arg_751_1.time_ and arg_751_1.time_ <= 0 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				arg_751_1.leftNameTxt_.text = arg_751_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_1 = arg_751_1:GetWordFromCfg(120411184)
				local var_754_2 = arg_751_1:FormatText(var_754_1.content)

				arg_751_1.text_.text = var_754_2

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_4 = 47 <= 0 and var_754_0 or var_754_0 * (utf8.len(var_754_2) / 47)

				if (47 <= 0 and var_754_0 or var_754_0 * (utf8.len(var_754_2) / 47)) > 0 and var_754_0 < var_754_4 then
					arg_751_1.talkMaxDuration = var_754_4

					if var_754_4 + 0 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_4 + 0
					end
				end

				arg_751_1.text_.text = var_754_2
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411184", "story_v_out_120411.awb") ~= 0 then
					local var_754_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411184", "story_v_out_120411.awb") / 1000

					if var_754_5 + 0 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_5 + 0
					end

					if var_754_1.prefab_name ~= "" and arg_751_1.actors_[var_754_1.prefab_name] ~= nil then
						local var_754_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_751_1.actors_[var_754_1.prefab_name].transform, "story_v_out_120411", "120411184", "story_v_out_120411.awb")

						arg_751_1:RecordAudio("120411184", var_754_6)
						arg_751_1:RecordAudio("120411184", var_754_6)
					else
						arg_751_1:AudioAction("play", "voice", "story_v_out_120411", "120411184", "story_v_out_120411.awb")
					end

					arg_751_1:RecordHistoryTalkVoice("story_v_out_120411", "120411184", "story_v_out_120411.awb")
				end

				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_7 = math.max(var_754_0, arg_751_1.talkMaxDuration)

			if 0 <= arg_751_1.time_ and arg_751_1.time_ < 0 + var_754_7 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - 0) / var_754_7

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= 0 + var_754_7 and arg_751_1.time_ < 0 + var_754_7 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {}

		arg_751_1:InitPlayNodeList()
	end,
	Play120411185 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 120411185
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play120411186(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			if 0 < arg_755_1.time_ and arg_755_1.time_ <= 0 + arg_758_0 and not isNil(arg_755_1.actors_["1072ui_story"]) and arg_755_1.var_.characterEffect1072ui_story == nil then
				arg_755_1.var_.characterEffect1072ui_story = arg_755_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_0 = 0.2

			if 0 <= arg_755_1.time_ and arg_755_1.time_ < 0 + var_758_0 and not isNil(arg_755_1.actors_["1072ui_story"]) then
				if arg_755_1.var_.characterEffect1072ui_story and not isNil(arg_755_1.actors_["1072ui_story"]) then
					arg_755_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_755_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_755_1.time_ - 0) / var_758_0)
				end
			end

			if arg_755_1.time_ >= 0 + var_758_0 and arg_755_1.time_ < 0 + var_758_0 + arg_758_0 and not isNil(arg_755_1.actors_["1072ui_story"]) and arg_755_1.var_.characterEffect1072ui_story then
				arg_755_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_755_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_758_1 = 0
			local var_758_2 = 0.4

			if 0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, false)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_3 = arg_755_1:FormatText(arg_755_1:GetWordFromCfg(120411185).content)

				arg_755_1.text_.text = var_758_3

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_5 = 16 <= 0 and var_758_2 or var_758_2 * (utf8.len(var_758_3) / 16)

				if (16 <= 0 and var_758_2 or var_758_2 * (utf8.len(var_758_3) / 16)) > 0 and var_758_2 < var_758_5 then
					arg_755_1.talkMaxDuration = var_758_5

					if var_758_5 + var_758_1 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_5 + var_758_1
					end
				end

				arg_755_1.text_.text = var_758_3
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_6 = math.max(var_758_2, arg_755_1.talkMaxDuration)

			if var_758_1 <= arg_755_1.time_ and arg_755_1.time_ < var_758_1 + var_758_6 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_1) / var_758_6

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_1 + var_758_6 and arg_755_1.time_ < var_758_1 + var_758_6 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play120411186 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 120411186
		arg_759_1.duration_ = 5.77

		local var_759_0 = {
			zh = 1.999999999999,
			ja = 5.766
		}
		local var_759_1 = manager.audio:GetLocalizationFlag()

		if var_759_0[var_759_1] ~= nil then
			arg_759_1.duration_ = var_759_0[var_759_1]
		end

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play120411187(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				arg_759_1.var_.moveOldPos1072ui_story = arg_759_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_762_0 = 0.001

			if 0 <= arg_759_1.time_ and arg_759_1.time_ < 0 + var_762_0 then
				arg_759_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_759_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_759_1.time_ - 0) / var_762_0)
				arg_759_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_759_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1072ui_story"].transform.position).z)
				arg_759_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_759_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_759_1.actors_["1072ui_story"].transform.localEulerAngles = arg_759_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_759_1.time_ >= 0 + var_762_0 and arg_759_1.time_ < 0 + var_762_0 + arg_762_0 then
				arg_759_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_759_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_759_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1072ui_story"].transform.position).z)
				arg_759_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_759_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_759_1.actors_["1072ui_story"].transform.localEulerAngles = arg_759_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_762_1 = arg_759_1.actors_["1072ui_story"]

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 and not isNil(var_762_1) and arg_759_1.var_.characterEffect1072ui_story == nil then
				arg_759_1.var_.characterEffect1072ui_story = var_762_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_762_2 = 0.2

			if 0 <= arg_759_1.time_ and arg_759_1.time_ < 0 + var_762_2 and not isNil(var_762_1) then
				if arg_759_1.var_.characterEffect1072ui_story and not isNil(var_762_1) then
					arg_759_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_759_1.time_ >= 0 + var_762_2 and arg_759_1.time_ < 0 + var_762_2 + arg_762_0 and not isNil(var_762_1) and arg_759_1.var_.characterEffect1072ui_story then
				arg_759_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_762_4 = arg_759_1.actors_["1076ui_story"].transform

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				arg_759_1.var_.moveOldPos1076ui_story = var_762_4.localPosition
			end

			local var_762_5 = 0.001

			if 0 <= arg_759_1.time_ and arg_759_1.time_ < 0 + var_762_5 then
				var_762_4.localPosition = Vector3.Lerp(arg_759_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_759_1.time_ - 0) / var_762_5)
				var_762_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_762_4.position).x, (manager.ui.mainCamera.transform.position - var_762_4.position).y, (manager.ui.mainCamera.transform.position - var_762_4.position).z)
				var_762_4.localEulerAngles.z = 0
				var_762_4.localEulerAngles.x = 0
				var_762_4.localEulerAngles = var_762_4.localEulerAngles
			end

			if arg_759_1.time_ >= 0 + var_762_5 and arg_759_1.time_ < 0 + var_762_5 + arg_762_0 then
				var_762_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_762_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_762_4.position).x, (manager.ui.mainCamera.transform.position - var_762_4.position).y, (manager.ui.mainCamera.transform.position - var_762_4.position).z)
				var_762_4.localEulerAngles.z = 0
				var_762_4.localEulerAngles.x = 0
				var_762_4.localEulerAngles = var_762_4.localEulerAngles
			end

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				arg_759_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_762_6 = arg_759_1.actors_["1076ui_story"]

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 and not isNil(var_762_6) and arg_759_1.var_.characterEffect1076ui_story == nil then
				arg_759_1.var_.characterEffect1076ui_story = var_762_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_762_7 = 0.0166666666666667

			if 0 <= arg_759_1.time_ and arg_759_1.time_ < 0 + var_762_7 and not isNil(var_762_6) then
				if arg_759_1.var_.characterEffect1076ui_story and not isNil(var_762_6) then
					arg_759_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_759_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_759_1.time_ - 0) / var_762_7)
				end
			end

			if arg_759_1.time_ >= 0 + var_762_7 and arg_759_1.time_ < 0 + var_762_7 + arg_762_0 and not isNil(var_762_6) and arg_759_1.var_.characterEffect1076ui_story then
				arg_759_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_759_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_762_8 = 0
			local var_762_9 = 0.15

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= var_762_8 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				arg_759_1.leftNameTxt_.text = arg_759_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_10 = arg_759_1:GetWordFromCfg(120411186)
				local var_762_11 = arg_759_1:FormatText(var_762_10.content)

				arg_759_1.text_.text = var_762_11

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_13 = 6 <= 0 and var_762_9 or var_762_9 * (utf8.len(var_762_11) / 6)

				if (6 <= 0 and var_762_9 or var_762_9 * (utf8.len(var_762_11) / 6)) > 0 and var_762_9 < var_762_13 then
					arg_759_1.talkMaxDuration = var_762_13

					if var_762_13 + var_762_8 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_13 + var_762_8
					end
				end

				arg_759_1.text_.text = var_762_11
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411186", "story_v_out_120411.awb") ~= 0 then
					local var_762_14 = manager.audio:GetVoiceLength("story_v_out_120411", "120411186", "story_v_out_120411.awb") / 1000

					if var_762_14 + var_762_8 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_14 + var_762_8
					end

					if var_762_10.prefab_name ~= "" and arg_759_1.actors_[var_762_10.prefab_name] ~= nil then
						local var_762_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_759_1.actors_[var_762_10.prefab_name].transform, "story_v_out_120411", "120411186", "story_v_out_120411.awb")

						arg_759_1:RecordAudio("120411186", var_762_15)
						arg_759_1:RecordAudio("120411186", var_762_15)
					else
						arg_759_1:AudioAction("play", "voice", "story_v_out_120411", "120411186", "story_v_out_120411.awb")
					end

					arg_759_1:RecordHistoryTalkVoice("story_v_out_120411", "120411186", "story_v_out_120411.awb")
				end

				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_16 = math.max(var_762_9, arg_759_1.talkMaxDuration)

			if var_762_8 <= arg_759_1.time_ and arg_759_1.time_ < var_762_8 + var_762_16 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_8) / var_762_16

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_8 + var_762_16 and arg_759_1.time_ < var_762_8 + var_762_16 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_759_1:InitPlayNodeList()
	end,
	Play120411187 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 120411187
		arg_763_1.duration_ = 5

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play120411188(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 and not isNil(arg_763_1.actors_["1072ui_story"]) and arg_763_1.var_.characterEffect1072ui_story == nil then
				arg_763_1.var_.characterEffect1072ui_story = arg_763_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_766_0 = 0.2

			if 0 <= arg_763_1.time_ and arg_763_1.time_ < 0 + var_766_0 and not isNil(arg_763_1.actors_["1072ui_story"]) then
				if arg_763_1.var_.characterEffect1072ui_story and not isNil(arg_763_1.actors_["1072ui_story"]) then
					arg_763_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_763_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_763_1.time_ - 0) / var_766_0)
				end
			end

			if arg_763_1.time_ >= 0 + var_766_0 and arg_763_1.time_ < 0 + var_766_0 + arg_766_0 and not isNil(arg_763_1.actors_["1072ui_story"]) and arg_763_1.var_.characterEffect1072ui_story then
				arg_763_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_763_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_766_1 = 0
			local var_766_2 = 0.125

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= var_766_1 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				arg_763_1.leftNameTxt_.text = arg_763_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, true)
				arg_763_1.iconController_:SetSelectedState("hero")

				arg_763_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_763_1.callingController_:SetSelectedState("normal")

				arg_763_1.keyicon_.color = Color.New(1, 1, 1)
				arg_763_1.icon_.color = Color.New(1, 1, 1)

				local var_766_3 = arg_763_1:FormatText(arg_763_1:GetWordFromCfg(120411187).content)

				arg_763_1.text_.text = var_766_3

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_5 = 5 <= 0 and var_766_2 or var_766_2 * (utf8.len(var_766_3) / 5)

				if (5 <= 0 and var_766_2 or var_766_2 * (utf8.len(var_766_3) / 5)) > 0 and var_766_2 < var_766_5 then
					arg_763_1.talkMaxDuration = var_766_5

					if var_766_5 + var_766_1 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_5 + var_766_1
					end
				end

				arg_763_1.text_.text = var_766_3
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)
				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_6 = math.max(var_766_2, arg_763_1.talkMaxDuration)

			if var_766_1 <= arg_763_1.time_ and arg_763_1.time_ < var_766_1 + var_766_6 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_1) / var_766_6

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_1 + var_766_6 and arg_763_1.time_ < var_766_1 + var_766_6 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play120411188 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 120411188
		arg_767_1.duration_ = 2

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play120411189(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 and not isNil(arg_767_1.actors_["1076ui_story"]) and arg_767_1.var_.characterEffect1076ui_story == nil then
				arg_767_1.var_.characterEffect1076ui_story = arg_767_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_0 = 0.2

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_0 and not isNil(arg_767_1.actors_["1076ui_story"]) then
				if arg_767_1.var_.characterEffect1076ui_story and not isNil(arg_767_1.actors_["1076ui_story"]) then
					arg_767_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_767_1.time_ >= 0 + var_770_0 and arg_767_1.time_ < 0 + var_770_0 + arg_770_0 and not isNil(arg_767_1.actors_["1076ui_story"]) and arg_767_1.var_.characterEffect1076ui_story then
				arg_767_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 then
				arg_767_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_770_2 = 0
			local var_770_3 = 0.05

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= var_770_2 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				arg_767_1.leftNameTxt_.text = arg_767_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_4 = arg_767_1:GetWordFromCfg(120411188)
				local var_770_5 = arg_767_1:FormatText(var_770_4.content)

				arg_767_1.text_.text = var_770_5

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_7 = 2 <= 0 and var_770_3 or var_770_3 * (utf8.len(var_770_5) / 2)

				if (2 <= 0 and var_770_3 or var_770_3 * (utf8.len(var_770_5) / 2)) > 0 and var_770_3 < var_770_7 then
					arg_767_1.talkMaxDuration = var_770_7

					if var_770_7 + var_770_2 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_7 + var_770_2
					end
				end

				arg_767_1.text_.text = var_770_5
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411188", "story_v_out_120411.awb") ~= 0 then
					local var_770_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411188", "story_v_out_120411.awb") / 1000

					if var_770_8 + var_770_2 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_8 + var_770_2
					end

					if var_770_4.prefab_name ~= "" and arg_767_1.actors_[var_770_4.prefab_name] ~= nil then
						local var_770_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_767_1.actors_[var_770_4.prefab_name].transform, "story_v_out_120411", "120411188", "story_v_out_120411.awb")

						arg_767_1:RecordAudio("120411188", var_770_9)
						arg_767_1:RecordAudio("120411188", var_770_9)
					else
						arg_767_1:AudioAction("play", "voice", "story_v_out_120411", "120411188", "story_v_out_120411.awb")
					end

					arg_767_1:RecordHistoryTalkVoice("story_v_out_120411", "120411188", "story_v_out_120411.awb")
				end

				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_10 = math.max(var_770_3, arg_767_1.talkMaxDuration)

			if var_770_2 <= arg_767_1.time_ and arg_767_1.time_ < var_770_2 + var_770_10 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_2) / var_770_10

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_2 + var_770_10 and arg_767_1.time_ < var_770_2 + var_770_10 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {}

		arg_767_1:InitPlayNodeList()
	end,
	Play120411189 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 120411189
		arg_771_1.duration_ = 4.3

		local var_771_0 = {
			zh = 4.1,
			ja = 4.3
		}
		local var_771_1 = manager.audio:GetLocalizationFlag()

		if var_771_0[var_771_1] ~= nil then
			arg_771_1.duration_ = var_771_0[var_771_1]
		end

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play120411190(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			if 0 < arg_771_1.time_ and arg_771_1.time_ <= 0 + arg_774_0 and not isNil(arg_771_1.actors_["1072ui_story"]) and arg_771_1.var_.characterEffect1072ui_story == nil then
				arg_771_1.var_.characterEffect1072ui_story = arg_771_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_774_0 = 0.2

			if 0 <= arg_771_1.time_ and arg_771_1.time_ < 0 + var_774_0 and not isNil(arg_771_1.actors_["1072ui_story"]) then
				if arg_771_1.var_.characterEffect1072ui_story and not isNil(arg_771_1.actors_["1072ui_story"]) then
					arg_771_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_771_1.time_ >= 0 + var_774_0 and arg_771_1.time_ < 0 + var_774_0 + arg_774_0 and not isNil(arg_771_1.actors_["1072ui_story"]) and arg_771_1.var_.characterEffect1072ui_story then
				arg_771_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_774_2 = arg_771_1.actors_["1076ui_story"]

			if 0 < arg_771_1.time_ and arg_771_1.time_ <= 0 + arg_774_0 and not isNil(var_774_2) and arg_771_1.var_.characterEffect1076ui_story == nil then
				arg_771_1.var_.characterEffect1076ui_story = var_774_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_774_3 = 0.2

			if 0 <= arg_771_1.time_ and arg_771_1.time_ < 0 + var_774_3 and not isNil(var_774_2) then
				if arg_771_1.var_.characterEffect1076ui_story and not isNil(var_774_2) then
					arg_771_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_771_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_771_1.time_ - 0) / var_774_3)
				end
			end

			if arg_771_1.time_ >= 0 + var_774_3 and arg_771_1.time_ < 0 + var_774_3 + arg_774_0 and not isNil(var_774_2) and arg_771_1.var_.characterEffect1076ui_story then
				arg_771_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_771_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_774_4 = 0
			local var_774_5 = 0.75

			if 0 < arg_771_1.time_ and arg_771_1.time_ <= var_774_4 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, true)

				arg_771_1.leftNameTxt_.text = arg_771_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_771_1.leftNameTxt_.transform)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1.leftNameTxt_.text)
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_6 = arg_771_1:GetWordFromCfg(120411189)
				local var_774_7 = arg_771_1:FormatText(var_774_6.content)

				arg_771_1.text_.text = var_774_7

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_9 = 30 <= 0 and var_774_5 or var_774_5 * (utf8.len(var_774_7) / 30)

				if (30 <= 0 and var_774_5 or var_774_5 * (utf8.len(var_774_7) / 30)) > 0 and var_774_5 < var_774_9 then
					arg_771_1.talkMaxDuration = var_774_9

					if var_774_9 + var_774_4 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_9 + var_774_4
					end
				end

				arg_771_1.text_.text = var_774_7
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411189", "story_v_out_120411.awb") ~= 0 then
					local var_774_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411189", "story_v_out_120411.awb") / 1000

					if var_774_10 + var_774_4 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_10 + var_774_4
					end

					if var_774_6.prefab_name ~= "" and arg_771_1.actors_[var_774_6.prefab_name] ~= nil then
						local var_774_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_771_1.actors_[var_774_6.prefab_name].transform, "story_v_out_120411", "120411189", "story_v_out_120411.awb")

						arg_771_1:RecordAudio("120411189", var_774_11)
						arg_771_1:RecordAudio("120411189", var_774_11)
					else
						arg_771_1:AudioAction("play", "voice", "story_v_out_120411", "120411189", "story_v_out_120411.awb")
					end

					arg_771_1:RecordHistoryTalkVoice("story_v_out_120411", "120411189", "story_v_out_120411.awb")
				end

				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_12 = math.max(var_774_5, arg_771_1.talkMaxDuration)

			if var_774_4 <= arg_771_1.time_ and arg_771_1.time_ < var_774_4 + var_774_12 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_4) / var_774_12

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_4 + var_774_12 and arg_771_1.time_ < var_774_4 + var_774_12 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play120411190 = function(arg_775_0, arg_775_1)
		arg_775_1.time_ = 0
		arg_775_1.frameCnt_ = 0
		arg_775_1.state_ = "playing"
		arg_775_1.curTalkId_ = 120411190
		arg_775_1.duration_ = 8.1

		local var_775_0 = {
			zh = 2.166,
			ja = 8.1
		}
		local var_775_1 = manager.audio:GetLocalizationFlag()

		if var_775_0[var_775_1] ~= nil then
			arg_775_1.duration_ = var_775_0[var_775_1]
		end

		SetActive(arg_775_1.tipsGo_, false)

		function arg_775_1.onSingleLineFinish_()
			arg_775_1.onSingleLineUpdate_ = nil
			arg_775_1.onSingleLineFinish_ = nil
			arg_775_1.state_ = "waiting"
		end

		function arg_775_1.playNext_(arg_777_0)
			if arg_777_0 == 1 then
				arg_775_0:Play120411191(arg_775_1)
			end
		end

		function arg_775_1.onSingleLineUpdate_(arg_778_0)
			local var_778_0 = 0.2

			if 0 < arg_775_1.time_ and arg_775_1.time_ <= 0 + arg_778_0 then
				arg_775_1.talkMaxDuration = 0
				arg_775_1.dialogCg_.alpha = 1

				arg_775_1.dialog_:SetActive(true)
				SetActive(arg_775_1.leftNameGo_, true)

				arg_775_1.leftNameTxt_.text = arg_775_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_775_1.leftNameTxt_.transform)

				arg_775_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_775_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_775_1:RecordName(arg_775_1.leftNameTxt_.text)
				SetActive(arg_775_1.iconTrs_.gameObject, false)
				arg_775_1.callingController_:SetSelectedState("normal")

				local var_778_1 = arg_775_1:GetWordFromCfg(120411190)
				local var_778_2 = arg_775_1:FormatText(var_778_1.content)

				arg_775_1.text_.text = var_778_2

				LuaForUtil.ClearLinePrefixSymbol(arg_775_1.text_)

				local var_778_4 = 8 <= 0 and var_778_0 or var_778_0 * (utf8.len(var_778_2) / 8)

				if (8 <= 0 and var_778_0 or var_778_0 * (utf8.len(var_778_2) / 8)) > 0 and var_778_0 < var_778_4 then
					arg_775_1.talkMaxDuration = var_778_4

					if var_778_4 + 0 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_4 + 0
					end
				end

				arg_775_1.text_.text = var_778_2
				arg_775_1.typewritter.percent = 0

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411190", "story_v_out_120411.awb") ~= 0 then
					local var_778_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411190", "story_v_out_120411.awb") / 1000

					if var_778_5 + 0 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_5 + 0
					end

					if var_778_1.prefab_name ~= "" and arg_775_1.actors_[var_778_1.prefab_name] ~= nil then
						local var_778_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_775_1.actors_[var_778_1.prefab_name].transform, "story_v_out_120411", "120411190", "story_v_out_120411.awb")

						arg_775_1:RecordAudio("120411190", var_778_6)
						arg_775_1:RecordAudio("120411190", var_778_6)
					else
						arg_775_1:AudioAction("play", "voice", "story_v_out_120411", "120411190", "story_v_out_120411.awb")
					end

					arg_775_1:RecordHistoryTalkVoice("story_v_out_120411", "120411190", "story_v_out_120411.awb")
				end

				arg_775_1:RecordContent(arg_775_1.text_.text)
			end

			local var_778_7 = math.max(var_778_0, arg_775_1.talkMaxDuration)

			if 0 <= arg_775_1.time_ and arg_775_1.time_ < 0 + var_778_7 then
				arg_775_1.typewritter.percent = (arg_775_1.time_ - 0) / var_778_7

				arg_775_1.typewritter:SetDirty()
			end

			if arg_775_1.time_ >= 0 + var_778_7 and arg_775_1.time_ < 0 + var_778_7 + arg_778_0 then
				arg_775_1.typewritter.percent = 1

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(true)
			end
		end

		arg_775_1.nodeConfigList_ = {}

		arg_775_1:InitPlayNodeList()
	end,
	Play120411191 = function(arg_779_0, arg_779_1)
		arg_779_1.time_ = 0
		arg_779_1.frameCnt_ = 0
		arg_779_1.state_ = "playing"
		arg_779_1.curTalkId_ = 120411191
		arg_779_1.duration_ = 5

		SetActive(arg_779_1.tipsGo_, false)

		function arg_779_1.onSingleLineFinish_()
			arg_779_1.onSingleLineUpdate_ = nil
			arg_779_1.onSingleLineFinish_ = nil
			arg_779_1.state_ = "waiting"
		end

		function arg_779_1.playNext_(arg_781_0)
			if arg_781_0 == 1 then
				arg_779_0:Play120411192(arg_779_1)
			end
		end

		function arg_779_1.onSingleLineUpdate_(arg_782_0)
			if 0 < arg_779_1.time_ and arg_779_1.time_ <= 0 + arg_782_0 and not isNil(arg_779_1.actors_["1072ui_story"]) and arg_779_1.var_.characterEffect1072ui_story == nil then
				arg_779_1.var_.characterEffect1072ui_story = arg_779_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_782_0 = 0.2

			if 0 <= arg_779_1.time_ and arg_779_1.time_ < 0 + var_782_0 and not isNil(arg_779_1.actors_["1072ui_story"]) then
				if arg_779_1.var_.characterEffect1072ui_story and not isNil(arg_779_1.actors_["1072ui_story"]) then
					arg_779_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_779_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_779_1.time_ - 0) / var_782_0)
				end
			end

			if arg_779_1.time_ >= 0 + var_782_0 and arg_779_1.time_ < 0 + var_782_0 + arg_782_0 and not isNil(arg_779_1.actors_["1072ui_story"]) and arg_779_1.var_.characterEffect1072ui_story then
				arg_779_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_779_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_782_1 = 0
			local var_782_2 = 0.05

			if 0 < arg_779_1.time_ and arg_779_1.time_ <= var_782_1 + arg_782_0 then
				arg_779_1.talkMaxDuration = 0
				arg_779_1.dialogCg_.alpha = 1

				arg_779_1.dialog_:SetActive(true)
				SetActive(arg_779_1.leftNameGo_, true)

				arg_779_1.leftNameTxt_.text = arg_779_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_779_1.leftNameTxt_.transform)

				arg_779_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_779_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_779_1:RecordName(arg_779_1.leftNameTxt_.text)
				SetActive(arg_779_1.iconTrs_.gameObject, true)
				arg_779_1.iconController_:SetSelectedState("hero")

				arg_779_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_779_1.callingController_:SetSelectedState("normal")

				arg_779_1.keyicon_.color = Color.New(1, 1, 1)
				arg_779_1.icon_.color = Color.New(1, 1, 1)

				local var_782_3 = arg_779_1:FormatText(arg_779_1:GetWordFromCfg(120411191).content)

				arg_779_1.text_.text = var_782_3

				LuaForUtil.ClearLinePrefixSymbol(arg_779_1.text_)

				local var_782_5 = 2 <= 0 and var_782_2 or var_782_2 * (utf8.len(var_782_3) / 2)

				if (2 <= 0 and var_782_2 or var_782_2 * (utf8.len(var_782_3) / 2)) > 0 and var_782_2 < var_782_5 then
					arg_779_1.talkMaxDuration = var_782_5

					if var_782_5 + var_782_1 > arg_779_1.duration_ then
						arg_779_1.duration_ = var_782_5 + var_782_1
					end
				end

				arg_779_1.text_.text = var_782_3
				arg_779_1.typewritter.percent = 0

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(false)
				arg_779_1:RecordContent(arg_779_1.text_.text)
			end

			local var_782_6 = math.max(var_782_2, arg_779_1.talkMaxDuration)

			if var_782_1 <= arg_779_1.time_ and arg_779_1.time_ < var_782_1 + var_782_6 then
				arg_779_1.typewritter.percent = (arg_779_1.time_ - var_782_1) / var_782_6

				arg_779_1.typewritter:SetDirty()
			end

			if arg_779_1.time_ >= var_782_1 + var_782_6 and arg_779_1.time_ < var_782_1 + var_782_6 + arg_782_0 then
				arg_779_1.typewritter.percent = 1

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(true)
			end
		end

		arg_779_1.nodeConfigList_ = {}

		arg_779_1:InitPlayNodeList()
	end,
	Play120411192 = function(arg_783_0, arg_783_1)
		arg_783_1.time_ = 0
		arg_783_1.frameCnt_ = 0
		arg_783_1.state_ = "playing"
		arg_783_1.curTalkId_ = 120411192
		arg_783_1.duration_ = 7.57

		local var_783_0 = {
			zh = 4.5,
			ja = 7.566
		}
		local var_783_1 = manager.audio:GetLocalizationFlag()

		if var_783_0[var_783_1] ~= nil then
			arg_783_1.duration_ = var_783_0[var_783_1]
		end

		SetActive(arg_783_1.tipsGo_, false)

		function arg_783_1.onSingleLineFinish_()
			arg_783_1.onSingleLineUpdate_ = nil
			arg_783_1.onSingleLineFinish_ = nil
			arg_783_1.state_ = "waiting"
		end

		function arg_783_1.playNext_(arg_785_0)
			if arg_785_0 == 1 then
				arg_783_0:Play120411193(arg_783_1)
			end
		end

		function arg_783_1.onSingleLineUpdate_(arg_786_0)
			if 0 < arg_783_1.time_ and arg_783_1.time_ <= 0 + arg_786_0 and not isNil(arg_783_1.actors_["1076ui_story"]) and arg_783_1.var_.characterEffect1076ui_story == nil then
				arg_783_1.var_.characterEffect1076ui_story = arg_783_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_786_0 = 0.2

			if 0 <= arg_783_1.time_ and arg_783_1.time_ < 0 + var_786_0 and not isNil(arg_783_1.actors_["1076ui_story"]) then
				if arg_783_1.var_.characterEffect1076ui_story and not isNil(arg_783_1.actors_["1076ui_story"]) then
					arg_783_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_783_1.time_ >= 0 + var_786_0 and arg_783_1.time_ < 0 + var_786_0 + arg_786_0 and not isNil(arg_783_1.actors_["1076ui_story"]) and arg_783_1.var_.characterEffect1076ui_story then
				arg_783_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_783_1.time_ and arg_783_1.time_ <= 0 + arg_786_0 then
				arg_783_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			local var_786_2 = 0
			local var_786_3 = 0.475

			if 0 < arg_783_1.time_ and arg_783_1.time_ <= var_786_2 + arg_786_0 then
				arg_783_1.talkMaxDuration = 0
				arg_783_1.dialogCg_.alpha = 1

				arg_783_1.dialog_:SetActive(true)
				SetActive(arg_783_1.leftNameGo_, true)

				arg_783_1.leftNameTxt_.text = arg_783_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_783_1.leftNameTxt_.transform)

				arg_783_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_783_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_783_1:RecordName(arg_783_1.leftNameTxt_.text)
				SetActive(arg_783_1.iconTrs_.gameObject, false)
				arg_783_1.callingController_:SetSelectedState("normal")

				local var_786_4 = arg_783_1:GetWordFromCfg(120411192)
				local var_786_5 = arg_783_1:FormatText(var_786_4.content)

				arg_783_1.text_.text = var_786_5

				LuaForUtil.ClearLinePrefixSymbol(arg_783_1.text_)

				local var_786_7 = 19 <= 0 and var_786_3 or var_786_3 * (utf8.len(var_786_5) / 19)

				if (19 <= 0 and var_786_3 or var_786_3 * (utf8.len(var_786_5) / 19)) > 0 and var_786_3 < var_786_7 then
					arg_783_1.talkMaxDuration = var_786_7

					if var_786_7 + var_786_2 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_7 + var_786_2
					end
				end

				arg_783_1.text_.text = var_786_5
				arg_783_1.typewritter.percent = 0

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411192", "story_v_out_120411.awb") ~= 0 then
					local var_786_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411192", "story_v_out_120411.awb") / 1000

					if var_786_8 + var_786_2 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_8 + var_786_2
					end

					if var_786_4.prefab_name ~= "" and arg_783_1.actors_[var_786_4.prefab_name] ~= nil then
						local var_786_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_783_1.actors_[var_786_4.prefab_name].transform, "story_v_out_120411", "120411192", "story_v_out_120411.awb")

						arg_783_1:RecordAudio("120411192", var_786_9)
						arg_783_1:RecordAudio("120411192", var_786_9)
					else
						arg_783_1:AudioAction("play", "voice", "story_v_out_120411", "120411192", "story_v_out_120411.awb")
					end

					arg_783_1:RecordHistoryTalkVoice("story_v_out_120411", "120411192", "story_v_out_120411.awb")
				end

				arg_783_1:RecordContent(arg_783_1.text_.text)
			end

			local var_786_10 = math.max(var_786_3, arg_783_1.talkMaxDuration)

			if var_786_2 <= arg_783_1.time_ and arg_783_1.time_ < var_786_2 + var_786_10 then
				arg_783_1.typewritter.percent = (arg_783_1.time_ - var_786_2) / var_786_10

				arg_783_1.typewritter:SetDirty()
			end

			if arg_783_1.time_ >= var_786_2 + var_786_10 and arg_783_1.time_ < var_786_2 + var_786_10 + arg_786_0 then
				arg_783_1.typewritter.percent = 1

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(true)
			end
		end

		arg_783_1.nodeConfigList_ = {}

		arg_783_1:InitPlayNodeList()
	end,
	Play120411193 = function(arg_787_0, arg_787_1)
		arg_787_1.time_ = 0
		arg_787_1.frameCnt_ = 0
		arg_787_1.state_ = "playing"
		arg_787_1.curTalkId_ = 120411193
		arg_787_1.duration_ = 8.6

		local var_787_0 = {
			zh = 6.066,
			ja = 8.6
		}
		local var_787_1 = manager.audio:GetLocalizationFlag()

		if var_787_0[var_787_1] ~= nil then
			arg_787_1.duration_ = var_787_0[var_787_1]
		end

		SetActive(arg_787_1.tipsGo_, false)

		function arg_787_1.onSingleLineFinish_()
			arg_787_1.onSingleLineUpdate_ = nil
			arg_787_1.onSingleLineFinish_ = nil
			arg_787_1.state_ = "waiting"
		end

		function arg_787_1.playNext_(arg_789_0)
			if arg_789_0 == 1 then
				arg_787_0:Play120411194(arg_787_1)
			end
		end

		function arg_787_1.onSingleLineUpdate_(arg_790_0)
			if 0 < arg_787_1.time_ and arg_787_1.time_ <= 0 + arg_790_0 then
				arg_787_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_2")
			end

			if 0 < arg_787_1.time_ and arg_787_1.time_ <= 0 + arg_790_0 then
				arg_787_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_790_0 = 0
			local var_790_1 = 0.675

			if 0 < arg_787_1.time_ and arg_787_1.time_ <= var_790_0 + arg_790_0 then
				arg_787_1.talkMaxDuration = 0
				arg_787_1.dialogCg_.alpha = 1

				arg_787_1.dialog_:SetActive(true)
				SetActive(arg_787_1.leftNameGo_, true)

				arg_787_1.leftNameTxt_.text = arg_787_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_787_1.leftNameTxt_.transform)

				arg_787_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_787_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_787_1:RecordName(arg_787_1.leftNameTxt_.text)
				SetActive(arg_787_1.iconTrs_.gameObject, false)
				arg_787_1.callingController_:SetSelectedState("normal")

				local var_790_2 = arg_787_1:GetWordFromCfg(120411193)
				local var_790_3 = arg_787_1:FormatText(var_790_2.content)

				arg_787_1.text_.text = var_790_3

				LuaForUtil.ClearLinePrefixSymbol(arg_787_1.text_)

				local var_790_5 = 27 <= 0 and var_790_1 or var_790_1 * (utf8.len(var_790_3) / 27)

				if (27 <= 0 and var_790_1 or var_790_1 * (utf8.len(var_790_3) / 27)) > 0 and var_790_1 < var_790_5 then
					arg_787_1.talkMaxDuration = var_790_5

					if var_790_5 + var_790_0 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_5 + var_790_0
					end
				end

				arg_787_1.text_.text = var_790_3
				arg_787_1.typewritter.percent = 0

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411193", "story_v_out_120411.awb") ~= 0 then
					local var_790_6 = manager.audio:GetVoiceLength("story_v_out_120411", "120411193", "story_v_out_120411.awb") / 1000

					if var_790_6 + var_790_0 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_6 + var_790_0
					end

					if var_790_2.prefab_name ~= "" and arg_787_1.actors_[var_790_2.prefab_name] ~= nil then
						local var_790_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_787_1.actors_[var_790_2.prefab_name].transform, "story_v_out_120411", "120411193", "story_v_out_120411.awb")

						arg_787_1:RecordAudio("120411193", var_790_7)
						arg_787_1:RecordAudio("120411193", var_790_7)
					else
						arg_787_1:AudioAction("play", "voice", "story_v_out_120411", "120411193", "story_v_out_120411.awb")
					end

					arg_787_1:RecordHistoryTalkVoice("story_v_out_120411", "120411193", "story_v_out_120411.awb")
				end

				arg_787_1:RecordContent(arg_787_1.text_.text)
			end

			local var_790_8 = math.max(var_790_1, arg_787_1.talkMaxDuration)

			if var_790_0 <= arg_787_1.time_ and arg_787_1.time_ < var_790_0 + var_790_8 then
				arg_787_1.typewritter.percent = (arg_787_1.time_ - var_790_0) / var_790_8

				arg_787_1.typewritter:SetDirty()
			end

			if arg_787_1.time_ >= var_790_0 + var_790_8 and arg_787_1.time_ < var_790_0 + var_790_8 + arg_790_0 then
				arg_787_1.typewritter.percent = 1

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(true)
			end
		end

		arg_787_1.nodeConfigList_ = {}

		arg_787_1:InitPlayNodeList()
	end,
	Play120411194 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 120411194
		arg_791_1.duration_ = 6.3

		local var_791_0 = {
			zh = 3.866,
			ja = 6.3
		}
		local var_791_1 = manager.audio:GetLocalizationFlag()

		if var_791_0[var_791_1] ~= nil then
			arg_791_1.duration_ = var_791_0[var_791_1]
		end

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play120411195(arg_791_1)
			end
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			if 0 < arg_791_1.time_ and arg_791_1.time_ <= 0 + arg_794_0 and not isNil(arg_791_1.actors_["1076ui_story"]) and arg_791_1.var_.characterEffect1076ui_story == nil then
				arg_791_1.var_.characterEffect1076ui_story = arg_791_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_794_0 = 0.2

			if 0 <= arg_791_1.time_ and arg_791_1.time_ < 0 + var_794_0 and not isNil(arg_791_1.actors_["1076ui_story"]) then
				if arg_791_1.var_.characterEffect1076ui_story and not isNil(arg_791_1.actors_["1076ui_story"]) then
					arg_791_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_791_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_791_1.time_ - 0) / var_794_0)
				end
			end

			if arg_791_1.time_ >= 0 + var_794_0 and arg_791_1.time_ < 0 + var_794_0 + arg_794_0 and not isNil(arg_791_1.actors_["1076ui_story"]) and arg_791_1.var_.characterEffect1076ui_story then
				arg_791_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_791_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_794_1 = arg_791_1.actors_["1072ui_story"]

			if 0 < arg_791_1.time_ and arg_791_1.time_ <= 0 + arg_794_0 and not isNil(var_794_1) and arg_791_1.var_.characterEffect1072ui_story == nil then
				arg_791_1.var_.characterEffect1072ui_story = var_794_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_794_2 = 0.2

			if 0 <= arg_791_1.time_ and arg_791_1.time_ < 0 + var_794_2 and not isNil(var_794_1) then
				if arg_791_1.var_.characterEffect1072ui_story and not isNil(var_794_1) then
					arg_791_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_791_1.time_ >= 0 + var_794_2 and arg_791_1.time_ < 0 + var_794_2 + arg_794_0 and not isNil(var_794_1) and arg_791_1.var_.characterEffect1072ui_story then
				arg_791_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_794_4 = 0
			local var_794_5 = 0.375

			if 0 < arg_791_1.time_ and arg_791_1.time_ <= var_794_4 + arg_794_0 then
				arg_791_1.talkMaxDuration = 0
				arg_791_1.dialogCg_.alpha = 1

				arg_791_1.dialog_:SetActive(true)
				SetActive(arg_791_1.leftNameGo_, true)

				arg_791_1.leftNameTxt_.text = arg_791_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_791_1.leftNameTxt_.transform)

				arg_791_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_791_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_791_1:RecordName(arg_791_1.leftNameTxt_.text)
				SetActive(arg_791_1.iconTrs_.gameObject, false)
				arg_791_1.callingController_:SetSelectedState("normal")

				local var_794_6 = arg_791_1:GetWordFromCfg(120411194)
				local var_794_7 = arg_791_1:FormatText(var_794_6.content)

				arg_791_1.text_.text = var_794_7

				LuaForUtil.ClearLinePrefixSymbol(arg_791_1.text_)

				local var_794_9 = 15 <= 0 and var_794_5 or var_794_5 * (utf8.len(var_794_7) / 15)

				if (15 <= 0 and var_794_5 or var_794_5 * (utf8.len(var_794_7) / 15)) > 0 and var_794_5 < var_794_9 then
					arg_791_1.talkMaxDuration = var_794_9

					if var_794_9 + var_794_4 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_9 + var_794_4
					end
				end

				arg_791_1.text_.text = var_794_7
				arg_791_1.typewritter.percent = 0

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411194", "story_v_out_120411.awb") ~= 0 then
					local var_794_10 = manager.audio:GetVoiceLength("story_v_out_120411", "120411194", "story_v_out_120411.awb") / 1000

					if var_794_10 + var_794_4 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_10 + var_794_4
					end

					if var_794_6.prefab_name ~= "" and arg_791_1.actors_[var_794_6.prefab_name] ~= nil then
						local var_794_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_791_1.actors_[var_794_6.prefab_name].transform, "story_v_out_120411", "120411194", "story_v_out_120411.awb")

						arg_791_1:RecordAudio("120411194", var_794_11)
						arg_791_1:RecordAudio("120411194", var_794_11)
					else
						arg_791_1:AudioAction("play", "voice", "story_v_out_120411", "120411194", "story_v_out_120411.awb")
					end

					arg_791_1:RecordHistoryTalkVoice("story_v_out_120411", "120411194", "story_v_out_120411.awb")
				end

				arg_791_1:RecordContent(arg_791_1.text_.text)
			end

			local var_794_12 = math.max(var_794_5, arg_791_1.talkMaxDuration)

			if var_794_4 <= arg_791_1.time_ and arg_791_1.time_ < var_794_4 + var_794_12 then
				arg_791_1.typewritter.percent = (arg_791_1.time_ - var_794_4) / var_794_12

				arg_791_1.typewritter:SetDirty()
			end

			if arg_791_1.time_ >= var_794_4 + var_794_12 and arg_791_1.time_ < var_794_4 + var_794_12 + arg_794_0 then
				arg_791_1.typewritter.percent = 1

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(true)
			end
		end

		arg_791_1.nodeConfigList_ = {}

		arg_791_1:InitPlayNodeList()
	end,
	Play120411195 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 120411195
		arg_795_1.duration_ = 11.9

		local var_795_0 = {
			zh = 5.933,
			ja = 11.9
		}
		local var_795_1 = manager.audio:GetLocalizationFlag()

		if var_795_0[var_795_1] ~= nil then
			arg_795_1.duration_ = var_795_0[var_795_1]
		end

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play120411196(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = 0.825

			if 0 < arg_795_1.time_ and arg_795_1.time_ <= 0 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, true)

				arg_795_1.leftNameTxt_.text = arg_795_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_795_1.leftNameTxt_.transform)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1.leftNameTxt_.text)
				SetActive(arg_795_1.iconTrs_.gameObject, false)
				arg_795_1.callingController_:SetSelectedState("normal")

				local var_798_1 = arg_795_1:GetWordFromCfg(120411195)
				local var_798_2 = arg_795_1:FormatText(var_798_1.content)

				arg_795_1.text_.text = var_798_2

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_4 = 34 <= 0 and var_798_0 or var_798_0 * (utf8.len(var_798_2) / 34)

				if (34 <= 0 and var_798_0 or var_798_0 * (utf8.len(var_798_2) / 34)) > 0 and var_798_0 < var_798_4 then
					arg_795_1.talkMaxDuration = var_798_4

					if var_798_4 + 0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_4 + 0
					end
				end

				arg_795_1.text_.text = var_798_2
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411195", "story_v_out_120411.awb") ~= 0 then
					local var_798_5 = manager.audio:GetVoiceLength("story_v_out_120411", "120411195", "story_v_out_120411.awb") / 1000

					if var_798_5 + 0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_5 + 0
					end

					if var_798_1.prefab_name ~= "" and arg_795_1.actors_[var_798_1.prefab_name] ~= nil then
						local var_798_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_795_1.actors_[var_798_1.prefab_name].transform, "story_v_out_120411", "120411195", "story_v_out_120411.awb")

						arg_795_1:RecordAudio("120411195", var_798_6)
						arg_795_1:RecordAudio("120411195", var_798_6)
					else
						arg_795_1:AudioAction("play", "voice", "story_v_out_120411", "120411195", "story_v_out_120411.awb")
					end

					arg_795_1:RecordHistoryTalkVoice("story_v_out_120411", "120411195", "story_v_out_120411.awb")
				end

				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_7 = math.max(var_798_0, arg_795_1.talkMaxDuration)

			if 0 <= arg_795_1.time_ and arg_795_1.time_ < 0 + var_798_7 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - 0) / var_798_7

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= 0 + var_798_7 and arg_795_1.time_ < 0 + var_798_7 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {}

		arg_795_1:InitPlayNodeList()
	end,
	Play120411196 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 120411196
		arg_799_1.duration_ = 5

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play120411197(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			if 0 < arg_799_1.time_ and arg_799_1.time_ <= 0 + arg_802_0 and not isNil(arg_799_1.actors_["1072ui_story"]) and arg_799_1.var_.characterEffect1072ui_story == nil then
				arg_799_1.var_.characterEffect1072ui_story = arg_799_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_802_0 = 0.2

			if 0 <= arg_799_1.time_ and arg_799_1.time_ < 0 + var_802_0 and not isNil(arg_799_1.actors_["1072ui_story"]) then
				if arg_799_1.var_.characterEffect1072ui_story and not isNil(arg_799_1.actors_["1072ui_story"]) then
					arg_799_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_799_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_799_1.time_ - 0) / var_802_0)
				end
			end

			if arg_799_1.time_ >= 0 + var_802_0 and arg_799_1.time_ < 0 + var_802_0 + arg_802_0 and not isNil(arg_799_1.actors_["1072ui_story"]) and arg_799_1.var_.characterEffect1072ui_story then
				arg_799_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_799_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_802_1 = 0
			local var_802_2 = 1.375

			if 0 < arg_799_1.time_ and arg_799_1.time_ <= var_802_1 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, false)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_799_1.iconTrs_.gameObject, false)
				arg_799_1.callingController_:SetSelectedState("normal")

				local var_802_3 = arg_799_1:FormatText(arg_799_1:GetWordFromCfg(120411196).content)

				arg_799_1.text_.text = var_802_3

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_5 = 55 <= 0 and var_802_2 or var_802_2 * (utf8.len(var_802_3) / 55)

				if (55 <= 0 and var_802_2 or var_802_2 * (utf8.len(var_802_3) / 55)) > 0 and var_802_2 < var_802_5 then
					arg_799_1.talkMaxDuration = var_802_5

					if var_802_5 + var_802_1 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_5 + var_802_1
					end
				end

				arg_799_1.text_.text = var_802_3
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)
				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_6 = math.max(var_802_2, arg_799_1.talkMaxDuration)

			if var_802_1 <= arg_799_1.time_ and arg_799_1.time_ < var_802_1 + var_802_6 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_1) / var_802_6

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_1 + var_802_6 and arg_799_1.time_ < var_802_1 + var_802_6 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {}

		arg_799_1:InitPlayNodeList()
	end,
	Play120411197 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 120411197
		arg_803_1.duration_ = 5

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play120411198(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			local var_806_0 = 0.6

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0
				arg_803_1.dialogCg_.alpha = 1

				arg_803_1.dialog_:SetActive(true)
				SetActive(arg_803_1.leftNameGo_, true)

				arg_803_1.leftNameTxt_.text = arg_803_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_803_1.leftNameTxt_.transform)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1.leftNameTxt_.text)
				SetActive(arg_803_1.iconTrs_.gameObject, true)
				arg_803_1.iconController_:SetSelectedState("hero")

				arg_803_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_803_1.callingController_:SetSelectedState("normal")

				arg_803_1.keyicon_.color = Color.New(1, 1, 1)
				arg_803_1.icon_.color = Color.New(1, 1, 1)

				local var_806_1 = arg_803_1:FormatText(arg_803_1:GetWordFromCfg(120411197).content)

				arg_803_1.text_.text = var_806_1

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_3 = 24 <= 0 and var_806_0 or var_806_0 * (utf8.len(var_806_1) / 24)

				if (24 <= 0 and var_806_0 or var_806_0 * (utf8.len(var_806_1) / 24)) > 0 and var_806_0 < var_806_3 then
					arg_803_1.talkMaxDuration = var_806_3

					if var_806_3 + 0 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_3 + 0
					end
				end

				arg_803_1.text_.text = var_806_1
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)
				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_4 = math.max(var_806_0, arg_803_1.talkMaxDuration)

			if 0 <= arg_803_1.time_ and arg_803_1.time_ < 0 + var_806_4 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - 0) / var_806_4

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= 0 + var_806_4 and arg_803_1.time_ < 0 + var_806_4 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {}

		arg_803_1:InitPlayNodeList()
	end,
	Play120411198 = function(arg_807_0, arg_807_1)
		arg_807_1.time_ = 0
		arg_807_1.frameCnt_ = 0
		arg_807_1.state_ = "playing"
		arg_807_1.curTalkId_ = 120411198
		arg_807_1.duration_ = 5.43

		local var_807_0 = {
			zh = 2.466,
			ja = 5.433
		}
		local var_807_1 = manager.audio:GetLocalizationFlag()

		if var_807_0[var_807_1] ~= nil then
			arg_807_1.duration_ = var_807_0[var_807_1]
		end

		SetActive(arg_807_1.tipsGo_, false)

		function arg_807_1.onSingleLineFinish_()
			arg_807_1.onSingleLineUpdate_ = nil
			arg_807_1.onSingleLineFinish_ = nil
			arg_807_1.state_ = "waiting"
		end

		function arg_807_1.playNext_(arg_809_0)
			if arg_809_0 == 1 then
				arg_807_0:Play120411199(arg_807_1)
			end
		end

		function arg_807_1.onSingleLineUpdate_(arg_810_0)
			if 0 < arg_807_1.time_ and arg_807_1.time_ <= 0 + arg_810_0 and not isNil(arg_807_1.actors_["1072ui_story"]) and arg_807_1.var_.characterEffect1072ui_story == nil then
				arg_807_1.var_.characterEffect1072ui_story = arg_807_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_810_0 = 0.2

			if 0 <= arg_807_1.time_ and arg_807_1.time_ < 0 + var_810_0 and not isNil(arg_807_1.actors_["1072ui_story"]) then
				if arg_807_1.var_.characterEffect1072ui_story and not isNil(arg_807_1.actors_["1072ui_story"]) then
					arg_807_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_807_1.time_ >= 0 + var_810_0 and arg_807_1.time_ < 0 + var_810_0 + arg_810_0 and not isNil(arg_807_1.actors_["1072ui_story"]) and arg_807_1.var_.characterEffect1072ui_story then
				arg_807_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_807_1.time_ and arg_807_1.time_ <= 0 + arg_810_0 then
				arg_807_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			local var_810_2 = 0
			local var_810_3 = 0.275

			if 0 < arg_807_1.time_ and arg_807_1.time_ <= var_810_2 + arg_810_0 then
				arg_807_1.talkMaxDuration = 0
				arg_807_1.dialogCg_.alpha = 1

				arg_807_1.dialog_:SetActive(true)
				SetActive(arg_807_1.leftNameGo_, true)

				arg_807_1.leftNameTxt_.text = arg_807_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_807_1.leftNameTxt_.transform)

				arg_807_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_807_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_807_1:RecordName(arg_807_1.leftNameTxt_.text)
				SetActive(arg_807_1.iconTrs_.gameObject, false)
				arg_807_1.callingController_:SetSelectedState("normal")

				local var_810_4 = arg_807_1:GetWordFromCfg(120411198)
				local var_810_5 = arg_807_1:FormatText(var_810_4.content)

				arg_807_1.text_.text = var_810_5

				LuaForUtil.ClearLinePrefixSymbol(arg_807_1.text_)

				local var_810_7 = 11 <= 0 and var_810_3 or var_810_3 * (utf8.len(var_810_5) / 11)

				if (11 <= 0 and var_810_3 or var_810_3 * (utf8.len(var_810_5) / 11)) > 0 and var_810_3 < var_810_7 then
					arg_807_1.talkMaxDuration = var_810_7

					if var_810_7 + var_810_2 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_7 + var_810_2
					end
				end

				arg_807_1.text_.text = var_810_5
				arg_807_1.typewritter.percent = 0

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120411", "120411198", "story_v_out_120411.awb") ~= 0 then
					local var_810_8 = manager.audio:GetVoiceLength("story_v_out_120411", "120411198", "story_v_out_120411.awb") / 1000

					if var_810_8 + var_810_2 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_8 + var_810_2
					end

					if var_810_4.prefab_name ~= "" and arg_807_1.actors_[var_810_4.prefab_name] ~= nil then
						local var_810_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_807_1.actors_[var_810_4.prefab_name].transform, "story_v_out_120411", "120411198", "story_v_out_120411.awb")

						arg_807_1:RecordAudio("120411198", var_810_9)
						arg_807_1:RecordAudio("120411198", var_810_9)
					else
						arg_807_1:AudioAction("play", "voice", "story_v_out_120411", "120411198", "story_v_out_120411.awb")
					end

					arg_807_1:RecordHistoryTalkVoice("story_v_out_120411", "120411198", "story_v_out_120411.awb")
				end

				arg_807_1:RecordContent(arg_807_1.text_.text)
			end

			local var_810_10 = math.max(var_810_3, arg_807_1.talkMaxDuration)

			if var_810_2 <= arg_807_1.time_ and arg_807_1.time_ < var_810_2 + var_810_10 then
				arg_807_1.typewritter.percent = (arg_807_1.time_ - var_810_2) / var_810_10

				arg_807_1.typewritter:SetDirty()
			end

			if arg_807_1.time_ >= var_810_2 + var_810_10 and arg_807_1.time_ < var_810_2 + var_810_10 + arg_810_0 then
				arg_807_1.typewritter.percent = 1

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(true)
			end
		end

		arg_807_1.nodeConfigList_ = {}

		arg_807_1:InitPlayNodeList()
	end,
	Play120411199 = function(arg_811_0, arg_811_1)
		arg_811_1.time_ = 0
		arg_811_1.frameCnt_ = 0
		arg_811_1.state_ = "playing"
		arg_811_1.curTalkId_ = 120411199
		arg_811_1.duration_ = 5

		SetActive(arg_811_1.tipsGo_, false)

		function arg_811_1.onSingleLineFinish_()
			arg_811_1.onSingleLineUpdate_ = nil
			arg_811_1.onSingleLineFinish_ = nil
			arg_811_1.state_ = "waiting"
			arg_811_1.auto_ = false
		end

		function arg_811_1.playNext_(arg_813_0)
			arg_811_1.onStoryFinished_()
		end

		function arg_811_1.onSingleLineUpdate_(arg_814_0)
			if 0 < arg_811_1.time_ and arg_811_1.time_ <= 0 + arg_814_0 then
				arg_811_1.var_.moveOldPos1072ui_story = arg_811_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_814_0 = 0.001

			if 0 <= arg_811_1.time_ and arg_811_1.time_ < 0 + var_814_0 then
				arg_811_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_811_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_811_1.time_ - 0) / var_814_0)
				arg_811_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_811_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["1072ui_story"].transform.position).z)
				arg_811_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_811_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_811_1.actors_["1072ui_story"].transform.localEulerAngles = arg_811_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_811_1.time_ >= 0 + var_814_0 and arg_811_1.time_ < 0 + var_814_0 + arg_814_0 then
				arg_811_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_811_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_811_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["1072ui_story"].transform.position).z)
				arg_811_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_811_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_811_1.actors_["1072ui_story"].transform.localEulerAngles = arg_811_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_814_1 = arg_811_1.actors_["1076ui_story"].transform

			if 0 < arg_811_1.time_ and arg_811_1.time_ <= 0 + arg_814_0 then
				arg_811_1.var_.moveOldPos1076ui_story = var_814_1.localPosition
			end

			local var_814_2 = 0.001

			if 0 <= arg_811_1.time_ and arg_811_1.time_ < 0 + var_814_2 then
				var_814_1.localPosition = Vector3.Lerp(arg_811_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_811_1.time_ - 0) / var_814_2)
				var_814_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_814_1.position).x, (manager.ui.mainCamera.transform.position - var_814_1.position).y, (manager.ui.mainCamera.transform.position - var_814_1.position).z)
				var_814_1.localEulerAngles.z = 0
				var_814_1.localEulerAngles.x = 0
				var_814_1.localEulerAngles = var_814_1.localEulerAngles
			end

			if arg_811_1.time_ >= 0 + var_814_2 and arg_811_1.time_ < 0 + var_814_2 + arg_814_0 then
				var_814_1.localPosition = Vector3.New(0, 100, 0)
				var_814_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_814_1.position).x, (manager.ui.mainCamera.transform.position - var_814_1.position).y, (manager.ui.mainCamera.transform.position - var_814_1.position).z)
				var_814_1.localEulerAngles.z = 0
				var_814_1.localEulerAngles.x = 0
				var_814_1.localEulerAngles = var_814_1.localEulerAngles
			end

			local var_814_3 = 0
			local var_814_4 = 0.575

			if 0 < arg_811_1.time_ and arg_811_1.time_ <= var_814_3 + arg_814_0 then
				arg_811_1.talkMaxDuration = 0
				arg_811_1.dialogCg_.alpha = 1

				arg_811_1.dialog_:SetActive(true)
				SetActive(arg_811_1.leftNameGo_, false)

				arg_811_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_811_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_811_1:RecordName(arg_811_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_811_1.iconTrs_.gameObject, false)
				arg_811_1.callingController_:SetSelectedState("normal")

				local var_814_5 = arg_811_1:FormatText(arg_811_1:GetWordFromCfg(120411199).content)

				arg_811_1.text_.text = var_814_5

				LuaForUtil.ClearLinePrefixSymbol(arg_811_1.text_)

				local var_814_7 = 23 <= 0 and var_814_4 or var_814_4 * (utf8.len(var_814_5) / 23)

				if (23 <= 0 and var_814_4 or var_814_4 * (utf8.len(var_814_5) / 23)) > 0 and var_814_4 < var_814_7 then
					arg_811_1.talkMaxDuration = var_814_7

					if var_814_7 + var_814_3 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_7 + var_814_3
					end
				end

				arg_811_1.text_.text = var_814_5
				arg_811_1.typewritter.percent = 0

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(false)
				arg_811_1:RecordContent(arg_811_1.text_.text)
			end

			local var_814_8 = math.max(var_814_4, arg_811_1.talkMaxDuration)

			if var_814_3 <= arg_811_1.time_ and arg_811_1.time_ < var_814_3 + var_814_8 then
				arg_811_1.typewritter.percent = (arg_811_1.time_ - var_814_3) / var_814_8

				arg_811_1.typewritter:SetDirty()
			end

			if arg_811_1.time_ >= var_814_3 + var_814_8 and arg_811_1.time_ < var_814_3 + var_814_8 + arg_814_0 then
				arg_811_1.typewritter.percent = 1

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(true)
			end
		end

		arg_811_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_811_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/J05f",
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/XH0203"
	},
	voices = {
		"story_v_out_120411.awb"
	}
}
