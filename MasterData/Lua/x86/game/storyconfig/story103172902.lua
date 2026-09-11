return {
	Play317292001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317292001
		arg_1_1.duration_ = 5.43

		local var_1_0 = {
			zh = 5.433,
			ja = 4.766
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
				arg_1_0:Play317292002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K12f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K12f")
				var_4_0.name = "K12f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K12f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K12f

				arg_1_1.bgs_.K12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K12f" then
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

			local var_4_8 = "1199ui_story"

			if arg_1_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1199ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1199ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.08, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1199ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1199ui_story == nil then
				arg_1_1.var_.characterEffect1199ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1199ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1199ui_story then
				arg_1_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.733333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.733333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet")

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
			local var_4_24 = 0.475

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(317292001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)

				if (19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292001", "story_v_out_317292.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_317292", "317292001", "story_v_out_317292.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_317292", "317292001", "story_v_out_317292.awb")

						arg_1_1:RecordAudio("317292001", var_4_31)
						arg_1_1:RecordAudio("317292001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_317292", "317292001", "story_v_out_317292.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_317292", "317292001", "story_v_out_317292.awb")
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
				actorName = "1199ui_story",
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
	Play317292002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317292002
		arg_9_1.duration_ = 5.9

		local var_9_0 = {
			zh = 4.166,
			ja = 5.9
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
				arg_9_0:Play317292003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1158ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1158ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1158ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1158ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1158ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1158ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1158ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1158ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1158ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1158ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.95, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1158ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1158ui_story == nil then
				arg_9_1.var_.characterEffect1158ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1158ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1158ui_story then
				arg_9_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action5_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["1199ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1199ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_9)
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

			local var_12_10 = arg_9_1.actors_["1199ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1199ui_story == nil then
				arg_9_1.var_.characterEffect1199ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect1199ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1199ui_story then
				arg_9_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(317292002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 25 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 25)

				if (25 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 25)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292002", "story_v_out_317292.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_317292", "317292002", "story_v_out_317292.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_317292", "317292002", "story_v_out_317292.awb")

						arg_9_1:RecordAudio("317292002", var_12_19)
						arg_9_1:RecordAudio("317292002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317292", "317292002", "story_v_out_317292.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317292", "317292002", "story_v_out_317292.awb")
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
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_9_1:InitPlayNodeList()
	end,
	Play317292003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317292003
		arg_13_1.duration_ = 3.17

		local var_13_0 = {
			zh = 2.4,
			ja = 3.166
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
				arg_13_0:Play317292004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(317292003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 14 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 14)

				if (14 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 14)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292003", "story_v_out_317292.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292003", "story_v_out_317292.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_317292", "317292003", "story_v_out_317292.awb")

						arg_13_1:RecordAudio("317292003", var_16_6)
						arg_13_1:RecordAudio("317292003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317292", "317292003", "story_v_out_317292.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317292", "317292003", "story_v_out_317292.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play317292004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317292004
		arg_17_1.duration_ = 9

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317292005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.bgs_.ST58 == nil then
				local var_20_0 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST58")
				var_20_0.name = "ST58"
				var_20_0.transform.parent = arg_17_1.stage_.transform
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_.ST58 = var_20_0
			end

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= 2 + arg_20_0 then
				local var_20_1 = arg_17_1.bgs_.ST58

				arg_17_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_2 = var_20_1:GetComponent("SpriteRenderer")

				if var_20_2 and var_20_2.sprite then
					local var_20_3 = 2 * (var_20_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_1.transform.localScale = Vector3.New(var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "ST58" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_4 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_5 = 2

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_5 then
				local var_20_6 = Color.New(0, 0, 0)

				var_20_6.a = Mathf.Lerp(0, 1, (arg_17_1.time_ - var_20_4) / var_20_5)
				arg_17_1.mask_.color = var_20_6
			end

			if arg_17_1.time_ >= var_20_4 + var_20_5 and arg_17_1.time_ < var_20_4 + var_20_5 + arg_20_0 then
				local var_20_7 = Color.New(0, 0, 0)

				var_20_7.a = 1
				arg_17_1.mask_.color = var_20_7
			end

			local var_20_8 = 2

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_9 = 2

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 then
				local var_20_10 = Color.New(0, 0, 0)

				var_20_10.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_8) / var_20_9)
				arg_17_1.mask_.color = var_20_10
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 then
				local var_20_11 = Color.New(0, 0, 0)

				arg_17_1.mask_.enabled = false
				var_20_11.a = 0
				arg_17_1.mask_.color = var_20_11
			end

			local var_20_12 = arg_17_1.actors_["1158ui_story"].transform

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= 2 + arg_20_0 then
				arg_17_1.var_.moveOldPos1158ui_story = var_20_12.localPosition
			end

			local var_20_13 = 0.001

			if 2 <= arg_17_1.time_ and arg_17_1.time_ < 2 + var_20_13 then
				var_20_12.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 2) / var_20_13)
				var_20_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_12.position).x, (manager.ui.mainCamera.transform.position - var_20_12.position).y, (manager.ui.mainCamera.transform.position - var_20_12.position).z)
				var_20_12.localEulerAngles.z = 0
				var_20_12.localEulerAngles.x = 0
				var_20_12.localEulerAngles = var_20_12.localEulerAngles
			end

			if arg_17_1.time_ >= 2 + var_20_13 and arg_17_1.time_ < 2 + var_20_13 + arg_20_0 then
				var_20_12.localPosition = Vector3.New(0, 100, 0)
				var_20_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_12.position).x, (manager.ui.mainCamera.transform.position - var_20_12.position).y, (manager.ui.mainCamera.transform.position - var_20_12.position).z)
				var_20_12.localEulerAngles.z = 0
				var_20_12.localEulerAngles.x = 0
				var_20_12.localEulerAngles = var_20_12.localEulerAngles
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_14 = 4
			local var_20_15 = 0.9

			if 4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_16 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_16:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(317292004).content)

				arg_17_1.text_.text = var_20_17

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 36 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 36)

				if (36 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 36)) > 0 and var_20_15 < var_20_19 then
					arg_17_1.talkMaxDuration = var_20_19
					var_20_14 = var_20_14 + 0.3

					if var_20_19 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_17
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = var_20_14 + 0.3
			local var_20_21 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_21 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_21

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_21 and arg_17_1.time_ < var_20_20 + var_20_21 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play317292005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 317292005
		arg_23_1.duration_ = 5.3

		local var_23_0 = {
			zh = 1.7,
			ja = 5.3
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play317292006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1015ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1015ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1015ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1015ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1015ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1015ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1015ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1015ui_story == nil then
				arg_23_1.var_.characterEffect1015ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1015ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1015ui_story then
				arg_23_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_8 = 0
			local var_26_9 = 0.2

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(317292005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 8 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 8)

				if (8 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 8)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292005", "story_v_out_317292.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292005", "story_v_out_317292.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_317292", "317292005", "story_v_out_317292.awb")

						arg_23_1:RecordAudio("317292005", var_26_15)
						arg_23_1:RecordAudio("317292005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_317292", "317292005", "story_v_out_317292.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_317292", "317292005", "story_v_out_317292.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play317292006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 317292006
		arg_27_1.duration_ = 9.03

		local var_27_0 = {
			zh = 4.933,
			ja = 9.033
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
				arg_27_0:Play317292007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "10053ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["10053ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["10053ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["10053ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["10053ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10053ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0.7, -1.12, -5.99)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = arg_27_1.actors_["10053ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect10053ui_story == nil then
				arg_27_1.var_.characterEffect10053ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect10053ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect10053ui_story then
				arg_27_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_8 = arg_27_1.actors_["1015ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect1015ui_story == nil then
				arg_27_1.var_.characterEffect1015ui_story = var_30_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_9 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_9 and not isNil(var_30_8) then
				if arg_27_1.var_.characterEffect1015ui_story and not isNil(var_30_8) then
					arg_27_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_9)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_9 and arg_27_1.time_ < 0 + var_30_9 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect1015ui_story then
				arg_27_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_30_10 = 0
			local var_30_11 = 0.525

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_12 = arg_27_1:GetWordFromCfg(317292006)
				local var_30_13 = arg_27_1:FormatText(var_30_12.content)

				arg_27_1.text_.text = var_30_13

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 21 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 21)

				if (21 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 21)) > 0 and var_30_11 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_13
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292006", "story_v_out_317292.awb") ~= 0 then
					local var_30_16 = manager.audio:GetVoiceLength("story_v_out_317292", "317292006", "story_v_out_317292.awb") / 1000

					if var_30_16 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_16 + var_30_10
					end

					if var_30_12.prefab_name ~= "" and arg_27_1.actors_[var_30_12.prefab_name] ~= nil then
						local var_30_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_12.prefab_name].transform, "story_v_out_317292", "317292006", "story_v_out_317292.awb")

						arg_27_1:RecordAudio("317292006", var_30_17)
						arg_27_1:RecordAudio("317292006", var_30_17)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_317292", "317292006", "story_v_out_317292.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_317292", "317292006", "story_v_out_317292.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = math.max(var_30_11, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_18 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_18

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_18 and arg_27_1.time_ < var_30_10 + var_30_18 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play317292007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 317292007
		arg_31_1.duration_ = 10.9

		local var_31_0 = {
			zh = 5.166,
			ja = 10.9
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
				arg_31_0:Play317292008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1015ui_story = arg_31_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).z)
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles = arg_31_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_31_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).z)
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles = arg_31_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1015ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1015ui_story == nil then
				arg_31_1.var_.characterEffect1015ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1015ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1015ui_story then
				arg_31_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_4 = arg_31_1.actors_["10053ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect10053ui_story == nil then
				arg_31_1.var_.characterEffect10053ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_5 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 and not isNil(var_34_4) then
				if arg_31_1.var_.characterEffect10053ui_story and not isNil(var_34_4) then
					arg_31_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_31_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_5)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect10053ui_story then
				arg_31_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_31_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_34_6 = 0
			local var_34_7 = 0.55

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:GetWordFromCfg(317292007)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_11 = 21 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 21)

				if (21 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 21)) > 0 and var_34_7 < var_34_11 then
					arg_31_1.talkMaxDuration = var_34_11

					if var_34_11 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_11 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_9
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292007", "story_v_out_317292.awb") ~= 0 then
					local var_34_12 = manager.audio:GetVoiceLength("story_v_out_317292", "317292007", "story_v_out_317292.awb") / 1000

					if var_34_12 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_6
					end

					if var_34_8.prefab_name ~= "" and arg_31_1.actors_[var_34_8.prefab_name] ~= nil then
						local var_34_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_8.prefab_name].transform, "story_v_out_317292", "317292007", "story_v_out_317292.awb")

						arg_31_1:RecordAudio("317292007", var_34_13)
						arg_31_1:RecordAudio("317292007", var_34_13)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_317292", "317292007", "story_v_out_317292.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_317292", "317292007", "story_v_out_317292.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_14 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_14 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_14

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_14 and arg_31_1.time_ < var_34_6 + var_34_14 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play317292008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 317292008
		arg_35_1.duration_ = 6.67

		local var_35_0 = {
			zh = 6.666,
			ja = 4.966
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play317292009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10053ui_story = arg_35_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10053ui_story"].transform.position).z)
				arg_35_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10053ui_story"].transform.localEulerAngles = arg_35_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_35_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10053ui_story"].transform.position).z)
				arg_35_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10053ui_story"].transform.localEulerAngles = arg_35_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["10053ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10053ui_story == nil then
				arg_35_1.var_.characterEffect10053ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect10053ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10053ui_story then
				arg_35_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_4 = arg_35_1.actors_["1015ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1015ui_story == nil then
				arg_35_1.var_.characterEffect1015ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_5 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 and not isNil(var_38_4) then
				if arg_35_1.var_.characterEffect1015ui_story and not isNil(var_38_4) then
					arg_35_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_5)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1015ui_story then
				arg_35_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_38_6 = 0
			local var_38_7 = 0.65

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(317292008)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 26 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_9) / 26)

				if (26 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_9) / 26)) > 0 and var_38_7 < var_38_11 then
					arg_35_1.talkMaxDuration = var_38_11

					if var_38_11 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_11 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292008", "story_v_out_317292.awb") ~= 0 then
					local var_38_12 = manager.audio:GetVoiceLength("story_v_out_317292", "317292008", "story_v_out_317292.awb") / 1000

					if var_38_12 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_6
					end

					if var_38_8.prefab_name ~= "" and arg_35_1.actors_[var_38_8.prefab_name] ~= nil then
						local var_38_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_8.prefab_name].transform, "story_v_out_317292", "317292008", "story_v_out_317292.awb")

						arg_35_1:RecordAudio("317292008", var_38_13)
						arg_35_1:RecordAudio("317292008", var_38_13)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_317292", "317292008", "story_v_out_317292.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_317292", "317292008", "story_v_out_317292.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_14 and arg_35_1.time_ < var_38_6 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play317292009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 317292009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play317292010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["10053ui_story"]) and arg_39_1.var_.characterEffect10053ui_story == nil then
				arg_39_1.var_.characterEffect10053ui_story = arg_39_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["10053ui_story"]) then
				if arg_39_1.var_.characterEffect10053ui_story and not isNil(arg_39_1.actors_["10053ui_story"]) then
					arg_39_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["10053ui_story"]) and arg_39_1.var_.characterEffect10053ui_story then
				arg_39_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.925

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(317292009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 37 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 37)

				if (37 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 37)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play317292010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 317292010
		arg_43_1.duration_ = 5.17

		local var_43_0 = {
			zh = 4.6,
			ja = 5.166
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
				arg_43_0:Play317292011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10053ui_story = arg_43_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10053ui_story"].transform.position).z)
				arg_43_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10053ui_story"].transform.localEulerAngles = arg_43_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_43_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10053ui_story"].transform.position).z)
				arg_43_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10053ui_story"].transform.localEulerAngles = arg_43_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["10053ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10053ui_story == nil then
				arg_43_1.var_.characterEffect10053ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect10053ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10053ui_story then
				arg_43_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_2")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.325

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(317292010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 13 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 13)

				if (13 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 13)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292010", "story_v_out_317292.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292010", "story_v_out_317292.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_317292", "317292010", "story_v_out_317292.awb")

						arg_43_1:RecordAudio("317292010", var_46_11)
						arg_43_1:RecordAudio("317292010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_317292", "317292010", "story_v_out_317292.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_317292", "317292010", "story_v_out_317292.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play317292011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 317292011
		arg_47_1.duration_ = 5.9

		local var_47_0 = {
			zh = 1.999999999999,
			ja = 5.9
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
				arg_47_0:Play317292012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1015ui_story = arg_47_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).z)
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles = arg_47_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_47_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).z)
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles = arg_47_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1015ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1015ui_story == nil then
				arg_47_1.var_.characterEffect1015ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1015ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1015ui_story then
				arg_47_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_50_4 = arg_47_1.actors_["10053ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect10053ui_story == nil then
				arg_47_1.var_.characterEffect10053ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect10053ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect10053ui_story then
				arg_47_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_50_6 = 0
			local var_50_7 = 0.175

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(317292011)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 7 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 7)

				if (7 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 7)) > 0 and var_50_7 < var_50_11 then
					arg_47_1.talkMaxDuration = var_50_11

					if var_50_11 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292011", "story_v_out_317292.awb") ~= 0 then
					local var_50_12 = manager.audio:GetVoiceLength("story_v_out_317292", "317292011", "story_v_out_317292.awb") / 1000

					if var_50_12 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_6
					end

					if var_50_8.prefab_name ~= "" and arg_47_1.actors_[var_50_8.prefab_name] ~= nil then
						local var_50_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_8.prefab_name].transform, "story_v_out_317292", "317292011", "story_v_out_317292.awb")

						arg_47_1:RecordAudio("317292011", var_50_13)
						arg_47_1:RecordAudio("317292011", var_50_13)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_317292", "317292011", "story_v_out_317292.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_317292", "317292011", "story_v_out_317292.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_14 and arg_47_1.time_ < var_50_6 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play317292012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 317292012
		arg_51_1.duration_ = 6.07

		local var_51_0 = {
			zh = 6.066,
			ja = 5.8
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
				arg_51_0:Play317292013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1015ui_story = arg_51_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).z)
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles = arg_51_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).z)
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles = arg_51_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1015ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1015ui_story == nil then
				arg_51_1.var_.characterEffect1015ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1015ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_2)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1015ui_story then
				arg_51_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_54_3 = arg_51_1.actors_["10053ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10053ui_story = var_54_3.localPosition
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_4)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0, 100, 0)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			local var_54_5 = arg_51_1.actors_["10053ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect10053ui_story == nil then
				arg_51_1.var_.characterEffect10053ui_story = var_54_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.characterEffect10053ui_story and not isNil(var_54_5) then
					arg_51_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_6)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect10053ui_story then
				arg_51_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_54_7 = arg_51_1.actors_["1199ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1199ui_story = var_54_7.localPosition
			end

			local var_54_8 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_8 then
				var_54_7.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_51_1.time_ - 0) / var_54_8)
				var_54_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_7.position).x, (manager.ui.mainCamera.transform.position - var_54_7.position).y, (manager.ui.mainCamera.transform.position - var_54_7.position).z)
				var_54_7.localEulerAngles.z = 0
				var_54_7.localEulerAngles.x = 0
				var_54_7.localEulerAngles = var_54_7.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_8 and arg_51_1.time_ < 0 + var_54_8 + arg_54_0 then
				var_54_7.localPosition = Vector3.New(0, -1.08, -5.9)
				var_54_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_7.position).x, (manager.ui.mainCamera.transform.position - var_54_7.position).y, (manager.ui.mainCamera.transform.position - var_54_7.position).z)
				var_54_7.localEulerAngles.z = 0
				var_54_7.localEulerAngles.x = 0
				var_54_7.localEulerAngles = var_54_7.localEulerAngles
			end

			local var_54_9 = arg_51_1.actors_["1199ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1199ui_story == nil then
				arg_51_1.var_.characterEffect1199ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_10 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_10 and not isNil(var_54_9) then
				if arg_51_1.var_.characterEffect1199ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_10 and arg_51_1.time_ < 0 + var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1199ui_story then
				arg_51_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_12 = 0
			local var_54_13 = 0.65

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_14 = arg_51_1:GetWordFromCfg(317292012)
				local var_54_15 = arg_51_1:FormatText(var_54_14.content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_17 = 26 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 26)

				if (26 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 26)) > 0 and var_54_13 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17

					if var_54_17 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_12
					end
				end

				arg_51_1.text_.text = var_54_15
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292012", "story_v_out_317292.awb") ~= 0 then
					local var_54_18 = manager.audio:GetVoiceLength("story_v_out_317292", "317292012", "story_v_out_317292.awb") / 1000

					if var_54_18 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_12
					end

					if var_54_14.prefab_name ~= "" and arg_51_1.actors_[var_54_14.prefab_name] ~= nil then
						local var_54_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_14.prefab_name].transform, "story_v_out_317292", "317292012", "story_v_out_317292.awb")

						arg_51_1:RecordAudio("317292012", var_54_19)
						arg_51_1:RecordAudio("317292012", var_54_19)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_317292", "317292012", "story_v_out_317292.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_317292", "317292012", "story_v_out_317292.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_20 = math.max(var_54_13, arg_51_1.talkMaxDuration)

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_12) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_12 + var_54_20 and arg_51_1.time_ < var_54_12 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_51_1:InitPlayNodeList()
	end,
	Play317292013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 317292013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play317292014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1199ui_story"]) and arg_55_1.var_.characterEffect1199ui_story == nil then
				arg_55_1.var_.characterEffect1199ui_story = arg_55_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1199ui_story"]) then
				if arg_55_1.var_.characterEffect1199ui_story and not isNil(arg_55_1.actors_["1199ui_story"]) then
					arg_55_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1199ui_story"]) and arg_55_1.var_.characterEffect1199ui_story then
				arg_55_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.825

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(317292013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 33 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 33)

				if (33 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 33)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play317292014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 317292014
		arg_59_1.duration_ = 3.27

		local var_59_0 = {
			zh = 3.1,
			ja = 3.266
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
				arg_59_0:Play317292015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1199ui_story = arg_59_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).z)
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles = arg_59_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_59_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).z)
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles = arg_59_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1199ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1199ui_story == nil then
				arg_59_1.var_.characterEffect1199ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1199ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1199ui_story then
				arg_59_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.15

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(317292014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 6 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 6)

				if (6 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 6)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292014", "story_v_out_317292.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292014", "story_v_out_317292.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_317292", "317292014", "story_v_out_317292.awb")

						arg_59_1:RecordAudio("317292014", var_62_11)
						arg_59_1:RecordAudio("317292014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_317292", "317292014", "story_v_out_317292.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_317292", "317292014", "story_v_out_317292.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play317292015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 317292015
		arg_63_1.duration_ = 3.77

		local var_63_0 = {
			zh = 1.999999999999,
			ja = 3.766
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play317292016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1199ui_story = arg_63_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1199ui_story"].transform.position).z)
				arg_63_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1199ui_story"].transform.localEulerAngles = arg_63_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1199ui_story"].transform.position).z)
				arg_63_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1199ui_story"].transform.localEulerAngles = arg_63_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1199ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1199ui_story == nil then
				arg_63_1.var_.characterEffect1199ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1199ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_2)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1199ui_story then
				arg_63_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_66_3 = arg_63_1.actors_["1015ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1015ui_story = var_66_3.localPosition
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_3.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_63_1.time_ - 0) / var_66_4)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			local var_66_5 = arg_63_1.actors_["1015ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1015ui_story == nil then
				arg_63_1.var_.characterEffect1015ui_story = var_66_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 and not isNil(var_66_5) then
				if arg_63_1.var_.characterEffect1015ui_story and not isNil(var_66_5) then
					arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1015ui_story then
				arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_8 = 0
			local var_66_9 = 0.225

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(317292015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 9 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 9)

				if (9 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 9)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292015", "story_v_out_317292.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292015", "story_v_out_317292.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_317292", "317292015", "story_v_out_317292.awb")

						arg_63_1:RecordAudio("317292015", var_66_15)
						arg_63_1:RecordAudio("317292015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_317292", "317292015", "story_v_out_317292.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_317292", "317292015", "story_v_out_317292.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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

		arg_63_1:InitPlayNodeList()
	end,
	Play317292016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 317292016
		arg_67_1.duration_ = 6.7

		local var_67_0 = {
			zh = 1.999999999999,
			ja = 6.7
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
				arg_67_0:Play317292017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_70_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_67_1.stage_.transform)

				var_70_0.name = "1093ui_story"
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1093ui_story"] = var_70_0

				local var_70_1 = var_70_0:GetComponentInChildren(typeof(CharacterEffect))

				var_70_1.enabled = true

				local var_70_2 = GameObjectTools.GetOrAddComponent(var_70_0, typeof(DynamicBoneHelper))

				if var_70_2 then
					var_70_2:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_1.transform, false)

				arg_67_1.var_["1093ui_story" .. "Animator"] = var_70_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_67_1.var_["1093ui_story" .. "LipSync"] = var_70_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_70_3 = arg_67_1.actors_["1093ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1093ui_story = var_70_3.localPosition
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_3.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_67_1.time_ - 0) / var_70_4)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			local var_70_5 = arg_67_1.actors_["1093ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1093ui_story == nil then
				arg_67_1.var_.characterEffect1093ui_story = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.characterEffect1093ui_story and not isNil(var_70_5) then
					arg_67_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1093ui_story then
				arg_67_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_70_8 = arg_67_1.actors_["1015ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1015ui_story = var_70_8.localPosition
			end

			local var_70_9 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_9 then
				var_70_8.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_9)
				var_70_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_8.position).x, (manager.ui.mainCamera.transform.position - var_70_8.position).y, (manager.ui.mainCamera.transform.position - var_70_8.position).z)
				var_70_8.localEulerAngles.z = 0
				var_70_8.localEulerAngles.x = 0
				var_70_8.localEulerAngles = var_70_8.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_9 and arg_67_1.time_ < 0 + var_70_9 + arg_70_0 then
				var_70_8.localPosition = Vector3.New(0, 100, 0)
				var_70_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_8.position).x, (manager.ui.mainCamera.transform.position - var_70_8.position).y, (manager.ui.mainCamera.transform.position - var_70_8.position).z)
				var_70_8.localEulerAngles.z = 0
				var_70_8.localEulerAngles.x = 0
				var_70_8.localEulerAngles = var_70_8.localEulerAngles
			end

			local var_70_10 = arg_67_1.actors_["1015ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_10) and arg_67_1.var_.characterEffect1015ui_story == nil then
				arg_67_1.var_.characterEffect1015ui_story = var_70_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_11 and not isNil(var_70_10) then
				if arg_67_1.var_.characterEffect1015ui_story and not isNil(var_70_10) then
					arg_67_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_11)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_11 and arg_67_1.time_ < 0 + var_70_11 + arg_70_0 and not isNil(var_70_10) and arg_67_1.var_.characterEffect1015ui_story then
				arg_67_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_70_12 = 0
			local var_70_13 = 0.15

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_14 = arg_67_1:GetWordFromCfg(317292016)
				local var_70_15 = arg_67_1:FormatText(var_70_14.content)

				arg_67_1.text_.text = var_70_15

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_17 = 6 <= 0 and var_70_13 or var_70_13 * (utf8.len(var_70_15) / 6)

				if (6 <= 0 and var_70_13 or var_70_13 * (utf8.len(var_70_15) / 6)) > 0 and var_70_13 < var_70_17 then
					arg_67_1.talkMaxDuration = var_70_17

					if var_70_17 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_17 + var_70_12
					end
				end

				arg_67_1.text_.text = var_70_15
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292016", "story_v_out_317292.awb") ~= 0 then
					local var_70_18 = manager.audio:GetVoiceLength("story_v_out_317292", "317292016", "story_v_out_317292.awb") / 1000

					if var_70_18 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_18 + var_70_12
					end

					if var_70_14.prefab_name ~= "" and arg_67_1.actors_[var_70_14.prefab_name] ~= nil then
						local var_70_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_14.prefab_name].transform, "story_v_out_317292", "317292016", "story_v_out_317292.awb")

						arg_67_1:RecordAudio("317292016", var_70_19)
						arg_67_1:RecordAudio("317292016", var_70_19)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_317292", "317292016", "story_v_out_317292.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_317292", "317292016", "story_v_out_317292.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_20 = math.max(var_70_13, arg_67_1.talkMaxDuration)

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_20 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_12) / var_70_20

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_12 + var_70_20 and arg_67_1.time_ < var_70_12 + var_70_20 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play317292017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 317292017
		arg_71_1.duration_ = 3.7

		local var_71_0 = {
			zh = 2.1,
			ja = 3.7
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play317292018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1093ui_story = arg_71_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).z)
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles = arg_71_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).z)
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles = arg_71_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1093ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1093ui_story == nil then
				arg_71_1.var_.characterEffect1093ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1093ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_2)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1093ui_story then
				arg_71_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_74_3 = "2078ui_story"

			if arg_71_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_74_4 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_71_1.stage_.transform)

				var_74_4.name = var_74_3
				var_74_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_[var_74_3] = var_74_4

				local var_74_5 = var_74_4:GetComponentInChildren(typeof(CharacterEffect))

				var_74_5.enabled = true

				local var_74_6 = GameObjectTools.GetOrAddComponent(var_74_4, typeof(DynamicBoneHelper))

				if var_74_6 then
					var_74_6:EnableDynamicBone(false)
				end

				arg_71_1:ShowWeapon(var_74_5.transform, false)

				arg_71_1.var_[var_74_3 .. "Animator"] = var_74_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_71_1.var_[var_74_3 .. "Animator"].applyRootMotion = true
				arg_71_1.var_[var_74_3 .. "LipSync"] = var_74_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_74_7 = arg_71_1.actors_["2078ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos2078ui_story = var_74_7.localPosition
			end

			local var_74_8 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_8 then
				var_74_7.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_71_1.time_ - 0) / var_74_8)
				var_74_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_7.position).x, (manager.ui.mainCamera.transform.position - var_74_7.position).y, (manager.ui.mainCamera.transform.position - var_74_7.position).z)
				var_74_7.localEulerAngles.z = 0
				var_74_7.localEulerAngles.x = 0
				var_74_7.localEulerAngles = var_74_7.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_8 and arg_71_1.time_ < 0 + var_74_8 + arg_74_0 then
				var_74_7.localPosition = Vector3.New(0, -1.28, -5.6)
				var_74_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_7.position).x, (manager.ui.mainCamera.transform.position - var_74_7.position).y, (manager.ui.mainCamera.transform.position - var_74_7.position).z)
				var_74_7.localEulerAngles.z = 0
				var_74_7.localEulerAngles.x = 0
				var_74_7.localEulerAngles = var_74_7.localEulerAngles
			end

			local var_74_9 = arg_71_1.actors_["2078ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect2078ui_story == nil then
				arg_71_1.var_.characterEffect2078ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_10 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_10 and not isNil(var_74_9) then
				if arg_71_1.var_.characterEffect2078ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_10 and arg_71_1.time_ < 0 + var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect2078ui_story then
				arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_74_12 = 0
			local var_74_13 = 0.25

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_14 = arg_71_1:GetWordFromCfg(317292017)
				local var_74_15 = arg_71_1:FormatText(var_74_14.content)

				arg_71_1.text_.text = var_74_15

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_17 = 10 <= 0 and var_74_13 or var_74_13 * (utf8.len(var_74_15) / 10)

				if (10 <= 0 and var_74_13 or var_74_13 * (utf8.len(var_74_15) / 10)) > 0 and var_74_13 < var_74_17 then
					arg_71_1.talkMaxDuration = var_74_17

					if var_74_17 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_17 + var_74_12
					end
				end

				arg_71_1.text_.text = var_74_15
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292017", "story_v_out_317292.awb") ~= 0 then
					local var_74_18 = manager.audio:GetVoiceLength("story_v_out_317292", "317292017", "story_v_out_317292.awb") / 1000

					if var_74_18 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_12
					end

					if var_74_14.prefab_name ~= "" and arg_71_1.actors_[var_74_14.prefab_name] ~= nil then
						local var_74_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_14.prefab_name].transform, "story_v_out_317292", "317292017", "story_v_out_317292.awb")

						arg_71_1:RecordAudio("317292017", var_74_19)
						arg_71_1:RecordAudio("317292017", var_74_19)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_317292", "317292017", "story_v_out_317292.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_317292", "317292017", "story_v_out_317292.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_20 = math.max(var_74_13, arg_71_1.talkMaxDuration)

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_20 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_12) / var_74_20

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_12 + var_74_20 and arg_71_1.time_ < var_74_12 + var_74_20 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play317292018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 317292018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play317292019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["2078ui_story"]) and arg_75_1.var_.characterEffect2078ui_story == nil then
				arg_75_1.var_.characterEffect2078ui_story = arg_75_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["2078ui_story"]) then
				if arg_75_1.var_.characterEffect2078ui_story and not isNil(arg_75_1.actors_["2078ui_story"]) then
					arg_75_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_75_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["2078ui_story"]) and arg_75_1.var_.characterEffect2078ui_story then
				arg_75_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_75_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.95

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(317292018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 38 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 38)

				if (38 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 38)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play317292019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 317292019
		arg_79_1.duration_ = 9.6

		local var_79_0 = {
			zh = 8.266,
			ja = 9.6
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
				arg_79_0:Play317292020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos2078ui_story = arg_79_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).z)
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles = arg_79_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_79_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).z)
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles = arg_79_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["2078ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect2078ui_story == nil then
				arg_79_1.var_.characterEffect2078ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect2078ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect2078ui_story then
				arg_79_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_82_4 = 0
			local var_82_5 = 0.925

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(317292019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 37 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 37)

				if (37 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 37)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292019", "story_v_out_317292.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292019", "story_v_out_317292.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_317292", "317292019", "story_v_out_317292.awb")

						arg_79_1:RecordAudio("317292019", var_82_11)
						arg_79_1:RecordAudio("317292019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_317292", "317292019", "story_v_out_317292.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_317292", "317292019", "story_v_out_317292.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play317292020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 317292020
		arg_83_1.duration_ = 13.83

		local var_83_0 = {
			zh = 12.5,
			ja = 13.833
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
				arg_83_0:Play317292021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.4

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(317292020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 56 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 56)

				if (56 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 56)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292020", "story_v_out_317292.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292020", "story_v_out_317292.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_317292", "317292020", "story_v_out_317292.awb")

						arg_83_1:RecordAudio("317292020", var_86_6)
						arg_83_1:RecordAudio("317292020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_317292", "317292020", "story_v_out_317292.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_317292", "317292020", "story_v_out_317292.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play317292021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 317292021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play317292022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["2078ui_story"]) and arg_87_1.var_.characterEffect2078ui_story == nil then
				arg_87_1.var_.characterEffect2078ui_story = arg_87_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["2078ui_story"]) then
				if arg_87_1.var_.characterEffect2078ui_story and not isNil(arg_87_1.actors_["2078ui_story"]) then
					arg_87_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_87_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["2078ui_story"]) and arg_87_1.var_.characterEffect2078ui_story then
				arg_87_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_87_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(317292021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 4 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 4)

				if (4 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 4)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play317292022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 317292022
		arg_91_1.duration_ = 9.83

		local var_91_0 = {
			zh = 9.833,
			ja = 6.6
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
				arg_91_0:Play317292023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["2078ui_story"]) and arg_91_1.var_.characterEffect2078ui_story == nil then
				arg_91_1.var_.characterEffect2078ui_story = arg_91_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["2078ui_story"]) then
				if arg_91_1.var_.characterEffect2078ui_story and not isNil(arg_91_1.actors_["2078ui_story"]) then
					arg_91_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["2078ui_story"]) and arg_91_1.var_.characterEffect2078ui_story then
				arg_91_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_94_2 = 0
			local var_94_3 = 1.1

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(317292022)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 45 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 45)

				if (45 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 45)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292022", "story_v_out_317292.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_317292", "317292022", "story_v_out_317292.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_317292", "317292022", "story_v_out_317292.awb")

						arg_91_1:RecordAudio("317292022", var_94_9)
						arg_91_1:RecordAudio("317292022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_317292", "317292022", "story_v_out_317292.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_317292", "317292022", "story_v_out_317292.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play317292023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 317292023
		arg_95_1.duration_ = 9.17

		local var_95_0 = {
			zh = 8.8,
			ja = 9.166
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
				arg_95_0:Play317292024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.125

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(317292023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 45 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 45)

				if (45 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 45)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292023", "story_v_out_317292.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292023", "story_v_out_317292.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_317292", "317292023", "story_v_out_317292.awb")

						arg_95_1:RecordAudio("317292023", var_98_6)
						arg_95_1:RecordAudio("317292023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_317292", "317292023", "story_v_out_317292.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_317292", "317292023", "story_v_out_317292.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play317292024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317292024
		arg_99_1.duration_ = 13.3

		local var_99_0 = {
			zh = 13.3,
			ja = 11.3
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play317292025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.65

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(317292024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 65 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 65)

				if (65 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 65)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292024", "story_v_out_317292.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292024", "story_v_out_317292.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_317292", "317292024", "story_v_out_317292.awb")

						arg_99_1:RecordAudio("317292024", var_102_6)
						arg_99_1:RecordAudio("317292024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_317292", "317292024", "story_v_out_317292.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_317292", "317292024", "story_v_out_317292.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play317292025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 317292025
		arg_103_1.duration_ = 10.67

		local var_103_0 = {
			zh = 9.566,
			ja = 10.666
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
				arg_103_0:Play317292026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.175

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:GetWordFromCfg(317292025)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 47 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 47)

				if (47 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 47)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292025", "story_v_out_317292.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292025", "story_v_out_317292.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_317292", "317292025", "story_v_out_317292.awb")

						arg_103_1:RecordAudio("317292025", var_106_6)
						arg_103_1:RecordAudio("317292025", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_317292", "317292025", "story_v_out_317292.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_317292", "317292025", "story_v_out_317292.awb")
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
	Play317292026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 317292026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play317292027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["2078ui_story"]) and arg_107_1.var_.characterEffect2078ui_story == nil then
				arg_107_1.var_.characterEffect2078ui_story = arg_107_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["2078ui_story"]) then
				if arg_107_1.var_.characterEffect2078ui_story and not isNil(arg_107_1.actors_["2078ui_story"]) then
					arg_107_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_107_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["2078ui_story"]) and arg_107_1.var_.characterEffect2078ui_story then
				arg_107_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_107_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.65

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(317292026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 26 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 26)

				if (26 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 26)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play317292027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 317292027
		arg_111_1.duration_ = 10.37

		local var_111_0 = {
			zh = 8,
			ja = 10.366
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
				arg_111_0:Play317292028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["2078ui_story"]) and arg_111_1.var_.characterEffect2078ui_story == nil then
				arg_111_1.var_.characterEffect2078ui_story = arg_111_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["2078ui_story"]) then
				if arg_111_1.var_.characterEffect2078ui_story and not isNil(arg_111_1.actors_["2078ui_story"]) then
					arg_111_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["2078ui_story"]) and arg_111_1.var_.characterEffect2078ui_story then
				arg_111_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_114_2 = 0
			local var_114_3 = 0.75

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(317292027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 30 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 30)

				if (30 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 30)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292027", "story_v_out_317292.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_317292", "317292027", "story_v_out_317292.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_317292", "317292027", "story_v_out_317292.awb")

						arg_111_1:RecordAudio("317292027", var_114_9)
						arg_111_1:RecordAudio("317292027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_317292", "317292027", "story_v_out_317292.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_317292", "317292027", "story_v_out_317292.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play317292028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 317292028
		arg_115_1.duration_ = 2.03

		local var_115_0 = {
			zh = 0.999999999999,
			ja = 2.033
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
				arg_115_0:Play317292029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1015ui_story = arg_115_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1015ui_story"].transform.position).z)
				arg_115_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1015ui_story"].transform.localEulerAngles = arg_115_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_115_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1015ui_story"].transform.position).z)
				arg_115_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1015ui_story"].transform.localEulerAngles = arg_115_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1015ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1015ui_story == nil then
				arg_115_1.var_.characterEffect1015ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1015ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1015ui_story then
				arg_115_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_4 = arg_115_1.actors_["2078ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos2078ui_story = var_118_4.localPosition
			end

			local var_118_5 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				var_118_4.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_5)
				var_118_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_4.position).x, (manager.ui.mainCamera.transform.position - var_118_4.position).y, (manager.ui.mainCamera.transform.position - var_118_4.position).z)
				var_118_4.localEulerAngles.z = 0
				var_118_4.localEulerAngles.x = 0
				var_118_4.localEulerAngles = var_118_4.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 then
				var_118_4.localPosition = Vector3.New(0, 100, 0)
				var_118_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_4.position).x, (manager.ui.mainCamera.transform.position - var_118_4.position).y, (manager.ui.mainCamera.transform.position - var_118_4.position).z)
				var_118_4.localEulerAngles.z = 0
				var_118_4.localEulerAngles.x = 0
				var_118_4.localEulerAngles = var_118_4.localEulerAngles
			end

			local var_118_6 = arg_115_1.actors_["2078ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect2078ui_story == nil then
				arg_115_1.var_.characterEffect2078ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_7 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 and not isNil(var_118_6) then
				if arg_115_1.var_.characterEffect2078ui_story and not isNil(var_118_6) then
					arg_115_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_115_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_7)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect2078ui_story then
				arg_115_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_115_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_118_8 = 0
			local var_118_9 = 0.05

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(317292028)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 2 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 2)

				if (2 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 2)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292028", "story_v_out_317292.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292028", "story_v_out_317292.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_317292", "317292028", "story_v_out_317292.awb")

						arg_115_1:RecordAudio("317292028", var_118_15)
						arg_115_1:RecordAudio("317292028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_317292", "317292028", "story_v_out_317292.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_317292", "317292028", "story_v_out_317292.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play317292029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 317292029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play317292030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1015ui_story = arg_119_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1015ui_story"].transform.position).z)
				arg_119_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1015ui_story"].transform.localEulerAngles = arg_119_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1015ui_story"].transform.position).z)
				arg_119_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1015ui_story"].transform.localEulerAngles = arg_119_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_122_1 = 0
			local var_122_2 = 0.85

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(317292029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 34 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 34)

				if (34 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 34)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play317292030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 317292030
		arg_123_1.duration_ = 8.73

		local var_123_0 = {
			zh = 2.733,
			ja = 8.733
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
				arg_123_0:Play317292031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1093ui_story = arg_123_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1093ui_story"].transform.position).z)
				arg_123_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1093ui_story"].transform.localEulerAngles = arg_123_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_123_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1093ui_story"].transform.position).z)
				arg_123_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1093ui_story"].transform.localEulerAngles = arg_123_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1093ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1093ui_story == nil then
				arg_123_1.var_.characterEffect1093ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1093ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1093ui_story then
				arg_123_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.35

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(317292030)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 14 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 14)

				if (14 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 14)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292030", "story_v_out_317292.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292030", "story_v_out_317292.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_317292", "317292030", "story_v_out_317292.awb")

						arg_123_1:RecordAudio("317292030", var_126_11)
						arg_123_1:RecordAudio("317292030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_317292", "317292030", "story_v_out_317292.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_317292", "317292030", "story_v_out_317292.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play317292031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 317292031
		arg_127_1.duration_ = 1.57

		local var_127_0 = {
			zh = 1.566,
			ja = 1.533
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
				arg_127_0:Play317292032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1015ui_story = arg_127_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1015ui_story"].transform.position).z)
				arg_127_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1015ui_story"].transform.localEulerAngles = arg_127_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_127_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1015ui_story"].transform.position).z)
				arg_127_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1015ui_story"].transform.localEulerAngles = arg_127_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1015ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1015ui_story == nil then
				arg_127_1.var_.characterEffect1015ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1015ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1015ui_story then
				arg_127_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_4 = arg_127_1.actors_["1093ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1093ui_story = var_130_4.localPosition
			end

			local var_130_5 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 then
				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_5)
				var_130_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_4.position).x, (manager.ui.mainCamera.transform.position - var_130_4.position).y, (manager.ui.mainCamera.transform.position - var_130_4.position).z)
				var_130_4.localEulerAngles.z = 0
				var_130_4.localEulerAngles.x = 0
				var_130_4.localEulerAngles = var_130_4.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(0, 100, 0)
				var_130_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_4.position).x, (manager.ui.mainCamera.transform.position - var_130_4.position).y, (manager.ui.mainCamera.transform.position - var_130_4.position).z)
				var_130_4.localEulerAngles.z = 0
				var_130_4.localEulerAngles.x = 0
				var_130_4.localEulerAngles = var_130_4.localEulerAngles
			end

			local var_130_6 = arg_127_1.actors_["1093ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1093ui_story == nil then
				arg_127_1.var_.characterEffect1093ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_7 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 and not isNil(var_130_6) then
				if arg_127_1.var_.characterEffect1093ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_7)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1093ui_story then
				arg_127_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_130_8 = 0
			local var_130_9 = 0.15

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:GetWordFromCfg(317292031)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 6 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 6)

				if (6 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 6)) > 0 and var_130_9 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292031", "story_v_out_317292.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292031", "story_v_out_317292.awb") / 1000

					if var_130_14 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_8
					end

					if var_130_10.prefab_name ~= "" and arg_127_1.actors_[var_130_10.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_10.prefab_name].transform, "story_v_out_317292", "317292031", "story_v_out_317292.awb")

						arg_127_1:RecordAudio("317292031", var_130_15)
						arg_127_1:RecordAudio("317292031", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_317292", "317292031", "story_v_out_317292.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_317292", "317292031", "story_v_out_317292.awb")
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play317292032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 317292032
		arg_131_1.duration_ = 13.03

		local var_131_0 = {
			zh = 7.8,
			ja = 13.033
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play317292033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.975

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(317292032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 39 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 39)

				if (39 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 39)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292032", "story_v_out_317292.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292032", "story_v_out_317292.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_317292", "317292032", "story_v_out_317292.awb")

						arg_131_1:RecordAudio("317292032", var_134_6)
						arg_131_1:RecordAudio("317292032", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_317292", "317292032", "story_v_out_317292.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_317292", "317292032", "story_v_out_317292.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play317292033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 317292033
		arg_135_1.duration_ = 12.43

		local var_135_0 = {
			zh = 12.433,
			ja = 3.533
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
				arg_135_0:Play317292034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.425

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(317292033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 57 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 57)

				if (57 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 57)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292033", "story_v_out_317292.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292033", "story_v_out_317292.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_317292", "317292033", "story_v_out_317292.awb")

						arg_135_1:RecordAudio("317292033", var_138_6)
						arg_135_1:RecordAudio("317292033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_317292", "317292033", "story_v_out_317292.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_317292", "317292033", "story_v_out_317292.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play317292034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 317292034
		arg_139_1.duration_ = 12.57

		local var_139_0 = {
			zh = 12.566,
			ja = 10.166
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play317292035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			local var_142_0 = 0
			local var_142_1 = 1.275

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(317292034)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 51 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 51)

				if (51 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 51)) > 0 and var_142_1 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292034", "story_v_out_317292.awb") ~= 0 then
					local var_142_6 = manager.audio:GetVoiceLength("story_v_out_317292", "317292034", "story_v_out_317292.awb") / 1000

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end

					if var_142_2.prefab_name ~= "" and arg_139_1.actors_[var_142_2.prefab_name] ~= nil then
						local var_142_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_2.prefab_name].transform, "story_v_out_317292", "317292034", "story_v_out_317292.awb")

						arg_139_1:RecordAudio("317292034", var_142_7)
						arg_139_1:RecordAudio("317292034", var_142_7)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_317292", "317292034", "story_v_out_317292.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_317292", "317292034", "story_v_out_317292.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play317292035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 317292035
		arg_143_1.duration_ = 4.37

		local var_143_0 = {
			zh = 2.4,
			ja = 4.366
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
				arg_143_0:Play317292036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10053ui_story = arg_143_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10053ui_story"].transform.position).z)
				arg_143_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10053ui_story"].transform.localEulerAngles = arg_143_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_143_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10053ui_story"].transform.position).z)
				arg_143_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10053ui_story"].transform.localEulerAngles = arg_143_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["10053ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10053ui_story == nil then
				arg_143_1.var_.characterEffect10053ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10053ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10053ui_story then
				arg_143_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action11_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = arg_143_1.actors_["1015ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1015ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_5)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(0, 100, 0)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			local var_146_6 = arg_143_1.actors_["1015ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1015ui_story == nil then
				arg_143_1.var_.characterEffect1015ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_7 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 and not isNil(var_146_6) then
				if arg_143_1.var_.characterEffect1015ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_7)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1015ui_story then
				arg_143_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_146_8 = 0
			local var_146_9 = 0.275

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(317292035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 11 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 11)

				if (11 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 11)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292035", "story_v_out_317292.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292035", "story_v_out_317292.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_317292", "317292035", "story_v_out_317292.awb")

						arg_143_1:RecordAudio("317292035", var_146_15)
						arg_143_1:RecordAudio("317292035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_317292", "317292035", "story_v_out_317292.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_317292", "317292035", "story_v_out_317292.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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

		arg_143_1:InitPlayNodeList()
	end,
	Play317292036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 317292036
		arg_147_1.duration_ = 2.17

		local var_147_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_147_0:Play317292037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1015ui_story = arg_147_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1015ui_story"].transform.position).z)
				arg_147_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1015ui_story"].transform.localEulerAngles = arg_147_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_147_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1015ui_story"].transform.position).z)
				arg_147_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1015ui_story"].transform.localEulerAngles = arg_147_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1015ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1015ui_story == nil then
				arg_147_1.var_.characterEffect1015ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1015ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1015ui_story then
				arg_147_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_2")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_150_4 = arg_147_1.actors_["10053ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10053ui_story = var_150_4.localPosition
			end

			local var_150_5 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 then
				var_150_4.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_5)
				var_150_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_4.position).x, (manager.ui.mainCamera.transform.position - var_150_4.position).y, (manager.ui.mainCamera.transform.position - var_150_4.position).z)
				var_150_4.localEulerAngles.z = 0
				var_150_4.localEulerAngles.x = 0
				var_150_4.localEulerAngles = var_150_4.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 then
				var_150_4.localPosition = Vector3.New(0, 100, 0)
				var_150_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_4.position).x, (manager.ui.mainCamera.transform.position - var_150_4.position).y, (manager.ui.mainCamera.transform.position - var_150_4.position).z)
				var_150_4.localEulerAngles.z = 0
				var_150_4.localEulerAngles.x = 0
				var_150_4.localEulerAngles = var_150_4.localEulerAngles
			end

			local var_150_6 = arg_147_1.actors_["10053ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect10053ui_story == nil then
				arg_147_1.var_.characterEffect10053ui_story = var_150_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_7 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 and not isNil(var_150_6) then
				if arg_147_1.var_.characterEffect10053ui_story and not isNil(var_150_6) then
					arg_147_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_7)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect10053ui_story then
				arg_147_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_150_8 = 0
			local var_150_9 = 0.225

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(317292036)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 9 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 9)

				if (9 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 9)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292036", "story_v_out_317292.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292036", "story_v_out_317292.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_317292", "317292036", "story_v_out_317292.awb")

						arg_147_1:RecordAudio("317292036", var_150_15)
						arg_147_1:RecordAudio("317292036", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_317292", "317292036", "story_v_out_317292.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_317292", "317292036", "story_v_out_317292.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play317292037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 317292037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play317292038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1015ui_story"]) and arg_151_1.var_.characterEffect1015ui_story == nil then
				arg_151_1.var_.characterEffect1015ui_story = arg_151_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1015ui_story"]) then
				if arg_151_1.var_.characterEffect1015ui_story and not isNil(arg_151_1.actors_["1015ui_story"]) then
					arg_151_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1015ui_story"]) and arg_151_1.var_.characterEffect1015ui_story then
				arg_151_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.275

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(317292037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 11 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 11)

				if (11 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 11)) > 0 and var_154_2 < var_154_5 then
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
	Play317292038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 317292038
		arg_155_1.duration_ = 14.3

		local var_155_0 = {
			zh = 11.033,
			ja = 14.3
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play317292039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1015ui_story"]) and arg_155_1.var_.characterEffect1015ui_story == nil then
				arg_155_1.var_.characterEffect1015ui_story = arg_155_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1015ui_story"]) then
				if arg_155_1.var_.characterEffect1015ui_story and not isNil(arg_155_1.actors_["1015ui_story"]) then
					arg_155_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1015ui_story"]) and arg_155_1.var_.characterEffect1015ui_story then
				arg_155_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_158_2 = 0
			local var_158_3 = 1.5

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(317292038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 60 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 60)

				if (60 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 60)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292038", "story_v_out_317292.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_317292", "317292038", "story_v_out_317292.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_317292", "317292038", "story_v_out_317292.awb")

						arg_155_1:RecordAudio("317292038", var_158_9)
						arg_155_1:RecordAudio("317292038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_317292", "317292038", "story_v_out_317292.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_317292", "317292038", "story_v_out_317292.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play317292039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 317292039
		arg_159_1.duration_ = 9.3

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play317292040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(317292039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 50 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 50)

				if (50 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 50)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292039", "story_v_out_317292.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292039", "story_v_out_317292.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_317292", "317292039", "story_v_out_317292.awb")

						arg_159_1:RecordAudio("317292039", var_162_6)
						arg_159_1:RecordAudio("317292039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_317292", "317292039", "story_v_out_317292.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_317292", "317292039", "story_v_out_317292.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play317292040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 317292040
		arg_163_1.duration_ = 10.5

		local var_163_0 = {
			zh = 10.5,
			ja = 6
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
				arg_163_0:Play317292041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 1.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(317292040)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 52 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 52)

				if (52 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 52)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292040", "story_v_out_317292.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292040", "story_v_out_317292.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_317292", "317292040", "story_v_out_317292.awb")

						arg_163_1:RecordAudio("317292040", var_166_6)
						arg_163_1:RecordAudio("317292040", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_317292", "317292040", "story_v_out_317292.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_317292", "317292040", "story_v_out_317292.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play317292041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 317292041
		arg_167_1.duration_ = 8.8

		local var_167_0 = {
			zh = 7.433,
			ja = 8.8
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play317292042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1015ui_story = arg_167_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1015ui_story"].transform.position).z)
				arg_167_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1015ui_story"].transform.localEulerAngles = arg_167_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_167_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1015ui_story"].transform.position).z)
				arg_167_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1015ui_story"].transform.localEulerAngles = arg_167_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1015ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1015ui_story == nil then
				arg_167_1.var_.characterEffect1015ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1015ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1015ui_story then
				arg_167_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_170_4 = 0
			local var_170_5 = 0.8

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(317292041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 32 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 32)

				if (32 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 32)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292041", "story_v_out_317292.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292041", "story_v_out_317292.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_317292", "317292041", "story_v_out_317292.awb")

						arg_167_1:RecordAudio("317292041", var_170_11)
						arg_167_1:RecordAudio("317292041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_317292", "317292041", "story_v_out_317292.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_317292", "317292041", "story_v_out_317292.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play317292042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 317292042
		arg_171_1.duration_ = 11.23

		local var_171_0 = {
			zh = 6.9,
			ja = 11.233
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play317292043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1015ui_story = arg_171_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1015ui_story"].transform.position).z)
				arg_171_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1015ui_story"].transform.localEulerAngles = arg_171_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1015ui_story"].transform.position).z)
				arg_171_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1015ui_story"].transform.localEulerAngles = arg_171_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1015ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1015ui_story == nil then
				arg_171_1.var_.characterEffect1015ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1015ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_2)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1015ui_story then
				arg_171_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_174_3 = arg_171_1.actors_["10053ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10053ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, -1.12, -5.99)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			local var_174_5 = arg_171_1.actors_["10053ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10053ui_story == nil then
				arg_171_1.var_.characterEffect10053ui_story = var_174_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.characterEffect10053ui_story and not isNil(var_174_5) then
					arg_171_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10053ui_story then
				arg_171_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action41117")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_8 = 0
			local var_174_9 = 0.825

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(317292042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 33 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 33)

				if (33 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 33)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292042", "story_v_out_317292.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292042", "story_v_out_317292.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_317292", "317292042", "story_v_out_317292.awb")

						arg_171_1:RecordAudio("317292042", var_174_15)
						arg_171_1:RecordAudio("317292042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_317292", "317292042", "story_v_out_317292.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_317292", "317292042", "story_v_out_317292.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play317292043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 317292043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play317292044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10053ui_story = arg_175_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10053ui_story"].transform.position).z)
				arg_175_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10053ui_story"].transform.localEulerAngles = arg_175_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10053ui_story"].transform.position).z)
				arg_175_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10053ui_story"].transform.localEulerAngles = arg_175_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["10053ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10053ui_story == nil then
				arg_175_1.var_.characterEffect10053ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect10053ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_2)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10053ui_story then
				arg_175_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_178_3 = 0
			local var_178_4 = 0.3

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_5 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(317292043).content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 12 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 12)

				if (12 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 12)) > 0 and var_178_4 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_3
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_4, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_3) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_8 and arg_175_1.time_ < var_178_3 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play317292044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317292044
		arg_179_1.duration_ = 8.1

		local var_179_0 = {
			zh = 8.1,
			ja = 7.366
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317292045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1015ui_story = arg_179_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1015ui_story"].transform.position).z)
				arg_179_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1015ui_story"].transform.localEulerAngles = arg_179_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_179_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1015ui_story"].transform.position).z)
				arg_179_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1015ui_story"].transform.localEulerAngles = arg_179_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1015ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1015ui_story == nil then
				arg_179_1.var_.characterEffect1015ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1015ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1015ui_story then
				arg_179_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_182_4 = 0
			local var_182_5 = 0.75

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(317292044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 30 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 30)

				if (30 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 30)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292044", "story_v_out_317292.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292044", "story_v_out_317292.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_317292", "317292044", "story_v_out_317292.awb")

						arg_179_1:RecordAudio("317292044", var_182_11)
						arg_179_1:RecordAudio("317292044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_317292", "317292044", "story_v_out_317292.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_317292", "317292044", "story_v_out_317292.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play317292045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 317292045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play317292046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1015ui_story = arg_183_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1015ui_story"].transform.position).z)
				arg_183_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1015ui_story"].transform.localEulerAngles = arg_183_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1015ui_story"].transform.position).z)
				arg_183_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1015ui_story"].transform.localEulerAngles = arg_183_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1015ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1015ui_story == nil then
				arg_183_1.var_.characterEffect1015ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1015ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_2)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1015ui_story then
				arg_183_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_186_4 = 0
			local var_186_5 = 1.55

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(317292045).content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 62 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_6) / 62)

				if (62 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_6) / 62)) > 0 and var_186_5 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_9 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_9 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_9

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_9 and arg_183_1.time_ < var_186_4 + var_186_9 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play317292046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 317292046
		arg_187_1.duration_ = 15.4

		local var_187_0 = {
			zh = 12.7,
			ja = 15.4
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play317292047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1199ui_story = arg_187_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1199ui_story"].transform.position).z)
				arg_187_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1199ui_story"].transform.localEulerAngles = arg_187_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_187_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1199ui_story"].transform.position).z)
				arg_187_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1199ui_story"].transform.localEulerAngles = arg_187_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1199ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1199ui_story == nil then
				arg_187_1.var_.characterEffect1199ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1199ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1199ui_story then
				arg_187_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_4 = 0
			local var_190_5 = 1.375

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(317292046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 55 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 55)

				if (55 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 55)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292046", "story_v_out_317292.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292046", "story_v_out_317292.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_317292", "317292046", "story_v_out_317292.awb")

						arg_187_1:RecordAudio("317292046", var_190_11)
						arg_187_1:RecordAudio("317292046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_317292", "317292046", "story_v_out_317292.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_317292", "317292046", "story_v_out_317292.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play317292047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317292047
		arg_191_1.duration_ = 6.73

		local var_191_0 = {
			zh = 5.2,
			ja = 6.733
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
				arg_191_0:Play317292048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1199ui_story = arg_191_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1199ui_story"].transform.position).z)
				arg_191_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1199ui_story"].transform.localEulerAngles = arg_191_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1199ui_story"].transform.position).z)
				arg_191_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1199ui_story"].transform.localEulerAngles = arg_191_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1199ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1199ui_story == nil then
				arg_191_1.var_.characterEffect1199ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1199ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_2)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1199ui_story then
				arg_191_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_194_3 = arg_191_1.actors_["10053ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10053ui_story = var_194_3.localPosition
			end

			local var_194_4 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				var_194_3.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_191_1.time_ - 0) / var_194_4)
				var_194_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_3.position).x, (manager.ui.mainCamera.transform.position - var_194_3.position).y, (manager.ui.mainCamera.transform.position - var_194_3.position).z)
				var_194_3.localEulerAngles.z = 0
				var_194_3.localEulerAngles.x = 0
				var_194_3.localEulerAngles = var_194_3.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				var_194_3.localPosition = Vector3.New(0, -1.12, -5.99)
				var_194_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_3.position).x, (manager.ui.mainCamera.transform.position - var_194_3.position).y, (manager.ui.mainCamera.transform.position - var_194_3.position).z)
				var_194_3.localEulerAngles.z = 0
				var_194_3.localEulerAngles.x = 0
				var_194_3.localEulerAngles = var_194_3.localEulerAngles
			end

			local var_194_5 = arg_191_1.actors_["10053ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect10053ui_story == nil then
				arg_191_1.var_.characterEffect10053ui_story = var_194_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_6 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_6 and not isNil(var_194_5) then
				if arg_191_1.var_.characterEffect10053ui_story and not isNil(var_194_5) then
					arg_191_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_6 and arg_191_1.time_ < 0 + var_194_6 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect10053ui_story then
				arg_191_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_194_8 = 0
			local var_194_9 = 0.125

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(317292047)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 5 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 5)

				if (5 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 5)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292047", "story_v_out_317292.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292047", "story_v_out_317292.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_317292", "317292047", "story_v_out_317292.awb")

						arg_191_1:RecordAudio("317292047", var_194_15)
						arg_191_1:RecordAudio("317292047", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_317292", "317292047", "story_v_out_317292.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_317292", "317292047", "story_v_out_317292.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_191_1:InitPlayNodeList()
	end,
	Play317292048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317292048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play317292049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10053ui_story"]) and arg_195_1.var_.characterEffect10053ui_story == nil then
				arg_195_1.var_.characterEffect10053ui_story = arg_195_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10053ui_story"]) then
				if arg_195_1.var_.characterEffect10053ui_story and not isNil(arg_195_1.actors_["10053ui_story"]) then
					arg_195_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10053ui_story"]) and arg_195_1.var_.characterEffect10053ui_story then
				arg_195_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.85

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(317292048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 34 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 34)

				if (34 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 34)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play317292049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317292049
		arg_199_1.duration_ = 8.43

		local var_199_0 = {
			zh = 7.366,
			ja = 8.433
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
				arg_199_0:Play317292050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10053ui_story = arg_199_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10053ui_story"].transform.position).z)
				arg_199_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10053ui_story"].transform.localEulerAngles = arg_199_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_199_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10053ui_story"].transform.position).z)
				arg_199_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10053ui_story"].transform.localEulerAngles = arg_199_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["10053ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10053ui_story == nil then
				arg_199_1.var_.characterEffect10053ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect10053ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10053ui_story then
				arg_199_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action12_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_4 = 0
			local var_202_5 = 0.525

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(317292049)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 21 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 21)

				if (21 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 21)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292049", "story_v_out_317292.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292049", "story_v_out_317292.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_317292", "317292049", "story_v_out_317292.awb")

						arg_199_1:RecordAudio("317292049", var_202_11)
						arg_199_1:RecordAudio("317292049", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_317292", "317292049", "story_v_out_317292.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_317292", "317292049", "story_v_out_317292.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play317292050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317292050
		arg_203_1.duration_ = 16.07

		local var_203_0 = {
			zh = 16.066,
			ja = 12.533
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
				arg_203_0:Play317292051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.675

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(317292050)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 65 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 65)

				if (65 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 65)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292050", "story_v_out_317292.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292050", "story_v_out_317292.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_317292", "317292050", "story_v_out_317292.awb")

						arg_203_1:RecordAudio("317292050", var_206_6)
						arg_203_1:RecordAudio("317292050", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_317292", "317292050", "story_v_out_317292.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_317292", "317292050", "story_v_out_317292.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play317292051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317292051
		arg_207_1.duration_ = 4.93

		local var_207_0 = {
			zh = 3.3,
			ja = 4.933
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
				arg_207_0:Play317292052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.3

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(317292051)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 12 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 12)

				if (12 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 12)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292051", "story_v_out_317292.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292051", "story_v_out_317292.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_317292", "317292051", "story_v_out_317292.awb")

						arg_207_1:RecordAudio("317292051", var_210_6)
						arg_207_1:RecordAudio("317292051", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_317292", "317292051", "story_v_out_317292.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_317292", "317292051", "story_v_out_317292.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play317292052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317292052
		arg_211_1.duration_ = 12.67

		local var_211_0 = {
			zh = 12.666,
			ja = 9.6
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play317292053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action12_2")
			end

			local var_214_0 = 0
			local var_214_1 = 1.25

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(317292052)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 50 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 50)

				if (50 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 50)) > 0 and var_214_1 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292052", "story_v_out_317292.awb") ~= 0 then
					local var_214_6 = manager.audio:GetVoiceLength("story_v_out_317292", "317292052", "story_v_out_317292.awb") / 1000

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end

					if var_214_2.prefab_name ~= "" and arg_211_1.actors_[var_214_2.prefab_name] ~= nil then
						local var_214_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_2.prefab_name].transform, "story_v_out_317292", "317292052", "story_v_out_317292.awb")

						arg_211_1:RecordAudio("317292052", var_214_7)
						arg_211_1:RecordAudio("317292052", var_214_7)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_317292", "317292052", "story_v_out_317292.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_317292", "317292052", "story_v_out_317292.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play317292053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317292053
		arg_215_1.duration_ = 17.4

		local var_215_0 = {
			zh = 16.1,
			ja = 17.4
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
				arg_215_0:Play317292054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.225

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(317292053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 49 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 49)

				if (49 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 49)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292053", "story_v_out_317292.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292053", "story_v_out_317292.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_317292", "317292053", "story_v_out_317292.awb")

						arg_215_1:RecordAudio("317292053", var_218_6)
						arg_215_1:RecordAudio("317292053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317292", "317292053", "story_v_out_317292.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317292", "317292053", "story_v_out_317292.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play317292054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317292054
		arg_219_1.duration_ = 12.13

		local var_219_0 = {
			zh = 8.333,
			ja = 12.133
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
				arg_219_0:Play317292055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_222_0 = 0
			local var_222_1 = 0.675

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(317292054)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 27 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 27)

				if (27 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 27)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292054", "story_v_out_317292.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_out_317292", "317292054", "story_v_out_317292.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_out_317292", "317292054", "story_v_out_317292.awb")

						arg_219_1:RecordAudio("317292054", var_222_7)
						arg_219_1:RecordAudio("317292054", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_317292", "317292054", "story_v_out_317292.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_317292", "317292054", "story_v_out_317292.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play317292055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317292055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play317292056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10053ui_story = arg_223_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10053ui_story"].transform.position).z)
				arg_223_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10053ui_story"].transform.localEulerAngles = arg_223_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10053ui_story"].transform.position).z)
				arg_223_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10053ui_story"].transform.localEulerAngles = arg_223_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_226_1 = 0
			local var_226_2 = 0.825

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(317292055).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 33 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 33)

				if (33 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 33)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play317292056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 317292056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play317292057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.875

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(317292056).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 35 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 35)

				if (35 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 35)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play317292057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317292057
		arg_231_1.duration_ = 11.23

		local var_231_0 = {
			zh = 11.233,
			ja = 6.866
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
				arg_231_0:Play317292058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1199ui_story = arg_231_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1199ui_story"].transform.position).z)
				arg_231_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1199ui_story"].transform.localEulerAngles = arg_231_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_231_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1199ui_story"].transform.position).z)
				arg_231_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1199ui_story"].transform.localEulerAngles = arg_231_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1199ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1199ui_story == nil then
				arg_231_1.var_.characterEffect1199ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1199ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1199ui_story then
				arg_231_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_4 = 0
			local var_234_5 = 1.05

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(317292057)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 42 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 42)

				if (42 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 42)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292057", "story_v_out_317292.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292057", "story_v_out_317292.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_317292", "317292057", "story_v_out_317292.awb")

						arg_231_1:RecordAudio("317292057", var_234_11)
						arg_231_1:RecordAudio("317292057", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_317292", "317292057", "story_v_out_317292.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_317292", "317292057", "story_v_out_317292.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play317292058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 317292058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play317292059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1199ui_story = arg_235_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1199ui_story"].transform.position).z)
				arg_235_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1199ui_story"].transform.localEulerAngles = arg_235_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1199ui_story"].transform.position).z)
				arg_235_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1199ui_story"].transform.localEulerAngles = arg_235_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1199ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1199ui_story == nil then
				arg_235_1.var_.characterEffect1199ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1199ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_2)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1199ui_story then
				arg_235_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_238_3 = 0
			local var_238_4 = 0.4

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_3 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_5 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(317292058).content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 16 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_5) / 16)

				if (16 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_5) / 16)) > 0 and var_238_4 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_3 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_3
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_4, arg_235_1.talkMaxDuration)

			if var_238_3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_3 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_3) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_3 + var_238_8 and arg_235_1.time_ < var_238_3 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play317292059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 317292059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play317292060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.575

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(317292059).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 23 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 23)

				if (23 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 23)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play317292060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 317292060
		arg_243_1.duration_ = 14.67

		local var_243_0 = {
			zh = 14.666,
			ja = 12.6
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
				arg_243_0:Play317292061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10053ui_story = arg_243_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10053ui_story"].transform.position).z)
				arg_243_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["10053ui_story"].transform.localEulerAngles = arg_243_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_243_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10053ui_story"].transform.position).z)
				arg_243_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["10053ui_story"].transform.localEulerAngles = arg_243_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["10053ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect10053ui_story == nil then
				arg_243_1.var_.characterEffect10053ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect10053ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect10053ui_story then
				arg_243_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_4 = 0
			local var_246_5 = 1.175

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(317292060)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 47 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 47)

				if (47 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 47)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292060", "story_v_out_317292.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292060", "story_v_out_317292.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_317292", "317292060", "story_v_out_317292.awb")

						arg_243_1:RecordAudio("317292060", var_246_11)
						arg_243_1:RecordAudio("317292060", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_317292", "317292060", "story_v_out_317292.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_317292", "317292060", "story_v_out_317292.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play317292061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 317292061
		arg_247_1.duration_ = 17.4

		local var_247_0 = {
			zh = 17.4,
			ja = 16.866
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
				arg_247_0:Play317292062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.2

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(317292061)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 49 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 49)

				if (49 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 49)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292061", "story_v_out_317292.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292061", "story_v_out_317292.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_317292", "317292061", "story_v_out_317292.awb")

						arg_247_1:RecordAudio("317292061", var_250_6)
						arg_247_1:RecordAudio("317292061", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_317292", "317292061", "story_v_out_317292.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_317292", "317292061", "story_v_out_317292.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play317292062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 317292062
		arg_251_1.duration_ = 15.8

		local var_251_0 = {
			zh = 7.6,
			ja = 15.8
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
				arg_251_0:Play317292063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.6

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(317292062)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 24 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 24)

				if (24 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 24)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292062", "story_v_out_317292.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292062", "story_v_out_317292.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_317292", "317292062", "story_v_out_317292.awb")

						arg_251_1:RecordAudio("317292062", var_254_6)
						arg_251_1:RecordAudio("317292062", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_317292", "317292062", "story_v_out_317292.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_317292", "317292062", "story_v_out_317292.awb")
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
	Play317292063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 317292063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play317292064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10053ui_story = arg_255_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10053ui_story"].transform.position).z)
				arg_255_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10053ui_story"].transform.localEulerAngles = arg_255_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10053ui_story"].transform.position).z)
				arg_255_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10053ui_story"].transform.localEulerAngles = arg_255_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_258_1 = 0
			local var_258_2 = 1.2

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(317292063).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 48 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 48)

				if (48 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 48)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play317292064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 317292064
		arg_259_1.duration_ = 6.37

		local var_259_0 = {
			zh = 4.2,
			ja = 6.366
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
				arg_259_0:Play317292065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1199ui_story = arg_259_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1199ui_story"].transform.position).z)
				arg_259_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1199ui_story"].transform.localEulerAngles = arg_259_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_259_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1199ui_story"].transform.position).z)
				arg_259_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1199ui_story"].transform.localEulerAngles = arg_259_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1199ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1199ui_story == nil then
				arg_259_1.var_.characterEffect1199ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1199ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1199ui_story then
				arg_259_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_262_4 = 0
			local var_262_5 = 0.55

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(317292064)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 22 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 22)

				if (22 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 22)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292064", "story_v_out_317292.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292064", "story_v_out_317292.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_317292", "317292064", "story_v_out_317292.awb")

						arg_259_1:RecordAudio("317292064", var_262_11)
						arg_259_1:RecordAudio("317292064", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_317292", "317292064", "story_v_out_317292.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_317292", "317292064", "story_v_out_317292.awb")
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

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play317292065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 317292065
		arg_263_1.duration_ = 13.47

		local var_263_0 = {
			zh = 12.533,
			ja = 13.466
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
				arg_263_0:Play317292066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 1.475

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(317292065)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 59 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 59)

				if (59 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 59)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292065", "story_v_out_317292.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292065", "story_v_out_317292.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_317292", "317292065", "story_v_out_317292.awb")

						arg_263_1:RecordAudio("317292065", var_266_6)
						arg_263_1:RecordAudio("317292065", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_317292", "317292065", "story_v_out_317292.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_317292", "317292065", "story_v_out_317292.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play317292066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 317292066
		arg_267_1.duration_ = 9.1

		local var_267_0 = {
			zh = 9.1,
			ja = 9.033
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play317292067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.25

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:GetWordFromCfg(317292066)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 50 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 50)

				if (50 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 50)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292066", "story_v_out_317292.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292066", "story_v_out_317292.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_317292", "317292066", "story_v_out_317292.awb")

						arg_267_1:RecordAudio("317292066", var_270_6)
						arg_267_1:RecordAudio("317292066", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_317292", "317292066", "story_v_out_317292.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_317292", "317292066", "story_v_out_317292.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play317292067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 317292067
		arg_271_1.duration_ = 8.2

		local var_271_0 = {
			zh = 5.033,
			ja = 8.2
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play317292068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1093ui_story = arg_271_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1093ui_story"].transform.position).z)
				arg_271_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1093ui_story"].transform.localEulerAngles = arg_271_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_271_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1093ui_story"].transform.position).z)
				arg_271_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1093ui_story"].transform.localEulerAngles = arg_271_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1093ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1093ui_story == nil then
				arg_271_1.var_.characterEffect1093ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1093ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1093ui_story then
				arg_271_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_4 = arg_271_1.actors_["1199ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1199ui_story = var_274_4.localPosition
			end

			local var_274_5 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_5 then
				var_274_4.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_271_1.time_ - 0) / var_274_5)
				var_274_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_4.position).x, (manager.ui.mainCamera.transform.position - var_274_4.position).y, (manager.ui.mainCamera.transform.position - var_274_4.position).z)
				var_274_4.localEulerAngles.z = 0
				var_274_4.localEulerAngles.x = 0
				var_274_4.localEulerAngles = var_274_4.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_5 and arg_271_1.time_ < 0 + var_274_5 + arg_274_0 then
				var_274_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_274_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_4.position).x, (manager.ui.mainCamera.transform.position - var_274_4.position).y, (manager.ui.mainCamera.transform.position - var_274_4.position).z)
				var_274_4.localEulerAngles.z = 0
				var_274_4.localEulerAngles.x = 0
				var_274_4.localEulerAngles = var_274_4.localEulerAngles
			end

			local var_274_6 = arg_271_1.actors_["1199ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect1199ui_story == nil then
				arg_271_1.var_.characterEffect1199ui_story = var_274_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_7 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 and not isNil(var_274_6) then
				if arg_271_1.var_.characterEffect1199ui_story and not isNil(var_274_6) then
					arg_271_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_7)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect1199ui_story then
				arg_271_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_274_8 = 0
			local var_274_9 = 0.575

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:GetWordFromCfg(317292067)
				local var_274_11 = arg_271_1:FormatText(var_274_10.content)

				arg_271_1.text_.text = var_274_11

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 23 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 23)

				if (23 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 23)) > 0 and var_274_9 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_11
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292067", "story_v_out_317292.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292067", "story_v_out_317292.awb") / 1000

					if var_274_14 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_8
					end

					if var_274_10.prefab_name ~= "" and arg_271_1.actors_[var_274_10.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_10.prefab_name].transform, "story_v_out_317292", "317292067", "story_v_out_317292.awb")

						arg_271_1:RecordAudio("317292067", var_274_15)
						arg_271_1:RecordAudio("317292067", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_317292", "317292067", "story_v_out_317292.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_317292", "317292067", "story_v_out_317292.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play317292068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 317292068
		arg_275_1.duration_ = 8.9

		local var_275_0 = {
			zh = 8.9,
			ja = 5.5
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play317292069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1015ui_story = arg_275_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).z)
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles = arg_275_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_275_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).z)
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles = arg_275_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1015ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1015ui_story == nil then
				arg_275_1.var_.characterEffect1015ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1015ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1015ui_story then
				arg_275_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_278_4 = arg_275_1.actors_["1093ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1093ui_story = var_278_4.localPosition
			end

			local var_278_5 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 then
				var_278_4.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_5)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 then
				var_278_4.localPosition = Vector3.New(0, 100, 0)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			local var_278_6 = arg_275_1.actors_["1093ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1093ui_story == nil then
				arg_275_1.var_.characterEffect1093ui_story = var_278_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_7 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 and not isNil(var_278_6) then
				if arg_275_1.var_.characterEffect1093ui_story and not isNil(var_278_6) then
					arg_275_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_7)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1093ui_story then
				arg_275_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_278_8 = arg_275_1.actors_["1199ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1199ui_story = var_278_8.localPosition
			end

			local var_278_9 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_9 then
				var_278_8.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_9)
				var_278_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_8.position).x, (manager.ui.mainCamera.transform.position - var_278_8.position).y, (manager.ui.mainCamera.transform.position - var_278_8.position).z)
				var_278_8.localEulerAngles.z = 0
				var_278_8.localEulerAngles.x = 0
				var_278_8.localEulerAngles = var_278_8.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_9 and arg_275_1.time_ < 0 + var_278_9 + arg_278_0 then
				var_278_8.localPosition = Vector3.New(0, 100, 0)
				var_278_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_8.position).x, (manager.ui.mainCamera.transform.position - var_278_8.position).y, (manager.ui.mainCamera.transform.position - var_278_8.position).z)
				var_278_8.localEulerAngles.z = 0
				var_278_8.localEulerAngles.x = 0
				var_278_8.localEulerAngles = var_278_8.localEulerAngles
			end

			local var_278_10 = arg_275_1.actors_["1199ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_10) and arg_275_1.var_.characterEffect1199ui_story == nil then
				arg_275_1.var_.characterEffect1199ui_story = var_278_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_11 and not isNil(var_278_10) then
				if arg_275_1.var_.characterEffect1199ui_story and not isNil(var_278_10) then
					arg_275_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_11)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_11 and arg_275_1.time_ < 0 + var_278_11 + arg_278_0 and not isNil(var_278_10) and arg_275_1.var_.characterEffect1199ui_story then
				arg_275_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_278_12 = 0
			local var_278_13 = 1.025

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_12 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_14 = arg_275_1:GetWordFromCfg(317292068)
				local var_278_15 = arg_275_1:FormatText(var_278_14.content)

				arg_275_1.text_.text = var_278_15

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_17 = 41 <= 0 and var_278_13 or var_278_13 * (utf8.len(var_278_15) / 41)

				if (41 <= 0 and var_278_13 or var_278_13 * (utf8.len(var_278_15) / 41)) > 0 and var_278_13 < var_278_17 then
					arg_275_1.talkMaxDuration = var_278_17

					if var_278_17 + var_278_12 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_17 + var_278_12
					end
				end

				arg_275_1.text_.text = var_278_15
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292068", "story_v_out_317292.awb") ~= 0 then
					local var_278_18 = manager.audio:GetVoiceLength("story_v_out_317292", "317292068", "story_v_out_317292.awb") / 1000

					if var_278_18 + var_278_12 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_18 + var_278_12
					end

					if var_278_14.prefab_name ~= "" and arg_275_1.actors_[var_278_14.prefab_name] ~= nil then
						local var_278_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_14.prefab_name].transform, "story_v_out_317292", "317292068", "story_v_out_317292.awb")

						arg_275_1:RecordAudio("317292068", var_278_19)
						arg_275_1:RecordAudio("317292068", var_278_19)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_317292", "317292068", "story_v_out_317292.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_317292", "317292068", "story_v_out_317292.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_20 = math.max(var_278_13, arg_275_1.talkMaxDuration)

			if var_278_12 <= arg_275_1.time_ and arg_275_1.time_ < var_278_12 + var_278_20 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_12) / var_278_20

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_12 + var_278_20 and arg_275_1.time_ < var_278_12 + var_278_20 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play317292069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 317292069
		arg_279_1.duration_ = 5.67

		local var_279_0 = {
			zh = 4.1,
			ja = 5.666
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
				arg_279_0:Play317292070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.45

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:GetWordFromCfg(317292069)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 18 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 18)

				if (18 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 18)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292069", "story_v_out_317292.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292069", "story_v_out_317292.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_out_317292", "317292069", "story_v_out_317292.awb")

						arg_279_1:RecordAudio("317292069", var_282_6)
						arg_279_1:RecordAudio("317292069", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_317292", "317292069", "story_v_out_317292.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_317292", "317292069", "story_v_out_317292.awb")
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
	Play317292070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 317292070
		arg_283_1.duration_ = 16.73

		local var_283_0 = {
			zh = 16.733,
			ja = 14
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play317292071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.925

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:GetWordFromCfg(317292070)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 77 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 77)

				if (77 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 77)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292070", "story_v_out_317292.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292070", "story_v_out_317292.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_317292", "317292070", "story_v_out_317292.awb")

						arg_283_1:RecordAudio("317292070", var_286_6)
						arg_283_1:RecordAudio("317292070", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_317292", "317292070", "story_v_out_317292.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_317292", "317292070", "story_v_out_317292.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play317292071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 317292071
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play317292072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_290_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_287_1.bgmTxt_.text ~= var_290_2 and arg_287_1.bgmTxt_.text ~= "" then
						if arg_287_1.bgmTxt2_.text ~= "" then
							arg_287_1.bgmTxt_.text = arg_287_1.bgmTxt2_.text
						end

						arg_287_1.bgmTxt2_.text = var_290_2

						arg_287_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_287_1.bgmTxt_.text = var_290_2
						arg_287_1.bgmTxt2_.text = var_290_2
					end

					if arg_287_1.bgmTimer then
						arg_287_1.bgmTimer:Stop()

						arg_287_1.bgmTimer = nil
					end

					if arg_287_1.settingData.show_music_name == 1 then
						arg_287_1.musicController:SetSelectedState("show")
						arg_287_1.musicAnimator_:Play("open", 0, 0)

						if arg_287_1.settingData.music_time ~= 0 then
							arg_287_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_287_1.settingData.music_time), function()
								if arg_287_1 == nil or isNil(arg_287_1.bgmTxt_) then
									return
								end

								arg_287_1.musicController:SetSelectedState("hide")
								arg_287_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_290_3 = arg_287_1.actors_["1015ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect1015ui_story == nil then
				arg_287_1.var_.characterEffect1015ui_story = var_290_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_4 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 and not isNil(var_290_3) then
				if arg_287_1.var_.characterEffect1015ui_story and not isNil(var_290_3) then
					arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_4)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect1015ui_story then
				arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_290_5 = 0
			local var_290_6 = 0.675

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_7 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(317292071).content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 27 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_7) / 27)

				if (27 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_7) / 27)) > 0 and var_290_6 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_10 and arg_287_1.time_ < var_290_5 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play317292072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 317292072
		arg_292_1.duration_ = 7.57

		local var_292_0 = {
			zh = 7.566,
			ja = 6.033
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
				arg_292_0:Play317292073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if arg_292_1.bgs_.YA0206 == nil then
				local var_295_0 = Object.Instantiate(arg_292_1.paintGo_)

				var_295_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0206")
				var_295_0.name = "YA0206"
				var_295_0.transform.parent = arg_292_1.stage_.transform
				var_295_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.bgs_.YA0206 = var_295_0
			end

			if 2 < arg_292_1.time_ and arg_292_1.time_ <= 2 + arg_295_0 then
				local var_295_1 = arg_292_1.bgs_.YA0206

				arg_292_1.bgs_.YA0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_295_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_295_2 = var_295_1:GetComponent("SpriteRenderer")

				if var_295_2 and var_295_2.sprite then
					local var_295_3 = 2 * (var_295_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_295_1.transform.localScale = Vector3.New(var_295_3 / var_295_2.sprite.bounds.size.y < var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x and var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x or var_295_3 / var_295_2.sprite.bounds.size.y, var_295_3 / var_295_2.sprite.bounds.size.y < var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x and var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x or var_295_3 / var_295_2.sprite.bounds.size.y, 0)
				end

				for iter_295_0, iter_295_1 in pairs(arg_292_1.bgs_) do
					if iter_295_0 ~= "YA0206" then
						iter_295_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_295_4 = 0

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = true

				arg_292_1:SetGaussion(false)
			end

			local var_295_5 = 2

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_5 then
				local var_295_6 = Color.New(0, 0, 0)

				var_295_6.a = Mathf.Lerp(0, 1, (arg_292_1.time_ - var_295_4) / var_295_5)
				arg_292_1.mask_.color = var_295_6
			end

			if arg_292_1.time_ >= var_295_4 + var_295_5 and arg_292_1.time_ < var_295_4 + var_295_5 + arg_295_0 then
				local var_295_7 = Color.New(0, 0, 0)

				var_295_7.a = 1
				arg_292_1.mask_.color = var_295_7
			end

			local var_295_8 = 2

			if 2 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = true

				arg_292_1:SetGaussion(false)
			end

			local var_295_9 = 2

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_9 then
				local var_295_10 = Color.New(0, 0, 0)

				var_295_10.a = Mathf.Lerp(1, 0, (arg_292_1.time_ - var_295_8) / var_295_9)
				arg_292_1.mask_.color = var_295_10
			end

			if arg_292_1.time_ >= var_295_8 + var_295_9 and arg_292_1.time_ < var_295_8 + var_295_9 + arg_295_0 then
				local var_295_11 = Color.New(0, 0, 0)

				arg_292_1.mask_.enabled = false
				var_295_11.a = 0
				arg_292_1.mask_.color = var_295_11
			end

			local var_295_12 = arg_292_1.actors_["1015ui_story"].transform

			if 2 < arg_292_1.time_ and arg_292_1.time_ <= 2 + arg_295_0 then
				arg_292_1.var_.moveOldPos1015ui_story = var_295_12.localPosition
			end

			local var_295_13 = 0.001

			if 2 <= arg_292_1.time_ and arg_292_1.time_ < 2 + var_295_13 then
				var_295_12.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 2) / var_295_13)
				var_295_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_12.position).x, (manager.ui.mainCamera.transform.position - var_295_12.position).y, (manager.ui.mainCamera.transform.position - var_295_12.position).z)
				var_295_12.localEulerAngles.z = 0
				var_295_12.localEulerAngles.x = 0
				var_295_12.localEulerAngles = var_295_12.localEulerAngles
			end

			if arg_292_1.time_ >= 2 + var_295_13 and arg_292_1.time_ < 2 + var_295_13 + arg_295_0 then
				var_295_12.localPosition = Vector3.New(0, 100, 0)
				var_295_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_12.position).x, (manager.ui.mainCamera.transform.position - var_295_12.position).y, (manager.ui.mainCamera.transform.position - var_295_12.position).z)
				var_295_12.localEulerAngles.z = 0
				var_295_12.localEulerAngles.x = 0
				var_295_12.localEulerAngles = var_295_12.localEulerAngles
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_295_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_292_1.bgmTxt_.text ~= var_295_16 and arg_292_1.bgmTxt_.text ~= "" then
						if arg_292_1.bgmTxt2_.text ~= "" then
							arg_292_1.bgmTxt_.text = arg_292_1.bgmTxt2_.text
						end

						arg_292_1.bgmTxt2_.text = var_295_16

						arg_292_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_292_1.bgmTxt_.text = var_295_16
						arg_292_1.bgmTxt2_.text = var_295_16
					end

					if arg_292_1.bgmTimer then
						arg_292_1.bgmTimer:Stop()

						arg_292_1.bgmTimer = nil
					end

					if arg_292_1.settingData.show_music_name == 1 then
						arg_292_1.musicController:SetSelectedState("show")
						arg_292_1.musicAnimator_:Play("open", 0, 0)

						if arg_292_1.settingData.music_time ~= 0 then
							arg_292_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_292_1.settingData.music_time), function()
								if arg_292_1 == nil or isNil(arg_292_1.bgmTxt_) then
									return
								end

								arg_292_1.musicController:SetSelectedState("hide")
								arg_292_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_295_17 = arg_292_1.bgs_.YA0206.transform

			if 2 < arg_292_1.time_ and arg_292_1.time_ <= 2 + arg_295_0 then
				arg_292_1.var_.moveOldPosYA0206 = var_295_17.localPosition
			end

			local var_295_18 = 0.001

			if 2 <= arg_292_1.time_ and arg_292_1.time_ < 2 + var_295_18 then
				var_295_17.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPosYA0206, Vector3.New(-0.74, -1.09, -1.26), (arg_292_1.time_ - 2) / var_295_18)
			end

			if arg_292_1.time_ >= 2 + var_295_18 and arg_292_1.time_ < 2 + var_295_18 + arg_295_0 then
				var_295_17.localPosition = Vector3.New(-0.74, -1.09, -1.26)
			end

			local var_295_19 = arg_292_1.bgs_.YA0206.transform

			if 2.034 < arg_292_1.time_ and arg_292_1.time_ <= 2.034 + arg_295_0 then
				arg_292_1.var_.moveOldPosYA0206 = var_295_19.localPosition
			end

			local var_295_20 = 3

			if 2.034 <= arg_292_1.time_ and arg_292_1.time_ < 2.034 + var_295_20 then
				var_295_19.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPosYA0206, Vector3.New(-0.74, -1.09, -1), (arg_292_1.time_ - 2.034) / var_295_20)
			end

			if arg_292_1.time_ >= 2.034 + var_295_20 and arg_292_1.time_ < 2.034 + var_295_20 + arg_295_0 then
				var_295_19.localPosition = Vector3.New(-0.74, -1.09, -1)
			end

			if arg_292_1.frameCnt_ <= 1 then
				arg_292_1.dialog_:SetActive(false)
			end

			local var_295_21 = 4
			local var_295_22 = 0.275

			if 4 < arg_292_1.time_ and arg_292_1.time_ <= var_295_21 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				arg_292_1.dialog_:SetActive(true)

				arg_292_1.dialogCg_.alpha = 0

				local var_295_23 = LeanTween.value(arg_292_1.dialog_, 0, 1, 0.3)

				var_295_23:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_292_1.dialogCg_.alpha = arg_297_0
				end))
				var_295_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_292_1.dialog_)
					var_295_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_292_1.duration_ = arg_292_1.duration_ + 0.3

				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_24 = arg_292_1:GetWordFromCfg(317292072)
				local var_295_25 = arg_292_1:FormatText(var_295_24.content)

				arg_292_1.text_.text = var_295_25

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_27 = 11 <= 0 and var_295_22 or var_295_22 * (utf8.len(var_295_25) / 11)

				if (11 <= 0 and var_295_22 or var_295_22 * (utf8.len(var_295_25) / 11)) > 0 and var_295_22 < var_295_27 then
					arg_292_1.talkMaxDuration = var_295_27
					var_295_21 = var_295_21 + 0.3

					if var_295_27 + var_295_21 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_27 + var_295_21
					end
				end

				arg_292_1.text_.text = var_295_25
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292072", "story_v_out_317292.awb") ~= 0 then
					local var_295_28 = manager.audio:GetVoiceLength("story_v_out_317292", "317292072", "story_v_out_317292.awb") / 1000

					if var_295_28 + var_295_21 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_28 + var_295_21
					end

					if var_295_24.prefab_name ~= "" and arg_292_1.actors_[var_295_24.prefab_name] ~= nil then
						local var_295_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_24.prefab_name].transform, "story_v_out_317292", "317292072", "story_v_out_317292.awb")

						arg_292_1:RecordAudio("317292072", var_295_29)
						arg_292_1:RecordAudio("317292072", var_295_29)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_317292", "317292072", "story_v_out_317292.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_317292", "317292072", "story_v_out_317292.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_30 = var_295_21 + 0.3
			local var_295_31 = math.max(var_295_22, arg_292_1.talkMaxDuration)

			if var_295_21 + 0.3 <= arg_292_1.time_ and arg_292_1.time_ < var_295_30 + var_295_31 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_30) / var_295_31

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_30 + var_295_31 and arg_292_1.time_ < var_295_30 + var_295_31 + arg_295_0 then
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
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "YA0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play317292073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 317292073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play317292074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.55

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

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(317292073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 22 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 22)

				if (22 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 22)) > 0 and var_302_0 < var_302_3 then
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
	Play317292074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 317292074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play317292075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.3

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(317292074).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 52 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 52)

				if (52 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 52)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play317292075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 317292075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play317292076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.725

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(317292075).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 29 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 29)

				if (29 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 29)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play317292076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 317292076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play317292077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.15

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(317292076).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 6 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 6)

				if (6 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 6)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play317292077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 317292077
		arg_315_1.duration_ = 6

		local var_315_0 = {
			zh = 6,
			ja = 2.3
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
				arg_315_0:Play317292078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_318_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_315_1.bgmTxt_.text ~= var_318_2 and arg_315_1.bgmTxt_.text ~= "" then
						if arg_315_1.bgmTxt2_.text ~= "" then
							arg_315_1.bgmTxt_.text = arg_315_1.bgmTxt2_.text
						end

						arg_315_1.bgmTxt2_.text = var_318_2

						arg_315_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_315_1.bgmTxt_.text = var_318_2
						arg_315_1.bgmTxt2_.text = var_318_2
					end

					if arg_315_1.bgmTimer then
						arg_315_1.bgmTimer:Stop()

						arg_315_1.bgmTimer = nil
					end

					if arg_315_1.settingData.show_music_name == 1 then
						arg_315_1.musicController:SetSelectedState("show")
						arg_315_1.musicAnimator_:Play("open", 0, 0)

						if arg_315_1.settingData.music_time ~= 0 then
							arg_315_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_315_1.settingData.music_time), function()
								if arg_315_1 == nil or isNil(arg_315_1.bgmTxt_) then
									return
								end

								arg_315_1.musicController:SetSelectedState("hide")
								arg_315_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.733333333333333 < arg_315_1.time_ and arg_315_1.time_ <= 0.733333333333333 + arg_318_0 then
				arg_315_1:AudioAction("play", "music", "bgm_activity_2_7_story_death", "bgm_activity_2_7_story_death", "bgm_activity_2_7_story_death.awb")

				local var_318_5 = manager.audio:GetAudioName("bgm_activity_2_7_story_death", "bgm_activity_2_7_story_death")

				if "" ~= "" then
					if arg_315_1.bgmTxt_.text ~= var_318_5 and arg_315_1.bgmTxt_.text ~= "" then
						if arg_315_1.bgmTxt2_.text ~= "" then
							arg_315_1.bgmTxt_.text = arg_315_1.bgmTxt2_.text
						end

						arg_315_1.bgmTxt2_.text = var_318_5

						arg_315_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_315_1.bgmTxt_.text = var_318_5
						arg_315_1.bgmTxt2_.text = var_318_5
					end

					if arg_315_1.bgmTimer then
						arg_315_1.bgmTimer:Stop()

						arg_315_1.bgmTimer = nil
					end

					if arg_315_1.settingData.show_music_name == 1 then
						arg_315_1.musicController:SetSelectedState("show")
						arg_315_1.musicAnimator_:Play("open", 0, 0)

						if arg_315_1.settingData.music_time ~= 0 then
							arg_315_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_315_1.settingData.music_time), function()
								if arg_315_1 == nil or isNil(arg_315_1.bgmTxt_) then
									return
								end

								arg_315_1.musicController:SetSelectedState("hide")
								arg_315_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_318_6 = 0
			local var_318_7 = 0.7

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_8 = arg_315_1:GetWordFromCfg(317292077)
				local var_318_9 = arg_315_1:FormatText(var_318_8.content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 28 <= 0 and var_318_7 or var_318_7 * (utf8.len(var_318_9) / 28)

				if (28 <= 0 and var_318_7 or var_318_7 * (utf8.len(var_318_9) / 28)) > 0 and var_318_7 < var_318_11 then
					arg_315_1.talkMaxDuration = var_318_11

					if var_318_11 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292077", "story_v_out_317292.awb") ~= 0 then
					local var_318_12 = manager.audio:GetVoiceLength("story_v_out_317292", "317292077", "story_v_out_317292.awb") / 1000

					if var_318_12 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_12 + var_318_6
					end

					if var_318_8.prefab_name ~= "" and arg_315_1.actors_[var_318_8.prefab_name] ~= nil then
						local var_318_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_8.prefab_name].transform, "story_v_out_317292", "317292077", "story_v_out_317292.awb")

						arg_315_1:RecordAudio("317292077", var_318_13)
						arg_315_1:RecordAudio("317292077", var_318_13)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_317292", "317292077", "story_v_out_317292.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_317292", "317292077", "story_v_out_317292.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_14 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_14 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_14

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_14 and arg_315_1.time_ < var_318_6 + var_318_14 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play317292078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 317292078
		arg_321_1.duration_ = 7.57

		local var_321_0 = {
			zh = 5.066,
			ja = 7.566
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play317292079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.7

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(317292078)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 28 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 28)

				if (28 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 28)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292078", "story_v_out_317292.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292078", "story_v_out_317292.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_317292", "317292078", "story_v_out_317292.awb")

						arg_321_1:RecordAudio("317292078", var_324_6)
						arg_321_1:RecordAudio("317292078", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_317292", "317292078", "story_v_out_317292.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_317292", "317292078", "story_v_out_317292.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play317292079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 317292079
		arg_325_1.duration_ = 18.03

		local var_325_0 = {
			zh = 18.033,
			ja = 12.166
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play317292080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 2.175

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:GetWordFromCfg(317292079)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 88 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 88)

				if (88 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 88)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292079", "story_v_out_317292.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292079", "story_v_out_317292.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_317292", "317292079", "story_v_out_317292.awb")

						arg_325_1:RecordAudio("317292079", var_328_6)
						arg_325_1:RecordAudio("317292079", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_317292", "317292079", "story_v_out_317292.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_317292", "317292079", "story_v_out_317292.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play317292080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 317292080
		arg_329_1.duration_ = 4.97

		local var_329_0 = {
			zh = 4.8,
			ja = 4.966
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play317292081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.55

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:GetWordFromCfg(317292080)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 22 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 22)

				if (22 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 22)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292080", "story_v_out_317292.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292080", "story_v_out_317292.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_317292", "317292080", "story_v_out_317292.awb")

						arg_329_1:RecordAudio("317292080", var_332_6)
						arg_329_1:RecordAudio("317292080", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_317292", "317292080", "story_v_out_317292.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_317292", "317292080", "story_v_out_317292.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play317292081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 317292081
		arg_333_1.duration_ = 14.1

		local var_333_0 = {
			zh = 14.1,
			ja = 9.8
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play317292082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 1.625

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:GetWordFromCfg(317292081)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 66 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 66)

				if (66 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 66)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292081", "story_v_out_317292.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292081", "story_v_out_317292.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_317292", "317292081", "story_v_out_317292.awb")

						arg_333_1:RecordAudio("317292081", var_336_6)
						arg_333_1:RecordAudio("317292081", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_317292", "317292081", "story_v_out_317292.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_317292", "317292081", "story_v_out_317292.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play317292082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 317292082
		arg_337_1.duration_ = 9

		local var_337_0 = {
			zh = 9,
			ja = 7.166
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play317292083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.15

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:GetWordFromCfg(317292082)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 46 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 46)

				if (46 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 46)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292082", "story_v_out_317292.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292082", "story_v_out_317292.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_317292", "317292082", "story_v_out_317292.awb")

						arg_337_1:RecordAudio("317292082", var_340_6)
						arg_337_1:RecordAudio("317292082", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_317292", "317292082", "story_v_out_317292.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_317292", "317292082", "story_v_out_317292.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play317292083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 317292083
		arg_341_1.duration_ = 11.6

		local var_341_0 = {
			zh = 11.6,
			ja = 9.6
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play317292084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.3

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:GetWordFromCfg(317292083)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 52 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 52)

				if (52 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 52)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292083", "story_v_out_317292.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292083", "story_v_out_317292.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_317292", "317292083", "story_v_out_317292.awb")

						arg_341_1:RecordAudio("317292083", var_344_6)
						arg_341_1:RecordAudio("317292083", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_317292", "317292083", "story_v_out_317292.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_317292", "317292083", "story_v_out_317292.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play317292084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 317292084
		arg_345_1.duration_ = 10.6

		local var_345_0 = {
			zh = 9.133,
			ja = 10.6
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play317292085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.925

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(317292084)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 37 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 37)

				if (37 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 37)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292084", "story_v_out_317292.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292084", "story_v_out_317292.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_317292", "317292084", "story_v_out_317292.awb")

						arg_345_1:RecordAudio("317292084", var_348_6)
						arg_345_1:RecordAudio("317292084", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_317292", "317292084", "story_v_out_317292.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_317292", "317292084", "story_v_out_317292.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play317292085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 317292085
		arg_349_1.duration_ = 8.83

		local var_349_0 = {
			zh = 8.833,
			ja = 8.7
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play317292086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.975

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:GetWordFromCfg(317292085)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 39 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 39)

				if (39 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 39)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292085", "story_v_out_317292.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292085", "story_v_out_317292.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_out_317292", "317292085", "story_v_out_317292.awb")

						arg_349_1:RecordAudio("317292085", var_352_6)
						arg_349_1:RecordAudio("317292085", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_317292", "317292085", "story_v_out_317292.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_317292", "317292085", "story_v_out_317292.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play317292086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 317292086
		arg_353_1.duration_ = 10.37

		local var_353_0 = {
			zh = 10.366,
			ja = 9.266
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play317292087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.225

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:GetWordFromCfg(317292086)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 49 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 49)

				if (49 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 49)) > 0 and var_356_0 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292086", "story_v_out_317292.awb") ~= 0 then
					local var_356_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292086", "story_v_out_317292.awb") / 1000

					if var_356_5 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + 0
					end

					if var_356_1.prefab_name ~= "" and arg_353_1.actors_[var_356_1.prefab_name] ~= nil then
						local var_356_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_1.prefab_name].transform, "story_v_out_317292", "317292086", "story_v_out_317292.awb")

						arg_353_1:RecordAudio("317292086", var_356_6)
						arg_353_1:RecordAudio("317292086", var_356_6)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_317292", "317292086", "story_v_out_317292.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_317292", "317292086", "story_v_out_317292.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play317292087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 317292087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play317292088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 1.575

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(317292087).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 63 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 63)

				if (63 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 63)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play317292088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 317292088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play317292089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.7

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(317292088).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 28 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 28)

				if (28 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 28)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play317292089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 317292089
		arg_365_1.duration_ = 8.83

		local var_365_0 = {
			zh = 8.833,
			ja = 7.666
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play317292090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(317292089)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 40 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 40)

				if (40 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 40)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292089", "story_v_out_317292.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292089", "story_v_out_317292.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_317292", "317292089", "story_v_out_317292.awb")

						arg_365_1:RecordAudio("317292089", var_368_6)
						arg_365_1:RecordAudio("317292089", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_317292", "317292089", "story_v_out_317292.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_317292", "317292089", "story_v_out_317292.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play317292090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 317292090
		arg_369_1.duration_ = 9.77

		local var_369_0 = {
			zh = 9.3,
			ja = 9.766
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play317292091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 1.15

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:GetWordFromCfg(317292090)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.text_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 46 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 46)

				if (46 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 46)) > 0 and var_372_0 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end

				arg_369_1.text_.text = var_372_2
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292090", "story_v_out_317292.awb") ~= 0 then
					local var_372_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292090", "story_v_out_317292.awb") / 1000

					if var_372_5 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + 0
					end

					if var_372_1.prefab_name ~= "" and arg_369_1.actors_[var_372_1.prefab_name] ~= nil then
						local var_372_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_1.prefab_name].transform, "story_v_out_317292", "317292090", "story_v_out_317292.awb")

						arg_369_1:RecordAudio("317292090", var_372_6)
						arg_369_1:RecordAudio("317292090", var_372_6)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_317292", "317292090", "story_v_out_317292.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_317292", "317292090", "story_v_out_317292.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play317292091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 317292091
		arg_373_1.duration_ = 14.2

		local var_373_0 = {
			zh = 14.2,
			ja = 14.033
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play317292092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 2.05

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_1 = arg_373_1:GetWordFromCfg(317292091)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 78 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 78)

				if (78 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 78)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292091", "story_v_out_317292.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292091", "story_v_out_317292.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_out_317292", "317292091", "story_v_out_317292.awb")

						arg_373_1:RecordAudio("317292091", var_376_6)
						arg_373_1:RecordAudio("317292091", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_317292", "317292091", "story_v_out_317292.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_317292", "317292091", "story_v_out_317292.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play317292092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 317292092
		arg_377_1.duration_ = 6.93

		local var_377_0 = {
			zh = 5.8,
			ja = 6.933
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play317292093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.675

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:GetWordFromCfg(317292092)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 27 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 27)

				if (27 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 27)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292092", "story_v_out_317292.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292092", "story_v_out_317292.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_out_317292", "317292092", "story_v_out_317292.awb")

						arg_377_1:RecordAudio("317292092", var_380_6)
						arg_377_1:RecordAudio("317292092", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_317292", "317292092", "story_v_out_317292.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_317292", "317292092", "story_v_out_317292.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play317292093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 317292093
		arg_381_1.duration_ = 12.4

		local var_381_0 = {
			zh = 11.8,
			ja = 12.4
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play317292094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 1.325

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:GetWordFromCfg(317292093)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 53 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 53)

				if (53 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 53)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292093", "story_v_out_317292.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292093", "story_v_out_317292.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_317292", "317292093", "story_v_out_317292.awb")

						arg_381_1:RecordAudio("317292093", var_384_6)
						arg_381_1:RecordAudio("317292093", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_317292", "317292093", "story_v_out_317292.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_317292", "317292093", "story_v_out_317292.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play317292094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 317292094
		arg_385_1.duration_ = 10.63

		local var_385_0 = {
			zh = 10.633,
			ja = 9.9
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play317292095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 1.175

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(317292094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 47 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 47)

				if (47 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 47)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292094", "story_v_out_317292.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292094", "story_v_out_317292.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_317292", "317292094", "story_v_out_317292.awb")

						arg_385_1:RecordAudio("317292094", var_388_6)
						arg_385_1:RecordAudio("317292094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_317292", "317292094", "story_v_out_317292.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_317292", "317292094", "story_v_out_317292.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play317292095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 317292095
		arg_389_1.duration_ = 10.9

		local var_389_0 = {
			zh = 10.9,
			ja = 6.6
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play317292096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 1.35

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:GetWordFromCfg(317292095)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 54 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 54)

				if (54 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 54)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292095", "story_v_out_317292.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292095", "story_v_out_317292.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_out_317292", "317292095", "story_v_out_317292.awb")

						arg_389_1:RecordAudio("317292095", var_392_6)
						arg_389_1:RecordAudio("317292095", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_317292", "317292095", "story_v_out_317292.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_317292", "317292095", "story_v_out_317292.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play317292096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 317292096
		arg_393_1.duration_ = 13.1

		local var_393_0 = {
			zh = 12.566,
			ja = 13.1
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play317292097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.4

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:GetWordFromCfg(317292096)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 56 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 56)

				if (56 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 56)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292096", "story_v_out_317292.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292096", "story_v_out_317292.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_317292", "317292096", "story_v_out_317292.awb")

						arg_393_1:RecordAudio("317292096", var_396_6)
						arg_393_1:RecordAudio("317292096", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_317292", "317292096", "story_v_out_317292.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_317292", "317292096", "story_v_out_317292.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play317292097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 317292097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play317292098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.5

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(317292097).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 20 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 20)

				if (20 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 20)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play317292098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 317292098
		arg_401_1.duration_ = 18.57

		local var_401_0 = {
			zh = 18.566,
			ja = 11.266
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play317292099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 2.1

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:GetWordFromCfg(317292098)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 84 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 84)

				if (84 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 84)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292098", "story_v_out_317292.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292098", "story_v_out_317292.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_317292", "317292098", "story_v_out_317292.awb")

						arg_401_1:RecordAudio("317292098", var_404_6)
						arg_401_1:RecordAudio("317292098", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_317292", "317292098", "story_v_out_317292.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_317292", "317292098", "story_v_out_317292.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play317292099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 317292099
		arg_405_1.duration_ = 7.1

		local var_405_0 = {
			zh = 7.1,
			ja = 5.9
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play317292100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.85

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:GetWordFromCfg(317292099)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 34 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 34)

				if (34 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 34)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292099", "story_v_out_317292.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292099", "story_v_out_317292.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_317292", "317292099", "story_v_out_317292.awb")

						arg_405_1:RecordAudio("317292099", var_408_6)
						arg_405_1:RecordAudio("317292099", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_317292", "317292099", "story_v_out_317292.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_317292", "317292099", "story_v_out_317292.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play317292100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 317292100
		arg_409_1.duration_ = 6.73

		local var_409_0 = {
			zh = 5,
			ja = 6.733
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play317292101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.375

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_1 = arg_409_1:GetWordFromCfg(317292100)
				local var_412_2 = arg_409_1:FormatText(var_412_1.content)

				arg_409_1.text_.text = var_412_2

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 15 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 15)

				if (15 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 15)) > 0 and var_412_0 < var_412_4 then
					arg_409_1.talkMaxDuration = var_412_4

					if var_412_4 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_4 + 0
					end
				end

				arg_409_1.text_.text = var_412_2
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292100", "story_v_out_317292.awb") ~= 0 then
					local var_412_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292100", "story_v_out_317292.awb") / 1000

					if var_412_5 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + 0
					end

					if var_412_1.prefab_name ~= "" and arg_409_1.actors_[var_412_1.prefab_name] ~= nil then
						local var_412_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_1.prefab_name].transform, "story_v_out_317292", "317292100", "story_v_out_317292.awb")

						arg_409_1:RecordAudio("317292100", var_412_6)
						arg_409_1:RecordAudio("317292100", var_412_6)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_317292", "317292100", "story_v_out_317292.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_317292", "317292100", "story_v_out_317292.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_7 and arg_409_1.time_ < 0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play317292101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 317292101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play317292102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.8

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(317292101).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 32 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 32)

				if (32 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 32)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play317292102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 317292102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play317292103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.325

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_1 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(317292102).content)

				arg_417_1.text_.text = var_420_1

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_3 = 13 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 13)

				if (13 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 13)) > 0 and var_420_0 < var_420_3 then
					arg_417_1.talkMaxDuration = var_420_3

					if var_420_3 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_3 + 0
					end
				end

				arg_417_1.text_.text = var_420_1
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_4 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_4

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play317292103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 317292103
		arg_421_1.duration_ = 16.97

		local var_421_0 = {
			zh = 16.966,
			ja = 8.7
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play317292104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 1.9

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:GetWordFromCfg(317292103)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 76 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 76)

				if (76 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 76)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292103", "story_v_out_317292.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292103", "story_v_out_317292.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_317292", "317292103", "story_v_out_317292.awb")

						arg_421_1:RecordAudio("317292103", var_424_6)
						arg_421_1:RecordAudio("317292103", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_317292", "317292103", "story_v_out_317292.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_317292", "317292103", "story_v_out_317292.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play317292104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 317292104
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play317292105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.525

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(317292104).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 21 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 21)

				if (21 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 21)) > 0 and var_428_0 < var_428_3 then
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
	Play317292105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 317292105
		arg_429_1.duration_ = 7.13

		local var_429_0 = {
			zh = 7.133,
			ja = 2.1
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play317292106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.7

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:GetWordFromCfg(317292105)
				local var_432_2 = arg_429_1:FormatText(var_432_1.content)

				arg_429_1.text_.text = var_432_2

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 28 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 28)

				if (28 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 28)) > 0 and var_432_0 < var_432_4 then
					arg_429_1.talkMaxDuration = var_432_4

					if var_432_4 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_4 + 0
					end
				end

				arg_429_1.text_.text = var_432_2
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292105", "story_v_out_317292.awb") ~= 0 then
					local var_432_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292105", "story_v_out_317292.awb") / 1000

					if var_432_5 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + 0
					end

					if var_432_1.prefab_name ~= "" and arg_429_1.actors_[var_432_1.prefab_name] ~= nil then
						local var_432_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_1.prefab_name].transform, "story_v_out_317292", "317292105", "story_v_out_317292.awb")

						arg_429_1:RecordAudio("317292105", var_432_6)
						arg_429_1:RecordAudio("317292105", var_432_6)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_317292", "317292105", "story_v_out_317292.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_317292", "317292105", "story_v_out_317292.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play317292106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 317292106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play317292107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.9

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(317292106).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 36 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 36)

				if (36 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 36)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play317292107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 317292107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play317292108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.425

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_1 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(317292107).content)

				arg_437_1.text_.text = var_440_1

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_3 = 17 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 17)

				if (17 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 17)) > 0 and var_440_0 < var_440_3 then
					arg_437_1.talkMaxDuration = var_440_3

					if var_440_3 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_3 + 0
					end
				end

				arg_437_1.text_.text = var_440_1
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_4 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_4

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play317292108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 317292108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play317292109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.55

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(317292108).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 22 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 22)

				if (22 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 22)) > 0 and var_444_0 < var_444_3 then
					arg_441_1.talkMaxDuration = var_444_3

					if var_444_3 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_3 + 0
					end
				end

				arg_441_1.text_.text = var_444_1
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_4 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_4

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play317292109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 317292109
		arg_445_1.duration_ = 9.33

		local var_445_0 = {
			zh = 5.9,
			ja = 9.333
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play317292110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 2 < arg_445_1.time_ and arg_445_1.time_ <= 2 + arg_448_0 then
				local var_448_0 = arg_445_1.bgs_.YA0206

				arg_445_1.bgs_.YA0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_448_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_448_1 = var_448_0:GetComponent("SpriteRenderer")

				if var_448_1 and var_448_1.sprite then
					local var_448_2 = 2 * (var_448_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_448_0.transform.localScale = Vector3.New(var_448_2 / var_448_1.sprite.bounds.size.y < var_448_2 * manager.ui.mainCameraCom_.aspect / var_448_1.sprite.bounds.size.x and var_448_2 * manager.ui.mainCameraCom_.aspect / var_448_1.sprite.bounds.size.x or var_448_2 / var_448_1.sprite.bounds.size.y, var_448_2 / var_448_1.sprite.bounds.size.y < var_448_2 * manager.ui.mainCameraCom_.aspect / var_448_1.sprite.bounds.size.x and var_448_2 * manager.ui.mainCameraCom_.aspect / var_448_1.sprite.bounds.size.x or var_448_2 / var_448_1.sprite.bounds.size.y, 0)
				end

				for iter_448_0, iter_448_1 in pairs(arg_445_1.bgs_) do
					if iter_448_0 ~= "YA0206" then
						iter_448_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_448_3 = 0

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_3 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = true

				arg_445_1:SetGaussion(false)
			end

			local var_448_4 = 2

			if var_448_3 <= arg_445_1.time_ and arg_445_1.time_ < var_448_3 + var_448_4 then
				local var_448_5 = Color.New(0, 0, 0)

				var_448_5.a = Mathf.Lerp(0, 1, (arg_445_1.time_ - var_448_3) / var_448_4)
				arg_445_1.mask_.color = var_448_5
			end

			if arg_445_1.time_ >= var_448_3 + var_448_4 and arg_445_1.time_ < var_448_3 + var_448_4 + arg_448_0 then
				local var_448_6 = Color.New(0, 0, 0)

				var_448_6.a = 1
				arg_445_1.mask_.color = var_448_6
			end

			local var_448_7 = 2

			if 2 < arg_445_1.time_ and arg_445_1.time_ <= var_448_7 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = true

				arg_445_1:SetGaussion(false)
			end

			local var_448_8 = 2

			if var_448_7 <= arg_445_1.time_ and arg_445_1.time_ < var_448_7 + var_448_8 then
				local var_448_9 = Color.New(0, 0, 0)

				var_448_9.a = Mathf.Lerp(1, 0, (arg_445_1.time_ - var_448_7) / var_448_8)
				arg_445_1.mask_.color = var_448_9
			end

			if arg_445_1.time_ >= var_448_7 + var_448_8 and arg_445_1.time_ < var_448_7 + var_448_8 + arg_448_0 then
				local var_448_10 = Color.New(0, 0, 0)

				arg_445_1.mask_.enabled = false
				var_448_10.a = 0
				arg_445_1.mask_.color = var_448_10
			end

			local var_448_11 = arg_445_1.bgs_.YA0206.transform

			if 2 < arg_445_1.time_ and arg_445_1.time_ <= 2 + arg_448_0 then
				arg_445_1.var_.moveOldPosYA0206 = var_448_11.localPosition
			end

			local var_448_12 = 0.001

			if 2 <= arg_445_1.time_ and arg_445_1.time_ < 2 + var_448_12 then
				var_448_11.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPosYA0206, Vector3.New(-5.71, -1.7, -3.18), (arg_445_1.time_ - 2) / var_448_12)
			end

			if arg_445_1.time_ >= 2 + var_448_12 and arg_445_1.time_ < 2 + var_448_12 + arg_448_0 then
				var_448_11.localPosition = Vector3.New(-5.71, -1.7, -3.18)
			end

			local var_448_13 = arg_445_1.bgs_.YA0206.transform

			if 2.034 < arg_445_1.time_ and arg_445_1.time_ <= 2.034 + arg_448_0 then
				arg_445_1.var_.moveOldPosYA0206 = var_448_13.localPosition
			end

			local var_448_14 = 2.59933333333333

			if 2.034 <= arg_445_1.time_ and arg_445_1.time_ < 2.034 + var_448_14 then
				var_448_13.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPosYA0206, Vector3.New(-5.71, -1.7, -3), (arg_445_1.time_ - 2.034) / var_448_14)
			end

			if arg_445_1.time_ >= 2.034 + var_448_14 and arg_445_1.time_ < 2.034 + var_448_14 + arg_448_0 then
				var_448_13.localPosition = Vector3.New(-5.71, -1.7, -3)
			end

			if arg_445_1.frameCnt_ <= 1 then
				arg_445_1.dialog_:SetActive(false)
			end

			local var_448_15 = 4
			local var_448_16 = 0.225

			if 4 < arg_445_1.time_ and arg_445_1.time_ <= var_448_15 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0

				arg_445_1.dialog_:SetActive(true)

				arg_445_1.dialogCg_.alpha = 0

				local var_448_17 = LeanTween.value(arg_445_1.dialog_, 0, 1, 0.3)

				var_448_17:setOnUpdate(LuaHelper.FloatAction(function(arg_449_0)
					arg_445_1.dialogCg_.alpha = arg_449_0
				end))
				var_448_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_445_1.dialog_)
					var_448_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_445_1.duration_ = arg_445_1.duration_ + 0.3

				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_18 = arg_445_1:GetWordFromCfg(317292109)
				local var_448_19 = arg_445_1:FormatText(var_448_18.content)

				arg_445_1.text_.text = var_448_19

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_21 = 9 <= 0 and var_448_16 or var_448_16 * (utf8.len(var_448_19) / 9)

				if (9 <= 0 and var_448_16 or var_448_16 * (utf8.len(var_448_19) / 9)) > 0 and var_448_16 < var_448_21 then
					arg_445_1.talkMaxDuration = var_448_21
					var_448_15 = var_448_15 + 0.3

					if var_448_21 + var_448_15 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_21 + var_448_15
					end
				end

				arg_445_1.text_.text = var_448_19
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292109", "story_v_out_317292.awb") ~= 0 then
					local var_448_22 = manager.audio:GetVoiceLength("story_v_out_317292", "317292109", "story_v_out_317292.awb") / 1000

					if var_448_22 + var_448_15 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_22 + var_448_15
					end

					if var_448_18.prefab_name ~= "" and arg_445_1.actors_[var_448_18.prefab_name] ~= nil then
						local var_448_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_18.prefab_name].transform, "story_v_out_317292", "317292109", "story_v_out_317292.awb")

						arg_445_1:RecordAudio("317292109", var_448_23)
						arg_445_1:RecordAudio("317292109", var_448_23)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_317292", "317292109", "story_v_out_317292.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_317292", "317292109", "story_v_out_317292.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_24 = var_448_15 + 0.3
			local var_448_25 = math.max(var_448_16, arg_445_1.talkMaxDuration)

			if var_448_15 + 0.3 <= arg_445_1.time_ and arg_445_1.time_ < var_448_24 + var_448_25 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_24) / var_448_25

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_24 + var_448_25 and arg_445_1.time_ < var_448_24 + var_448_25 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "YA0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.59933333333333,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play317292110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 317292110
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play317292111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 1.025

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(317292110).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 41 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 41)

				if (41 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 41)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play317292111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 317292111
		arg_455_1.duration_ = 8.83

		local var_455_0 = {
			zh = 7.033,
			ja = 8.833
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
				arg_455_0:Play317292112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.85

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:GetWordFromCfg(317292111)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 34 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 34)

				if (34 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 34)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292111", "story_v_out_317292.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292111", "story_v_out_317292.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_out_317292", "317292111", "story_v_out_317292.awb")

						arg_455_1:RecordAudio("317292111", var_458_6)
						arg_455_1:RecordAudio("317292111", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_317292", "317292111", "story_v_out_317292.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_317292", "317292111", "story_v_out_317292.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_7 and arg_455_1.time_ < 0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play317292112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 317292112
		arg_459_1.duration_ = 14.23

		local var_459_0 = {
			zh = 12.233,
			ja = 14.233
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play317292113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 1.3

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:GetWordFromCfg(317292112)
				local var_462_2 = arg_459_1:FormatText(var_462_1.content)

				arg_459_1.text_.text = var_462_2

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 52 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 52)

				if (52 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 52)) > 0 and var_462_0 < var_462_4 then
					arg_459_1.talkMaxDuration = var_462_4

					if var_462_4 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_4 + 0
					end
				end

				arg_459_1.text_.text = var_462_2
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292112", "story_v_out_317292.awb") ~= 0 then
					local var_462_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292112", "story_v_out_317292.awb") / 1000

					if var_462_5 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + 0
					end

					if var_462_1.prefab_name ~= "" and arg_459_1.actors_[var_462_1.prefab_name] ~= nil then
						local var_462_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_1.prefab_name].transform, "story_v_out_317292", "317292112", "story_v_out_317292.awb")

						arg_459_1:RecordAudio("317292112", var_462_6)
						arg_459_1:RecordAudio("317292112", var_462_6)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_317292", "317292112", "story_v_out_317292.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_317292", "317292112", "story_v_out_317292.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_7 and arg_459_1.time_ < 0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play317292113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 317292113
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play317292114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.075

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(317292113).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 3 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 3)

				if (3 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 3)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play317292114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 317292114
		arg_467_1.duration_ = 14.77

		local var_467_0 = {
			zh = 14.7666666666667,
			ja = 10.2666666666667
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play317292115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 2 < arg_467_1.time_ and arg_467_1.time_ <= 2 + arg_470_0 then
				local var_470_0 = arg_467_1.bgs_.YA0206

				arg_467_1.bgs_.YA0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_470_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_470_1 = var_470_0:GetComponent("SpriteRenderer")

				if var_470_1 and var_470_1.sprite then
					local var_470_2 = 2 * (var_470_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_470_0.transform.localScale = Vector3.New(var_470_2 / var_470_1.sprite.bounds.size.y < var_470_2 * manager.ui.mainCameraCom_.aspect / var_470_1.sprite.bounds.size.x and var_470_2 * manager.ui.mainCameraCom_.aspect / var_470_1.sprite.bounds.size.x or var_470_2 / var_470_1.sprite.bounds.size.y, var_470_2 / var_470_1.sprite.bounds.size.y < var_470_2 * manager.ui.mainCameraCom_.aspect / var_470_1.sprite.bounds.size.x and var_470_2 * manager.ui.mainCameraCom_.aspect / var_470_1.sprite.bounds.size.x or var_470_2 / var_470_1.sprite.bounds.size.y, 0)
				end

				for iter_470_0, iter_470_1 in pairs(arg_467_1.bgs_) do
					if iter_470_0 ~= "YA0206" then
						iter_470_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_470_3 = 0

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_3 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_4 = 2

			if var_470_3 <= arg_467_1.time_ and arg_467_1.time_ < var_470_3 + var_470_4 then
				local var_470_5 = Color.New(0, 0, 0)

				var_470_5.a = Mathf.Lerp(0, 1, (arg_467_1.time_ - var_470_3) / var_470_4)
				arg_467_1.mask_.color = var_470_5
			end

			if arg_467_1.time_ >= var_470_3 + var_470_4 and arg_467_1.time_ < var_470_3 + var_470_4 + arg_470_0 then
				local var_470_6 = Color.New(0, 0, 0)

				var_470_6.a = 1
				arg_467_1.mask_.color = var_470_6
			end

			local var_470_7 = 2

			if 2 < arg_467_1.time_ and arg_467_1.time_ <= var_470_7 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_8 = 2

			if var_470_7 <= arg_467_1.time_ and arg_467_1.time_ < var_470_7 + var_470_8 then
				local var_470_9 = Color.New(0, 0, 0)

				var_470_9.a = Mathf.Lerp(1, 0, (arg_467_1.time_ - var_470_7) / var_470_8)
				arg_467_1.mask_.color = var_470_9
			end

			if arg_467_1.time_ >= var_470_7 + var_470_8 and arg_467_1.time_ < var_470_7 + var_470_8 + arg_470_0 then
				local var_470_10 = Color.New(0, 0, 0)

				arg_467_1.mask_.enabled = false
				var_470_10.a = 0
				arg_467_1.mask_.color = var_470_10
			end

			local var_470_11 = arg_467_1.bgs_.YA0206.transform

			if 2 < arg_467_1.time_ and arg_467_1.time_ <= 2 + arg_470_0 then
				arg_467_1.var_.moveOldPosYA0206 = var_470_11.localPosition
			end

			local var_470_12 = 0.001

			if 2 <= arg_467_1.time_ and arg_467_1.time_ < 2 + var_470_12 then
				var_470_11.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPosYA0206, Vector3.New(4.13, -1.77, -4.08), (arg_467_1.time_ - 2) / var_470_12)
			end

			if arg_467_1.time_ >= 2 + var_470_12 and arg_467_1.time_ < 2 + var_470_12 + arg_470_0 then
				var_470_11.localPosition = Vector3.New(4.13, -1.77, -4.08)
			end

			local var_470_13 = arg_467_1.bgs_.YA0206.transform

			if 2.01666666666667 < arg_467_1.time_ and arg_467_1.time_ <= 2.01666666666667 + arg_470_0 then
				arg_467_1.var_.moveOldPosYA0206 = var_470_13.localPosition
			end

			local var_470_14 = 3.05

			if 2.01666666666667 <= arg_467_1.time_ and arg_467_1.time_ < 2.01666666666667 + var_470_14 then
				var_470_13.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPosYA0206, Vector3.New(4.13, -1.77, -3.9), (arg_467_1.time_ - 2.01666666666667) / var_470_14)
			end

			if arg_467_1.time_ >= 2.01666666666667 + var_470_14 and arg_467_1.time_ < 2.01666666666667 + var_470_14 + arg_470_0 then
				var_470_13.localPosition = Vector3.New(4.13, -1.77, -3.9)
			end

			if arg_467_1.frameCnt_ <= 1 then
				arg_467_1.dialog_:SetActive(false)
			end

			local var_470_15 = 3.96666666666667
			local var_470_16 = 1.1

			if 3.96666666666667 < arg_467_1.time_ and arg_467_1.time_ <= var_470_15 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0

				arg_467_1.dialog_:SetActive(true)

				arg_467_1.dialogCg_.alpha = 0

				local var_470_17 = LeanTween.value(arg_467_1.dialog_, 0, 1, 0.3)

				var_470_17:setOnUpdate(LuaHelper.FloatAction(function(arg_471_0)
					arg_467_1.dialogCg_.alpha = arg_471_0
				end))
				var_470_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_467_1.dialog_)
					var_470_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_467_1.duration_ = arg_467_1.duration_ + 0.3

				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_18 = arg_467_1:GetWordFromCfg(317292114)
				local var_470_19 = arg_467_1:FormatText(var_470_18.content)

				arg_467_1.text_.text = var_470_19

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_21 = 45 <= 0 and var_470_16 or var_470_16 * (utf8.len(var_470_19) / 45)

				if (45 <= 0 and var_470_16 or var_470_16 * (utf8.len(var_470_19) / 45)) > 0 and var_470_16 < var_470_21 then
					arg_467_1.talkMaxDuration = var_470_21
					var_470_15 = var_470_15 + 0.3

					if var_470_21 + var_470_15 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_21 + var_470_15
					end
				end

				arg_467_1.text_.text = var_470_19
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292114", "story_v_out_317292.awb") ~= 0 then
					local var_470_22 = manager.audio:GetVoiceLength("story_v_out_317292", "317292114", "story_v_out_317292.awb") / 1000

					if var_470_22 + var_470_15 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_22 + var_470_15
					end

					if var_470_18.prefab_name ~= "" and arg_467_1.actors_[var_470_18.prefab_name] ~= nil then
						local var_470_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_18.prefab_name].transform, "story_v_out_317292", "317292114", "story_v_out_317292.awb")

						arg_467_1:RecordAudio("317292114", var_470_23)
						arg_467_1:RecordAudio("317292114", var_470_23)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_317292", "317292114", "story_v_out_317292.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_317292", "317292114", "story_v_out_317292.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_24 = var_470_15 + 0.3
			local var_470_25 = math.max(var_470_16, arg_467_1.talkMaxDuration)

			if var_470_15 + 0.3 <= arg_467_1.time_ and arg_467_1.time_ < var_470_24 + var_470_25 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_24) / var_470_25

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_24 + var_470_25 and arg_467_1.time_ < var_470_24 + var_470_25 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "YA0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.05,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play317292115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 317292115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play317292116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.925

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(317292115).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 37 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 37)

				if (37 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 37)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play317292116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 317292116
		arg_477_1.duration_ = 8.23

		local var_477_0 = {
			zh = 4.833,
			ja = 8.233
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play317292117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.allBtn_.enabled = false
			end

			if arg_477_1.time_ >= 0 + 1.33333333333333 and arg_477_1.time_ < 0 + 1.33333333333333 + arg_480_0 then
				arg_477_1.allBtn_.enabled = true
			end

			local var_480_0 = 0
			local var_480_1 = 0.5

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_2 = arg_477_1:GetWordFromCfg(317292116)
				local var_480_3 = arg_477_1:FormatText(var_480_2.content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 20 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 20)

				if (20 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 20)) > 0 and var_480_1 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292116", "story_v_out_317292.awb") ~= 0 then
					local var_480_6 = manager.audio:GetVoiceLength("story_v_out_317292", "317292116", "story_v_out_317292.awb") / 1000

					if var_480_6 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_6 + var_480_0
					end

					if var_480_2.prefab_name ~= "" and arg_477_1.actors_[var_480_2.prefab_name] ~= nil then
						local var_480_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_2.prefab_name].transform, "story_v_out_317292", "317292116", "story_v_out_317292.awb")

						arg_477_1:RecordAudio("317292116", var_480_7)
						arg_477_1:RecordAudio("317292116", var_480_7)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_317292", "317292116", "story_v_out_317292.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_317292", "317292116", "story_v_out_317292.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play317292117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 317292117
		arg_481_1.duration_ = 9

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play317292118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 2 < arg_481_1.time_ and arg_481_1.time_ <= 2 + arg_484_0 then
				local var_484_0 = arg_481_1.bgs_.YA0206

				arg_481_1.bgs_.YA0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_484_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_484_1 = var_484_0:GetComponent("SpriteRenderer")

				if var_484_1 and var_484_1.sprite then
					local var_484_2 = 2 * (var_484_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_484_0.transform.localScale = Vector3.New(var_484_2 / var_484_1.sprite.bounds.size.y < var_484_2 * manager.ui.mainCameraCom_.aspect / var_484_1.sprite.bounds.size.x and var_484_2 * manager.ui.mainCameraCom_.aspect / var_484_1.sprite.bounds.size.x or var_484_2 / var_484_1.sprite.bounds.size.y, var_484_2 / var_484_1.sprite.bounds.size.y < var_484_2 * manager.ui.mainCameraCom_.aspect / var_484_1.sprite.bounds.size.x and var_484_2 * manager.ui.mainCameraCom_.aspect / var_484_1.sprite.bounds.size.x or var_484_2 / var_484_1.sprite.bounds.size.y, 0)
				end

				for iter_484_0, iter_484_1 in pairs(arg_481_1.bgs_) do
					if iter_484_0 ~= "YA0206" then
						iter_484_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_484_3 = 0

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_3 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_4 = 2

			if var_484_3 <= arg_481_1.time_ and arg_481_1.time_ < var_484_3 + var_484_4 then
				local var_484_5 = Color.New(0, 0, 0)

				var_484_5.a = Mathf.Lerp(0, 1, (arg_481_1.time_ - var_484_3) / var_484_4)
				arg_481_1.mask_.color = var_484_5
			end

			if arg_481_1.time_ >= var_484_3 + var_484_4 and arg_481_1.time_ < var_484_3 + var_484_4 + arg_484_0 then
				local var_484_6 = Color.New(0, 0, 0)

				var_484_6.a = 1
				arg_481_1.mask_.color = var_484_6
			end

			local var_484_7 = 2

			if 2 < arg_481_1.time_ and arg_481_1.time_ <= var_484_7 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_8 = 2

			if var_484_7 <= arg_481_1.time_ and arg_481_1.time_ < var_484_7 + var_484_8 then
				local var_484_9 = Color.New(0, 0, 0)

				var_484_9.a = Mathf.Lerp(1, 0, (arg_481_1.time_ - var_484_7) / var_484_8)
				arg_481_1.mask_.color = var_484_9
			end

			if arg_481_1.time_ >= var_484_7 + var_484_8 and arg_481_1.time_ < var_484_7 + var_484_8 + arg_484_0 then
				local var_484_10 = Color.New(0, 0, 0)

				arg_481_1.mask_.enabled = false
				var_484_10.a = 0
				arg_481_1.mask_.color = var_484_10
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_11 = 4
			local var_484_12 = 1.375

			if 4 < arg_481_1.time_ and arg_481_1.time_ <= var_484_11 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_13 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_13:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_481_1.dialogCg_.alpha = arg_485_0
				end))
				var_484_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_14 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(317292117).content)

				arg_481_1.text_.text = var_484_14

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_16 = 55 <= 0 and var_484_12 or var_484_12 * (utf8.len(var_484_14) / 55)

				if (55 <= 0 and var_484_12 or var_484_12 * (utf8.len(var_484_14) / 55)) > 0 and var_484_12 < var_484_16 then
					arg_481_1.talkMaxDuration = var_484_16
					var_484_11 = var_484_11 + 0.3

					if var_484_16 + var_484_11 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_16 + var_484_11
					end
				end

				arg_481_1.text_.text = var_484_14
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_17 = var_484_11 + 0.3
			local var_484_18 = math.max(var_484_12, arg_481_1.talkMaxDuration)

			if var_484_11 + 0.3 <= arg_481_1.time_ and arg_481_1.time_ < var_484_17 + var_484_18 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_17) / var_484_18

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_17 + var_484_18 and arg_481_1.time_ < var_484_17 + var_484_18 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play317292118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 317292118
		arg_487_1.duration_ = 14.37

		local var_487_0 = {
			zh = 14.366,
			ja = 4.566
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play317292119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 1.45

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:GetWordFromCfg(317292118)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 58 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 58)

				if (58 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 58)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292118", "story_v_out_317292.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292118", "story_v_out_317292.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_out_317292", "317292118", "story_v_out_317292.awb")

						arg_487_1:RecordAudio("317292118", var_490_6)
						arg_487_1:RecordAudio("317292118", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_317292", "317292118", "story_v_out_317292.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_317292", "317292118", "story_v_out_317292.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play317292119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 317292119
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play317292120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.15

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

				local var_494_1 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(317292119).content)

				arg_491_1.text_.text = var_494_1

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_3 = 6 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 6)

				if (6 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 6)) > 0 and var_494_0 < var_494_3 then
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
	Play317292120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 317292120
		arg_495_1.duration_ = 6.7

		local var_495_0 = {
			zh = 6.333,
			ja = 6.7
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play317292121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.775

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(317292120)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 31 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 31)

				if (31 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 31)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292120", "story_v_out_317292.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292120", "story_v_out_317292.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_317292", "317292120", "story_v_out_317292.awb")

						arg_495_1:RecordAudio("317292120", var_498_6)
						arg_495_1:RecordAudio("317292120", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_317292", "317292120", "story_v_out_317292.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_317292", "317292120", "story_v_out_317292.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play317292121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 317292121
		arg_499_1.duration_ = 3.8

		local var_499_0 = {
			zh = 3.8,
			ja = 2.4
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play317292122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.35

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:GetWordFromCfg(317292121)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 14 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 14)

				if (14 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 14)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292121", "story_v_out_317292.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292121", "story_v_out_317292.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_out_317292", "317292121", "story_v_out_317292.awb")

						arg_499_1:RecordAudio("317292121", var_502_6)
						arg_499_1:RecordAudio("317292121", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_317292", "317292121", "story_v_out_317292.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_317292", "317292121", "story_v_out_317292.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play317292122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 317292122
		arg_503_1.duration_ = 15

		local var_503_0 = {
			zh = 15,
			ja = 9.666
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play317292123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 1.775

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:GetWordFromCfg(317292122)
				local var_506_2 = arg_503_1:FormatText(var_506_1.content)

				arg_503_1.text_.text = var_506_2

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 68 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 68)

				if (68 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 68)) > 0 and var_506_0 < var_506_4 then
					arg_503_1.talkMaxDuration = var_506_4

					if var_506_4 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_4 + 0
					end
				end

				arg_503_1.text_.text = var_506_2
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292122", "story_v_out_317292.awb") ~= 0 then
					local var_506_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292122", "story_v_out_317292.awb") / 1000

					if var_506_5 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + 0
					end

					if var_506_1.prefab_name ~= "" and arg_503_1.actors_[var_506_1.prefab_name] ~= nil then
						local var_506_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_1.prefab_name].transform, "story_v_out_317292", "317292122", "story_v_out_317292.awb")

						arg_503_1:RecordAudio("317292122", var_506_6)
						arg_503_1:RecordAudio("317292122", var_506_6)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_317292", "317292122", "story_v_out_317292.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_317292", "317292122", "story_v_out_317292.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play317292123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 317292123
		arg_507_1.duration_ = 15.03

		local var_507_0 = {
			zh = 15.033,
			ja = 7.3
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play317292124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.725

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:GetWordFromCfg(317292123)
				local var_510_2 = arg_507_1:FormatText(var_510_1.content)

				arg_507_1.text_.text = var_510_2

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 69 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 69)

				if (69 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 69)) > 0 and var_510_0 < var_510_4 then
					arg_507_1.talkMaxDuration = var_510_4

					if var_510_4 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_4 + 0
					end
				end

				arg_507_1.text_.text = var_510_2
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292123", "story_v_out_317292.awb") ~= 0 then
					local var_510_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292123", "story_v_out_317292.awb") / 1000

					if var_510_5 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + 0
					end

					if var_510_1.prefab_name ~= "" and arg_507_1.actors_[var_510_1.prefab_name] ~= nil then
						local var_510_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_1.prefab_name].transform, "story_v_out_317292", "317292123", "story_v_out_317292.awb")

						arg_507_1:RecordAudio("317292123", var_510_6)
						arg_507_1:RecordAudio("317292123", var_510_6)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_317292", "317292123", "story_v_out_317292.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_317292", "317292123", "story_v_out_317292.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play317292124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 317292124
		arg_511_1.duration_ = 11.73

		local var_511_0 = {
			zh = 10.1,
			ja = 11.733
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
				arg_511_0:Play317292125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 1.15

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_1 = arg_511_1:GetWordFromCfg(317292124)
				local var_514_2 = arg_511_1:FormatText(var_514_1.content)

				arg_511_1.text_.text = var_514_2

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_4 = 46 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 46)

				if (46 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 46)) > 0 and var_514_0 < var_514_4 then
					arg_511_1.talkMaxDuration = var_514_4

					if var_514_4 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_4 + 0
					end
				end

				arg_511_1.text_.text = var_514_2
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292124", "story_v_out_317292.awb") ~= 0 then
					local var_514_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292124", "story_v_out_317292.awb") / 1000

					if var_514_5 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + 0
					end

					if var_514_1.prefab_name ~= "" and arg_511_1.actors_[var_514_1.prefab_name] ~= nil then
						local var_514_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_1.prefab_name].transform, "story_v_out_317292", "317292124", "story_v_out_317292.awb")

						arg_511_1:RecordAudio("317292124", var_514_6)
						arg_511_1:RecordAudio("317292124", var_514_6)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_317292", "317292124", "story_v_out_317292.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_317292", "317292124", "story_v_out_317292.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_7 and arg_511_1.time_ < 0 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play317292125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 317292125
		arg_515_1.duration_ = 10.67

		local var_515_0 = {
			zh = 6.033,
			ja = 10.666
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play317292126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.8

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_1 = arg_515_1:GetWordFromCfg(317292125)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 31 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 31)

				if (31 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 31)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292125", "story_v_out_317292.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292125", "story_v_out_317292.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_out_317292", "317292125", "story_v_out_317292.awb")

						arg_515_1:RecordAudio("317292125", var_518_6)
						arg_515_1:RecordAudio("317292125", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_317292", "317292125", "story_v_out_317292.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_317292", "317292125", "story_v_out_317292.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play317292126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 317292126
		arg_519_1.duration_ = 10.83

		local var_519_0 = {
			zh = 10.833,
			ja = 4.533
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
				arg_519_0:Play317292127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 1.175

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_1 = arg_519_1:GetWordFromCfg(317292126)
				local var_522_2 = arg_519_1:FormatText(var_522_1.content)

				arg_519_1.text_.text = var_522_2

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_4 = 47 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 47)

				if (47 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 47)) > 0 and var_522_0 < var_522_4 then
					arg_519_1.talkMaxDuration = var_522_4

					if var_522_4 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_4 + 0
					end
				end

				arg_519_1.text_.text = var_522_2
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292126", "story_v_out_317292.awb") ~= 0 then
					local var_522_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292126", "story_v_out_317292.awb") / 1000

					if var_522_5 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + 0
					end

					if var_522_1.prefab_name ~= "" and arg_519_1.actors_[var_522_1.prefab_name] ~= nil then
						local var_522_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_1.prefab_name].transform, "story_v_out_317292", "317292126", "story_v_out_317292.awb")

						arg_519_1:RecordAudio("317292126", var_522_6)
						arg_519_1:RecordAudio("317292126", var_522_6)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_317292", "317292126", "story_v_out_317292.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_317292", "317292126", "story_v_out_317292.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_7 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_7

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play317292127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 317292127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play317292128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.675

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(317292127).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 27 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 27)

				if (27 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 27)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play317292128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 317292128
		arg_527_1.duration_ = 9.2

		local var_527_0 = {
			zh = 9.166,
			ja = 9.2
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play317292129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.975

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:GetWordFromCfg(317292128)
				local var_530_2 = arg_527_1:FormatText(var_530_1.content)

				arg_527_1.text_.text = var_530_2

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 39 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 39)

				if (39 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 39)) > 0 and var_530_0 < var_530_4 then
					arg_527_1.talkMaxDuration = var_530_4

					if var_530_4 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_4 + 0
					end
				end

				arg_527_1.text_.text = var_530_2
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292128", "story_v_out_317292.awb") ~= 0 then
					local var_530_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292128", "story_v_out_317292.awb") / 1000

					if var_530_5 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + 0
					end

					if var_530_1.prefab_name ~= "" and arg_527_1.actors_[var_530_1.prefab_name] ~= nil then
						local var_530_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_1.prefab_name].transform, "story_v_out_317292", "317292128", "story_v_out_317292.awb")

						arg_527_1:RecordAudio("317292128", var_530_6)
						arg_527_1:RecordAudio("317292128", var_530_6)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_317292", "317292128", "story_v_out_317292.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_317292", "317292128", "story_v_out_317292.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play317292129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 317292129
		arg_531_1.duration_ = 15.73

		local var_531_0 = {
			zh = 15.733,
			ja = 4.866
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
				arg_531_0:Play317292130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 1.475

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_1 = arg_531_1:GetWordFromCfg(317292129)
				local var_534_2 = arg_531_1:FormatText(var_534_1.content)

				arg_531_1.text_.text = var_534_2

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 59 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 59)

				if (59 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 59)) > 0 and var_534_0 < var_534_4 then
					arg_531_1.talkMaxDuration = var_534_4

					if var_534_4 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_4 + 0
					end
				end

				arg_531_1.text_.text = var_534_2
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292129", "story_v_out_317292.awb") ~= 0 then
					local var_534_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292129", "story_v_out_317292.awb") / 1000

					if var_534_5 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + 0
					end

					if var_534_1.prefab_name ~= "" and arg_531_1.actors_[var_534_1.prefab_name] ~= nil then
						local var_534_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_1.prefab_name].transform, "story_v_out_317292", "317292129", "story_v_out_317292.awb")

						arg_531_1:RecordAudio("317292129", var_534_6)
						arg_531_1:RecordAudio("317292129", var_534_6)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_317292", "317292129", "story_v_out_317292.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_317292", "317292129", "story_v_out_317292.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play317292130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 317292130
		arg_535_1.duration_ = 12.53

		local var_535_0 = {
			zh = 12.533,
			ja = 5.066
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play317292131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 1.15

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_1 = arg_535_1:GetWordFromCfg(317292130)
				local var_538_2 = arg_535_1:FormatText(var_538_1.content)

				arg_535_1.text_.text = var_538_2

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 46 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 46)

				if (46 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 46)) > 0 and var_538_0 < var_538_4 then
					arg_535_1.talkMaxDuration = var_538_4

					if var_538_4 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_4 + 0
					end
				end

				arg_535_1.text_.text = var_538_2
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292130", "story_v_out_317292.awb") ~= 0 then
					local var_538_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292130", "story_v_out_317292.awb") / 1000

					if var_538_5 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + 0
					end

					if var_538_1.prefab_name ~= "" and arg_535_1.actors_[var_538_1.prefab_name] ~= nil then
						local var_538_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_1.prefab_name].transform, "story_v_out_317292", "317292130", "story_v_out_317292.awb")

						arg_535_1:RecordAudio("317292130", var_538_6)
						arg_535_1:RecordAudio("317292130", var_538_6)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_317292", "317292130", "story_v_out_317292.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_317292", "317292130", "story_v_out_317292.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play317292131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 317292131
		arg_539_1.duration_ = 12.13

		local var_539_0 = {
			zh = 12.133,
			ja = 10.666
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play317292132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 1.3

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_1 = arg_539_1:GetWordFromCfg(317292131)
				local var_542_2 = arg_539_1:FormatText(var_542_1.content)

				arg_539_1.text_.text = var_542_2

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_4 = 52 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 52)

				if (52 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 52)) > 0 and var_542_0 < var_542_4 then
					arg_539_1.talkMaxDuration = var_542_4

					if var_542_4 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_4 + 0
					end
				end

				arg_539_1.text_.text = var_542_2
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292131", "story_v_out_317292.awb") ~= 0 then
					local var_542_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292131", "story_v_out_317292.awb") / 1000

					if var_542_5 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + 0
					end

					if var_542_1.prefab_name ~= "" and arg_539_1.actors_[var_542_1.prefab_name] ~= nil then
						local var_542_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_1.prefab_name].transform, "story_v_out_317292", "317292131", "story_v_out_317292.awb")

						arg_539_1:RecordAudio("317292131", var_542_6)
						arg_539_1:RecordAudio("317292131", var_542_6)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_317292", "317292131", "story_v_out_317292.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_317292", "317292131", "story_v_out_317292.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_7 and arg_539_1.time_ < 0 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play317292132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 317292132
		arg_543_1.duration_ = 10.17

		local var_543_0 = {
			zh = 9.7,
			ja = 10.166
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play317292133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 1.05

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_1 = arg_543_1:GetWordFromCfg(317292132)
				local var_546_2 = arg_543_1:FormatText(var_546_1.content)

				arg_543_1.text_.text = var_546_2

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_4 = 42 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 42)

				if (42 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 42)) > 0 and var_546_0 < var_546_4 then
					arg_543_1.talkMaxDuration = var_546_4

					if var_546_4 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_4 + 0
					end
				end

				arg_543_1.text_.text = var_546_2
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292132", "story_v_out_317292.awb") ~= 0 then
					local var_546_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292132", "story_v_out_317292.awb") / 1000

					if var_546_5 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_5 + 0
					end

					if var_546_1.prefab_name ~= "" and arg_543_1.actors_[var_546_1.prefab_name] ~= nil then
						local var_546_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_1.prefab_name].transform, "story_v_out_317292", "317292132", "story_v_out_317292.awb")

						arg_543_1:RecordAudio("317292132", var_546_6)
						arg_543_1:RecordAudio("317292132", var_546_6)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_317292", "317292132", "story_v_out_317292.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_317292", "317292132", "story_v_out_317292.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_7 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_7 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_7

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_7 and arg_543_1.time_ < 0 + var_546_7 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play317292133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 317292133
		arg_547_1.duration_ = 11.8

		local var_547_0 = {
			zh = 7.266,
			ja = 11.8
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
				arg_547_0:Play317292134(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0.975

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_1 = arg_547_1:GetWordFromCfg(317292133)
				local var_550_2 = arg_547_1:FormatText(var_550_1.content)

				arg_547_1.text_.text = var_550_2

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_4 = 39 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 39)

				if (39 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 39)) > 0 and var_550_0 < var_550_4 then
					arg_547_1.talkMaxDuration = var_550_4

					if var_550_4 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_4 + 0
					end
				end

				arg_547_1.text_.text = var_550_2
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292133", "story_v_out_317292.awb") ~= 0 then
					local var_550_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292133", "story_v_out_317292.awb") / 1000

					if var_550_5 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + 0
					end

					if var_550_1.prefab_name ~= "" and arg_547_1.actors_[var_550_1.prefab_name] ~= nil then
						local var_550_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_1.prefab_name].transform, "story_v_out_317292", "317292133", "story_v_out_317292.awb")

						arg_547_1:RecordAudio("317292133", var_550_6)
						arg_547_1:RecordAudio("317292133", var_550_6)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_317292", "317292133", "story_v_out_317292.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_317292", "317292133", "story_v_out_317292.awb")
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
	Play317292134 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 317292134
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play317292135(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 1.15

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(317292134).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 46 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 46)

				if (46 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 46)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play317292135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 317292135
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play317292136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.35

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

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(317292135).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 14 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 14)

				if (14 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 14)) > 0 and var_558_0 < var_558_3 then
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
	Play317292136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 317292136
		arg_559_1.duration_ = 7.2

		local var_559_0 = {
			zh = 7.2,
			ja = 4.533
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play317292137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.5

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_1 = arg_559_1:GetWordFromCfg(317292136)
				local var_562_2 = arg_559_1:FormatText(var_562_1.content)

				arg_559_1.text_.text = var_562_2

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 20 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 20)

				if (20 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 20)) > 0 and var_562_0 < var_562_4 then
					arg_559_1.talkMaxDuration = var_562_4

					if var_562_4 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_4 + 0
					end
				end

				arg_559_1.text_.text = var_562_2
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292136", "story_v_out_317292.awb") ~= 0 then
					local var_562_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292136", "story_v_out_317292.awb") / 1000

					if var_562_5 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + 0
					end

					if var_562_1.prefab_name ~= "" and arg_559_1.actors_[var_562_1.prefab_name] ~= nil then
						local var_562_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_1.prefab_name].transform, "story_v_out_317292", "317292136", "story_v_out_317292.awb")

						arg_559_1:RecordAudio("317292136", var_562_6)
						arg_559_1:RecordAudio("317292136", var_562_6)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_317292", "317292136", "story_v_out_317292.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_317292", "317292136", "story_v_out_317292.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_7 and arg_559_1.time_ < 0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play317292137 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 317292137
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play317292138(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.125

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_1 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(317292137).content)

				arg_563_1.text_.text = var_566_1

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_3 = 5 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 5)

				if (5 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 5)) > 0 and var_566_0 < var_566_3 then
					arg_563_1.talkMaxDuration = var_566_3

					if var_566_3 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_3 + 0
					end
				end

				arg_563_1.text_.text = var_566_1
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_4 = math.max(var_566_0, arg_563_1.talkMaxDuration)

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_4 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - 0) / var_566_4

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= 0 + var_566_4 and arg_563_1.time_ < 0 + var_566_4 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play317292138 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 317292138
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play317292139(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0.575

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

				local var_570_1 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(317292138).content)

				arg_567_1.text_.text = var_570_1

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_3 = 23 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 23)

				if (23 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 23)) > 0 and var_570_0 < var_570_3 then
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
	Play317292139 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 317292139
		arg_571_1.duration_ = 3.6

		local var_571_0 = {
			zh = 3.6,
			ja = 2.6
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play317292140(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0.475

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_1 = arg_571_1:GetWordFromCfg(317292139)
				local var_574_2 = arg_571_1:FormatText(var_574_1.content)

				arg_571_1.text_.text = var_574_2

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_4 = 19 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_2) / 19)

				if (19 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_2) / 19)) > 0 and var_574_0 < var_574_4 then
					arg_571_1.talkMaxDuration = var_574_4

					if var_574_4 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_4 + 0
					end
				end

				arg_571_1.text_.text = var_574_2
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292139", "story_v_out_317292.awb") ~= 0 then
					local var_574_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292139", "story_v_out_317292.awb") / 1000

					if var_574_5 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_5 + 0
					end

					if var_574_1.prefab_name ~= "" and arg_571_1.actors_[var_574_1.prefab_name] ~= nil then
						local var_574_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_1.prefab_name].transform, "story_v_out_317292", "317292139", "story_v_out_317292.awb")

						arg_571_1:RecordAudio("317292139", var_574_6)
						arg_571_1:RecordAudio("317292139", var_574_6)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_317292", "317292139", "story_v_out_317292.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_317292", "317292139", "story_v_out_317292.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_0, arg_571_1.talkMaxDuration)

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - 0) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= 0 + var_574_7 and arg_571_1.time_ < 0 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play317292140 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 317292140
		arg_575_1.duration_ = 3.8

		local var_575_0 = {
			zh = 3.8,
			ja = 3.7
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play317292141(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.4

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_1 = arg_575_1:GetWordFromCfg(317292140)
				local var_578_2 = arg_575_1:FormatText(var_578_1.content)

				arg_575_1.text_.text = var_578_2

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 16 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 16)

				if (16 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 16)) > 0 and var_578_0 < var_578_4 then
					arg_575_1.talkMaxDuration = var_578_4

					if var_578_4 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_4 + 0
					end
				end

				arg_575_1.text_.text = var_578_2
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292140", "story_v_out_317292.awb") ~= 0 then
					local var_578_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292140", "story_v_out_317292.awb") / 1000

					if var_578_5 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + 0
					end

					if var_578_1.prefab_name ~= "" and arg_575_1.actors_[var_578_1.prefab_name] ~= nil then
						local var_578_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_1.prefab_name].transform, "story_v_out_317292", "317292140", "story_v_out_317292.awb")

						arg_575_1:RecordAudio("317292140", var_578_6)
						arg_575_1:RecordAudio("317292140", var_578_6)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_317292", "317292140", "story_v_out_317292.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_317292", "317292140", "story_v_out_317292.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_7 and arg_575_1.time_ < 0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play317292141 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 317292141
		arg_579_1.duration_ = 10.03

		local var_579_0 = {
			zh = 10.033,
			ja = 4.8
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play317292142(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 1.175

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_1 = arg_579_1:GetWordFromCfg(317292141)
				local var_582_2 = arg_579_1:FormatText(var_582_1.content)

				arg_579_1.text_.text = var_582_2

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 47 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 47)

				if (47 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 47)) > 0 and var_582_0 < var_582_4 then
					arg_579_1.talkMaxDuration = var_582_4

					if var_582_4 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_4 + 0
					end
				end

				arg_579_1.text_.text = var_582_2
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292141", "story_v_out_317292.awb") ~= 0 then
					local var_582_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292141", "story_v_out_317292.awb") / 1000

					if var_582_5 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + 0
					end

					if var_582_1.prefab_name ~= "" and arg_579_1.actors_[var_582_1.prefab_name] ~= nil then
						local var_582_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_1.prefab_name].transform, "story_v_out_317292", "317292141", "story_v_out_317292.awb")

						arg_579_1:RecordAudio("317292141", var_582_6)
						arg_579_1:RecordAudio("317292141", var_582_6)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_317292", "317292141", "story_v_out_317292.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_317292", "317292141", "story_v_out_317292.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_7 and arg_579_1.time_ < 0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play317292142 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 317292142
		arg_583_1.duration_ = 6.43

		local var_583_0 = {
			zh = 6.433,
			ja = 5.766
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
				arg_583_0:Play317292143(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.7

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_1 = arg_583_1:GetWordFromCfg(317292142)
				local var_586_2 = arg_583_1:FormatText(var_586_1.content)

				arg_583_1.text_.text = var_586_2

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 28 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 28)

				if (28 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 28)) > 0 and var_586_0 < var_586_4 then
					arg_583_1.talkMaxDuration = var_586_4

					if var_586_4 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_4 + 0
					end
				end

				arg_583_1.text_.text = var_586_2
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292142", "story_v_out_317292.awb") ~= 0 then
					local var_586_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292142", "story_v_out_317292.awb") / 1000

					if var_586_5 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + 0
					end

					if var_586_1.prefab_name ~= "" and arg_583_1.actors_[var_586_1.prefab_name] ~= nil then
						local var_586_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_1.prefab_name].transform, "story_v_out_317292", "317292142", "story_v_out_317292.awb")

						arg_583_1:RecordAudio("317292142", var_586_6)
						arg_583_1:RecordAudio("317292142", var_586_6)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_317292", "317292142", "story_v_out_317292.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_317292", "317292142", "story_v_out_317292.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_7 and arg_583_1.time_ < 0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play317292143 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 317292143
		arg_587_1.duration_ = 10.5

		local var_587_0 = {
			zh = 10.5,
			ja = 8.566
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play317292144(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 1.25

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_1 = arg_587_1:GetWordFromCfg(317292143)
				local var_590_2 = arg_587_1:FormatText(var_590_1.content)

				arg_587_1.text_.text = var_590_2

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_4 = 50 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_2) / 50)

				if (50 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_2) / 50)) > 0 and var_590_0 < var_590_4 then
					arg_587_1.talkMaxDuration = var_590_4

					if var_590_4 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_4 + 0
					end
				end

				arg_587_1.text_.text = var_590_2
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292143", "story_v_out_317292.awb") ~= 0 then
					local var_590_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292143", "story_v_out_317292.awb") / 1000

					if var_590_5 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + 0
					end

					if var_590_1.prefab_name ~= "" and arg_587_1.actors_[var_590_1.prefab_name] ~= nil then
						local var_590_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_1.prefab_name].transform, "story_v_out_317292", "317292143", "story_v_out_317292.awb")

						arg_587_1:RecordAudio("317292143", var_590_6)
						arg_587_1:RecordAudio("317292143", var_590_6)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_317292", "317292143", "story_v_out_317292.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_317292", "317292143", "story_v_out_317292.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_7 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_7 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_7

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_7 and arg_587_1.time_ < 0 + var_590_7 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play317292144 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 317292144
		arg_591_1.duration_ = 5.1

		local var_591_0 = {
			zh = 5.1,
			ja = 4.7
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play317292145(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.65

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:GetWordFromCfg(317292144)
				local var_594_2 = arg_591_1:FormatText(var_594_1.content)

				arg_591_1.text_.text = var_594_2

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_4 = 26 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_2) / 26)

				if (26 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_2) / 26)) > 0 and var_594_0 < var_594_4 then
					arg_591_1.talkMaxDuration = var_594_4

					if var_594_4 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_4 + 0
					end
				end

				arg_591_1.text_.text = var_594_2
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292144", "story_v_out_317292.awb") ~= 0 then
					local var_594_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292144", "story_v_out_317292.awb") / 1000

					if var_594_5 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_5 + 0
					end

					if var_594_1.prefab_name ~= "" and arg_591_1.actors_[var_594_1.prefab_name] ~= nil then
						local var_594_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_1.prefab_name].transform, "story_v_out_317292", "317292144", "story_v_out_317292.awb")

						arg_591_1:RecordAudio("317292144", var_594_6)
						arg_591_1:RecordAudio("317292144", var_594_6)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_317292", "317292144", "story_v_out_317292.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_317292", "317292144", "story_v_out_317292.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_7 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_7 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_7

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_7 and arg_591_1.time_ < 0 + var_594_7 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play317292145 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 317292145
		arg_595_1.duration_ = 2.63

		local var_595_0 = {
			zh = 2.633,
			ja = 2.366
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
				arg_595_0:Play317292146(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.325

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_1 = arg_595_1:GetWordFromCfg(317292145)
				local var_598_2 = arg_595_1:FormatText(var_598_1.content)

				arg_595_1.text_.text = var_598_2

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 13 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 13)

				if (13 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 13)) > 0 and var_598_0 < var_598_4 then
					arg_595_1.talkMaxDuration = var_598_4

					if var_598_4 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_4 + 0
					end
				end

				arg_595_1.text_.text = var_598_2
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292145", "story_v_out_317292.awb") ~= 0 then
					local var_598_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292145", "story_v_out_317292.awb") / 1000

					if var_598_5 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + 0
					end

					if var_598_1.prefab_name ~= "" and arg_595_1.actors_[var_598_1.prefab_name] ~= nil then
						local var_598_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_1.prefab_name].transform, "story_v_out_317292", "317292145", "story_v_out_317292.awb")

						arg_595_1:RecordAudio("317292145", var_598_6)
						arg_595_1:RecordAudio("317292145", var_598_6)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_317292", "317292145", "story_v_out_317292.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_317292", "317292145", "story_v_out_317292.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_7 and arg_595_1.time_ < 0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play317292146 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 317292146
		arg_599_1.duration_ = 6.2

		local var_599_0 = {
			zh = 6.2,
			ja = 4.566
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
				arg_599_0:Play317292147(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0.425

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_1 = arg_599_1:GetWordFromCfg(317292146)
				local var_602_2 = arg_599_1:FormatText(var_602_1.content)

				arg_599_1.text_.text = var_602_2

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_4 = 17 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 17)

				if (17 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 17)) > 0 and var_602_0 < var_602_4 then
					arg_599_1.talkMaxDuration = var_602_4

					if var_602_4 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_4 + 0
					end
				end

				arg_599_1.text_.text = var_602_2
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292146", "story_v_out_317292.awb") ~= 0 then
					local var_602_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292146", "story_v_out_317292.awb") / 1000

					if var_602_5 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_5 + 0
					end

					if var_602_1.prefab_name ~= "" and arg_599_1.actors_[var_602_1.prefab_name] ~= nil then
						local var_602_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_1.prefab_name].transform, "story_v_out_317292", "317292146", "story_v_out_317292.awb")

						arg_599_1:RecordAudio("317292146", var_602_6)
						arg_599_1:RecordAudio("317292146", var_602_6)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_out_317292", "317292146", "story_v_out_317292.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_out_317292", "317292146", "story_v_out_317292.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_7 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_7 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_7

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_7 and arg_599_1.time_ < 0 + var_602_7 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play317292147 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 317292147
		arg_603_1.duration_ = 12.9

		local var_603_0 = {
			zh = 12.9,
			ja = 9.333
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
				arg_603_0:Play317292148(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 1.325

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_1 = arg_603_1:GetWordFromCfg(317292147)
				local var_606_2 = arg_603_1:FormatText(var_606_1.content)

				arg_603_1.text_.text = var_606_2

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_4 = 53 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_2) / 53)

				if (53 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_2) / 53)) > 0 and var_606_0 < var_606_4 then
					arg_603_1.talkMaxDuration = var_606_4

					if var_606_4 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_4 + 0
					end
				end

				arg_603_1.text_.text = var_606_2
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292147", "story_v_out_317292.awb") ~= 0 then
					local var_606_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292147", "story_v_out_317292.awb") / 1000

					if var_606_5 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_5 + 0
					end

					if var_606_1.prefab_name ~= "" and arg_603_1.actors_[var_606_1.prefab_name] ~= nil then
						local var_606_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_1.prefab_name].transform, "story_v_out_317292", "317292147", "story_v_out_317292.awb")

						arg_603_1:RecordAudio("317292147", var_606_6)
						arg_603_1:RecordAudio("317292147", var_606_6)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_317292", "317292147", "story_v_out_317292.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_317292", "317292147", "story_v_out_317292.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_7 = math.max(var_606_0, arg_603_1.talkMaxDuration)

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_7 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - 0) / var_606_7

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= 0 + var_606_7 and arg_603_1.time_ < 0 + var_606_7 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play317292148 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 317292148
		arg_607_1.duration_ = 5.73

		local var_607_0 = {
			zh = 5.4,
			ja = 5.733
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
				arg_607_0:Play317292149(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.525

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_1 = arg_607_1:GetWordFromCfg(317292148)
				local var_610_2 = arg_607_1:FormatText(var_610_1.content)

				arg_607_1.text_.text = var_610_2

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_4 = 21 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 21)

				if (21 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 21)) > 0 and var_610_0 < var_610_4 then
					arg_607_1.talkMaxDuration = var_610_4

					if var_610_4 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_4 + 0
					end
				end

				arg_607_1.text_.text = var_610_2
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292148", "story_v_out_317292.awb") ~= 0 then
					local var_610_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292148", "story_v_out_317292.awb") / 1000

					if var_610_5 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_5 + 0
					end

					if var_610_1.prefab_name ~= "" and arg_607_1.actors_[var_610_1.prefab_name] ~= nil then
						local var_610_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_1.prefab_name].transform, "story_v_out_317292", "317292148", "story_v_out_317292.awb")

						arg_607_1:RecordAudio("317292148", var_610_6)
						arg_607_1:RecordAudio("317292148", var_610_6)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_317292", "317292148", "story_v_out_317292.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_317292", "317292148", "story_v_out_317292.awb")
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
	Play317292149 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 317292149
		arg_611_1.duration_ = 7

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play317292150(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if arg_611_1.bgs_.STblack == nil then
				local var_614_0 = Object.Instantiate(arg_611_1.paintGo_)

				var_614_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_614_0.name = "STblack"
				var_614_0.transform.parent = arg_611_1.stage_.transform
				var_614_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_611_1.bgs_.STblack = var_614_0
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				local var_614_1 = arg_611_1.bgs_.STblack

				arg_611_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_614_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_614_2 = var_614_1:GetComponent("SpriteRenderer")

				if var_614_2 and var_614_2.sprite then
					local var_614_3 = 2 * (var_614_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_614_1.transform.localScale = Vector3.New(var_614_3 / var_614_2.sprite.bounds.size.y < var_614_3 * manager.ui.mainCameraCom_.aspect / var_614_2.sprite.bounds.size.x and var_614_3 * manager.ui.mainCameraCom_.aspect / var_614_2.sprite.bounds.size.x or var_614_3 / var_614_2.sprite.bounds.size.y, var_614_3 / var_614_2.sprite.bounds.size.y < var_614_3 * manager.ui.mainCameraCom_.aspect / var_614_2.sprite.bounds.size.x and var_614_3 * manager.ui.mainCameraCom_.aspect / var_614_2.sprite.bounds.size.x or var_614_3 / var_614_2.sprite.bounds.size.y, 0)
				end

				for iter_614_0, iter_614_1 in pairs(arg_611_1.bgs_) do
					if iter_614_0 ~= "STblack" then
						iter_614_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_614_4 = 0

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_4 + arg_614_0 then
				arg_611_1.mask_.enabled = true
				arg_611_1.mask_.raycastTarget = true

				arg_611_1:SetGaussion(false)
			end

			local var_614_5 = 2

			if var_614_4 <= arg_611_1.time_ and arg_611_1.time_ < var_614_4 + var_614_5 then
				local var_614_6 = Color.New(0, 0, 0)

				var_614_6.a = Mathf.Lerp(1, 0, (arg_611_1.time_ - var_614_4) / var_614_5)
				arg_611_1.mask_.color = var_614_6
			end

			if arg_611_1.time_ >= var_614_4 + var_614_5 and arg_611_1.time_ < var_614_4 + var_614_5 + arg_614_0 then
				local var_614_7 = Color.New(0, 0, 0)

				arg_611_1.mask_.enabled = false
				var_614_7.a = 0
				arg_611_1.mask_.color = var_614_7
			end

			if arg_611_1.frameCnt_ <= 1 then
				arg_611_1.dialog_:SetActive(false)
			end

			local var_614_8 = 2
			local var_614_9 = 0.65

			if 2 < arg_611_1.time_ and arg_611_1.time_ <= var_614_8 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0

				arg_611_1.dialog_:SetActive(true)

				arg_611_1.dialogCg_.alpha = 0

				local var_614_10 = LeanTween.value(arg_611_1.dialog_, 0, 1, 0.3)

				var_614_10:setOnUpdate(LuaHelper.FloatAction(function(arg_615_0)
					arg_611_1.dialogCg_.alpha = arg_615_0
				end))
				var_614_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_611_1.dialog_)
					var_614_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_611_1.duration_ = arg_611_1.duration_ + 0.3

				SetActive(arg_611_1.leftNameGo_, false)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_11 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(317292149).content)

				arg_611_1.text_.text = var_614_11

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_13 = 26 <= 0 and var_614_9 or var_614_9 * (utf8.len(var_614_11) / 26)

				if (26 <= 0 and var_614_9 or var_614_9 * (utf8.len(var_614_11) / 26)) > 0 and var_614_9 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13
					var_614_8 = var_614_8 + 0.3

					if var_614_13 + var_614_8 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_8
					end
				end

				arg_611_1.text_.text = var_614_11
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_14 = var_614_8 + 0.3
			local var_614_15 = math.max(var_614_9, arg_611_1.talkMaxDuration)

			if var_614_8 + 0.3 <= arg_611_1.time_ and arg_611_1.time_ < var_614_14 + var_614_15 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_14) / var_614_15

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_14 + var_614_15 and arg_611_1.time_ < var_614_14 + var_614_15 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play317292150 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 317292150
		arg_617_1.duration_ = 10.57

		local var_617_0 = {
			zh = 10.566,
			ja = 10.333
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play317292151(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				local var_620_0 = arg_617_1.bgs_.ST58

				arg_617_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_620_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_620_1 = var_620_0:GetComponent("SpriteRenderer")

				if var_620_1 and var_620_1.sprite then
					local var_620_2 = 2 * (var_620_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_620_0.transform.localScale = Vector3.New(var_620_2 / var_620_1.sprite.bounds.size.y < var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x and var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x or var_620_2 / var_620_1.sprite.bounds.size.y, var_620_2 / var_620_1.sprite.bounds.size.y < var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x and var_620_2 * manager.ui.mainCameraCom_.aspect / var_620_1.sprite.bounds.size.x or var_620_2 / var_620_1.sprite.bounds.size.y, 0)
				end

				for iter_620_0, iter_620_1 in pairs(arg_617_1.bgs_) do
					if iter_620_0 ~= "ST58" then
						iter_620_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_620_3 = 0

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_3 + arg_620_0 then
				arg_617_1.mask_.enabled = true
				arg_617_1.mask_.raycastTarget = true

				arg_617_1:SetGaussion(false)
			end

			local var_620_4 = 2

			if var_620_3 <= arg_617_1.time_ and arg_617_1.time_ < var_620_3 + var_620_4 then
				local var_620_5 = Color.New(0, 0, 0)

				var_620_5.a = Mathf.Lerp(1, 0, (arg_617_1.time_ - var_620_3) / var_620_4)
				arg_617_1.mask_.color = var_620_5
			end

			if arg_617_1.time_ >= var_620_3 + var_620_4 and arg_617_1.time_ < var_620_3 + var_620_4 + arg_620_0 then
				local var_620_6 = Color.New(0, 0, 0)

				arg_617_1.mask_.enabled = false
				var_620_6.a = 0
				arg_617_1.mask_.color = var_620_6
			end

			local var_620_7 = arg_617_1.actors_["1015ui_story"].transform

			if 2 < arg_617_1.time_ and arg_617_1.time_ <= 2 + arg_620_0 then
				arg_617_1.var_.moveOldPos1015ui_story = var_620_7.localPosition
			end

			local var_620_8 = 0.001

			if 2 <= arg_617_1.time_ and arg_617_1.time_ < 2 + var_620_8 then
				var_620_7.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_617_1.time_ - 2) / var_620_8)
				var_620_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_620_7.position).x, (manager.ui.mainCamera.transform.position - var_620_7.position).y, (manager.ui.mainCamera.transform.position - var_620_7.position).z)
				var_620_7.localEulerAngles.z = 0
				var_620_7.localEulerAngles.x = 0
				var_620_7.localEulerAngles = var_620_7.localEulerAngles
			end

			if arg_617_1.time_ >= 2 + var_620_8 and arg_617_1.time_ < 2 + var_620_8 + arg_620_0 then
				var_620_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_620_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_620_7.position).x, (manager.ui.mainCamera.transform.position - var_620_7.position).y, (manager.ui.mainCamera.transform.position - var_620_7.position).z)
				var_620_7.localEulerAngles.z = 0
				var_620_7.localEulerAngles.x = 0
				var_620_7.localEulerAngles = var_620_7.localEulerAngles
			end

			local var_620_9 = arg_617_1.actors_["1015ui_story"]

			if 2 < arg_617_1.time_ and arg_617_1.time_ <= 2 + arg_620_0 and not isNil(var_620_9) and arg_617_1.var_.characterEffect1015ui_story == nil then
				arg_617_1.var_.characterEffect1015ui_story = var_620_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_10 = 0.200000002980232

			if 2 <= arg_617_1.time_ and arg_617_1.time_ < 2 + var_620_10 and not isNil(var_620_9) then
				if arg_617_1.var_.characterEffect1015ui_story and not isNil(var_620_9) then
					arg_617_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= 2 + var_620_10 and arg_617_1.time_ < 2 + var_620_10 + arg_620_0 and not isNil(var_620_9) and arg_617_1.var_.characterEffect1015ui_story then
				arg_617_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 2 < arg_617_1.time_ and arg_617_1.time_ <= 2 + arg_620_0 then
				arg_617_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 2 < arg_617_1.time_ and arg_617_1.time_ <= 2 + arg_620_0 then
				arg_617_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_617_1.frameCnt_ <= 1 then
				arg_617_1.dialog_:SetActive(false)
			end

			local var_620_12 = 2
			local var_620_13 = 1

			if 2 < arg_617_1.time_ and arg_617_1.time_ <= var_620_12 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0

				arg_617_1.dialog_:SetActive(true)

				arg_617_1.dialogCg_.alpha = 0

				local var_620_14 = LeanTween.value(arg_617_1.dialog_, 0, 1, 0.3)

				var_620_14:setOnUpdate(LuaHelper.FloatAction(function(arg_621_0)
					arg_617_1.dialogCg_.alpha = arg_621_0
				end))
				var_620_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_617_1.dialog_)
					var_620_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_617_1.duration_ = arg_617_1.duration_ + 0.3

				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_15 = arg_617_1:GetWordFromCfg(317292150)
				local var_620_16 = arg_617_1:FormatText(var_620_15.content)

				arg_617_1.text_.text = var_620_16

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_18 = 40 <= 0 and var_620_13 or var_620_13 * (utf8.len(var_620_16) / 40)

				if (40 <= 0 and var_620_13 or var_620_13 * (utf8.len(var_620_16) / 40)) > 0 and var_620_13 < var_620_18 then
					arg_617_1.talkMaxDuration = var_620_18
					var_620_12 = var_620_12 + 0.3

					if var_620_18 + var_620_12 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_18 + var_620_12
					end
				end

				arg_617_1.text_.text = var_620_16
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292150", "story_v_out_317292.awb") ~= 0 then
					local var_620_19 = manager.audio:GetVoiceLength("story_v_out_317292", "317292150", "story_v_out_317292.awb") / 1000

					if var_620_19 + var_620_12 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_19 + var_620_12
					end

					if var_620_15.prefab_name ~= "" and arg_617_1.actors_[var_620_15.prefab_name] ~= nil then
						local var_620_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_15.prefab_name].transform, "story_v_out_317292", "317292150", "story_v_out_317292.awb")

						arg_617_1:RecordAudio("317292150", var_620_20)
						arg_617_1:RecordAudio("317292150", var_620_20)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_317292", "317292150", "story_v_out_317292.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_317292", "317292150", "story_v_out_317292.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_21 = var_620_12 + 0.3
			local var_620_22 = math.max(var_620_13, arg_617_1.talkMaxDuration)

			if var_620_12 + 0.3 <= arg_617_1.time_ and arg_617_1.time_ < var_620_21 + var_620_22 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_21) / var_620_22

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_21 + var_620_22 and arg_617_1.time_ < var_620_21 + var_620_22 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_617_1:InitPlayNodeList()
	end,
	Play317292151 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 317292151
		arg_623_1.duration_ = 4.8

		local var_623_0 = {
			zh = 3.966,
			ja = 4.8
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
				arg_623_0:Play317292152(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["1015ui_story"]) and arg_623_1.var_.characterEffect1015ui_story == nil then
				arg_623_1.var_.characterEffect1015ui_story = arg_623_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_0 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["1015ui_story"]) then
				if arg_623_1.var_.characterEffect1015ui_story and not isNil(arg_623_1.actors_["1015ui_story"]) then
					arg_623_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_623_1.time_ - 0) / var_626_0)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["1015ui_story"]) and arg_623_1.var_.characterEffect1015ui_story then
				arg_623_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_626_1 = 0
			local var_626_2 = 0.5

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, true)
				arg_623_1.iconController_:SetSelectedState("hero")

				arg_623_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_623_1.callingController_:SetSelectedState("normal")

				arg_623_1.keyicon_.color = Color.New(1, 1, 1)
				arg_623_1.icon_.color = Color.New(1, 1, 1)

				local var_626_3 = arg_623_1:GetWordFromCfg(317292151)
				local var_626_4 = arg_623_1:FormatText(var_626_3.content)

				arg_623_1.text_.text = var_626_4

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_6 = 20 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_4) / 20)

				if (20 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_4) / 20)) > 0 and var_626_2 < var_626_6 then
					arg_623_1.talkMaxDuration = var_626_6

					if var_626_6 + var_626_1 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_6 + var_626_1
					end
				end

				arg_623_1.text_.text = var_626_4
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292151", "story_v_out_317292.awb") ~= 0 then
					local var_626_7 = manager.audio:GetVoiceLength("story_v_out_317292", "317292151", "story_v_out_317292.awb") / 1000

					if var_626_7 + var_626_1 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_7 + var_626_1
					end

					if var_626_3.prefab_name ~= "" and arg_623_1.actors_[var_626_3.prefab_name] ~= nil then
						local var_626_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_3.prefab_name].transform, "story_v_out_317292", "317292151", "story_v_out_317292.awb")

						arg_623_1:RecordAudio("317292151", var_626_8)
						arg_623_1:RecordAudio("317292151", var_626_8)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_317292", "317292151", "story_v_out_317292.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_317292", "317292151", "story_v_out_317292.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_9 = math.max(var_626_2, arg_623_1.talkMaxDuration)

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_9 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_1) / var_626_9

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_1 + var_626_9 and arg_623_1.time_ < var_626_1 + var_626_9 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play317292152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 317292152
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play317292153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0.125

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_1 = arg_627_1:FormatText(arg_627_1:GetWordFromCfg(317292152).content)

				arg_627_1.text_.text = var_630_1

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_3 = 5 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_1) / 5)

				if (5 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_1) / 5)) > 0 and var_630_0 < var_630_3 then
					arg_627_1.talkMaxDuration = var_630_3

					if var_630_3 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_3 + 0
					end
				end

				arg_627_1.text_.text = var_630_1
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_4 = math.max(var_630_0, arg_627_1.talkMaxDuration)

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_4 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - 0) / var_630_4

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= 0 + var_630_4 and arg_627_1.time_ < 0 + var_630_4 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play317292153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 317292153
		arg_631_1.duration_ = 7.27

		local var_631_0 = {
			zh = 4.7,
			ja = 7.266
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
				arg_631_0:Play317292154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0.525

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_1 = arg_631_1:GetWordFromCfg(317292153)
				local var_634_2 = arg_631_1:FormatText(var_634_1.content)

				arg_631_1.text_.text = var_634_2

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_4 = 21 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_2) / 21)

				if (21 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_2) / 21)) > 0 and var_634_0 < var_634_4 then
					arg_631_1.talkMaxDuration = var_634_4

					if var_634_4 + 0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_4 + 0
					end
				end

				arg_631_1.text_.text = var_634_2
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292153", "story_v_out_317292.awb") ~= 0 then
					local var_634_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292153", "story_v_out_317292.awb") / 1000

					if var_634_5 + 0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_5 + 0
					end

					if var_634_1.prefab_name ~= "" and arg_631_1.actors_[var_634_1.prefab_name] ~= nil then
						local var_634_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_1.prefab_name].transform, "story_v_out_317292", "317292153", "story_v_out_317292.awb")

						arg_631_1:RecordAudio("317292153", var_634_6)
						arg_631_1:RecordAudio("317292153", var_634_6)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_out_317292", "317292153", "story_v_out_317292.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_out_317292", "317292153", "story_v_out_317292.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_7 = math.max(var_634_0, arg_631_1.talkMaxDuration)

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - 0) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= 0 + var_634_7 and arg_631_1.time_ < 0 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play317292154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 317292154
		arg_635_1.duration_ = 4.77

		local var_635_0 = {
			zh = 2.9,
			ja = 4.766
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
				arg_635_0:Play317292155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1015ui_story = arg_635_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_638_0 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 then
				arg_635_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_635_1.time_ - 0) / var_638_0)
				arg_635_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1015ui_story"].transform.position).z)
				arg_635_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1015ui_story"].transform.localEulerAngles = arg_635_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 then
				arg_635_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_635_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1015ui_story"].transform.position).z)
				arg_635_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1015ui_story"].transform.localEulerAngles = arg_635_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_638_1 = arg_635_1.actors_["1015ui_story"]

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1015ui_story == nil then
				arg_635_1.var_.characterEffect1015ui_story = var_638_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_2 and not isNil(var_638_1) then
				if arg_635_1.var_.characterEffect1015ui_story and not isNil(var_638_1) then
					arg_635_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= 0 + var_638_2 and arg_635_1.time_ < 0 + var_638_2 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1015ui_story then
				arg_635_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_638_4 = 0
			local var_638_5 = 0.35

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_4 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_6 = arg_635_1:GetWordFromCfg(317292154)
				local var_638_7 = arg_635_1:FormatText(var_638_6.content)

				arg_635_1.text_.text = var_638_7

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_9 = 14 <= 0 and var_638_5 or var_638_5 * (utf8.len(var_638_7) / 14)

				if (14 <= 0 and var_638_5 or var_638_5 * (utf8.len(var_638_7) / 14)) > 0 and var_638_5 < var_638_9 then
					arg_635_1.talkMaxDuration = var_638_9

					if var_638_9 + var_638_4 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_9 + var_638_4
					end
				end

				arg_635_1.text_.text = var_638_7
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292154", "story_v_out_317292.awb") ~= 0 then
					local var_638_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292154", "story_v_out_317292.awb") / 1000

					if var_638_10 + var_638_4 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_10 + var_638_4
					end

					if var_638_6.prefab_name ~= "" and arg_635_1.actors_[var_638_6.prefab_name] ~= nil then
						local var_638_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_6.prefab_name].transform, "story_v_out_317292", "317292154", "story_v_out_317292.awb")

						arg_635_1:RecordAudio("317292154", var_638_11)
						arg_635_1:RecordAudio("317292154", var_638_11)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_out_317292", "317292154", "story_v_out_317292.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_out_317292", "317292154", "story_v_out_317292.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_12 = math.max(var_638_5, arg_635_1.talkMaxDuration)

			if var_638_4 <= arg_635_1.time_ and arg_635_1.time_ < var_638_4 + var_638_12 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_4) / var_638_12

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_4 + var_638_12 and arg_635_1.time_ < var_638_4 + var_638_12 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
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

		arg_635_1:InitPlayNodeList()
	end,
	Play317292155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 317292155
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play317292156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.var_.moveOldPos1015ui_story = arg_639_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_642_0 = 0.001

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 then
				arg_639_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_639_1.time_ - 0) / var_642_0)
				arg_639_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1015ui_story"].transform.position).z)
				arg_639_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1015ui_story"].transform.localEulerAngles = arg_639_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 then
				arg_639_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_639_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1015ui_story"].transform.position).z)
				arg_639_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1015ui_story"].transform.localEulerAngles = arg_639_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_642_1 = arg_639_1.actors_["1015ui_story"]

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(var_642_1) and arg_639_1.var_.characterEffect1015ui_story == nil then
				arg_639_1.var_.characterEffect1015ui_story = var_642_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_2 = 0.200000002980232

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_2 and not isNil(var_642_1) then
				if arg_639_1.var_.characterEffect1015ui_story and not isNil(var_642_1) then
					arg_639_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_639_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_639_1.time_ - 0) / var_642_2)
				end
			end

			if arg_639_1.time_ >= 0 + var_642_2 and arg_639_1.time_ < 0 + var_642_2 + arg_642_0 and not isNil(var_642_1) and arg_639_1.var_.characterEffect1015ui_story then
				arg_639_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_639_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_642_3 = 0
			local var_642_4 = 0.7

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_3 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_5 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(317292155).content)

				arg_639_1.text_.text = var_642_5

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_7 = 28 <= 0 and var_642_4 or var_642_4 * (utf8.len(var_642_5) / 28)

				if (28 <= 0 and var_642_4 or var_642_4 * (utf8.len(var_642_5) / 28)) > 0 and var_642_4 < var_642_7 then
					arg_639_1.talkMaxDuration = var_642_7

					if var_642_7 + var_642_3 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_7 + var_642_3
					end
				end

				arg_639_1.text_.text = var_642_5
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_8 = math.max(var_642_4, arg_639_1.talkMaxDuration)

			if var_642_3 <= arg_639_1.time_ and arg_639_1.time_ < var_642_3 + var_642_8 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_3) / var_642_8

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_3 + var_642_8 and arg_639_1.time_ < var_642_3 + var_642_8 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
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

		arg_639_1:InitPlayNodeList()
	end,
	Play317292156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 317292156
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play317292157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 1.225

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_1 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(317292156).content)

				arg_643_1.text_.text = var_646_1

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_3 = 49 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 49)

				if (49 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 49)) > 0 and var_646_0 < var_646_3 then
					arg_643_1.talkMaxDuration = var_646_3

					if var_646_3 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_3 + 0
					end
				end

				arg_643_1.text_.text = var_646_1
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_4 = math.max(var_646_0, arg_643_1.talkMaxDuration)

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_4 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - 0) / var_646_4

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= 0 + var_646_4 and arg_643_1.time_ < 0 + var_646_4 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play317292157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 317292157
		arg_647_1.duration_ = 3.4

		local var_647_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_647_1 = manager.audio:GetLocalizationFlag()

		if var_647_0[var_647_1] ~= nil then
			arg_647_1.duration_ = var_647_0[var_647_1]
		end

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play317292158(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.var_.moveOldPos1199ui_story = arg_647_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_650_0 = 0.001

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_0 then
				arg_647_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_647_1.time_ - 0) / var_650_0)
				arg_647_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_647_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1199ui_story"].transform.position).z)
				arg_647_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_647_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_647_1.actors_["1199ui_story"].transform.localEulerAngles = arg_647_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_647_1.time_ >= 0 + var_650_0 and arg_647_1.time_ < 0 + var_650_0 + arg_650_0 then
				arg_647_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_647_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_647_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1199ui_story"].transform.position).z)
				arg_647_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_647_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_647_1.actors_["1199ui_story"].transform.localEulerAngles = arg_647_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_650_1 = arg_647_1.actors_["1199ui_story"]

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 and not isNil(var_650_1) and arg_647_1.var_.characterEffect1199ui_story == nil then
				arg_647_1.var_.characterEffect1199ui_story = var_650_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_2 = 0.200000002980232

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_2 and not isNil(var_650_1) then
				if arg_647_1.var_.characterEffect1199ui_story and not isNil(var_650_1) then
					arg_647_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_647_1.time_ >= 0 + var_650_2 and arg_647_1.time_ < 0 + var_650_2 + arg_650_0 and not isNil(var_650_1) and arg_647_1.var_.characterEffect1199ui_story then
				arg_647_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_650_4 = 0
			local var_650_5 = 0.1

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_4 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_6 = arg_647_1:GetWordFromCfg(317292157)
				local var_650_7 = arg_647_1:FormatText(var_650_6.content)

				arg_647_1.text_.text = var_650_7

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_9 = 4 <= 0 and var_650_5 or var_650_5 * (utf8.len(var_650_7) / 4)

				if (4 <= 0 and var_650_5 or var_650_5 * (utf8.len(var_650_7) / 4)) > 0 and var_650_5 < var_650_9 then
					arg_647_1.talkMaxDuration = var_650_9

					if var_650_9 + var_650_4 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_9 + var_650_4
					end
				end

				arg_647_1.text_.text = var_650_7
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292157", "story_v_out_317292.awb") ~= 0 then
					local var_650_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292157", "story_v_out_317292.awb") / 1000

					if var_650_10 + var_650_4 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_10 + var_650_4
					end

					if var_650_6.prefab_name ~= "" and arg_647_1.actors_[var_650_6.prefab_name] ~= nil then
						local var_650_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_6.prefab_name].transform, "story_v_out_317292", "317292157", "story_v_out_317292.awb")

						arg_647_1:RecordAudio("317292157", var_650_11)
						arg_647_1:RecordAudio("317292157", var_650_11)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_317292", "317292157", "story_v_out_317292.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_317292", "317292157", "story_v_out_317292.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_12 = math.max(var_650_5, arg_647_1.talkMaxDuration)

			if var_650_4 <= arg_647_1.time_ and arg_647_1.time_ < var_650_4 + var_650_12 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_4) / var_650_12

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_4 + var_650_12 and arg_647_1.time_ < var_650_4 + var_650_12 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
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

		arg_647_1:InitPlayNodeList()
	end,
	Play317292158 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 317292158
		arg_651_1.duration_ = 3.93

		local var_651_0 = {
			zh = 2.133,
			ja = 3.933
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
				arg_651_0:Play317292159(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.var_.moveOldPos1093ui_story = arg_651_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_654_0 = 0.001

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_0 then
				arg_651_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_651_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_651_1.time_ - 0) / var_654_0)
				arg_651_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_651_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1093ui_story"].transform.position).z)
				arg_651_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_651_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_651_1.actors_["1093ui_story"].transform.localEulerAngles = arg_651_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_651_1.time_ >= 0 + var_654_0 and arg_651_1.time_ < 0 + var_654_0 + arg_654_0 then
				arg_651_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_651_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_651_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1093ui_story"].transform.position).z)
				arg_651_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_651_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_651_1.actors_["1093ui_story"].transform.localEulerAngles = arg_651_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_654_1 = arg_651_1.actors_["1093ui_story"]

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 and not isNil(var_654_1) and arg_651_1.var_.characterEffect1093ui_story == nil then
				arg_651_1.var_.characterEffect1093ui_story = var_654_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_2 = 0.200000002980232

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_2 and not isNil(var_654_1) then
				if arg_651_1.var_.characterEffect1093ui_story and not isNil(var_654_1) then
					arg_651_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_651_1.time_ >= 0 + var_654_2 and arg_651_1.time_ < 0 + var_654_2 + arg_654_0 and not isNil(var_654_1) and arg_651_1.var_.characterEffect1093ui_story then
				arg_651_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_654_4 = arg_651_1.actors_["1199ui_story"]

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 and not isNil(var_654_4) and arg_651_1.var_.characterEffect1199ui_story == nil then
				arg_651_1.var_.characterEffect1199ui_story = var_654_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_5 = 0.200000002980232

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_5 and not isNil(var_654_4) then
				if arg_651_1.var_.characterEffect1199ui_story and not isNil(var_654_4) then
					arg_651_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_651_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_651_1.time_ - 0) / var_654_5)
				end
			end

			if arg_651_1.time_ >= 0 + var_654_5 and arg_651_1.time_ < 0 + var_654_5 + arg_654_0 and not isNil(var_654_4) and arg_651_1.var_.characterEffect1199ui_story then
				arg_651_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_651_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_654_6 = 0
			local var_654_7 = 0.325

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_6 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_8 = arg_651_1:GetWordFromCfg(317292158)
				local var_654_9 = arg_651_1:FormatText(var_654_8.content)

				arg_651_1.text_.text = var_654_9

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_11 = 13 <= 0 and var_654_7 or var_654_7 * (utf8.len(var_654_9) / 13)

				if (13 <= 0 and var_654_7 or var_654_7 * (utf8.len(var_654_9) / 13)) > 0 and var_654_7 < var_654_11 then
					arg_651_1.talkMaxDuration = var_654_11

					if var_654_11 + var_654_6 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_11 + var_654_6
					end
				end

				arg_651_1.text_.text = var_654_9
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292158", "story_v_out_317292.awb") ~= 0 then
					local var_654_12 = manager.audio:GetVoiceLength("story_v_out_317292", "317292158", "story_v_out_317292.awb") / 1000

					if var_654_12 + var_654_6 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_12 + var_654_6
					end

					if var_654_8.prefab_name ~= "" and arg_651_1.actors_[var_654_8.prefab_name] ~= nil then
						local var_654_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_8.prefab_name].transform, "story_v_out_317292", "317292158", "story_v_out_317292.awb")

						arg_651_1:RecordAudio("317292158", var_654_13)
						arg_651_1:RecordAudio("317292158", var_654_13)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_out_317292", "317292158", "story_v_out_317292.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_out_317292", "317292158", "story_v_out_317292.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_14 = math.max(var_654_7, arg_651_1.talkMaxDuration)

			if var_654_6 <= arg_651_1.time_ and arg_651_1.time_ < var_654_6 + var_654_14 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_6) / var_654_14

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_6 + var_654_14 and arg_651_1.time_ < var_654_6 + var_654_14 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {
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

		arg_651_1:InitPlayNodeList()
	end,
	Play317292159 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 317292159
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play317292160(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(arg_655_1.actors_["1093ui_story"]) and arg_655_1.var_.characterEffect1093ui_story == nil then
				arg_655_1.var_.characterEffect1093ui_story = arg_655_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_658_0 = 0.200000002980232

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 and not isNil(arg_655_1.actors_["1093ui_story"]) then
				if arg_655_1.var_.characterEffect1093ui_story and not isNil(arg_655_1.actors_["1093ui_story"]) then
					arg_655_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_655_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_655_1.time_ - 0) / var_658_0)
				end
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 and not isNil(arg_655_1.actors_["1093ui_story"]) and arg_655_1.var_.characterEffect1093ui_story then
				arg_655_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_655_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_658_1 = 0
			local var_658_2 = 0.475

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_3 = arg_655_1:FormatText(arg_655_1:GetWordFromCfg(317292159).content)

				arg_655_1.text_.text = var_658_3

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 19 <= 0 and var_658_2 or var_658_2 * (utf8.len(var_658_3) / 19)

				if (19 <= 0 and var_658_2 or var_658_2 * (utf8.len(var_658_3) / 19)) > 0 and var_658_2 < var_658_5 then
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

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play317292160 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 317292160
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play317292161(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0.275

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, false)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_1 = arg_659_1:FormatText(arg_659_1:GetWordFromCfg(317292160).content)

				arg_659_1.text_.text = var_662_1

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_3 = 11 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_1) / 11)

				if (11 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_1) / 11)) > 0 and var_662_0 < var_662_3 then
					arg_659_1.talkMaxDuration = var_662_3

					if var_662_3 + 0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_3 + 0
					end
				end

				arg_659_1.text_.text = var_662_1
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_4 = math.max(var_662_0, arg_659_1.talkMaxDuration)

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_4 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - 0) / var_662_4

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= 0 + var_662_4 and arg_659_1.time_ < 0 + var_662_4 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play317292161 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 317292161
		arg_663_1.duration_ = 4.6

		local var_663_0 = {
			zh = 4.6,
			ja = 2.166
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
				arg_663_0:Play317292162(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos1199ui_story = arg_663_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_666_0 = 0.001

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 then
				arg_663_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_663_1.time_ - 0) / var_666_0)
				arg_663_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1199ui_story"].transform.position).z)
				arg_663_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["1199ui_story"].transform.localEulerAngles = arg_663_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 then
				arg_663_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_663_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1199ui_story"].transform.position).z)
				arg_663_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["1199ui_story"].transform.localEulerAngles = arg_663_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_666_1 = arg_663_1.actors_["1199ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect1199ui_story == nil then
				arg_663_1.var_.characterEffect1199ui_story = var_666_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_2 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_2 and not isNil(var_666_1) then
				if arg_663_1.var_.characterEffect1199ui_story and not isNil(var_666_1) then
					arg_663_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_663_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_663_1.time_ - 0) / var_666_2)
				end
			end

			if arg_663_1.time_ >= 0 + var_666_2 and arg_663_1.time_ < 0 + var_666_2 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect1199ui_story then
				arg_663_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_663_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_666_3 = arg_663_1.actors_["1093ui_story"].transform

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos1093ui_story = var_666_3.localPosition
			end

			local var_666_4 = 0.001

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_4 then
				var_666_3.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_663_1.time_ - 0) / var_666_4)
				var_666_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_666_3.position).x, (manager.ui.mainCamera.transform.position - var_666_3.position).y, (manager.ui.mainCamera.transform.position - var_666_3.position).z)
				var_666_3.localEulerAngles.z = 0
				var_666_3.localEulerAngles.x = 0
				var_666_3.localEulerAngles = var_666_3.localEulerAngles
			end

			if arg_663_1.time_ >= 0 + var_666_4 and arg_663_1.time_ < 0 + var_666_4 + arg_666_0 then
				var_666_3.localPosition = Vector3.New(0, 100, 0)
				var_666_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_666_3.position).x, (manager.ui.mainCamera.transform.position - var_666_3.position).y, (manager.ui.mainCamera.transform.position - var_666_3.position).z)
				var_666_3.localEulerAngles.z = 0
				var_666_3.localEulerAngles.x = 0
				var_666_3.localEulerAngles = var_666_3.localEulerAngles
			end

			local var_666_5 = arg_663_1.actors_["1093ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_5) and arg_663_1.var_.characterEffect1093ui_story == nil then
				arg_663_1.var_.characterEffect1093ui_story = var_666_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_6 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_6 and not isNil(var_666_5) then
				if arg_663_1.var_.characterEffect1093ui_story and not isNil(var_666_5) then
					arg_663_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_663_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_663_1.time_ - 0) / var_666_6)
				end
			end

			if arg_663_1.time_ >= 0 + var_666_6 and arg_663_1.time_ < 0 + var_666_6 + arg_666_0 and not isNil(var_666_5) and arg_663_1.var_.characterEffect1093ui_story then
				arg_663_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_663_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_666_7 = arg_663_1.actors_["1015ui_story"].transform

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos1015ui_story = var_666_7.localPosition
			end

			local var_666_8 = 0.001

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_8 then
				var_666_7.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_663_1.time_ - 0) / var_666_8)
				var_666_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_666_7.position).x, (manager.ui.mainCamera.transform.position - var_666_7.position).y, (manager.ui.mainCamera.transform.position - var_666_7.position).z)
				var_666_7.localEulerAngles.z = 0
				var_666_7.localEulerAngles.x = 0
				var_666_7.localEulerAngles = var_666_7.localEulerAngles
			end

			if arg_663_1.time_ >= 0 + var_666_8 and arg_663_1.time_ < 0 + var_666_8 + arg_666_0 then
				var_666_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_666_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_666_7.position).x, (manager.ui.mainCamera.transform.position - var_666_7.position).y, (manager.ui.mainCamera.transform.position - var_666_7.position).z)
				var_666_7.localEulerAngles.z = 0
				var_666_7.localEulerAngles.x = 0
				var_666_7.localEulerAngles = var_666_7.localEulerAngles
			end

			local var_666_9 = arg_663_1.actors_["1015ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_9) and arg_663_1.var_.characterEffect1015ui_story == nil then
				arg_663_1.var_.characterEffect1015ui_story = var_666_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_10 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_10 and not isNil(var_666_9) then
				if arg_663_1.var_.characterEffect1015ui_story and not isNil(var_666_9) then
					arg_663_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_663_1.time_ >= 0 + var_666_10 and arg_663_1.time_ < 0 + var_666_10 + arg_666_0 and not isNil(var_666_9) and arg_663_1.var_.characterEffect1015ui_story then
				arg_663_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_666_12 = 0
			local var_666_13 = 0.175

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_12 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_14 = arg_663_1:GetWordFromCfg(317292161)
				local var_666_15 = arg_663_1:FormatText(var_666_14.content)

				arg_663_1.text_.text = var_666_15

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_17 = 7 <= 0 and var_666_13 or var_666_13 * (utf8.len(var_666_15) / 7)

				if (7 <= 0 and var_666_13 or var_666_13 * (utf8.len(var_666_15) / 7)) > 0 and var_666_13 < var_666_17 then
					arg_663_1.talkMaxDuration = var_666_17

					if var_666_17 + var_666_12 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_17 + var_666_12
					end
				end

				arg_663_1.text_.text = var_666_15
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292161", "story_v_out_317292.awb") ~= 0 then
					local var_666_18 = manager.audio:GetVoiceLength("story_v_out_317292", "317292161", "story_v_out_317292.awb") / 1000

					if var_666_18 + var_666_12 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_18 + var_666_12
					end

					if var_666_14.prefab_name ~= "" and arg_663_1.actors_[var_666_14.prefab_name] ~= nil then
						local var_666_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_14.prefab_name].transform, "story_v_out_317292", "317292161", "story_v_out_317292.awb")

						arg_663_1:RecordAudio("317292161", var_666_19)
						arg_663_1:RecordAudio("317292161", var_666_19)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_out_317292", "317292161", "story_v_out_317292.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_out_317292", "317292161", "story_v_out_317292.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_20 = math.max(var_666_13, arg_663_1.talkMaxDuration)

			if var_666_12 <= arg_663_1.time_ and arg_663_1.time_ < var_666_12 + var_666_20 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_12) / var_666_20

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_12 + var_666_20 and arg_663_1.time_ < var_666_12 + var_666_20 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_663_1:InitPlayNodeList()
	end,
	Play317292162 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 317292162
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play317292163(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(arg_667_1.actors_["1015ui_story"]) and arg_667_1.var_.characterEffect1015ui_story == nil then
				arg_667_1.var_.characterEffect1015ui_story = arg_667_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_0 = 0.200000002980232

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_0 and not isNil(arg_667_1.actors_["1015ui_story"]) then
				if arg_667_1.var_.characterEffect1015ui_story and not isNil(arg_667_1.actors_["1015ui_story"]) then
					arg_667_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_667_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_667_1.time_ - 0) / var_670_0)
				end
			end

			if arg_667_1.time_ >= 0 + var_670_0 and arg_667_1.time_ < 0 + var_670_0 + arg_670_0 and not isNil(arg_667_1.actors_["1015ui_story"]) and arg_667_1.var_.characterEffect1015ui_story then
				arg_667_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_667_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_670_1 = 0
			local var_670_2 = 0.8

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, false)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_3 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(317292162).content)

				arg_667_1.text_.text = var_670_3

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_5 = 32 <= 0 and var_670_2 or var_670_2 * (utf8.len(var_670_3) / 32)

				if (32 <= 0 and var_670_2 or var_670_2 * (utf8.len(var_670_3) / 32)) > 0 and var_670_2 < var_670_5 then
					arg_667_1.talkMaxDuration = var_670_5

					if var_670_5 + var_670_1 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_5 + var_670_1
					end
				end

				arg_667_1.text_.text = var_670_3
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_6 = math.max(var_670_2, arg_667_1.talkMaxDuration)

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_6 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_1) / var_670_6

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_1 + var_670_6 and arg_667_1.time_ < var_670_1 + var_670_6 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play317292163 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 317292163
		arg_671_1.duration_ = 9.3

		local var_671_0 = {
			zh = 9.3,
			ja = 9.266
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
				arg_671_0:Play317292164(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1.var_.moveOldPos1015ui_story = arg_671_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_674_0 = 0.001

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_0 then
				arg_671_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_671_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_671_1.time_ - 0) / var_674_0)
				arg_671_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_671_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1015ui_story"].transform.position).z)
				arg_671_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_671_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_671_1.actors_["1015ui_story"].transform.localEulerAngles = arg_671_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_671_1.time_ >= 0 + var_674_0 and arg_671_1.time_ < 0 + var_674_0 + arg_674_0 then
				arg_671_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_671_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_671_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1015ui_story"].transform.position).z)
				arg_671_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_671_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_671_1.actors_["1015ui_story"].transform.localEulerAngles = arg_671_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_674_1 = arg_671_1.actors_["1015ui_story"]

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 and not isNil(var_674_1) and arg_671_1.var_.characterEffect1015ui_story == nil then
				arg_671_1.var_.characterEffect1015ui_story = var_674_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_2 = 0.200000002980232

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_2 and not isNil(var_674_1) then
				if arg_671_1.var_.characterEffect1015ui_story and not isNil(var_674_1) then
					arg_671_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_671_1.time_ >= 0 + var_674_2 and arg_671_1.time_ < 0 + var_674_2 + arg_674_0 and not isNil(var_674_1) and arg_671_1.var_.characterEffect1015ui_story then
				arg_671_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_674_4 = 0
			local var_674_5 = 1.05

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_4 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_6 = arg_671_1:GetWordFromCfg(317292163)
				local var_674_7 = arg_671_1:FormatText(var_674_6.content)

				arg_671_1.text_.text = var_674_7

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_9 = 42 <= 0 and var_674_5 or var_674_5 * (utf8.len(var_674_7) / 42)

				if (42 <= 0 and var_674_5 or var_674_5 * (utf8.len(var_674_7) / 42)) > 0 and var_674_5 < var_674_9 then
					arg_671_1.talkMaxDuration = var_674_9

					if var_674_9 + var_674_4 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_9 + var_674_4
					end
				end

				arg_671_1.text_.text = var_674_7
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292163", "story_v_out_317292.awb") ~= 0 then
					local var_674_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292163", "story_v_out_317292.awb") / 1000

					if var_674_10 + var_674_4 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_10 + var_674_4
					end

					if var_674_6.prefab_name ~= "" and arg_671_1.actors_[var_674_6.prefab_name] ~= nil then
						local var_674_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_6.prefab_name].transform, "story_v_out_317292", "317292163", "story_v_out_317292.awb")

						arg_671_1:RecordAudio("317292163", var_674_11)
						arg_671_1:RecordAudio("317292163", var_674_11)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_out_317292", "317292163", "story_v_out_317292.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_out_317292", "317292163", "story_v_out_317292.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_12 = math.max(var_674_5, arg_671_1.talkMaxDuration)

			if var_674_4 <= arg_671_1.time_ and arg_671_1.time_ < var_674_4 + var_674_12 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_4) / var_674_12

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_4 + var_674_12 and arg_671_1.time_ < var_674_4 + var_674_12 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {
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

		arg_671_1:InitPlayNodeList()
	end,
	Play317292164 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 317292164
		arg_675_1.duration_ = 5.03

		local var_675_0 = {
			zh = 4.733,
			ja = 5.033
		}
		local var_675_1 = manager.audio:GetLocalizationFlag()

		if var_675_0[var_675_1] ~= nil then
			arg_675_1.duration_ = var_675_0[var_675_1]
		end

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play317292165(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0.525

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_1 = arg_675_1:GetWordFromCfg(317292164)
				local var_678_2 = arg_675_1:FormatText(var_678_1.content)

				arg_675_1.text_.text = var_678_2

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_4 = 21 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 21)

				if (21 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 21)) > 0 and var_678_0 < var_678_4 then
					arg_675_1.talkMaxDuration = var_678_4

					if var_678_4 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_4 + 0
					end
				end

				arg_675_1.text_.text = var_678_2
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292164", "story_v_out_317292.awb") ~= 0 then
					local var_678_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292164", "story_v_out_317292.awb") / 1000

					if var_678_5 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_5 + 0
					end

					if var_678_1.prefab_name ~= "" and arg_675_1.actors_[var_678_1.prefab_name] ~= nil then
						local var_678_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_1.prefab_name].transform, "story_v_out_317292", "317292164", "story_v_out_317292.awb")

						arg_675_1:RecordAudio("317292164", var_678_6)
						arg_675_1:RecordAudio("317292164", var_678_6)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_out_317292", "317292164", "story_v_out_317292.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_out_317292", "317292164", "story_v_out_317292.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_7 = math.max(var_678_0, arg_675_1.talkMaxDuration)

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_7 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - 0) / var_678_7

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= 0 + var_678_7 and arg_675_1.time_ < 0 + var_678_7 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play317292165 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 317292165
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play317292166(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(arg_679_1.actors_["1015ui_story"]) and arg_679_1.var_.characterEffect1015ui_story == nil then
				arg_679_1.var_.characterEffect1015ui_story = arg_679_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_0 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 and not isNil(arg_679_1.actors_["1015ui_story"]) then
				if arg_679_1.var_.characterEffect1015ui_story and not isNil(arg_679_1.actors_["1015ui_story"]) then
					arg_679_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_679_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_679_1.time_ - 0) / var_682_0)
				end
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 and not isNil(arg_679_1.actors_["1015ui_story"]) and arg_679_1.var_.characterEffect1015ui_story then
				arg_679_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_679_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_682_1 = 0
			local var_682_2 = 0.7

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_3 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(317292165).content)

				arg_679_1.text_.text = var_682_3

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_5 = 28 <= 0 and var_682_2 or var_682_2 * (utf8.len(var_682_3) / 28)

				if (28 <= 0 and var_682_2 or var_682_2 * (utf8.len(var_682_3) / 28)) > 0 and var_682_2 < var_682_5 then
					arg_679_1.talkMaxDuration = var_682_5

					if var_682_5 + var_682_1 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_5 + var_682_1
					end
				end

				arg_679_1.text_.text = var_682_3
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_6 = math.max(var_682_2, arg_679_1.talkMaxDuration)

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_6 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_1) / var_682_6

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_1 + var_682_6 and arg_679_1.time_ < var_682_1 + var_682_6 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play317292166 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 317292166
		arg_683_1.duration_ = 5.6

		local var_683_0 = {
			zh = 5.6,
			ja = 3.266
		}
		local var_683_1 = manager.audio:GetLocalizationFlag()

		if var_683_0[var_683_1] ~= nil then
			arg_683_1.duration_ = var_683_0[var_683_1]
		end

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play317292167(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.var_.moveOldPos1015ui_story = arg_683_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_686_0 = 0.001

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 then
				arg_683_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_683_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_683_1.time_ - 0) / var_686_0)
				arg_683_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_683_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["1015ui_story"].transform.position).z)
				arg_683_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_683_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_683_1.actors_["1015ui_story"].transform.localEulerAngles = arg_683_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 then
				arg_683_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_683_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_683_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["1015ui_story"].transform.position).z)
				arg_683_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_683_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_683_1.actors_["1015ui_story"].transform.localEulerAngles = arg_683_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_686_1 = arg_683_1.actors_["1015ui_story"]

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(var_686_1) and arg_683_1.var_.characterEffect1015ui_story == nil then
				arg_683_1.var_.characterEffect1015ui_story = var_686_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_2 = 0.200000002980232

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_2 and not isNil(var_686_1) then
				if arg_683_1.var_.characterEffect1015ui_story and not isNil(var_686_1) then
					arg_683_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_683_1.time_ >= 0 + var_686_2 and arg_683_1.time_ < 0 + var_686_2 + arg_686_0 and not isNil(var_686_1) and arg_683_1.var_.characterEffect1015ui_story then
				arg_683_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_2")
			end

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_686_4 = 0
			local var_686_5 = 0.575

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_4 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_6 = arg_683_1:GetWordFromCfg(317292166)
				local var_686_7 = arg_683_1:FormatText(var_686_6.content)

				arg_683_1.text_.text = var_686_7

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_9 = 23 <= 0 and var_686_5 or var_686_5 * (utf8.len(var_686_7) / 23)

				if (23 <= 0 and var_686_5 or var_686_5 * (utf8.len(var_686_7) / 23)) > 0 and var_686_5 < var_686_9 then
					arg_683_1.talkMaxDuration = var_686_9

					if var_686_9 + var_686_4 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_9 + var_686_4
					end
				end

				arg_683_1.text_.text = var_686_7
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292166", "story_v_out_317292.awb") ~= 0 then
					local var_686_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292166", "story_v_out_317292.awb") / 1000

					if var_686_10 + var_686_4 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_10 + var_686_4
					end

					if var_686_6.prefab_name ~= "" and arg_683_1.actors_[var_686_6.prefab_name] ~= nil then
						local var_686_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_6.prefab_name].transform, "story_v_out_317292", "317292166", "story_v_out_317292.awb")

						arg_683_1:RecordAudio("317292166", var_686_11)
						arg_683_1:RecordAudio("317292166", var_686_11)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_out_317292", "317292166", "story_v_out_317292.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_out_317292", "317292166", "story_v_out_317292.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_12 = math.max(var_686_5, arg_683_1.talkMaxDuration)

			if var_686_4 <= arg_683_1.time_ and arg_683_1.time_ < var_686_4 + var_686_12 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_4) / var_686_12

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_4 + var_686_12 and arg_683_1.time_ < var_686_4 + var_686_12 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {
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

		arg_683_1:InitPlayNodeList()
	end,
	Play317292167 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 317292167
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play317292168(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(arg_687_1.actors_["1015ui_story"]) and arg_687_1.var_.characterEffect1015ui_story == nil then
				arg_687_1.var_.characterEffect1015ui_story = arg_687_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_0 = 0.200000002980232

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 and not isNil(arg_687_1.actors_["1015ui_story"]) then
				if arg_687_1.var_.characterEffect1015ui_story and not isNil(arg_687_1.actors_["1015ui_story"]) then
					arg_687_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_687_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_687_1.time_ - 0) / var_690_0)
				end
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 and not isNil(arg_687_1.actors_["1015ui_story"]) and arg_687_1.var_.characterEffect1015ui_story then
				arg_687_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_687_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_690_1 = 0
			local var_690_2 = 0.125

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_687_1.callingController_:SetSelectedState("normal")

				arg_687_1.keyicon_.color = Color.New(1, 1, 1)
				arg_687_1.icon_.color = Color.New(1, 1, 1)

				local var_690_3 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(317292167).content)

				arg_687_1.text_.text = var_690_3

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_5 = 5 <= 0 and var_690_2 or var_690_2 * (utf8.len(var_690_3) / 5)

				if (5 <= 0 and var_690_2 or var_690_2 * (utf8.len(var_690_3) / 5)) > 0 and var_690_2 < var_690_5 then
					arg_687_1.talkMaxDuration = var_690_5

					if var_690_5 + var_690_1 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_5 + var_690_1
					end
				end

				arg_687_1.text_.text = var_690_3
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_6 = math.max(var_690_2, arg_687_1.talkMaxDuration)

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_6 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_1) / var_690_6

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_1 + var_690_6 and arg_687_1.time_ < var_690_1 + var_690_6 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play317292168 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 317292168
		arg_691_1.duration_ = 9.7

		local var_691_0 = {
			zh = 9.7,
			ja = 5.766
		}
		local var_691_1 = manager.audio:GetLocalizationFlag()

		if var_691_0[var_691_1] ~= nil then
			arg_691_1.duration_ = var_691_0[var_691_1]
		end

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play317292169(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1.var_.moveOldPos1015ui_story = arg_691_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_694_0 = 0.001

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 then
				arg_691_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_691_1.time_ - 0) / var_694_0)
				arg_691_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_691_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1015ui_story"].transform.position).z)
				arg_691_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_691_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_691_1.actors_["1015ui_story"].transform.localEulerAngles = arg_691_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 then
				arg_691_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_691_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_691_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1015ui_story"].transform.position).z)
				arg_691_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_691_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_691_1.actors_["1015ui_story"].transform.localEulerAngles = arg_691_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_694_1 = arg_691_1.actors_["1015ui_story"]

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect1015ui_story == nil then
				arg_691_1.var_.characterEffect1015ui_story = var_694_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_2 = 0.200000002980232

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_2 and not isNil(var_694_1) then
				if arg_691_1.var_.characterEffect1015ui_story and not isNil(var_694_1) then
					arg_691_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= 0 + var_694_2 and arg_691_1.time_ < 0 + var_694_2 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect1015ui_story then
				arg_691_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_694_4 = 0
			local var_694_5 = 1.275

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_4 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_6 = arg_691_1:GetWordFromCfg(317292168)
				local var_694_7 = arg_691_1:FormatText(var_694_6.content)

				arg_691_1.text_.text = var_694_7

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_9 = 51 <= 0 and var_694_5 or var_694_5 * (utf8.len(var_694_7) / 51)

				if (51 <= 0 and var_694_5 or var_694_5 * (utf8.len(var_694_7) / 51)) > 0 and var_694_5 < var_694_9 then
					arg_691_1.talkMaxDuration = var_694_9

					if var_694_9 + var_694_4 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_9 + var_694_4
					end
				end

				arg_691_1.text_.text = var_694_7
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292168", "story_v_out_317292.awb") ~= 0 then
					local var_694_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292168", "story_v_out_317292.awb") / 1000

					if var_694_10 + var_694_4 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_10 + var_694_4
					end

					if var_694_6.prefab_name ~= "" and arg_691_1.actors_[var_694_6.prefab_name] ~= nil then
						local var_694_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_6.prefab_name].transform, "story_v_out_317292", "317292168", "story_v_out_317292.awb")

						arg_691_1:RecordAudio("317292168", var_694_11)
						arg_691_1:RecordAudio("317292168", var_694_11)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_out_317292", "317292168", "story_v_out_317292.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_out_317292", "317292168", "story_v_out_317292.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_12 = math.max(var_694_5, arg_691_1.talkMaxDuration)

			if var_694_4 <= arg_691_1.time_ and arg_691_1.time_ < var_694_4 + var_694_12 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_4) / var_694_12

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_4 + var_694_12 and arg_691_1.time_ < var_694_4 + var_694_12 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
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

		arg_691_1:InitPlayNodeList()
	end,
	Play317292169 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 317292169
		arg_695_1.duration_ = 13.87

		local var_695_0 = {
			zh = 13.466,
			ja = 13.866
		}
		local var_695_1 = manager.audio:GetLocalizationFlag()

		if var_695_0[var_695_1] ~= nil then
			arg_695_1.duration_ = var_695_0[var_695_1]
		end

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play317292170(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 1.725

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_1 = arg_695_1:GetWordFromCfg(317292169)
				local var_698_2 = arg_695_1:FormatText(var_698_1.content)

				arg_695_1.text_.text = var_698_2

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_4 = 69 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_2) / 69)

				if (69 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_2) / 69)) > 0 and var_698_0 < var_698_4 then
					arg_695_1.talkMaxDuration = var_698_4

					if var_698_4 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_4 + 0
					end
				end

				arg_695_1.text_.text = var_698_2
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292169", "story_v_out_317292.awb") ~= 0 then
					local var_698_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292169", "story_v_out_317292.awb") / 1000

					if var_698_5 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_5 + 0
					end

					if var_698_1.prefab_name ~= "" and arg_695_1.actors_[var_698_1.prefab_name] ~= nil then
						local var_698_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_1.prefab_name].transform, "story_v_out_317292", "317292169", "story_v_out_317292.awb")

						arg_695_1:RecordAudio("317292169", var_698_6)
						arg_695_1:RecordAudio("317292169", var_698_6)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_out_317292", "317292169", "story_v_out_317292.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_out_317292", "317292169", "story_v_out_317292.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_7 = math.max(var_698_0, arg_695_1.talkMaxDuration)

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_7 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - 0) / var_698_7

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= 0 + var_698_7 and arg_695_1.time_ < 0 + var_698_7 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play317292170 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 317292170
		arg_699_1.duration_ = 3.13

		local var_699_0 = {
			zh = 2.833,
			ja = 3.133
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play317292171(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.var_.moveOldPos1015ui_story = arg_699_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_702_0 = 0.001

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 then
				arg_699_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_699_1.time_ - 0) / var_702_0)
				arg_699_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1015ui_story"].transform.position).z)
				arg_699_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["1015ui_story"].transform.localEulerAngles = arg_699_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 then
				arg_699_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_699_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1015ui_story"].transform.position).z)
				arg_699_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["1015ui_story"].transform.localEulerAngles = arg_699_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_702_1 = arg_699_1.actors_["1015ui_story"]

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(var_702_1) and arg_699_1.var_.characterEffect1015ui_story == nil then
				arg_699_1.var_.characterEffect1015ui_story = var_702_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.200000002980232

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_2 and not isNil(var_702_1) then
				if arg_699_1.var_.characterEffect1015ui_story and not isNil(var_702_1) then
					arg_699_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= 0 + var_702_2 and arg_699_1.time_ < 0 + var_702_2 + arg_702_0 and not isNil(var_702_1) and arg_699_1.var_.characterEffect1015ui_story then
				arg_699_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_702_4 = 0
			local var_702_5 = 0.175

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_4 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_6 = arg_699_1:GetWordFromCfg(317292170)
				local var_702_7 = arg_699_1:FormatText(var_702_6.content)

				arg_699_1.text_.text = var_702_7

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_9 = 7 <= 0 and var_702_5 or var_702_5 * (utf8.len(var_702_7) / 7)

				if (7 <= 0 and var_702_5 or var_702_5 * (utf8.len(var_702_7) / 7)) > 0 and var_702_5 < var_702_9 then
					arg_699_1.talkMaxDuration = var_702_9

					if var_702_9 + var_702_4 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_9 + var_702_4
					end
				end

				arg_699_1.text_.text = var_702_7
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292170", "story_v_out_317292.awb") ~= 0 then
					local var_702_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292170", "story_v_out_317292.awb") / 1000

					if var_702_10 + var_702_4 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_10 + var_702_4
					end

					if var_702_6.prefab_name ~= "" and arg_699_1.actors_[var_702_6.prefab_name] ~= nil then
						local var_702_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_6.prefab_name].transform, "story_v_out_317292", "317292170", "story_v_out_317292.awb")

						arg_699_1:RecordAudio("317292170", var_702_11)
						arg_699_1:RecordAudio("317292170", var_702_11)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_317292", "317292170", "story_v_out_317292.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_317292", "317292170", "story_v_out_317292.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_12 = math.max(var_702_5, arg_699_1.talkMaxDuration)

			if var_702_4 <= arg_699_1.time_ and arg_699_1.time_ < var_702_4 + var_702_12 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_4) / var_702_12

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_4 + var_702_12 and arg_699_1.time_ < var_702_4 + var_702_12 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
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

		arg_699_1:InitPlayNodeList()
	end,
	Play317292171 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 317292171
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play317292172(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(arg_703_1.actors_["1015ui_story"]) and arg_703_1.var_.characterEffect1015ui_story == nil then
				arg_703_1.var_.characterEffect1015ui_story = arg_703_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_0 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 and not isNil(arg_703_1.actors_["1015ui_story"]) then
				if arg_703_1.var_.characterEffect1015ui_story and not isNil(arg_703_1.actors_["1015ui_story"]) then
					arg_703_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_703_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_703_1.time_ - 0) / var_706_0)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 and not isNil(arg_703_1.actors_["1015ui_story"]) and arg_703_1.var_.characterEffect1015ui_story then
				arg_703_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_703_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_706_1 = 0
			local var_706_2 = 0.075

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_3 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(317292171).content)

				arg_703_1.text_.text = var_706_3

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_5 = 3 <= 0 and var_706_2 or var_706_2 * (utf8.len(var_706_3) / 3)

				if (3 <= 0 and var_706_2 or var_706_2 * (utf8.len(var_706_3) / 3)) > 0 and var_706_2 < var_706_5 then
					arg_703_1.talkMaxDuration = var_706_5

					if var_706_5 + var_706_1 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_5 + var_706_1
					end
				end

				arg_703_1.text_.text = var_706_3
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_6 = math.max(var_706_2, arg_703_1.talkMaxDuration)

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_6 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_1) / var_706_6

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_1 + var_706_6 and arg_703_1.time_ < var_706_1 + var_706_6 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play317292172 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 317292172
		arg_707_1.duration_ = 14.9

		local var_707_0 = {
			zh = 9.666,
			ja = 14.9
		}
		local var_707_1 = manager.audio:GetLocalizationFlag()

		if var_707_0[var_707_1] ~= nil then
			arg_707_1.duration_ = var_707_0[var_707_1]
		end

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play317292173(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.var_.moveOldPos1015ui_story = arg_707_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_710_0 = 0.001

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_0 then
				arg_707_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_707_1.time_ - 0) / var_710_0)
				arg_707_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1015ui_story"].transform.position).z)
				arg_707_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["1015ui_story"].transform.localEulerAngles = arg_707_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_707_1.time_ >= 0 + var_710_0 and arg_707_1.time_ < 0 + var_710_0 + arg_710_0 then
				arg_707_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_707_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1015ui_story"].transform.position).z)
				arg_707_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["1015ui_story"].transform.localEulerAngles = arg_707_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_710_1 = arg_707_1.actors_["1015ui_story"]

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 and not isNil(var_710_1) and arg_707_1.var_.characterEffect1015ui_story == nil then
				arg_707_1.var_.characterEffect1015ui_story = var_710_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_2 = 0.200000002980232

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_2 and not isNil(var_710_1) then
				if arg_707_1.var_.characterEffect1015ui_story and not isNil(var_710_1) then
					arg_707_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_707_1.time_ >= 0 + var_710_2 and arg_707_1.time_ < 0 + var_710_2 + arg_710_0 and not isNil(var_710_1) and arg_707_1.var_.characterEffect1015ui_story then
				arg_707_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_710_4 = 0
			local var_710_5 = 1.275

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_4 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_6 = arg_707_1:GetWordFromCfg(317292172)
				local var_710_7 = arg_707_1:FormatText(var_710_6.content)

				arg_707_1.text_.text = var_710_7

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_9 = 51 <= 0 and var_710_5 or var_710_5 * (utf8.len(var_710_7) / 51)

				if (51 <= 0 and var_710_5 or var_710_5 * (utf8.len(var_710_7) / 51)) > 0 and var_710_5 < var_710_9 then
					arg_707_1.talkMaxDuration = var_710_9

					if var_710_9 + var_710_4 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_9 + var_710_4
					end
				end

				arg_707_1.text_.text = var_710_7
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292172", "story_v_out_317292.awb") ~= 0 then
					local var_710_10 = manager.audio:GetVoiceLength("story_v_out_317292", "317292172", "story_v_out_317292.awb") / 1000

					if var_710_10 + var_710_4 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_10 + var_710_4
					end

					if var_710_6.prefab_name ~= "" and arg_707_1.actors_[var_710_6.prefab_name] ~= nil then
						local var_710_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_6.prefab_name].transform, "story_v_out_317292", "317292172", "story_v_out_317292.awb")

						arg_707_1:RecordAudio("317292172", var_710_11)
						arg_707_1:RecordAudio("317292172", var_710_11)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_out_317292", "317292172", "story_v_out_317292.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_out_317292", "317292172", "story_v_out_317292.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_12 = math.max(var_710_5, arg_707_1.talkMaxDuration)

			if var_710_4 <= arg_707_1.time_ and arg_707_1.time_ < var_710_4 + var_710_12 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_4) / var_710_12

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_4 + var_710_12 and arg_707_1.time_ < var_710_4 + var_710_12 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
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

		arg_707_1:InitPlayNodeList()
	end,
	Play317292173 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 317292173
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play317292174(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 and not isNil(arg_711_1.actors_["1015ui_story"]) and arg_711_1.var_.characterEffect1015ui_story == nil then
				arg_711_1.var_.characterEffect1015ui_story = arg_711_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_0 = 0.200000002980232

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_0 and not isNil(arg_711_1.actors_["1015ui_story"]) then
				if arg_711_1.var_.characterEffect1015ui_story and not isNil(arg_711_1.actors_["1015ui_story"]) then
					arg_711_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_711_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_711_1.time_ - 0) / var_714_0)
				end
			end

			if arg_711_1.time_ >= 0 + var_714_0 and arg_711_1.time_ < 0 + var_714_0 + arg_714_0 and not isNil(arg_711_1.actors_["1015ui_story"]) and arg_711_1.var_.characterEffect1015ui_story then
				arg_711_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_711_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_714_1 = 0
			local var_714_2 = 0.475

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, true)
				arg_711_1.iconController_:SetSelectedState("hero")

				arg_711_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_711_1.callingController_:SetSelectedState("normal")

				arg_711_1.keyicon_.color = Color.New(1, 1, 1)
				arg_711_1.icon_.color = Color.New(1, 1, 1)

				local var_714_3 = arg_711_1:FormatText(arg_711_1:GetWordFromCfg(317292173).content)

				arg_711_1.text_.text = var_714_3

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_5 = 19 <= 0 and var_714_2 or var_714_2 * (utf8.len(var_714_3) / 19)

				if (19 <= 0 and var_714_2 or var_714_2 * (utf8.len(var_714_3) / 19)) > 0 and var_714_2 < var_714_5 then
					arg_711_1.talkMaxDuration = var_714_5

					if var_714_5 + var_714_1 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_5 + var_714_1
					end
				end

				arg_711_1.text_.text = var_714_3
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_6 = math.max(var_714_2, arg_711_1.talkMaxDuration)

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_6 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_1) / var_714_6

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_1 + var_714_6 and arg_711_1.time_ < var_714_1 + var_714_6 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play317292174 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 317292174
		arg_715_1.duration_ = 11.9

		local var_715_0 = {
			zh = 7.7,
			ja = 11.9
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play317292175(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(arg_715_1.actors_["1015ui_story"]) and arg_715_1.var_.characterEffect1015ui_story == nil then
				arg_715_1.var_.characterEffect1015ui_story = arg_715_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_0 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_0 and not isNil(arg_715_1.actors_["1015ui_story"]) then
				if arg_715_1.var_.characterEffect1015ui_story and not isNil(arg_715_1.actors_["1015ui_story"]) then
					arg_715_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_715_1.time_ >= 0 + var_718_0 and arg_715_1.time_ < 0 + var_718_0 + arg_718_0 and not isNil(arg_715_1.actors_["1015ui_story"]) and arg_715_1.var_.characterEffect1015ui_story then
				arg_715_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_718_2 = 0
			local var_718_3 = 0.825

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_2 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_4 = arg_715_1:GetWordFromCfg(317292174)
				local var_718_5 = arg_715_1:FormatText(var_718_4.content)

				arg_715_1.text_.text = var_718_5

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_7 = 33 <= 0 and var_718_3 or var_718_3 * (utf8.len(var_718_5) / 33)

				if (33 <= 0 and var_718_3 or var_718_3 * (utf8.len(var_718_5) / 33)) > 0 and var_718_3 < var_718_7 then
					arg_715_1.talkMaxDuration = var_718_7

					if var_718_7 + var_718_2 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_7 + var_718_2
					end
				end

				arg_715_1.text_.text = var_718_5
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292174", "story_v_out_317292.awb") ~= 0 then
					local var_718_8 = manager.audio:GetVoiceLength("story_v_out_317292", "317292174", "story_v_out_317292.awb") / 1000

					if var_718_8 + var_718_2 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_8 + var_718_2
					end

					if var_718_4.prefab_name ~= "" and arg_715_1.actors_[var_718_4.prefab_name] ~= nil then
						local var_718_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_4.prefab_name].transform, "story_v_out_317292", "317292174", "story_v_out_317292.awb")

						arg_715_1:RecordAudio("317292174", var_718_9)
						arg_715_1:RecordAudio("317292174", var_718_9)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_out_317292", "317292174", "story_v_out_317292.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_out_317292", "317292174", "story_v_out_317292.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_10 = math.max(var_718_3, arg_715_1.talkMaxDuration)

			if var_718_2 <= arg_715_1.time_ and arg_715_1.time_ < var_718_2 + var_718_10 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_2) / var_718_10

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_2 + var_718_10 and arg_715_1.time_ < var_718_2 + var_718_10 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play317292175 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 317292175
		arg_719_1.duration_ = 7.43

		local var_719_0 = {
			zh = 4.433,
			ja = 7.433
		}
		local var_719_1 = manager.audio:GetLocalizationFlag()

		if var_719_0[var_719_1] ~= nil then
			arg_719_1.duration_ = var_719_0[var_719_1]
		end

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play317292176(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0.55

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_1 = arg_719_1:GetWordFromCfg(317292175)
				local var_722_2 = arg_719_1:FormatText(var_722_1.content)

				arg_719_1.text_.text = var_722_2

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_4 = 22 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_2) / 22)

				if (22 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_2) / 22)) > 0 and var_722_0 < var_722_4 then
					arg_719_1.talkMaxDuration = var_722_4

					if var_722_4 + 0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_4 + 0
					end
				end

				arg_719_1.text_.text = var_722_2
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292175", "story_v_out_317292.awb") ~= 0 then
					local var_722_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292175", "story_v_out_317292.awb") / 1000

					if var_722_5 + 0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_5 + 0
					end

					if var_722_1.prefab_name ~= "" and arg_719_1.actors_[var_722_1.prefab_name] ~= nil then
						local var_722_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_1.prefab_name].transform, "story_v_out_317292", "317292175", "story_v_out_317292.awb")

						arg_719_1:RecordAudio("317292175", var_722_6)
						arg_719_1:RecordAudio("317292175", var_722_6)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_out_317292", "317292175", "story_v_out_317292.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_out_317292", "317292175", "story_v_out_317292.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_7 = math.max(var_722_0, arg_719_1.talkMaxDuration)

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_7 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - 0) / var_722_7

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= 0 + var_722_7 and arg_719_1.time_ < 0 + var_722_7 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play317292176 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 317292176
		arg_723_1.duration_ = 2.37

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play317292177(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = 0.25

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				arg_723_1.leftNameTxt_.text = arg_723_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_1 = arg_723_1:GetWordFromCfg(317292176)
				local var_726_2 = arg_723_1:FormatText(var_726_1.content)

				arg_723_1.text_.text = var_726_2

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_4 = 10 <= 0 and var_726_0 or var_726_0 * (utf8.len(var_726_2) / 10)

				if (10 <= 0 and var_726_0 or var_726_0 * (utf8.len(var_726_2) / 10)) > 0 and var_726_0 < var_726_4 then
					arg_723_1.talkMaxDuration = var_726_4

					if var_726_4 + 0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_4 + 0
					end
				end

				arg_723_1.text_.text = var_726_2
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292176", "story_v_out_317292.awb") ~= 0 then
					local var_726_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292176", "story_v_out_317292.awb") / 1000

					if var_726_5 + 0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_5 + 0
					end

					if var_726_1.prefab_name ~= "" and arg_723_1.actors_[var_726_1.prefab_name] ~= nil then
						local var_726_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_1.prefab_name].transform, "story_v_out_317292", "317292176", "story_v_out_317292.awb")

						arg_723_1:RecordAudio("317292176", var_726_6)
						arg_723_1:RecordAudio("317292176", var_726_6)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_out_317292", "317292176", "story_v_out_317292.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_out_317292", "317292176", "story_v_out_317292.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_7 = math.max(var_726_0, arg_723_1.talkMaxDuration)

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_7 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - 0) / var_726_7

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= 0 + var_726_7 and arg_723_1.time_ < 0 + var_726_7 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play317292177 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 317292177
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play317292178(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.var_.moveOldPos2078ui_story = arg_727_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_730_0 = 0.001

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_0 then
				arg_727_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_727_1.time_ - 0) / var_730_0)
				arg_727_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_727_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["2078ui_story"].transform.position).z)
				arg_727_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_727_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_727_1.actors_["2078ui_story"].transform.localEulerAngles = arg_727_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_727_1.time_ >= 0 + var_730_0 and arg_727_1.time_ < 0 + var_730_0 + arg_730_0 then
				arg_727_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_727_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_727_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_727_1.actors_["2078ui_story"].transform.position).z)
				arg_727_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_727_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_727_1.actors_["2078ui_story"].transform.localEulerAngles = arg_727_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_730_1 = "2079ui_story"

			if arg_727_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_730_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_727_1.stage_.transform)

				var_730_2.name = var_730_1
				var_730_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_727_1.actors_[var_730_1] = var_730_2

				local var_730_3 = var_730_2:GetComponentInChildren(typeof(CharacterEffect))

				var_730_3.enabled = true

				local var_730_4 = GameObjectTools.GetOrAddComponent(var_730_2, typeof(DynamicBoneHelper))

				if var_730_4 then
					var_730_4:EnableDynamicBone(false)
				end

				arg_727_1:ShowWeapon(var_730_3.transform, false)

				arg_727_1.var_[var_730_1 .. "Animator"] = var_730_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_727_1.var_[var_730_1 .. "Animator"].applyRootMotion = true
				arg_727_1.var_[var_730_1 .. "LipSync"] = var_730_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_730_5 = arg_727_1.actors_["2079ui_story"].transform

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.var_.moveOldPos2079ui_story = var_730_5.localPosition
			end

			local var_730_6 = 0.001

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_6 then
				var_730_5.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_727_1.time_ - 0) / var_730_6)
				var_730_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_5.position).x, (manager.ui.mainCamera.transform.position - var_730_5.position).y, (manager.ui.mainCamera.transform.position - var_730_5.position).z)
				var_730_5.localEulerAngles.z = 0
				var_730_5.localEulerAngles.x = 0
				var_730_5.localEulerAngles = var_730_5.localEulerAngles
			end

			if arg_727_1.time_ >= 0 + var_730_6 and arg_727_1.time_ < 0 + var_730_6 + arg_730_0 then
				var_730_5.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_730_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_5.position).x, (manager.ui.mainCamera.transform.position - var_730_5.position).y, (manager.ui.mainCamera.transform.position - var_730_5.position).z)
				var_730_5.localEulerAngles.z = 0
				var_730_5.localEulerAngles.x = 0
				var_730_5.localEulerAngles = var_730_5.localEulerAngles
			end

			local var_730_7 = arg_727_1.actors_["1015ui_story"].transform

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.var_.moveOldPos1015ui_story = var_730_7.localPosition
			end

			local var_730_8 = 0.001

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_8 then
				var_730_7.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_727_1.time_ - 0) / var_730_8)
				var_730_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_7.position).x, (manager.ui.mainCamera.transform.position - var_730_7.position).y, (manager.ui.mainCamera.transform.position - var_730_7.position).z)
				var_730_7.localEulerAngles.z = 0
				var_730_7.localEulerAngles.x = 0
				var_730_7.localEulerAngles = var_730_7.localEulerAngles
			end

			if arg_727_1.time_ >= 0 + var_730_8 and arg_727_1.time_ < 0 + var_730_8 + arg_730_0 then
				var_730_7.localPosition = Vector3.New(0, 100, 0)
				var_730_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_7.position).x, (manager.ui.mainCamera.transform.position - var_730_7.position).y, (manager.ui.mainCamera.transform.position - var_730_7.position).z)
				var_730_7.localEulerAngles.z = 0
				var_730_7.localEulerAngles.x = 0
				var_730_7.localEulerAngles = var_730_7.localEulerAngles
			end

			local var_730_9 = arg_727_1.actors_["2079ui_story"]

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 and not isNil(var_730_9) and arg_727_1.var_.characterEffect2079ui_story == nil then
				arg_727_1.var_.characterEffect2079ui_story = var_730_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_10 = 0.0166666666666667

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_10 and not isNil(var_730_9) then
				if arg_727_1.var_.characterEffect2079ui_story and not isNil(var_730_9) then
					arg_727_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_727_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_727_1.time_ - 0) / var_730_10)
				end
			end

			if arg_727_1.time_ >= 0 + var_730_10 and arg_727_1.time_ < 0 + var_730_10 + arg_730_0 and not isNil(var_730_9) and arg_727_1.var_.characterEffect2079ui_story then
				arg_727_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_727_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_730_11 = 0
			local var_730_12 = 1.2

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_11 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, false)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_13 = arg_727_1:FormatText(arg_727_1:GetWordFromCfg(317292177).content)

				arg_727_1.text_.text = var_730_13

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_15 = 48 <= 0 and var_730_12 or var_730_12 * (utf8.len(var_730_13) / 48)

				if (48 <= 0 and var_730_12 or var_730_12 * (utf8.len(var_730_13) / 48)) > 0 and var_730_12 < var_730_15 then
					arg_727_1.talkMaxDuration = var_730_15

					if var_730_15 + var_730_11 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_15 + var_730_11
					end
				end

				arg_727_1.text_.text = var_730_13
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_16 = math.max(var_730_12, arg_727_1.talkMaxDuration)

			if var_730_11 <= arg_727_1.time_ and arg_727_1.time_ < var_730_11 + var_730_16 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_11) / var_730_16

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_11 + var_730_16 and arg_727_1.time_ < var_730_11 + var_730_16 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play317292178 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 317292178
		arg_731_1.duration_ = 11.43

		local var_731_0 = {
			zh = 11.433,
			ja = 8.166
		}
		local var_731_1 = manager.audio:GetLocalizationFlag()

		if var_731_0[var_731_1] ~= nil then
			arg_731_1.duration_ = var_731_0[var_731_1]
		end

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play317292179(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.moveOldPos1015ui_story = arg_731_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_734_0 = 0.001

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_0 then
				arg_731_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_731_1.time_ - 0) / var_734_0)
				arg_731_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_731_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["1015ui_story"].transform.position).z)
				arg_731_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_731_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_731_1.actors_["1015ui_story"].transform.localEulerAngles = arg_731_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_731_1.time_ >= 0 + var_734_0 and arg_731_1.time_ < 0 + var_734_0 + arg_734_0 then
				arg_731_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_731_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_731_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_731_1.actors_["1015ui_story"].transform.position).z)
				arg_731_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_731_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_731_1.actors_["1015ui_story"].transform.localEulerAngles = arg_731_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_734_1 = arg_731_1.actors_["1015ui_story"]

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 and not isNil(var_734_1) and arg_731_1.var_.characterEffect1015ui_story == nil then
				arg_731_1.var_.characterEffect1015ui_story = var_734_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_2 = 0.200000002980232

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_2 and not isNil(var_734_1) then
				if arg_731_1.var_.characterEffect1015ui_story and not isNil(var_734_1) then
					arg_731_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_731_1.time_ >= 0 + var_734_2 and arg_731_1.time_ < 0 + var_734_2 + arg_734_0 and not isNil(var_734_1) and arg_731_1.var_.characterEffect1015ui_story then
				arg_731_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_734_4 = arg_731_1.actors_["2078ui_story"].transform

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.moveOldPos2078ui_story = var_734_4.localPosition
			end

			local var_734_5 = 0.001

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_5 then
				var_734_4.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_731_1.time_ - 0) / var_734_5)
				var_734_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_4.position).x, (manager.ui.mainCamera.transform.position - var_734_4.position).y, (manager.ui.mainCamera.transform.position - var_734_4.position).z)
				var_734_4.localEulerAngles.z = 0
				var_734_4.localEulerAngles.x = 0
				var_734_4.localEulerAngles = var_734_4.localEulerAngles
			end

			if arg_731_1.time_ >= 0 + var_734_5 and arg_731_1.time_ < 0 + var_734_5 + arg_734_0 then
				var_734_4.localPosition = Vector3.New(0, 100, 0)
				var_734_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_4.position).x, (manager.ui.mainCamera.transform.position - var_734_4.position).y, (manager.ui.mainCamera.transform.position - var_734_4.position).z)
				var_734_4.localEulerAngles.z = 0
				var_734_4.localEulerAngles.x = 0
				var_734_4.localEulerAngles = var_734_4.localEulerAngles
			end

			local var_734_6 = arg_731_1.actors_["2079ui_story"].transform

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.moveOldPos2079ui_story = var_734_6.localPosition
			end

			local var_734_7 = 0.001

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_7 then
				var_734_6.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_731_1.time_ - 0) / var_734_7)
				var_734_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_6.position).x, (manager.ui.mainCamera.transform.position - var_734_6.position).y, (manager.ui.mainCamera.transform.position - var_734_6.position).z)
				var_734_6.localEulerAngles.z = 0
				var_734_6.localEulerAngles.x = 0
				var_734_6.localEulerAngles = var_734_6.localEulerAngles
			end

			if arg_731_1.time_ >= 0 + var_734_7 and arg_731_1.time_ < 0 + var_734_7 + arg_734_0 then
				var_734_6.localPosition = Vector3.New(0, 100, 0)
				var_734_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_6.position).x, (manager.ui.mainCamera.transform.position - var_734_6.position).y, (manager.ui.mainCamera.transform.position - var_734_6.position).z)
				var_734_6.localEulerAngles.z = 0
				var_734_6.localEulerAngles.x = 0
				var_734_6.localEulerAngles = var_734_6.localEulerAngles
			end

			local var_734_8 = 0
			local var_734_9 = 1.25

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_8 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				arg_731_1.leftNameTxt_.text = arg_731_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_10 = arg_731_1:GetWordFromCfg(317292178)
				local var_734_11 = arg_731_1:FormatText(var_734_10.content)

				arg_731_1.text_.text = var_734_11

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_13 = 50 <= 0 and var_734_9 or var_734_9 * (utf8.len(var_734_11) / 50)

				if (50 <= 0 and var_734_9 or var_734_9 * (utf8.len(var_734_11) / 50)) > 0 and var_734_9 < var_734_13 then
					arg_731_1.talkMaxDuration = var_734_13

					if var_734_13 + var_734_8 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_13 + var_734_8
					end
				end

				arg_731_1.text_.text = var_734_11
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292178", "story_v_out_317292.awb") ~= 0 then
					local var_734_14 = manager.audio:GetVoiceLength("story_v_out_317292", "317292178", "story_v_out_317292.awb") / 1000

					if var_734_14 + var_734_8 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_14 + var_734_8
					end

					if var_734_10.prefab_name ~= "" and arg_731_1.actors_[var_734_10.prefab_name] ~= nil then
						local var_734_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_10.prefab_name].transform, "story_v_out_317292", "317292178", "story_v_out_317292.awb")

						arg_731_1:RecordAudio("317292178", var_734_15)
						arg_731_1:RecordAudio("317292178", var_734_15)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_out_317292", "317292178", "story_v_out_317292.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_out_317292", "317292178", "story_v_out_317292.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_16 = math.max(var_734_9, arg_731_1.talkMaxDuration)

			if var_734_8 <= arg_731_1.time_ and arg_731_1.time_ < var_734_8 + var_734_16 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_8) / var_734_16

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_8 + var_734_16 and arg_731_1.time_ < var_734_8 + var_734_16 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
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
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	Play317292179 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 317292179
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play317292180(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 and not isNil(arg_735_1.actors_["1015ui_story"]) and arg_735_1.var_.characterEffect1015ui_story == nil then
				arg_735_1.var_.characterEffect1015ui_story = arg_735_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_0 = 0.200000002980232

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_0 and not isNil(arg_735_1.actors_["1015ui_story"]) then
				if arg_735_1.var_.characterEffect1015ui_story and not isNil(arg_735_1.actors_["1015ui_story"]) then
					arg_735_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_735_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_735_1.time_ - 0) / var_738_0)
				end
			end

			if arg_735_1.time_ >= 0 + var_738_0 and arg_735_1.time_ < 0 + var_738_0 + arg_738_0 and not isNil(arg_735_1.actors_["1015ui_story"]) and arg_735_1.var_.characterEffect1015ui_story then
				arg_735_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_735_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_738_1 = 0
			local var_738_2 = 0.175

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_1 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				arg_735_1.leftNameTxt_.text = arg_735_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, true)
				arg_735_1.iconController_:SetSelectedState("hero")

				arg_735_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_735_1.callingController_:SetSelectedState("normal")

				arg_735_1.keyicon_.color = Color.New(1, 1, 1)
				arg_735_1.icon_.color = Color.New(1, 1, 1)

				local var_738_3 = arg_735_1:FormatText(arg_735_1:GetWordFromCfg(317292179).content)

				arg_735_1.text_.text = var_738_3

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_5 = 7 <= 0 and var_738_2 or var_738_2 * (utf8.len(var_738_3) / 7)

				if (7 <= 0 and var_738_2 or var_738_2 * (utf8.len(var_738_3) / 7)) > 0 and var_738_2 < var_738_5 then
					arg_735_1.talkMaxDuration = var_738_5

					if var_738_5 + var_738_1 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_5 + var_738_1
					end
				end

				arg_735_1.text_.text = var_738_3
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_6 = math.max(var_738_2, arg_735_1.talkMaxDuration)

			if var_738_1 <= arg_735_1.time_ and arg_735_1.time_ < var_738_1 + var_738_6 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_1) / var_738_6

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_1 + var_738_6 and arg_735_1.time_ < var_738_1 + var_738_6 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play317292180 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 317292180
		arg_739_1.duration_ = 7

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play317292181(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				local var_742_0 = arg_739_1.bgs_.STblack

				arg_739_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_742_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_742_1 = var_742_0:GetComponent("SpriteRenderer")

				if var_742_1 and var_742_1.sprite then
					local var_742_2 = 2 * (var_742_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_742_0.transform.localScale = Vector3.New(var_742_2 / var_742_1.sprite.bounds.size.y < var_742_2 * manager.ui.mainCameraCom_.aspect / var_742_1.sprite.bounds.size.x and var_742_2 * manager.ui.mainCameraCom_.aspect / var_742_1.sprite.bounds.size.x or var_742_2 / var_742_1.sprite.bounds.size.y, var_742_2 / var_742_1.sprite.bounds.size.y < var_742_2 * manager.ui.mainCameraCom_.aspect / var_742_1.sprite.bounds.size.x and var_742_2 * manager.ui.mainCameraCom_.aspect / var_742_1.sprite.bounds.size.x or var_742_2 / var_742_1.sprite.bounds.size.y, 0)
				end

				for iter_742_0, iter_742_1 in pairs(arg_739_1.bgs_) do
					if iter_742_0 ~= "STblack" then
						iter_742_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_742_3 = 0

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_3 + arg_742_0 then
				arg_739_1.mask_.enabled = true
				arg_739_1.mask_.raycastTarget = true

				arg_739_1:SetGaussion(false)
			end

			local var_742_4 = 2

			if var_742_3 <= arg_739_1.time_ and arg_739_1.time_ < var_742_3 + var_742_4 then
				local var_742_5 = Color.New(0, 0, 0)

				var_742_5.a = Mathf.Lerp(1, 0, (arg_739_1.time_ - var_742_3) / var_742_4)
				arg_739_1.mask_.color = var_742_5
			end

			if arg_739_1.time_ >= var_742_3 + var_742_4 and arg_739_1.time_ < var_742_3 + var_742_4 + arg_742_0 then
				local var_742_6 = Color.New(0, 0, 0)

				arg_739_1.mask_.enabled = false
				var_742_6.a = 0
				arg_739_1.mask_.color = var_742_6
			end

			local var_742_7 = arg_739_1.actors_["1015ui_story"].transform

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1.var_.moveOldPos1015ui_story = var_742_7.localPosition
			end

			local var_742_8 = 0.001

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_8 then
				var_742_7.localPosition = Vector3.Lerp(arg_739_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_739_1.time_ - 0) / var_742_8)
				var_742_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_742_7.position).x, (manager.ui.mainCamera.transform.position - var_742_7.position).y, (manager.ui.mainCamera.transform.position - var_742_7.position).z)
				var_742_7.localEulerAngles.z = 0
				var_742_7.localEulerAngles.x = 0
				var_742_7.localEulerAngles = var_742_7.localEulerAngles
			end

			if arg_739_1.time_ >= 0 + var_742_8 and arg_739_1.time_ < 0 + var_742_8 + arg_742_0 then
				var_742_7.localPosition = Vector3.New(0, 100, 0)
				var_742_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_742_7.position).x, (manager.ui.mainCamera.transform.position - var_742_7.position).y, (manager.ui.mainCamera.transform.position - var_742_7.position).z)
				var_742_7.localEulerAngles.z = 0
				var_742_7.localEulerAngles.x = 0
				var_742_7.localEulerAngles = var_742_7.localEulerAngles
			end

			if arg_739_1.frameCnt_ <= 1 then
				arg_739_1.dialog_:SetActive(false)
			end

			local var_742_9 = 2
			local var_742_10 = 0.8

			if 2 < arg_739_1.time_ and arg_739_1.time_ <= var_742_9 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0

				arg_739_1.dialog_:SetActive(true)

				arg_739_1.dialogCg_.alpha = 0

				local var_742_11 = LeanTween.value(arg_739_1.dialog_, 0, 1, 0.3)

				var_742_11:setOnUpdate(LuaHelper.FloatAction(function(arg_743_0)
					arg_739_1.dialogCg_.alpha = arg_743_0
				end))
				var_742_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_739_1.dialog_)
					var_742_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_739_1.duration_ = arg_739_1.duration_ + 0.3

				SetActive(arg_739_1.leftNameGo_, false)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_12 = arg_739_1:FormatText(arg_739_1:GetWordFromCfg(317292180).content)

				arg_739_1.text_.text = var_742_12

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_14 = 32 <= 0 and var_742_10 or var_742_10 * (utf8.len(var_742_12) / 32)

				if (32 <= 0 and var_742_10 or var_742_10 * (utf8.len(var_742_12) / 32)) > 0 and var_742_10 < var_742_14 then
					arg_739_1.talkMaxDuration = var_742_14
					var_742_9 = var_742_9 + 0.3

					if var_742_14 + var_742_9 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_14 + var_742_9
					end
				end

				arg_739_1.text_.text = var_742_12
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_15 = var_742_9 + 0.3
			local var_742_16 = math.max(var_742_10, arg_739_1.talkMaxDuration)

			if var_742_9 + 0.3 <= arg_739_1.time_ and arg_739_1.time_ < var_742_15 + var_742_16 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_15) / var_742_16

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_15 + var_742_16 and arg_739_1.time_ < var_742_15 + var_742_16 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {
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

		arg_739_1:InitPlayNodeList()
	end,
	Play317292181 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 317292181
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play317292182(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 0.6

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				arg_745_1.leftNameTxt_.text = arg_745_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, true)
				arg_745_1.iconController_:SetSelectedState("hero")

				arg_745_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_745_1.callingController_:SetSelectedState("normal")

				arg_745_1.keyicon_.color = Color.New(1, 1, 1)
				arg_745_1.icon_.color = Color.New(1, 1, 1)

				local var_748_1 = arg_745_1:FormatText(arg_745_1:GetWordFromCfg(317292181).content)

				arg_745_1.text_.text = var_748_1

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_3 = 24 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 24)

				if (24 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 24)) > 0 and var_748_0 < var_748_3 then
					arg_745_1.talkMaxDuration = var_748_3

					if var_748_3 + 0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_3 + 0
					end
				end

				arg_745_1.text_.text = var_748_1
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_4 = math.max(var_748_0, arg_745_1.talkMaxDuration)

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_4 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - 0) / var_748_4

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= 0 + var_748_4 and arg_745_1.time_ < 0 + var_748_4 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play317292182 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 317292182
		arg_749_1.duration_ = 5.27

		local var_749_0 = {
			zh = 5.266,
			ja = 3.566
		}
		local var_749_1 = manager.audio:GetLocalizationFlag()

		if var_749_0[var_749_1] ~= nil then
			arg_749_1.duration_ = var_749_0[var_749_1]
		end

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play317292183(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 0.575

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				arg_749_1.leftNameTxt_.text = arg_749_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, true)
				arg_749_1.iconController_:SetSelectedState("hero")

				arg_749_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_749_1.callingController_:SetSelectedState("normal")

				arg_749_1.keyicon_.color = Color.New(1, 1, 1)
				arg_749_1.icon_.color = Color.New(1, 1, 1)

				local var_752_1 = arg_749_1:GetWordFromCfg(317292182)
				local var_752_2 = arg_749_1:FormatText(var_752_1.content)

				arg_749_1.text_.text = var_752_2

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_4 = 23 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_2) / 23)

				if (23 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_2) / 23)) > 0 and var_752_0 < var_752_4 then
					arg_749_1.talkMaxDuration = var_752_4

					if var_752_4 + 0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_4 + 0
					end
				end

				arg_749_1.text_.text = var_752_2
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317292", "317292182", "story_v_out_317292.awb") ~= 0 then
					local var_752_5 = manager.audio:GetVoiceLength("story_v_out_317292", "317292182", "story_v_out_317292.awb") / 1000

					if var_752_5 + 0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_5 + 0
					end

					if var_752_1.prefab_name ~= "" and arg_749_1.actors_[var_752_1.prefab_name] ~= nil then
						local var_752_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_749_1.actors_[var_752_1.prefab_name].transform, "story_v_out_317292", "317292182", "story_v_out_317292.awb")

						arg_749_1:RecordAudio("317292182", var_752_6)
						arg_749_1:RecordAudio("317292182", var_752_6)
					else
						arg_749_1:AudioAction("play", "voice", "story_v_out_317292", "317292182", "story_v_out_317292.awb")
					end

					arg_749_1:RecordHistoryTalkVoice("story_v_out_317292", "317292182", "story_v_out_317292.awb")
				end

				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_7 = math.max(var_752_0, arg_749_1.talkMaxDuration)

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_7 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - 0) / var_752_7

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= 0 + var_752_7 and arg_749_1.time_ < 0 + var_752_7 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play317292183 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 317292183
		arg_753_1.duration_ = 8.17

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play317292184(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				arg_753_1.fswbg_:SetActive(true)
				arg_753_1.dialog_:SetActive(false)

				arg_753_1.fswtw_.percent = 0
				arg_753_1.fswt_.text = arg_753_1:FormatText(arg_753_1:GetWordFromCfg(317292183).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.fswt_)

				arg_753_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_753_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_753_1.fswtw_:SetDirty()

				arg_753_1.typewritterCharCountI18N = 0

				SetActive(arg_753_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_753_1:ShowNextGo(false)
			end

			local var_756_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_753_1.time_ and arg_753_1.time_ <= var_756_0 + arg_756_0 then
				arg_753_1.var_.oldValueTypewriter = arg_753_1.fswtw_.percent

				SetActive(arg_753_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_753_1:ShowNextGo(false)
			end

			local var_756_1 = 33
			local var_756_2 = 2.2
			local var_756_3, var_756_4 = arg_753_1:GetPercentByPara(arg_753_1:FormatText(arg_753_1:GetWordFromCfg(317292183).content), 1)

			if var_756_0 < arg_753_1.time_ and arg_753_1.time_ <= var_756_0 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0

				local var_756_5 = var_756_1 <= 0 and var_756_2 or var_756_2 * ((var_756_4 - arg_753_1.typewritterCharCountI18N) / var_756_1)

				if (var_756_1 <= 0 and var_756_2 or var_756_2 * ((var_756_4 - arg_753_1.typewritterCharCountI18N) / var_756_1)) > 0 and var_756_2 < var_756_5 then
					arg_753_1.talkMaxDuration = var_756_5

					if var_756_5 + var_756_0 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_5 + var_756_0
					end
				end
			end

			local var_756_6 = math.max(2.2, arg_753_1.talkMaxDuration)

			if var_756_0 <= arg_753_1.time_ and arg_753_1.time_ < var_756_0 + var_756_6 then
				arg_753_1.fswtw_.percent = Mathf.Lerp(arg_753_1.var_.oldValueTypewriter, var_756_3, (arg_753_1.time_ - var_756_0) / var_756_6)
				arg_753_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_753_1.fswtw_:SetDirty()
			end

			if arg_753_1.time_ >= var_756_0 + var_756_6 and arg_753_1.time_ < var_756_0 + var_756_6 + arg_756_0 then
				arg_753_1.fswtw_.percent = var_756_3

				arg_753_1.fswtw_:SetDirty()
				arg_753_1:ShowNextGo(true)

				arg_753_1.typewritterCharCountI18N = var_756_4
			end

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				local var_756_7 = arg_753_1.fswbg_.transform:Find("textbox/adapt/content") or arg_753_1.fswbg_.transform:Find("textbox/content")
				local var_756_8 = arg_753_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_756_9 = var_756_7:GetComponent("RectTransform")

				var_756_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_756_9.offsetMin = Vector2.New(0, 0)
				var_756_9.offsetMax = Vector2.New(0, 0)
			end

			local var_756_10 = 0
			local var_756_11 = manager.audio:GetVoiceLength("story_v_out_317292", "317292183", "story_v_out_317292.awb") / 1000

			if var_756_11 > 0 and 8.166 < var_756_11 and var_756_11 + var_756_10 > arg_753_1.duration_ then
				arg_753_1.duration_ = var_756_11 + var_756_10
			end

			if var_756_10 < arg_753_1.time_ and arg_753_1.time_ <= var_756_10 + arg_756_0 then
				arg_753_1:AudioAction("play", "voice", "story_v_out_317292", "317292183", "story_v_out_317292.awb")
			end

			local var_756_13 = 0

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= var_756_13 + arg_756_0 then
				arg_753_1.allBtn_.enabled = false
			end

			if arg_753_1.time_ >= var_756_13 + 8.166 and arg_753_1.time_ < var_756_13 + 8.166 + arg_756_0 then
				arg_753_1.allBtn_.enabled = true
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play317292184 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 317292184
		arg_757_1.duration_ = 4.07

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play317292185(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1.fswbg_:SetActive(true)
				arg_757_1.dialog_:SetActive(false)

				arg_757_1.fswtw_.percent = 0
				arg_757_1.fswt_.text = arg_757_1:FormatText(arg_757_1:GetWordFromCfg(317292184).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.fswt_)

				arg_757_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_757_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_757_1.fswtw_:SetDirty()

				arg_757_1.typewritterCharCountI18N = 0

				SetActive(arg_757_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_757_1:ShowNextGo(false)
			end

			local var_760_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_757_1.time_ and arg_757_1.time_ <= var_760_0 + arg_760_0 then
				arg_757_1.var_.oldValueTypewriter = arg_757_1.fswtw_.percent

				SetActive(arg_757_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_757_1:ShowNextGo(false)
			end

			local var_760_1 = 17
			local var_760_2 = 1.13333333333333
			local var_760_3, var_760_4 = arg_757_1:GetPercentByPara(arg_757_1:FormatText(arg_757_1:GetWordFromCfg(317292184).content), 1)

			if var_760_0 < arg_757_1.time_ and arg_757_1.time_ <= var_760_0 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0

				local var_760_5 = var_760_1 <= 0 and var_760_2 or var_760_2 * ((var_760_4 - arg_757_1.typewritterCharCountI18N) / var_760_1)

				if (var_760_1 <= 0 and var_760_2 or var_760_2 * ((var_760_4 - arg_757_1.typewritterCharCountI18N) / var_760_1)) > 0 and var_760_2 < var_760_5 then
					arg_757_1.talkMaxDuration = var_760_5

					if var_760_5 + var_760_0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_5 + var_760_0
					end
				end
			end

			local var_760_6 = math.max(1.13333333333333, arg_757_1.talkMaxDuration)

			if var_760_0 <= arg_757_1.time_ and arg_757_1.time_ < var_760_0 + var_760_6 then
				arg_757_1.fswtw_.percent = Mathf.Lerp(arg_757_1.var_.oldValueTypewriter, var_760_3, (arg_757_1.time_ - var_760_0) / var_760_6)
				arg_757_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_757_1.fswtw_:SetDirty()
			end

			if arg_757_1.time_ >= var_760_0 + var_760_6 and arg_757_1.time_ < var_760_0 + var_760_6 + arg_760_0 then
				arg_757_1.fswtw_.percent = var_760_3

				arg_757_1.fswtw_:SetDirty()
				arg_757_1:ShowNextGo(true)

				arg_757_1.typewritterCharCountI18N = var_760_4
			end

			local var_760_7 = 0
			local var_760_8 = manager.audio:GetVoiceLength("story_v_out_317292", "317292184", "story_v_out_317292.awb") / 1000

			if var_760_8 > 0 and 4.066 < var_760_8 and var_760_8 + var_760_7 > arg_757_1.duration_ then
				arg_757_1.duration_ = var_760_8 + var_760_7
			end

			if var_760_7 < arg_757_1.time_ and arg_757_1.time_ <= var_760_7 + arg_760_0 then
				arg_757_1:AudioAction("play", "voice", "story_v_out_317292", "317292184", "story_v_out_317292.awb")
			end

			local var_760_10 = 0

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= var_760_10 + arg_760_0 then
				arg_757_1.allBtn_.enabled = false
			end

			if arg_757_1.time_ >= var_760_10 + 4.066 and arg_757_1.time_ < var_760_10 + 4.066 + arg_760_0 then
				arg_757_1.allBtn_.enabled = true
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play317292185 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 317292185
		arg_761_1.duration_ = 6.93

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
			arg_761_1.auto_ = false
		end

		function arg_761_1.playNext_(arg_763_0)
			arg_761_1.onStoryFinished_()
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				local var_764_0 = arg_761_1.bgs_.YA0206

				arg_761_1.bgs_.YA0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_764_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_764_1 = var_764_0:GetComponent("SpriteRenderer")

				if var_764_1 and var_764_1.sprite then
					local var_764_2 = 2 * (var_764_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_764_0.transform.localScale = Vector3.New(var_764_2 / var_764_1.sprite.bounds.size.y < var_764_2 * manager.ui.mainCameraCom_.aspect / var_764_1.sprite.bounds.size.x and var_764_2 * manager.ui.mainCameraCom_.aspect / var_764_1.sprite.bounds.size.x or var_764_2 / var_764_1.sprite.bounds.size.y, var_764_2 / var_764_1.sprite.bounds.size.y < var_764_2 * manager.ui.mainCameraCom_.aspect / var_764_1.sprite.bounds.size.x and var_764_2 * manager.ui.mainCameraCom_.aspect / var_764_1.sprite.bounds.size.x or var_764_2 / var_764_1.sprite.bounds.size.y, 0)
				end

				for iter_764_0, iter_764_1 in pairs(arg_761_1.bgs_) do
					if iter_764_0 ~= "YA0206" then
						iter_764_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_764_3 = 0

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= var_764_3 + arg_764_0 then
				arg_761_1.mask_.enabled = true
				arg_761_1.mask_.raycastTarget = true

				arg_761_1:SetGaussion(false)
			end

			local var_764_4 = 1.96666666666667

			if var_764_3 <= arg_761_1.time_ and arg_761_1.time_ < var_764_3 + var_764_4 then
				local var_764_5 = Color.New(1, 1, 1)

				var_764_5.a = Mathf.Lerp(1, 0, (arg_761_1.time_ - var_764_3) / var_764_4)
				arg_761_1.mask_.color = var_764_5
			end

			if arg_761_1.time_ >= var_764_3 + var_764_4 and arg_761_1.time_ < var_764_3 + var_764_4 + arg_764_0 then
				local var_764_6 = Color.New(1, 1, 1)

				arg_761_1.mask_.enabled = false
				var_764_6.a = 0
				arg_761_1.mask_.color = var_764_6
			end

			if 1.96666666666667 < arg_761_1.time_ and arg_761_1.time_ <= 1.96666666666667 + arg_764_0 then
				arg_761_1.fswbg_:SetActive(true)
				arg_761_1.dialog_:SetActive(false)

				arg_761_1.fswtw_.percent = 0
				arg_761_1.fswt_.text = arg_761_1:FormatText(arg_761_1:GetWordFromCfg(317292185).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.fswt_)

				arg_761_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_761_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_761_1.fswtw_:SetDirty()

				arg_761_1.typewritterCharCountI18N = 0

				SetActive(arg_761_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_761_1:ShowNextGo(false)
			end

			local var_764_7 = 1.98333333333333

			if 1.98333333333333 < arg_761_1.time_ and arg_761_1.time_ <= var_764_7 + arg_764_0 then
				arg_761_1.var_.oldValueTypewriter = arg_761_1.fswtw_.percent

				SetActive(arg_761_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_761_1:ShowNextGo(false)
			end

			local var_764_8 = 17
			local var_764_9 = 1.13333333333333
			local var_764_10, var_764_11 = arg_761_1:GetPercentByPara(arg_761_1:FormatText(arg_761_1:GetWordFromCfg(317292185).content), 1)

			if var_764_7 < arg_761_1.time_ and arg_761_1.time_ <= var_764_7 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0

				local var_764_12 = var_764_8 <= 0 and var_764_9 or var_764_9 * ((var_764_11 - arg_761_1.typewritterCharCountI18N) / var_764_8)

				if (var_764_8 <= 0 and var_764_9 or var_764_9 * ((var_764_11 - arg_761_1.typewritterCharCountI18N) / var_764_8)) > 0 and var_764_9 < var_764_12 then
					arg_761_1.talkMaxDuration = var_764_12

					if var_764_12 + var_764_7 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_12 + var_764_7
					end
				end
			end

			local var_764_13 = math.max(1.13333333333333, arg_761_1.talkMaxDuration)

			if var_764_7 <= arg_761_1.time_ and arg_761_1.time_ < var_764_7 + var_764_13 then
				arg_761_1.fswtw_.percent = Mathf.Lerp(arg_761_1.var_.oldValueTypewriter, var_764_10, (arg_761_1.time_ - var_764_7) / var_764_13)
				arg_761_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_761_1.fswtw_:SetDirty()
			end

			if arg_761_1.time_ >= var_764_7 + var_764_13 and arg_761_1.time_ < var_764_7 + var_764_13 + arg_764_0 then
				arg_761_1.fswtw_.percent = var_764_10

				arg_761_1.fswtw_:SetDirty()
				arg_761_1:ShowNextGo(true)

				arg_761_1.typewritterCharCountI18N = var_764_11
			end

			local var_764_14 = 1.96666666666667
			local var_764_15 = manager.audio:GetVoiceLength("story_v_out_317292", "317292185", "story_v_out_317292.awb") / 1000

			if var_764_15 > 0 and 4.1 < var_764_15 and var_764_15 + var_764_14 > arg_761_1.duration_ then
				arg_761_1.duration_ = var_764_15 + var_764_14
			end

			if var_764_14 < arg_761_1.time_ and arg_761_1.time_ <= var_764_14 + arg_764_0 then
				arg_761_1:AudioAction("play", "voice", "story_v_out_317292", "317292185", "story_v_out_317292.awb")
			end

			local var_764_17 = 1.96666666666667

			if 1.96666666666667 < arg_761_1.time_ and arg_761_1.time_ <= var_764_17 + arg_764_0 then
				arg_761_1.allBtn_.enabled = false
			end

			if arg_761_1.time_ >= var_764_17 + 4.96666666666667 and arg_761_1.time_ < var_764_17 + 4.96666666666667 + arg_764_0 then
				arg_761_1.allBtn_.enabled = true
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K12f",
		"TextureConfig/Background/ST58",
		"TextureConfig/Background/YA0206",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_317292.awb"
	}
}
