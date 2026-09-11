return {
	Play322071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322071001
		arg_1_1.duration_ = 4.4

		local var_1_0 = {
			zh = 3.799999999999,
			ja = 4.4
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
				arg_1_0:Play322071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L17f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L17f")
				var_4_0.name = "L17f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L17f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L17f

				arg_1_1.bgs_.L17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L17f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1284ui_story"

			if arg_1_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1284ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1284ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1284ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1284ui_story == nil then
				arg_1_1.var_.characterEffect1284ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1284ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1284ui_story then
				arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			if 0.31 < arg_1_1.time_ and arg_1_1.time_ <= 0.31 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_battle", "bgm_activity_4_5_story_serious.awb")

				local var_4_27 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_battle")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 2
			local var_4_29 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_31 = arg_1_1:GetWordFromCfg(322071001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 6 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 6)

				if (6 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 6)) > 0 and var_4_29 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34
					var_4_28 = var_4_28 + 0.3

					if var_4_34 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071001", "story_v_out_322071.awb") ~= 0 then
					local var_4_35 = manager.audio:GetVoiceLength("story_v_out_322071", "322071001", "story_v_out_322071.awb") / 1000

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end

					if var_4_31.prefab_name ~= "" and arg_1_1.actors_[var_4_31.prefab_name] ~= nil then
						local var_4_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_31.prefab_name].transform, "story_v_out_322071", "322071001", "story_v_out_322071.awb")

						arg_1_1:RecordAudio("322071001", var_4_36)
						arg_1_1:RecordAudio("322071001", var_4_36)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322071", "322071001", "story_v_out_322071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322071", "322071001", "story_v_out_322071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_28 + 0.3
			local var_4_38 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_28 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322071002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322071002
		arg_10_1.duration_ = 6.2

		local var_10_0 = {
			zh = 3.566,
			ja = 6.2
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322071003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_13_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_10_1.stage_.transform)

				var_13_0.name = "404001ui_story"
				var_13_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_10_1.actors_["404001ui_story"] = var_13_0

				local var_13_1 = var_13_0:GetComponentInChildren(typeof(CharacterEffect))

				var_13_1.enabled = true

				local var_13_2 = GameObjectTools.GetOrAddComponent(var_13_0, typeof(DynamicBoneHelper))

				if var_13_2 then
					var_13_2:EnableDynamicBone(false)
				end

				arg_10_1:ShowWeapon(var_13_1.transform, false)

				arg_10_1.var_["404001ui_story" .. "Animator"] = var_13_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_10_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_10_1.var_["404001ui_story" .. "LipSync"] = var_13_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_13_3 = arg_10_1.actors_["404001ui_story"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos404001ui_story = var_13_3.localPosition
			end

			local var_13_4 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				var_13_3.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_10_1.time_ - 0) / var_13_4)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				var_13_3.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			local var_13_5 = arg_10_1.actors_["404001ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect404001ui_story == nil then
				arg_10_1.var_.characterEffect404001ui_story = var_13_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_6 = 0.200000002980232

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_6 and not isNil(var_13_5) then
				if arg_10_1.var_.characterEffect404001ui_story and not isNil(var_13_5) then
					arg_10_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= 0 + var_13_6 and arg_10_1.time_ < 0 + var_13_6 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect404001ui_story then
				arg_10_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_13_8 = arg_10_1.actors_["1284ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_8) and arg_10_1.var_.characterEffect1284ui_story == nil then
				arg_10_1.var_.characterEffect1284ui_story = var_13_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_9 = 0.200000002980232

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_9 and not isNil(var_13_8) then
				if arg_10_1.var_.characterEffect1284ui_story and not isNil(var_13_8) then
					arg_10_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_10_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_10_1.time_ - 0) / var_13_9)
				end
			end

			if arg_10_1.time_ >= 0 + var_13_9 and arg_10_1.time_ < 0 + var_13_9 + arg_13_0 and not isNil(var_13_8) and arg_10_1.var_.characterEffect1284ui_story then
				arg_10_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_10_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_13_10 = 0
			local var_13_11 = 0.325

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_10 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_12 = arg_10_1:GetWordFromCfg(322071002)
				local var_13_13 = arg_10_1:FormatText(var_13_12.content)

				arg_10_1.text_.text = var_13_13

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_15 = 13 <= 0 and var_13_11 or var_13_11 * (utf8.len(var_13_13) / 13)

				if (13 <= 0 and var_13_11 or var_13_11 * (utf8.len(var_13_13) / 13)) > 0 and var_13_11 < var_13_15 then
					arg_10_1.talkMaxDuration = var_13_15

					if var_13_15 + var_13_10 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_15 + var_13_10
					end
				end

				arg_10_1.text_.text = var_13_13
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071002", "story_v_out_322071.awb") ~= 0 then
					local var_13_16 = manager.audio:GetVoiceLength("story_v_out_322071", "322071002", "story_v_out_322071.awb") / 1000

					if var_13_16 + var_13_10 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_16 + var_13_10
					end

					if var_13_12.prefab_name ~= "" and arg_10_1.actors_[var_13_12.prefab_name] ~= nil then
						local var_13_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_12.prefab_name].transform, "story_v_out_322071", "322071002", "story_v_out_322071.awb")

						arg_10_1:RecordAudio("322071002", var_13_17)
						arg_10_1:RecordAudio("322071002", var_13_17)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_322071", "322071002", "story_v_out_322071.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_322071", "322071002", "story_v_out_322071.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_18 = math.max(var_13_11, arg_10_1.talkMaxDuration)

			if var_13_10 <= arg_10_1.time_ and arg_10_1.time_ < var_13_10 + var_13_18 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_10) / var_13_18

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_10 + var_13_18 and arg_10_1.time_ < var_13_10 + var_13_18 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play322071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322071003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos404001ui_story = arg_14_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_17_0 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 then
				arg_14_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_14_1.time_ - 0) / var_17_0)
				arg_14_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_14_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["404001ui_story"].transform.position).z)
				arg_14_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_14_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_14_1.actors_["404001ui_story"].transform.localEulerAngles = arg_14_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 then
				arg_14_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_14_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["404001ui_story"].transform.position).z)
				arg_14_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_14_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_14_1.actors_["404001ui_story"].transform.localEulerAngles = arg_14_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_17_1 = arg_14_1.actors_["1284ui_story"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos1284ui_story = var_17_1.localPosition
			end

			local var_17_2 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_2 then
				var_17_1.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_14_1.time_ - 0) / var_17_2)
				var_17_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_1.position).x, (manager.ui.mainCamera.transform.position - var_17_1.position).y, (manager.ui.mainCamera.transform.position - var_17_1.position).z)
				var_17_1.localEulerAngles.z = 0
				var_17_1.localEulerAngles.x = 0
				var_17_1.localEulerAngles = var_17_1.localEulerAngles
			end

			if arg_14_1.time_ >= 0 + var_17_2 and arg_14_1.time_ < 0 + var_17_2 + arg_17_0 then
				var_17_1.localPosition = Vector3.New(0, 100, 0)
				var_17_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_1.position).x, (manager.ui.mainCamera.transform.position - var_17_1.position).y, (manager.ui.mainCamera.transform.position - var_17_1.position).z)
				var_17_1.localEulerAngles.z = 0
				var_17_1.localEulerAngles.x = 0
				var_17_1.localEulerAngles = var_17_1.localEulerAngles
			end

			local var_17_3 = 0
			local var_17_4 = 1.675

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_5 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(322071003).content)

				arg_14_1.text_.text = var_17_5

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_7 = 67 <= 0 and var_17_4 or var_17_4 * (utf8.len(var_17_5) / 67)

				if (67 <= 0 and var_17_4 or var_17_4 * (utf8.len(var_17_5) / 67)) > 0 and var_17_4 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_3 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_3
					end
				end

				arg_14_1.text_.text = var_17_5
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_8 = math.max(var_17_4, arg_14_1.talkMaxDuration)

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_8 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_3) / var_17_8

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_3 + var_17_8 and arg_14_1.time_ < var_17_3 + var_17_8 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322071004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1.375

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(322071004).content)

				arg_18_1.text_.text = var_21_1

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_3 = 55 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_1) / 55)

				if (55 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_1) / 55)) > 0 and var_21_0 < var_21_3 then
					arg_18_1.talkMaxDuration = var_21_3

					if var_21_3 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_3 + 0
					end
				end

				arg_18_1.text_.text = var_21_1
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_4 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_4

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play322071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322071005
		arg_22_1.duration_ = 9

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.bgs_.MS2202 == nil then
				local var_25_0 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2202")
				var_25_0.name = "MS2202"
				var_25_0.transform.parent = arg_22_1.stage_.transform
				var_25_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_.MS2202 = var_25_0
			end

			if 2 < arg_22_1.time_ and arg_22_1.time_ <= 2 + arg_25_0 then
				local var_25_1 = arg_22_1.bgs_.MS2202

				arg_22_1.bgs_.MS2202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_25_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_2 = var_25_1:GetComponent("SpriteRenderer")

				if var_25_2 and var_25_2.sprite then
					local var_25_3 = 2 * (var_25_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_25_1.transform.localScale = Vector3.New(var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "MS2202" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_4 = 4

			if 4 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			if arg_22_1.time_ >= var_25_4 + 0.3 and arg_22_1.time_ < var_25_4 + 0.3 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_5 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_6 = 2

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 then
				local var_25_7 = Color.New(0, 0, 0)

				var_25_7.a = Mathf.Lerp(0, 1, (arg_22_1.time_ - var_25_5) / var_25_6)
				arg_22_1.mask_.color = var_25_7
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 then
				local var_25_8 = Color.New(0, 0, 0)

				var_25_8.a = 1
				arg_22_1.mask_.color = var_25_8
			end

			local var_25_9 = 2

			if 2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_10 = 2

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_10 then
				local var_25_11 = Color.New(0, 0, 0)

				var_25_11.a = Mathf.Lerp(1, 0, (arg_22_1.time_ - var_25_9) / var_25_10)
				arg_22_1.mask_.color = var_25_11
			end

			if arg_22_1.time_ >= var_25_9 + var_25_10 and arg_22_1.time_ < var_25_9 + var_25_10 + arg_25_0 then
				local var_25_12 = Color.New(0, 0, 0)

				arg_22_1.mask_.enabled = false
				var_25_12.a = 0
				arg_22_1.mask_.color = var_25_12
			end

			if 0.1 < arg_22_1.time_ and arg_22_1.time_ <= 0.1 + arg_25_0 then
				arg_22_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 2 < arg_22_1.time_ and arg_22_1.time_ <= 2 + arg_25_0 then
				arg_22_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_MS2202", "")
			end

			local var_25_15 = arg_22_1.bgs_.MS2202.transform

			if 2 < arg_22_1.time_ and arg_22_1.time_ <= 2 + arg_25_0 then
				arg_22_1.var_.moveOldPosMS2202 = var_25_15.localPosition
			end

			local var_25_16 = 0.001

			if 2 <= arg_22_1.time_ and arg_22_1.time_ < 2 + var_25_16 then
				var_25_15.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPosMS2202, Vector3.New(0, -0.5, 2.5), (arg_22_1.time_ - 2) / var_25_16)
			end

			if arg_22_1.time_ >= 2 + var_25_16 and arg_22_1.time_ < 2 + var_25_16 + arg_25_0 then
				var_25_15.localPosition = Vector3.New(0, -0.5, 2.5)
			end

			local var_25_17 = arg_22_1.bgs_.MS2202.transform

			if 2.01666666666667 < arg_22_1.time_ and arg_22_1.time_ <= 2.01666666666667 + arg_25_0 then
				arg_22_1.var_.moveOldPosMS2202 = var_25_17.localPosition
			end

			local var_25_18 = 1.98333333333333

			if 2.01666666666667 <= arg_22_1.time_ and arg_22_1.time_ < 2.01666666666667 + var_25_18 then
				var_25_17.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPosMS2202, Vector3.New(0, -0.5, 2), (arg_22_1.time_ - 2.01666666666667) / var_25_18)
			end

			if arg_22_1.time_ >= 2.01666666666667 + var_25_18 and arg_22_1.time_ < 2.01666666666667 + var_25_18 + arg_25_0 then
				var_25_17.localPosition = Vector3.New(0, -0.5, 2)
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_19 = 4
			local var_25_20 = 1.4

			if 4 < arg_22_1.time_ and arg_22_1.time_ <= var_25_19 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_21 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_21:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_22 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(322071005).content)

				arg_22_1.text_.text = var_25_22

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_24 = 56 <= 0 and var_25_20 or var_25_20 * (utf8.len(var_25_22) / 56)

				if (56 <= 0 and var_25_20 or var_25_20 * (utf8.len(var_25_22) / 56)) > 0 and var_25_20 < var_25_24 then
					arg_22_1.talkMaxDuration = var_25_24
					var_25_19 = var_25_19 + 0.3

					if var_25_24 + var_25_19 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_24 + var_25_19
					end
				end

				arg_22_1.text_.text = var_25_22
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_25 = var_25_19 + 0.3
			local var_25_26 = math.max(var_25_20, arg_22_1.talkMaxDuration)

			if var_25_19 + 0.3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_25 + var_25_26 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_25) / var_25_26

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_25 + var_25_26 and arg_22_1.time_ < var_25_25 + var_25_26 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play322071006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 322071006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play322071007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0.1 < arg_28_1.time_ and arg_28_1.time_ <= 0.1 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_145", "se_story_145_explosion04", "")
			end

			local var_31_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_28_1.time_ and arg_28_1.time_ <= 0.1 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_1.localPosition
			end

			local var_31_2 = 0.733333333333333

			if 0.1 <= arg_28_1.time_ and arg_28_1.time_ < 0.1 + var_31_2 then
				local var_31_3, var_31_4 = math.modf((arg_28_1.time_ - 0.1) / 0.066)

				var_31_1.localPosition = Vector3.New(var_31_4 * 0.13, var_31_4 * 0.13, var_31_4 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= 0.1 + var_31_2 and arg_28_1.time_ < 0.1 + var_31_2 + arg_31_0 then
				var_31_1.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_5 = 0
			local var_31_6 = 1.6

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(322071006).content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 64 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 64)

				if (64 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 64)) > 0 and var_31_6 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_10 and arg_28_1.time_ < var_31_5 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play322071007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 322071007
		arg_32_1.duration_ = 2.47

		local var_32_0 = {
			zh = 2.3,
			ja = 2.466
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
				arg_32_0:Play322071008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.3

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(322071007)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 12 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 12)

				if (12 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 12)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071007", "story_v_out_322071.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071007", "story_v_out_322071.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_322071", "322071007", "story_v_out_322071.awb")

						arg_32_1:RecordAudio("322071007", var_35_6)
						arg_32_1:RecordAudio("322071007", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_322071", "322071007", "story_v_out_322071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_322071", "322071007", "story_v_out_322071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play322071008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 322071008
		arg_36_1.duration_ = 1.9

		local var_36_0 = {
			zh = 1.2,
			ja = 1.9
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
				arg_36_0:Play322071009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.125

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_36_1.callingController_:SetSelectedState("calling")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(322071008)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 5 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 5)

				if (5 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 5)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071008", "story_v_out_322071.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071008", "story_v_out_322071.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_322071", "322071008", "story_v_out_322071.awb")

						arg_36_1:RecordAudio("322071008", var_39_6)
						arg_36_1:RecordAudio("322071008", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_322071", "322071008", "story_v_out_322071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_322071", "322071008", "story_v_out_322071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play322071009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 322071009
		arg_40_1.duration_ = 6.87

		local var_40_0 = {
			zh = 4.866,
			ja = 6.866
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
				arg_40_0:Play322071010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.55

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(322071009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 22 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 22)

				if (22 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 22)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071009", "story_v_out_322071.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071009", "story_v_out_322071.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_322071", "322071009", "story_v_out_322071.awb")

						arg_40_1:RecordAudio("322071009", var_43_6)
						arg_40_1:RecordAudio("322071009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_322071", "322071009", "story_v_out_322071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_322071", "322071009", "story_v_out_322071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play322071010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 322071010
		arg_44_1.duration_ = 7.67

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play322071011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.075

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(322071010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 43 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 43)

				if (43 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 43)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071010", "story_v_out_322071.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071010", "story_v_out_322071.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_322071", "322071010", "story_v_out_322071.awb")

						arg_44_1:RecordAudio("322071010", var_47_6)
						arg_44_1:RecordAudio("322071010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_322071", "322071010", "story_v_out_322071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_322071", "322071010", "story_v_out_322071.awb")
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
	Play322071011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 322071011
		arg_48_1.duration_ = 4

		local var_48_0 = {
			zh = 4,
			ja = 3.6
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
				arg_48_0:Play322071012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:GetWordFromCfg(322071011)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 19 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 19)

				if (19 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 19)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071011", "story_v_out_322071.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071011", "story_v_out_322071.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_322071", "322071011", "story_v_out_322071.awb")

						arg_48_1:RecordAudio("322071011", var_51_6)
						arg_48_1:RecordAudio("322071011", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_322071", "322071011", "story_v_out_322071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_322071", "322071011", "story_v_out_322071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play322071012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 322071012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play322071013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0.1 < arg_52_1.time_ and arg_52_1.time_ <= 0.1 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_145", "se_story_145_plane02", "")
			end

			local var_55_1 = 0
			local var_55_2 = 1.225

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(322071012).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 49 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 49)

				if (49 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 49)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play322071013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 322071013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play322071014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_9001
			local var_59_9000

			if 0.624999999999 < arg_56_1.time_ and arg_56_1.time_ <= 0.624999999999 + arg_59_0 then
				local var_59_0 = arg_56_1.var_.effect1013

				if not arg_56_1.var_.effect1013 then
					var_59_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_59_0.name = "1013"
					arg_56_1.var_.effect1013 = var_59_0
				else
					var_59_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_59_0.transform.localPosition = Vector3.New(-1.63, 0.55, 3.1)
				var_59_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.53333333333333 < arg_56_1.time_ and arg_56_1.time_ <= 3.53333333333333 + arg_59_0 then
				if arg_56_1.var_.effect1013 then
					Object.Destroy(arg_56_1.var_.effect1013)

					arg_56_1.var_.effect1013 = nil
				end
			end

			if 0.766666666666667 < arg_56_1.time_ and arg_56_1.time_ <= 0.766666666666667 + arg_59_0 then
				local var_59_3 = arg_56_1.var_.effect10131

				if not arg_56_1.var_.effect10131 then
					var_59_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_59_3.name = "10131"
					arg_56_1.var_.effect10131 = var_59_3
				else
					var_59_3.transform:SetParent(var_59_9001)
				end

				var_59_3.transform.localPosition = Vector3.New(0.94, 0.15, 2)
				var_59_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.53333333333333 < arg_56_1.time_ and arg_56_1.time_ <= 3.53333333333333 + arg_59_0 then
				if arg_56_1.var_.effect10131 then
					Object.Destroy(arg_56_1.var_.effect10131)

					arg_56_1.var_.effect10131 = nil
				end
			end

			if 0.966666666666667 < arg_56_1.time_ and arg_56_1.time_ <= 0.966666666666667 + arg_59_0 then
				local var_59_6 = arg_56_1.var_.effect10132

				if not arg_56_1.var_.effect10132 then
					var_59_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_59_6.name = "10132"
					arg_56_1.var_.effect10132 = var_59_6
				else
					var_59_6.transform:SetParent(var_59_9000)
				end

				var_59_6.transform.localPosition = Vector3.New(0, 0.11, 2.5)
				var_59_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.53333333333333 < arg_56_1.time_ and arg_56_1.time_ <= 3.53333333333333 + arg_59_0 then
				if arg_56_1.var_.effect10132 then
					Object.Destroy(arg_56_1.var_.effect10132)

					arg_56_1.var_.effect10132 = nil
				end
			end

			local var_59_9 = manager.ui.mainCamera.transform

			if 0.624999999999 < arg_56_1.time_ and arg_56_1.time_ <= 0.624999999999 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_9.localPosition
			end

			local var_59_10 = 0.108333333334333

			if 0.624999999999 <= arg_56_1.time_ and arg_56_1.time_ < 0.624999999999 + var_59_10 then
				local var_59_11, var_59_12 = math.modf((arg_56_1.time_ - 0.624999999999) / 0.066)

				var_59_9.localPosition = Vector3.New(var_59_12 * 0.13, var_59_12 * 0.13, var_59_12 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= 0.624999999999 + var_59_10 and arg_56_1.time_ < 0.624999999999 + var_59_10 + arg_59_0 then
				var_59_9.localPosition = arg_56_1.var_.shakeOldPos
			end

			local var_59_13 = manager.ui.mainCamera.transform

			if 0.766666666666667 < arg_56_1.time_ and arg_56_1.time_ <= 0.766666666666667 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_13.localPosition
			end

			local var_59_14 = 0.133333333333333

			if 0.766666666666667 <= arg_56_1.time_ and arg_56_1.time_ < 0.766666666666667 + var_59_14 then
				local var_59_15, var_59_16 = math.modf((arg_56_1.time_ - 0.766666666666667) / 0.066)

				var_59_13.localPosition = Vector3.New(var_59_16 * 0.13, var_59_16 * 0.13, var_59_16 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= 0.766666666666667 + var_59_14 and arg_56_1.time_ < 0.766666666666667 + var_59_14 + arg_59_0 then
				var_59_13.localPosition = arg_56_1.var_.shakeOldPos
			end

			local var_59_17 = manager.ui.mainCamera.transform

			if 0.966666666666667 < arg_56_1.time_ and arg_56_1.time_ <= 0.966666666666667 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_17.localPosition
			end

			local var_59_18 = 0.133333333333333

			if 0.966666666666667 <= arg_56_1.time_ and arg_56_1.time_ < 0.966666666666667 + var_59_18 then
				local var_59_19, var_59_20 = math.modf((arg_56_1.time_ - 0.966666666666667) / 0.066)

				var_59_17.localPosition = Vector3.New(var_59_20 * 0.13, var_59_20 * 0.13, var_59_20 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= 0.966666666666667 + var_59_18 and arg_56_1.time_ < 0.966666666666667 + var_59_18 + arg_59_0 then
				var_59_17.localPosition = arg_56_1.var_.shakeOldPos
			end

			if 0.606940297875553 < arg_56_1.time_ and arg_56_1.time_ <= 0.606940297875553 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_145", "se_story_145_impact", "")
			end

			local var_59_22 = 0
			local var_59_23 = 1.625

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_24 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(322071013).content)

				arg_56_1.text_.text = var_59_24

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_26 = 65 <= 0 and var_59_23 or var_59_23 * (utf8.len(var_59_24) / 65)

				if (65 <= 0 and var_59_23 or var_59_23 * (utf8.len(var_59_24) / 65)) > 0 and var_59_23 < var_59_26 then
					arg_56_1.talkMaxDuration = var_59_26

					if var_59_26 + var_59_22 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_26 + var_59_22
					end
				end

				arg_56_1.text_.text = var_59_24
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_27 = math.max(var_59_23, arg_56_1.talkMaxDuration)

			if var_59_22 <= arg_56_1.time_ and arg_56_1.time_ < var_59_22 + var_59_27 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_22) / var_59_27

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_22 + var_59_27 and arg_56_1.time_ < var_59_22 + var_59_27 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play322071014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 322071014
		arg_60_1.duration_ = 4.63

		local var_60_0 = {
			zh = 3.9,
			ja = 4.633
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
				arg_60_0:Play322071015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.5

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(322071014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 20 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 20)

				if (20 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 20)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071014", "story_v_out_322071.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071014", "story_v_out_322071.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_322071", "322071014", "story_v_out_322071.awb")

						arg_60_1:RecordAudio("322071014", var_63_6)
						arg_60_1:RecordAudio("322071014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_322071", "322071014", "story_v_out_322071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_322071", "322071014", "story_v_out_322071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play322071015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 322071015
		arg_64_1.duration_ = 6.47

		local var_64_0 = {
			zh = 3,
			ja = 6.466
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
				arg_64_0:Play322071016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.35

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_64_1.callingController_:SetSelectedState("calling")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(322071015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 14 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 14)

				if (14 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 14)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071015", "story_v_out_322071.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071015", "story_v_out_322071.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_322071", "322071015", "story_v_out_322071.awb")

						arg_64_1:RecordAudio("322071015", var_67_6)
						arg_64_1:RecordAudio("322071015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_322071", "322071015", "story_v_out_322071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_322071", "322071015", "story_v_out_322071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play322071016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 322071016
		arg_68_1.duration_ = 1.57

		local var_68_0 = {
			zh = 1.333,
			ja = 1.566
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
				arg_68_0:Play322071017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.125

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(322071016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 5 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 5)

				if (5 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 5)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071016", "story_v_out_322071.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_322071", "322071016", "story_v_out_322071.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_322071", "322071016", "story_v_out_322071.awb")

						arg_68_1:RecordAudio("322071016", var_71_6)
						arg_68_1:RecordAudio("322071016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_322071", "322071016", "story_v_out_322071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_322071", "322071016", "story_v_out_322071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play322071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 322071017
		arg_72_1.duration_ = 8.8

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play322071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 2 < arg_72_1.time_ and arg_72_1.time_ <= 2 + arg_75_0 then
				local var_75_0 = arg_72_1.bgs_.L17f

				arg_72_1.bgs_.L17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_75_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_1 = var_75_0:GetComponent("SpriteRenderer")

				if var_75_1 and var_75_1.sprite then
					local var_75_2 = 2 * (var_75_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_75_0.transform.localScale = Vector3.New(var_75_2 / var_75_1.sprite.bounds.size.y < var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x and var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x or var_75_2 / var_75_1.sprite.bounds.size.y, var_75_2 / var_75_1.sprite.bounds.size.y < var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x and var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x or var_75_2 / var_75_1.sprite.bounds.size.y, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "L17f" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_3 = 4

			if 4 < arg_72_1.time_ and arg_72_1.time_ <= var_75_3 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_3 + 0.3 and arg_72_1.time_ < var_75_3 + 0.3 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_4 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_5 = 2

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_5 then
				local var_75_6 = Color.New(0, 0, 0)

				var_75_6.a = Mathf.Lerp(0, 1, (arg_72_1.time_ - var_75_4) / var_75_5)
				arg_72_1.mask_.color = var_75_6
			end

			if arg_72_1.time_ >= var_75_4 + var_75_5 and arg_72_1.time_ < var_75_4 + var_75_5 + arg_75_0 then
				local var_75_7 = Color.New(0, 0, 0)

				var_75_7.a = 1
				arg_72_1.mask_.color = var_75_7
			end

			local var_75_8 = 2

			if 2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_9 = 2

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_9 then
				local var_75_10 = Color.New(0, 0, 0)

				var_75_10.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_8) / var_75_9)
				arg_72_1.mask_.color = var_75_10
			end

			if arg_72_1.time_ >= var_75_8 + var_75_9 and arg_72_1.time_ < var_75_8 + var_75_9 + arg_75_0 then
				local var_75_11 = Color.New(0, 0, 0)

				arg_72_1.mask_.enabled = false
				var_75_11.a = 0
				arg_72_1.mask_.color = var_75_11
			end

			local var_75_12 = "1061ui_story"

			if arg_72_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_75_13 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_72_1.stage_.transform)

				var_75_13.name = var_75_12
				var_75_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_[var_75_12] = var_75_13

				local var_75_14 = var_75_13:GetComponentInChildren(typeof(CharacterEffect))

				var_75_14.enabled = true

				local var_75_15 = GameObjectTools.GetOrAddComponent(var_75_13, typeof(DynamicBoneHelper))

				if var_75_15 then
					var_75_15:EnableDynamicBone(false)
				end

				arg_72_1:ShowWeapon(var_75_14.transform, false)

				arg_72_1.var_[var_75_12 .. "Animator"] = var_75_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_72_1.var_[var_75_12 .. "Animator"].applyRootMotion = true
				arg_72_1.var_[var_75_12 .. "LipSync"] = var_75_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_75_16 = arg_72_1.actors_["1061ui_story"].transform

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				arg_72_1.var_.moveOldPos1061ui_story = var_75_16.localPosition

				arg_72_1:ShowWeapon(arg_72_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_75_17 = 0.001

			if 3.8 <= arg_72_1.time_ and arg_72_1.time_ < 3.8 + var_75_17 then
				var_75_16.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_72_1.time_ - 3.8) / var_75_17)
				var_75_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_16.position).x, (manager.ui.mainCamera.transform.position - var_75_16.position).y, (manager.ui.mainCamera.transform.position - var_75_16.position).z)
				var_75_16.localEulerAngles.z = 0
				var_75_16.localEulerAngles.x = 0
				var_75_16.localEulerAngles = var_75_16.localEulerAngles
			end

			if arg_72_1.time_ >= 3.8 + var_75_17 and arg_72_1.time_ < 3.8 + var_75_17 + arg_75_0 then
				var_75_16.localPosition = Vector3.New(0, -1.18, -6.15)
				var_75_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_16.position).x, (manager.ui.mainCamera.transform.position - var_75_16.position).y, (manager.ui.mainCamera.transform.position - var_75_16.position).z)
				var_75_16.localEulerAngles.z = 0
				var_75_16.localEulerAngles.x = 0
				var_75_16.localEulerAngles = var_75_16.localEulerAngles
			end

			local var_75_18 = arg_72_1.actors_["1061ui_story"]

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 and not isNil(var_75_18) and arg_72_1.var_.characterEffect1061ui_story == nil then
				arg_72_1.var_.characterEffect1061ui_story = var_75_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_19 = 0.200000002980232

			if 3.8 <= arg_72_1.time_ and arg_72_1.time_ < 3.8 + var_75_19 and not isNil(var_75_18) then
				if arg_72_1.var_.characterEffect1061ui_story and not isNil(var_75_18) then
					arg_72_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 3.8 + var_75_19 and arg_72_1.time_ < 3.8 + var_75_19 + arg_75_0 and not isNil(var_75_18) and arg_72_1.var_.characterEffect1061ui_story then
				arg_72_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				arg_72_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				arg_72_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 0.233333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 0.233333333333333 + arg_75_0 then
				arg_72_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_MS2202", "")
			end

			if 1.6 < arg_72_1.time_ and arg_72_1.time_ <= 1.6 + arg_75_0 then
				arg_72_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				if arg_72_1.var_.characterEffect1061ui_story == nil then
					arg_72_1.var_.characterEffect1061ui_story = arg_72_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_75_23 = arg_72_1.var_.characterEffect1061ui_story

				arg_72_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_75_23.interferenceEffect.enabled = true
				var_75_23.interferenceEffect.noise = 0.001
				var_75_23.interferenceEffect.simTimeScale = 1
				var_75_23.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				if arg_72_1.var_.characterEffect1061ui_story == nil then
					arg_72_1.var_.characterEffect1061ui_story = arg_72_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_72_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_25 = 4
			local var_75_26 = 0.5

			if 4 < arg_72_1.time_ and arg_72_1.time_ <= var_75_25 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_27 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_27:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_28 = arg_72_1:GetWordFromCfg(322071017)
				local var_75_29 = arg_72_1:FormatText(var_75_28.content)

				arg_72_1.text_.text = var_75_29

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_31 = 20 <= 0 and var_75_26 or var_75_26 * (utf8.len(var_75_29) / 20)

				if (20 <= 0 and var_75_26 or var_75_26 * (utf8.len(var_75_29) / 20)) > 0 and var_75_26 < var_75_31 then
					arg_72_1.talkMaxDuration = var_75_31
					var_75_25 = var_75_25 + 0.3

					if var_75_31 + var_75_25 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_31 + var_75_25
					end
				end

				arg_72_1.text_.text = var_75_29
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071017", "story_v_out_322071.awb") ~= 0 then
					local var_75_32 = manager.audio:GetVoiceLength("story_v_out_322071", "322071017", "story_v_out_322071.awb") / 1000

					if var_75_32 + var_75_25 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_32 + var_75_25
					end

					if var_75_28.prefab_name ~= "" and arg_72_1.actors_[var_75_28.prefab_name] ~= nil then
						local var_75_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_28.prefab_name].transform, "story_v_out_322071", "322071017", "story_v_out_322071.awb")

						arg_72_1:RecordAudio("322071017", var_75_33)
						arg_72_1:RecordAudio("322071017", var_75_33)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_322071", "322071017", "story_v_out_322071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_322071", "322071017", "story_v_out_322071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_34 = var_75_25 + 0.3
			local var_75_35 = math.max(var_75_26, arg_72_1.talkMaxDuration)

			if var_75_25 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_34 + var_75_35 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_34) / var_75_35

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_34 + var_75_35 and arg_72_1.time_ < var_75_34 + var_75_35 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play322071018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322071018
		arg_78_1.duration_ = 13.2

		local var_78_0 = {
			zh = 10.033,
			ja = 13.2
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
				arg_78_0:Play322071019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				if arg_78_1.var_.characterEffect1061ui_story == nil then
					arg_78_1.var_.characterEffect1061ui_story = arg_78_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_81_0 = arg_78_1.var_.characterEffect1061ui_story

				arg_78_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_81_0.interferenceEffect.enabled = true
				var_81_0.interferenceEffect.noise = 0.001
				var_81_0.interferenceEffect.simTimeScale = 1
				var_81_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				if arg_78_1.var_.characterEffect1061ui_story == nil then
					arg_78_1.var_.characterEffect1061ui_story = arg_78_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_78_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_81_2 = 0
			local var_81_3 = 1.25

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(322071018)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 50 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 50)

				if (50 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 50)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071018", "story_v_out_322071.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071018", "story_v_out_322071.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_322071", "322071018", "story_v_out_322071.awb")

						arg_78_1:RecordAudio("322071018", var_81_9)
						arg_78_1:RecordAudio("322071018", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322071", "322071018", "story_v_out_322071.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322071", "322071018", "story_v_out_322071.awb")
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
	Play322071019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322071019
		arg_82_1.duration_ = 15.93

		local var_82_0 = {
			zh = 12.333,
			ja = 15.933
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
				arg_82_0:Play322071020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_85_0 = 0
			local var_85_1 = 1.475

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(322071019)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 59 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 59)

				if (59 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 59)) > 0 and var_85_1 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071019", "story_v_out_322071.awb") ~= 0 then
					local var_85_6 = manager.audio:GetVoiceLength("story_v_out_322071", "322071019", "story_v_out_322071.awb") / 1000

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end

					if var_85_2.prefab_name ~= "" and arg_82_1.actors_[var_85_2.prefab_name] ~= nil then
						local var_85_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_2.prefab_name].transform, "story_v_out_322071", "322071019", "story_v_out_322071.awb")

						arg_82_1:RecordAudio("322071019", var_85_7)
						arg_82_1:RecordAudio("322071019", var_85_7)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322071", "322071019", "story_v_out_322071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322071", "322071019", "story_v_out_322071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322071020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322071020
		arg_86_1.duration_ = 8.67

		local var_86_0 = {
			zh = 5.766,
			ja = 8.666
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
				arg_86_0:Play322071021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos404001ui_story = arg_86_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["404001ui_story"].transform.position).z)
				arg_86_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["404001ui_story"].transform.localEulerAngles = arg_86_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_86_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["404001ui_story"].transform.position).z)
				arg_86_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["404001ui_story"].transform.localEulerAngles = arg_86_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1061ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1061ui_story = var_89_1.localPosition
			end

			local var_89_2 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_86_1.time_ - 0) / var_89_2)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			local var_89_3 = arg_86_1.actors_["404001ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect404001ui_story == nil then
				arg_86_1.var_.characterEffect404001ui_story = var_89_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_4 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 and not isNil(var_89_3) then
				if arg_86_1.var_.characterEffect404001ui_story and not isNil(var_89_3) then
					arg_86_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect404001ui_story then
				arg_86_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_89_6 = arg_86_1.actors_["1061ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect1061ui_story == nil then
				arg_86_1.var_.characterEffect1061ui_story = var_89_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_7 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 and not isNil(var_89_6) then
				if arg_86_1.var_.characterEffect1061ui_story and not isNil(var_89_6) then
					arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_7)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect1061ui_story then
				arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_8 = 0
			local var_89_9 = 0.575

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:GetWordFromCfg(322071020)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 23 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 23)

				if (23 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 23)) > 0 and var_89_9 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071020", "story_v_out_322071.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_322071", "322071020", "story_v_out_322071.awb") / 1000

					if var_89_14 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_8
					end

					if var_89_10.prefab_name ~= "" and arg_86_1.actors_[var_89_10.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_10.prefab_name].transform, "story_v_out_322071", "322071020", "story_v_out_322071.awb")

						arg_86_1:RecordAudio("322071020", var_89_15)
						arg_86_1:RecordAudio("322071020", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322071", "322071020", "story_v_out_322071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322071", "322071020", "story_v_out_322071.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_16 and arg_86_1.time_ < var_89_8 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play322071021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322071021
		arg_90_1.duration_ = 8.3

		local var_90_0 = {
			zh = 6.466,
			ja = 8.3
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
				arg_90_0:Play322071022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1061ui_story = arg_90_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_93_0 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 then
				arg_90_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_90_1.time_ - 0) / var_93_0)
				arg_90_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).z)
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles = arg_90_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 then
				arg_90_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_90_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).z)
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles = arg_90_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_93_1 = arg_90_1.actors_["1061ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1061ui_story == nil then
				arg_90_1.var_.characterEffect1061ui_story = var_93_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_2 and not isNil(var_93_1) then
				if arg_90_1.var_.characterEffect1061ui_story and not isNil(var_93_1) then
					arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_2 and arg_90_1.time_ < 0 + var_93_2 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1061ui_story then
				arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["404001ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect404001ui_story == nil then
				arg_90_1.var_.characterEffect404001ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_5 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_5 and not isNil(var_93_4) then
				if arg_90_1.var_.characterEffect404001ui_story and not isNil(var_93_4) then
					arg_90_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_90_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_5)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_5 and arg_90_1.time_ < 0 + var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect404001ui_story then
				arg_90_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_90_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				if arg_90_1.var_.characterEffect1061ui_story == nil then
					arg_90_1.var_.characterEffect1061ui_story = arg_90_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_93_6 = arg_90_1.var_.characterEffect1061ui_story

				arg_90_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_93_6.interferenceEffect.enabled = true
				var_93_6.interferenceEffect.noise = 0.001
				var_93_6.interferenceEffect.simTimeScale = 1
				var_93_6.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				if arg_90_1.var_.characterEffect1061ui_story == nil then
					arg_90_1.var_.characterEffect1061ui_story = arg_90_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_90_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_93_8 = 0
			local var_93_9 = 0.75

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(322071021)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 30 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 30)

				if (30 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 30)) > 0 and var_93_9 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071021", "story_v_out_322071.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_322071", "322071021", "story_v_out_322071.awb") / 1000

					if var_93_14 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_8
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_322071", "322071021", "story_v_out_322071.awb")

						arg_90_1:RecordAudio("322071021", var_93_15)
						arg_90_1:RecordAudio("322071021", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322071", "322071021", "story_v_out_322071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322071", "322071021", "story_v_out_322071.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play322071022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322071022
		arg_94_1.duration_ = 13.93

		local var_94_0 = {
			zh = 10.833,
			ja = 13.933
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
				arg_94_0:Play322071023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				if arg_94_1.var_.characterEffect1061ui_story == nil then
					arg_94_1.var_.characterEffect1061ui_story = arg_94_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_97_0 = arg_94_1.var_.characterEffect1061ui_story

				arg_94_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_97_0.interferenceEffect.enabled = true
				var_97_0.interferenceEffect.noise = 0.001
				var_97_0.interferenceEffect.simTimeScale = 1
				var_97_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				if arg_94_1.var_.characterEffect1061ui_story == nil then
					arg_94_1.var_.characterEffect1061ui_story = arg_94_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_94_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_97_2 = 0
			local var_97_3 = 1.2

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:GetWordFromCfg(322071022)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 48 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 48)

				if (48 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 48)) > 0 and var_97_3 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071022", "story_v_out_322071.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071022", "story_v_out_322071.awb") / 1000

					if var_97_8 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_2
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_out_322071", "322071022", "story_v_out_322071.awb")

						arg_94_1:RecordAudio("322071022", var_97_9)
						arg_94_1:RecordAudio("322071022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322071", "322071022", "story_v_out_322071.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322071", "322071022", "story_v_out_322071.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_10 and arg_94_1.time_ < var_97_2 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322071023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322071023
		arg_98_1.duration_ = 6.53

		local var_98_0 = {
			zh = 6.533,
			ja = 5.733
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
				arg_98_0:Play322071024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				if arg_98_1.var_.characterEffect1061ui_story == nil then
					arg_98_1.var_.characterEffect1061ui_story = arg_98_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_101_0 = arg_98_1.var_.characterEffect1061ui_story

				arg_98_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_101_0.interferenceEffect.enabled = true
				var_101_0.interferenceEffect.noise = 0.001
				var_101_0.interferenceEffect.simTimeScale = 1
				var_101_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				if arg_98_1.var_.characterEffect1061ui_story == nil then
					arg_98_1.var_.characterEffect1061ui_story = arg_98_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_98_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_101_2 = 0
			local var_101_3 = 0.8

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_4 = arg_98_1:GetWordFromCfg(322071023)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 32 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 32)

				if (32 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 32)) > 0 and var_101_3 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071023", "story_v_out_322071.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071023", "story_v_out_322071.awb") / 1000

					if var_101_8 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_2
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_out_322071", "322071023", "story_v_out_322071.awb")

						arg_98_1:RecordAudio("322071023", var_101_9)
						arg_98_1:RecordAudio("322071023", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322071", "322071023", "story_v_out_322071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322071", "322071023", "story_v_out_322071.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_10 and arg_98_1.time_ < var_101_2 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play322071024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322071024
		arg_102_1.duration_ = 5.57

		local var_102_0 = {
			zh = 3.7,
			ja = 5.566
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
				arg_102_0:Play322071025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos404001ui_story = arg_102_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).z)
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles = arg_102_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_102_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["404001ui_story"].transform.position).z)
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["404001ui_story"].transform.localEulerAngles = arg_102_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["404001ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect404001ui_story == nil then
				arg_102_1.var_.characterEffect404001ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect404001ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect404001ui_story then
				arg_102_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["1061ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_5 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_5 and not isNil(var_105_4) then
				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_4) then
					arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_5)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_5 and arg_102_1.time_ < 0 + var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1061ui_story then
				arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_6 = 0
			local var_105_7 = 0.325

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_8 = arg_102_1:GetWordFromCfg(322071024)
				local var_105_9 = arg_102_1:FormatText(var_105_8.content)

				arg_102_1.text_.text = var_105_9

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 13 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 13)

				if (13 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 13)) > 0 and var_105_7 < var_105_11 then
					arg_102_1.talkMaxDuration = var_105_11

					if var_105_11 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_9
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071024", "story_v_out_322071.awb") ~= 0 then
					local var_105_12 = manager.audio:GetVoiceLength("story_v_out_322071", "322071024", "story_v_out_322071.awb") / 1000

					if var_105_12 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_6
					end

					if var_105_8.prefab_name ~= "" and arg_102_1.actors_[var_105_8.prefab_name] ~= nil then
						local var_105_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_8.prefab_name].transform, "story_v_out_322071", "322071024", "story_v_out_322071.awb")

						arg_102_1:RecordAudio("322071024", var_105_13)
						arg_102_1:RecordAudio("322071024", var_105_13)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322071", "322071024", "story_v_out_322071.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322071", "322071024", "story_v_out_322071.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play322071025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322071025
		arg_106_1.duration_ = 8.57

		local var_106_0 = {
			zh = 8.566,
			ja = 7.866
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
				arg_106_0:Play322071026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1061ui_story"]) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = arg_106_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1061ui_story"]) then
				if arg_106_1.var_.characterEffect1061ui_story and not isNil(arg_106_1.actors_["1061ui_story"]) then
					arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1061ui_story"]) and arg_106_1.var_.characterEffect1061ui_story then
				arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["404001ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect404001ui_story == nil then
				arg_106_1.var_.characterEffect404001ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect404001ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_106_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect404001ui_story then
				arg_106_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_106_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				if arg_106_1.var_.characterEffect1061ui_story == nil then
					arg_106_1.var_.characterEffect1061ui_story = arg_106_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_109_4 = arg_106_1.var_.characterEffect1061ui_story

				arg_106_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_109_4.interferenceEffect.enabled = true
				var_109_4.interferenceEffect.noise = 0.001
				var_109_4.interferenceEffect.simTimeScale = 1
				var_109_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				if arg_106_1.var_.characterEffect1061ui_story == nil then
					arg_106_1.var_.characterEffect1061ui_story = arg_106_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_106_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_109_6 = 0
			local var_109_7 = 1.05

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(322071025)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 42 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 42)

				if (42 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 42)) > 0 and var_109_7 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071025", "story_v_out_322071.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_322071", "322071025", "story_v_out_322071.awb") / 1000

					if var_109_12 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_6
					end

					if var_109_8.prefab_name ~= "" and arg_106_1.actors_[var_109_8.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_8.prefab_name].transform, "story_v_out_322071", "322071025", "story_v_out_322071.awb")

						arg_106_1:RecordAudio("322071025", var_109_13)
						arg_106_1:RecordAudio("322071025", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322071", "322071025", "story_v_out_322071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322071", "322071025", "story_v_out_322071.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322071026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322071026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322071027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				if arg_110_1.var_.characterEffect1061ui_story == nil then
					arg_110_1.var_.characterEffect1061ui_story = arg_110_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_113_0 = arg_110_1.var_.characterEffect1061ui_story

				arg_110_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_113_0.interferenceEffect.enabled = true
				var_113_0.interferenceEffect.noise = 0.001
				var_113_0.interferenceEffect.simTimeScale = 1
				var_113_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				if arg_110_1.var_.characterEffect1061ui_story == nil then
					arg_110_1.var_.characterEffect1061ui_story = arg_110_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_110_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_113_2 = 0
			local var_113_3 = 0.2

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_4 = arg_110_1:GetWordFromCfg(322071026)
				local var_113_5 = arg_110_1:FormatText(var_113_4.content)

				arg_110_1.text_.text = var_113_5

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_7 = 8 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 8)

				if (8 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 8)) > 0 and var_113_3 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_2
					end
				end

				arg_110_1.text_.text = var_113_5
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071026", "story_v_out_322071.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071026", "story_v_out_322071.awb") / 1000

					if var_113_8 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_2
					end

					if var_113_4.prefab_name ~= "" and arg_110_1.actors_[var_113_4.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_4.prefab_name].transform, "story_v_out_322071", "322071026", "story_v_out_322071.awb")

						arg_110_1:RecordAudio("322071026", var_113_9)
						arg_110_1:RecordAudio("322071026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322071", "322071026", "story_v_out_322071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322071", "322071026", "story_v_out_322071.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_3, arg_110_1.talkMaxDuration)

			if var_113_2 <= arg_110_1.time_ and arg_110_1.time_ < var_113_2 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_2) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_2 + var_113_10 and arg_110_1.time_ < var_113_2 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play322071027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322071027
		arg_114_1.duration_ = 2.87

		local var_114_0 = {
			zh = 2,
			ja = 2.866
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
				arg_114_0:Play322071028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["404001ui_story"]) and arg_114_1.var_.characterEffect404001ui_story == nil then
				arg_114_1.var_.characterEffect404001ui_story = arg_114_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["404001ui_story"]) then
				if arg_114_1.var_.characterEffect404001ui_story and not isNil(arg_114_1.actors_["404001ui_story"]) then
					arg_114_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["404001ui_story"]) and arg_114_1.var_.characterEffect404001ui_story then
				arg_114_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1061ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_117_4 = 0
			local var_117_5 = 0.15

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(322071027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 6 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 6)

				if (6 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 6)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071027", "story_v_out_322071.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_322071", "322071027", "story_v_out_322071.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_322071", "322071027", "story_v_out_322071.awb")

						arg_114_1:RecordAudio("322071027", var_117_11)
						arg_114_1:RecordAudio("322071027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_322071", "322071027", "story_v_out_322071.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_322071", "322071027", "story_v_out_322071.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play322071028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 322071028
		arg_118_1.duration_ = 11.8

		local var_118_0 = {
			zh = 9.6,
			ja = 11.8
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
				arg_118_0:Play322071029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1061ui_story"]) and arg_118_1.var_.characterEffect1061ui_story == nil then
				arg_118_1.var_.characterEffect1061ui_story = arg_118_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1061ui_story"]) then
				if arg_118_1.var_.characterEffect1061ui_story and not isNil(arg_118_1.actors_["1061ui_story"]) then
					arg_118_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1061ui_story"]) and arg_118_1.var_.characterEffect1061ui_story then
				arg_118_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["404001ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect404001ui_story == nil then
				arg_118_1.var_.characterEffect404001ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect404001ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_118_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect404001ui_story then
				arg_118_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_118_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				if arg_118_1.var_.characterEffect1061ui_story == nil then
					arg_118_1.var_.characterEffect1061ui_story = arg_118_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_121_4 = arg_118_1.var_.characterEffect1061ui_story

				arg_118_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_121_4.interferenceEffect.enabled = true
				var_121_4.interferenceEffect.noise = 0.001
				var_121_4.interferenceEffect.simTimeScale = 1
				var_121_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				if arg_118_1.var_.characterEffect1061ui_story == nil then
					arg_118_1.var_.characterEffect1061ui_story = arg_118_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_118_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_121_6 = 0
			local var_121_7 = 1.125

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_8 = arg_118_1:GetWordFromCfg(322071028)
				local var_121_9 = arg_118_1:FormatText(var_121_8.content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 45 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 45)

				if (45 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 45)) > 0 and var_121_7 < var_121_11 then
					arg_118_1.talkMaxDuration = var_121_11

					if var_121_11 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071028", "story_v_out_322071.awb") ~= 0 then
					local var_121_12 = manager.audio:GetVoiceLength("story_v_out_322071", "322071028", "story_v_out_322071.awb") / 1000

					if var_121_12 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_6
					end

					if var_121_8.prefab_name ~= "" and arg_118_1.actors_[var_121_8.prefab_name] ~= nil then
						local var_121_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_8.prefab_name].transform, "story_v_out_322071", "322071028", "story_v_out_322071.awb")

						arg_118_1:RecordAudio("322071028", var_121_13)
						arg_118_1:RecordAudio("322071028", var_121_13)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_322071", "322071028", "story_v_out_322071.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_322071", "322071028", "story_v_out_322071.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play322071029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 322071029
		arg_122_1.duration_ = 5.9

		local var_122_0 = {
			zh = 4.999999999999,
			ja = 5.9
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
				arg_122_0:Play322071030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				if arg_122_1.var_.characterEffect1061ui_story == nil then
					arg_122_1.var_.characterEffect1061ui_story = arg_122_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_125_0 = arg_122_1.var_.characterEffect1061ui_story

				arg_122_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_125_0.interferenceEffect.enabled = true
				var_125_0.interferenceEffect.noise = 0.001
				var_125_0.interferenceEffect.simTimeScale = 1
				var_125_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				if arg_122_1.var_.characterEffect1061ui_story == nil then
					arg_122_1.var_.characterEffect1061ui_story = arg_122_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_122_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_125_2 = 0
			local var_125_3 = 0.675

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(322071029)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 27 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 27)

				if (27 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 27)) > 0 and var_125_3 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071029", "story_v_out_322071.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071029", "story_v_out_322071.awb") / 1000

					if var_125_8 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_2
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_322071", "322071029", "story_v_out_322071.awb")

						arg_122_1:RecordAudio("322071029", var_125_9)
						arg_122_1:RecordAudio("322071029", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_322071", "322071029", "story_v_out_322071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_322071", "322071029", "story_v_out_322071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_10 and arg_122_1.time_ < var_125_2 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play322071030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 322071030
		arg_126_1.duration_ = 4.4

		local var_126_0 = {
			zh = 4.4,
			ja = 4.366
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
				arg_126_0:Play322071031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1284ui_story = arg_126_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1284ui_story"].transform.position).z)
				arg_126_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1284ui_story"].transform.localEulerAngles = arg_126_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_126_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1284ui_story"].transform.position).z)
				arg_126_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1284ui_story"].transform.localEulerAngles = arg_126_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["404001ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos404001ui_story = var_129_1.localPosition
			end

			local var_129_2 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 then
				var_129_1.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_2)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 then
				var_129_1.localPosition = Vector3.New(0, 100, 0)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			local var_129_3 = arg_126_1.actors_["1284ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1284ui_story == nil then
				arg_126_1.var_.characterEffect1284ui_story = var_129_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_4 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 and not isNil(var_129_3) then
				if arg_126_1.var_.characterEffect1284ui_story and not isNil(var_129_3) then
					arg_126_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1284ui_story then
				arg_126_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_129_6 = arg_126_1.actors_["1061ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_6) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_7 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 and not isNil(var_129_6) then
				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_6) then
					arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_7)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 and not isNil(var_129_6) and arg_126_1.var_.characterEffect1061ui_story then
				arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_8 = 0
			local var_129_9 = 0.575

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(322071030)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 23 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 23)

				if (23 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 23)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071030", "story_v_out_322071.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_322071", "322071030", "story_v_out_322071.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_322071", "322071030", "story_v_out_322071.awb")

						arg_126_1:RecordAudio("322071030", var_129_15)
						arg_126_1:RecordAudio("322071030", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_322071", "322071030", "story_v_out_322071.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_322071", "322071030", "story_v_out_322071.awb")
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
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play322071031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 322071031
		arg_130_1.duration_ = 9.97

		local var_130_0 = {
			zh = 8,
			ja = 9.966
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
				arg_130_0:Play322071032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1061ui_story"]) and arg_130_1.var_.characterEffect1061ui_story == nil then
				arg_130_1.var_.characterEffect1061ui_story = arg_130_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1061ui_story"]) then
				if arg_130_1.var_.characterEffect1061ui_story and not isNil(arg_130_1.actors_["1061ui_story"]) then
					arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1061ui_story"]) and arg_130_1.var_.characterEffect1061ui_story then
				arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_133_2 = arg_130_1.actors_["1284ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1284ui_story == nil then
				arg_130_1.var_.characterEffect1284ui_story = var_133_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_3 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 and not isNil(var_133_2) then
				if arg_130_1.var_.characterEffect1284ui_story and not isNil(var_133_2) then
					arg_130_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_3)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1284ui_story then
				arg_130_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				if arg_130_1.var_.characterEffect1061ui_story == nil then
					arg_130_1.var_.characterEffect1061ui_story = arg_130_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_133_4 = arg_130_1.var_.characterEffect1061ui_story

				arg_130_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_133_4.interferenceEffect.enabled = true
				var_133_4.interferenceEffect.noise = 0.001
				var_133_4.interferenceEffect.simTimeScale = 1
				var_133_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				if arg_130_1.var_.characterEffect1061ui_story == nil then
					arg_130_1.var_.characterEffect1061ui_story = arg_130_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_130_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_133_6 = 0
			local var_133_7 = 0.85

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(322071031)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 34 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 34)

				if (34 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 34)) > 0 and var_133_7 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071031", "story_v_out_322071.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_322071", "322071031", "story_v_out_322071.awb") / 1000

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end

					if var_133_8.prefab_name ~= "" and arg_130_1.actors_[var_133_8.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_8.prefab_name].transform, "story_v_out_322071", "322071031", "story_v_out_322071.awb")

						arg_130_1:RecordAudio("322071031", var_133_13)
						arg_130_1:RecordAudio("322071031", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_322071", "322071031", "story_v_out_322071.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_322071", "322071031", "story_v_out_322071.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play322071032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 322071032
		arg_134_1.duration_ = 3.43

		local var_134_0 = {
			zh = 1.999999999999,
			ja = 3.433
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
				arg_134_0:Play322071033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos404001ui_story = arg_134_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["404001ui_story"].transform.position).z)
				arg_134_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["404001ui_story"].transform.localEulerAngles = arg_134_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_134_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["404001ui_story"].transform.position).z)
				arg_134_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["404001ui_story"].transform.localEulerAngles = arg_134_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["1284ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1284ui_story = var_137_1.localPosition
			end

			local var_137_2 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 then
				var_137_1.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 0) / var_137_2)
				var_137_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_1.position).x, (manager.ui.mainCamera.transform.position - var_137_1.position).y, (manager.ui.mainCamera.transform.position - var_137_1.position).z)
				var_137_1.localEulerAngles.z = 0
				var_137_1.localEulerAngles.x = 0
				var_137_1.localEulerAngles = var_137_1.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 then
				var_137_1.localPosition = Vector3.New(0, 100, 0)
				var_137_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_1.position).x, (manager.ui.mainCamera.transform.position - var_137_1.position).y, (manager.ui.mainCamera.transform.position - var_137_1.position).z)
				var_137_1.localEulerAngles.z = 0
				var_137_1.localEulerAngles.x = 0
				var_137_1.localEulerAngles = var_137_1.localEulerAngles
			end

			local var_137_3 = arg_134_1.actors_["404001ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_3) and arg_134_1.var_.characterEffect404001ui_story == nil then
				arg_134_1.var_.characterEffect404001ui_story = var_137_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_4 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 and not isNil(var_137_3) then
				if arg_134_1.var_.characterEffect404001ui_story and not isNil(var_137_3) then
					arg_134_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 and not isNil(var_137_3) and arg_134_1.var_.characterEffect404001ui_story then
				arg_134_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_137_6 = arg_134_1.actors_["1061ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_6) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_7 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 and not isNil(var_137_6) then
				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_6) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_7)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 and not isNil(var_137_6) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_8 = 0
			local var_137_9 = 0.125

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_10 = arg_134_1:GetWordFromCfg(322071032)
				local var_137_11 = arg_134_1:FormatText(var_137_10.content)

				arg_134_1.text_.text = var_137_11

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_13 = 5 <= 0 and var_137_9 or var_137_9 * (utf8.len(var_137_11) / 5)

				if (5 <= 0 and var_137_9 or var_137_9 * (utf8.len(var_137_11) / 5)) > 0 and var_137_9 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_8
					end
				end

				arg_134_1.text_.text = var_137_11
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071032", "story_v_out_322071.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_322071", "322071032", "story_v_out_322071.awb") / 1000

					if var_137_14 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_8
					end

					if var_137_10.prefab_name ~= "" and arg_134_1.actors_[var_137_10.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_10.prefab_name].transform, "story_v_out_322071", "322071032", "story_v_out_322071.awb")

						arg_134_1:RecordAudio("322071032", var_137_15)
						arg_134_1:RecordAudio("322071032", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_322071", "322071032", "story_v_out_322071.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_322071", "322071032", "story_v_out_322071.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_9, arg_134_1.talkMaxDuration)

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_8) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_8 + var_137_16 and arg_134_1.time_ < var_137_8 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play322071033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322071033
		arg_138_1.duration_ = 5

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
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) and arg_138_1.var_.characterEffect1061ui_story == nil then
				arg_138_1.var_.characterEffect1061ui_story = arg_138_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) then
				if arg_138_1.var_.characterEffect1061ui_story and not isNil(arg_138_1.actors_["1061ui_story"]) then
					arg_138_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) and arg_138_1.var_.characterEffect1061ui_story then
				arg_138_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_141_2 = arg_138_1.actors_["404001ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect404001ui_story == nil then
				arg_138_1.var_.characterEffect404001ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_3 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.characterEffect404001ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_138_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_3)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect404001ui_story then
				arg_138_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_138_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				if arg_138_1.var_.characterEffect1061ui_story == nil then
					arg_138_1.var_.characterEffect1061ui_story = arg_138_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_141_4 = arg_138_1.var_.characterEffect1061ui_story

				arg_138_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_141_4.interferenceEffect.enabled = true
				var_141_4.interferenceEffect.noise = 0.001
				var_141_4.interferenceEffect.simTimeScale = 1
				var_141_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				if arg_138_1.var_.characterEffect1061ui_story == nil then
					arg_138_1.var_.characterEffect1061ui_story = arg_138_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_138_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_141_6 = 0
			local var_141_7 = 0.125

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(322071033)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 5 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 5)

				if (5 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 5)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071033", "story_v_out_322071.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_322071", "322071033", "story_v_out_322071.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_322071", "322071033", "story_v_out_322071.awb")

						arg_138_1:RecordAudio("322071033", var_141_13)
						arg_138_1:RecordAudio("322071033", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_322071", "322071033", "story_v_out_322071.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_322071", "322071033", "story_v_out_322071.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L17f",
		"TextureConfig/Background/MS2202"
	},
	voices = {
		"story_v_out_322071.awb"
	}
}
