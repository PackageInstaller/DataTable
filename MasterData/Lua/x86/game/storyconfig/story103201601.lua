return {
	Play320161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320161001
		arg_1_1.duration_ = 4.47

		local var_1_0 = {
			zh = 3.799999999999,
			ja = 4.46600000298023
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
				arg_1_0:Play320161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST61 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_4_0.name = "ST61"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST61 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST61

				arg_1_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST61" then
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

			local var_4_9 = "10102ui_story"

			if arg_1_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10102ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10102ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.985, -6.275)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10102ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10102ui_story == nil then
				arg_1_1.var_.characterEffect10102ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10102ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10102ui_story then
				arg_1_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if 0.834000001847744 < arg_1_1.time_ and arg_1_1.time_ <= 0.834000001847744 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_130", "se_story_130__knock", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2.00000000298023
			local var_4_26 = 0.1

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_28 = arg_1_1:GetWordFromCfg(320161001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 4 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 4)

				if (4 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 4)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161001", "story_v_out_320161.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_320161", "320161001", "story_v_out_320161.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_320161", "320161001", "story_v_out_320161.awb")

						arg_1_1:RecordAudio("320161001", var_4_33)
						arg_1_1:RecordAudio("320161001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320161", "320161001", "story_v_out_320161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320161", "320161001", "story_v_out_320161.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play320161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320161002
		arg_9_1.duration_ = 3.1

		local var_9_0 = {
			zh = 3.1,
			ja = 2.5
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
				arg_9_0:Play320161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1056ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1056ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1056ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1056ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1056ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1056ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -1, -5.75)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1056ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1056ui_story == nil then
				arg_9_1.var_.characterEffect1056ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1056ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1056ui_story then
				arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_12_8 = arg_9_1.actors_["10102ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10102ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["10102ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10102ui_story == nil then
				arg_9_1.var_.characterEffect10102ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect10102ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10102ui_story then
				arg_9_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(320161002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 11 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 11)

				if (11 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 11)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161002", "story_v_out_320161.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_320161", "320161002", "story_v_out_320161.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_320161", "320161002", "story_v_out_320161.awb")

						arg_9_1:RecordAudio("320161002", var_12_19)
						arg_9_1:RecordAudio("320161002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320161", "320161002", "story_v_out_320161.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320161", "320161002", "story_v_out_320161.awb")
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
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play320161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320161003
		arg_13_1.duration_ = 4.5

		local var_13_0 = {
			zh = 3,
			ja = 4.5
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
				arg_13_0:Play320161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10102ui_story"]) and arg_13_1.var_.characterEffect10102ui_story == nil then
				arg_13_1.var_.characterEffect10102ui_story = arg_13_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10102ui_story"]) then
				if arg_13_1.var_.characterEffect10102ui_story and not isNil(arg_13_1.actors_["10102ui_story"]) then
					arg_13_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10102ui_story"]) and arg_13_1.var_.characterEffect10102ui_story then
				arg_13_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_16_2 = arg_13_1.actors_["1056ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect1056ui_story == nil then
				arg_13_1.var_.characterEffect1056ui_story = var_16_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_3 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.characterEffect1056ui_story and not isNil(var_16_2) then
					arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_3)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect1056ui_story then
				arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_16_4 = 0
			local var_16_5 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(320161003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 14 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 14)

				if (14 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 14)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161003", "story_v_out_320161.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161003", "story_v_out_320161.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_320161", "320161003", "story_v_out_320161.awb")

						arg_13_1:RecordAudio("320161003", var_16_11)
						arg_13_1:RecordAudio("320161003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320161", "320161003", "story_v_out_320161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320161", "320161003", "story_v_out_320161.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play320161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320161004
		arg_17_1.duration_ = 3.03

		local var_17_0 = {
			zh = 2.533,
			ja = 3.033
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
				arg_17_0:Play320161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) and arg_17_1.var_.characterEffect1056ui_story == nil then
				arg_17_1.var_.characterEffect1056ui_story = arg_17_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) then
				if arg_17_1.var_.characterEffect1056ui_story and not isNil(arg_17_1.actors_["1056ui_story"]) then
					arg_17_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) and arg_17_1.var_.characterEffect1056ui_story then
				arg_17_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = arg_17_1.actors_["10102ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect10102ui_story == nil then
				arg_17_1.var_.characterEffect10102ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect10102ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect10102ui_story then
				arg_17_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(320161004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)

				if (10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161004", "story_v_out_320161.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161004", "story_v_out_320161.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_320161", "320161004", "story_v_out_320161.awb")

						arg_17_1:RecordAudio("320161004", var_20_11)
						arg_17_1:RecordAudio("320161004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320161", "320161004", "story_v_out_320161.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320161", "320161004", "story_v_out_320161.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play320161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320161005
		arg_21_1.duration_ = 3.63

		local var_21_0 = {
			zh = 3.633,
			ja = 2.5
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play320161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) and arg_21_1.var_.characterEffect10102ui_story == nil then
				arg_21_1.var_.characterEffect10102ui_story = arg_21_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) then
				if arg_21_1.var_.characterEffect10102ui_story and not isNil(arg_21_1.actors_["10102ui_story"]) then
					arg_21_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) and arg_21_1.var_.characterEffect10102ui_story then
				arg_21_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_2 = arg_21_1.actors_["1056ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1056ui_story == nil then
				arg_21_1.var_.characterEffect1056ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1056ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1056ui_story then
				arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(320161005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 12 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 12)

				if (12 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 12)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161005", "story_v_out_320161.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161005", "story_v_out_320161.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_320161", "320161005", "story_v_out_320161.awb")

						arg_21_1:RecordAudio("320161005", var_24_11)
						arg_21_1:RecordAudio("320161005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320161", "320161005", "story_v_out_320161.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320161", "320161005", "story_v_out_320161.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320161006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320161006
		arg_25_1.duration_ = 2.7

		local var_25_0 = {
			zh = 1.3,
			ja = 2.7
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play320161007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1056ui_story"]) and arg_25_1.var_.characterEffect1056ui_story == nil then
				arg_25_1.var_.characterEffect1056ui_story = arg_25_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1056ui_story"]) then
				if arg_25_1.var_.characterEffect1056ui_story and not isNil(arg_25_1.actors_["1056ui_story"]) then
					arg_25_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1056ui_story"]) and arg_25_1.var_.characterEffect1056ui_story then
				arg_25_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_28_2 = arg_25_1.actors_["10102ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10102ui_story == nil then
				arg_25_1.var_.characterEffect10102ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect10102ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10102ui_story then
				arg_25_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(320161006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 4 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 4)

				if (4 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 4)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161006", "story_v_out_320161.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161006", "story_v_out_320161.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_320161", "320161006", "story_v_out_320161.awb")

						arg_25_1:RecordAudio("320161006", var_28_11)
						arg_25_1:RecordAudio("320161006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320161", "320161006", "story_v_out_320161.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320161", "320161006", "story_v_out_320161.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320161007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320161007
		arg_29_1.duration_ = 3.77

		local var_29_0 = {
			zh = 3.033,
			ja = 3.766
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
				arg_29_0:Play320161008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10102ui_story"]) and arg_29_1.var_.characterEffect10102ui_story == nil then
				arg_29_1.var_.characterEffect10102ui_story = arg_29_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10102ui_story"]) then
				if arg_29_1.var_.characterEffect10102ui_story and not isNil(arg_29_1.actors_["10102ui_story"]) then
					arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10102ui_story"]) and arg_29_1.var_.characterEffect10102ui_story then
				arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["1056ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1056ui_story == nil then
				arg_29_1.var_.characterEffect1056ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1056ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1056ui_story then
				arg_29_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_32_4 = 0
			local var_32_5 = 0.425

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(320161007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 17 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 17)

				if (17 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 17)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161007", "story_v_out_320161.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161007", "story_v_out_320161.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_320161", "320161007", "story_v_out_320161.awb")

						arg_29_1:RecordAudio("320161007", var_32_11)
						arg_29_1:RecordAudio("320161007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320161", "320161007", "story_v_out_320161.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320161", "320161007", "story_v_out_320161.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320161008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320161008
		arg_33_1.duration_ = 12.7

		local var_33_0 = {
			zh = 8.6,
			ja = 12.7
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
				arg_33_0:Play320161009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_0 = 0
			local var_36_1 = 1.225

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
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

				local var_36_2 = arg_33_1:GetWordFromCfg(320161008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 49 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 49)

				if (49 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 49)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161008", "story_v_out_320161.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161008", "story_v_out_320161.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_320161", "320161008", "story_v_out_320161.awb")

						arg_33_1:RecordAudio("320161008", var_36_7)
						arg_33_1:RecordAudio("320161008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320161", "320161008", "story_v_out_320161.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320161", "320161008", "story_v_out_320161.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320161009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320161009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play320161010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10102ui_story = arg_37_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).z)
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles = arg_37_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).z)
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles = arg_37_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10102ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10102ui_story == nil then
				arg_37_1.var_.characterEffect10102ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10102ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10102ui_story then
				arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_40_3 = arg_37_1.actors_["1056ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1056ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, 100, 0)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["1056ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1056ui_story == nil then
				arg_37_1.var_.characterEffect1056ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect1056ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_6)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1056ui_story then
				arg_37_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_40_7 = 0
			local var_40_8 = 1.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(320161009).content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 47 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_9) / 47)

				if (47 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_9) / 47)) > 0 and var_40_8 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_12 and arg_37_1.time_ < var_40_7 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320161010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320161010
		arg_41_1.duration_ = 6.63

		local var_41_0 = {
			zh = 5.799999999999,
			ja = 6.633
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
				arg_41_0:Play320161011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.bgs_.L01f == nil then
				local var_44_0 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_44_0.name = "L01f"
				var_44_0.transform.parent = arg_41_1.stage_.transform
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_.L01f = var_44_0
			end

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= 2 + arg_44_0 then
				local var_44_1 = arg_41_1.bgs_.L01f

				arg_41_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_2 = var_44_1:GetComponent("SpriteRenderer")

				if var_44_2 and var_44_2.sprite then
					local var_44_3 = 2 * (var_44_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_1.transform.localScale = Vector3.New(var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "L01f" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_4 = 4

			if 4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_4 + 0.3 and arg_41_1.time_ < var_44_4 + 0.3 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_5 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = Mathf.Lerp(0, 1, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(0, 0, 0)

				var_44_8.a = 1
				arg_41_1.mask_.color = var_44_8
			end

			local var_44_9 = 2

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_10 = 2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 then
				local var_44_11 = Color.New(0, 0, 0)

				var_44_11.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_9) / var_44_10)
				arg_41_1.mask_.color = var_44_11
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 then
				local var_44_12 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_12.a = 0
				arg_41_1.mask_.color = var_44_12
			end

			local var_44_13 = arg_41_1.actors_["1056ui_story"].transform

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1.var_.moveOldPos1056ui_story = var_44_13.localPosition
			end

			local var_44_14 = 0.001

			if 3.8 <= arg_41_1.time_ and arg_41_1.time_ < 3.8 + var_44_14 then
				var_44_13.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_41_1.time_ - 3.8) / var_44_14)
				var_44_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_13.position).x, (manager.ui.mainCamera.transform.position - var_44_13.position).y, (manager.ui.mainCamera.transform.position - var_44_13.position).z)
				var_44_13.localEulerAngles.z = 0
				var_44_13.localEulerAngles.x = 0
				var_44_13.localEulerAngles = var_44_13.localEulerAngles
			end

			if arg_41_1.time_ >= 3.8 + var_44_14 and arg_41_1.time_ < 3.8 + var_44_14 + arg_44_0 then
				var_44_13.localPosition = Vector3.New(0, -1, -5.75)
				var_44_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_13.position).x, (manager.ui.mainCamera.transform.position - var_44_13.position).y, (manager.ui.mainCamera.transform.position - var_44_13.position).z)
				var_44_13.localEulerAngles.z = 0
				var_44_13.localEulerAngles.x = 0
				var_44_13.localEulerAngles = var_44_13.localEulerAngles
			end

			local var_44_15 = arg_41_1.actors_["1056ui_story"]

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect1056ui_story == nil then
				arg_41_1.var_.characterEffect1056ui_story = var_44_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_16 = 0.200000002980232

			if 3.8 <= arg_41_1.time_ and arg_41_1.time_ < 3.8 + var_44_16 and not isNil(var_44_15) then
				if arg_41_1.var_.characterEffect1056ui_story and not isNil(var_44_15) then
					arg_41_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 3.8 + var_44_16 and arg_41_1.time_ < 3.8 + var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect1056ui_story then
				arg_41_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_44_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_41_1.bgmTxt_.text ~= var_44_20 and arg_41_1.bgmTxt_.text ~= "" then
						if arg_41_1.bgmTxt2_.text ~= "" then
							arg_41_1.bgmTxt_.text = arg_41_1.bgmTxt2_.text
						end

						arg_41_1.bgmTxt2_.text = var_44_20

						arg_41_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_41_1.bgmTxt_.text = var_44_20
						arg_41_1.bgmTxt2_.text = var_44_20
					end

					if arg_41_1.bgmTimer then
						arg_41_1.bgmTimer:Stop()

						arg_41_1.bgmTimer = nil
					end

					if arg_41_1.settingData.show_music_name == 1 then
						arg_41_1.musicController:SetSelectedState("show")
						arg_41_1.musicAnimator_:Play("open", 0, 0)

						if arg_41_1.settingData.music_time ~= 0 then
							arg_41_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_41_1.settingData.music_time), function()
								if arg_41_1 == nil or isNil(arg_41_1.bgmTxt_) then
									return
								end

								arg_41_1.musicController:SetSelectedState("hide")
								arg_41_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.33333333333333 < arg_41_1.time_ and arg_41_1.time_ <= 1.33333333333333 + arg_44_0 then
				arg_41_1:AudioAction("play", "music", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet.awb")

				local var_44_23 = manager.audio:GetAudioName("bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet")

				if "" ~= "" then
					if arg_41_1.bgmTxt_.text ~= var_44_23 and arg_41_1.bgmTxt_.text ~= "" then
						if arg_41_1.bgmTxt2_.text ~= "" then
							arg_41_1.bgmTxt_.text = arg_41_1.bgmTxt2_.text
						end

						arg_41_1.bgmTxt2_.text = var_44_23

						arg_41_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_41_1.bgmTxt_.text = var_44_23
						arg_41_1.bgmTxt2_.text = var_44_23
					end

					if arg_41_1.bgmTimer then
						arg_41_1.bgmTimer:Stop()

						arg_41_1.bgmTimer = nil
					end

					if arg_41_1.settingData.show_music_name == 1 then
						arg_41_1.musicController:SetSelectedState("show")
						arg_41_1.musicAnimator_:Play("open", 0, 0)

						if arg_41_1.settingData.music_time ~= 0 then
							arg_41_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_41_1.settingData.music_time), function()
								if arg_41_1 == nil or isNil(arg_41_1.bgmTxt_) then
									return
								end

								arg_41_1.musicController:SetSelectedState("hide")
								arg_41_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_24 = 4
			local var_44_25 = 0.15

			if 4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_26 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_26:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_41_1.dialogCg_.alpha = arg_47_0
				end))
				var_44_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_27 = arg_41_1:GetWordFromCfg(320161010)
				local var_44_28 = arg_41_1:FormatText(var_44_27.content)

				arg_41_1.text_.text = var_44_28

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_30 = 6 <= 0 and var_44_25 or var_44_25 * (utf8.len(var_44_28) / 6)

				if (6 <= 0 and var_44_25 or var_44_25 * (utf8.len(var_44_28) / 6)) > 0 and var_44_25 < var_44_30 then
					arg_41_1.talkMaxDuration = var_44_30
					var_44_24 = var_44_24 + 0.3

					if var_44_30 + var_44_24 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_30 + var_44_24
					end
				end

				arg_41_1.text_.text = var_44_28
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161010", "story_v_out_320161.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_320161", "320161010", "story_v_out_320161.awb") / 1000

					if var_44_31 + var_44_24 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_24
					end

					if var_44_27.prefab_name ~= "" and arg_41_1.actors_[var_44_27.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_27.prefab_name].transform, "story_v_out_320161", "320161010", "story_v_out_320161.awb")

						arg_41_1:RecordAudio("320161010", var_44_32)
						arg_41_1:RecordAudio("320161010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320161", "320161010", "story_v_out_320161.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320161", "320161010", "story_v_out_320161.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_33 = var_44_24 + 0.3
			local var_44_34 = math.max(var_44_25, arg_41_1.talkMaxDuration)

			if var_44_24 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_33 + var_44_34 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_33) / var_44_34

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_33 + var_44_34 and arg_41_1.time_ < var_44_33 + var_44_34 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play320161011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320161011
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play320161012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1056ui_story = arg_49_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1056ui_story"].transform.position).z)
				arg_49_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1056ui_story"].transform.localEulerAngles = arg_49_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1056ui_story"].transform.position).z)
				arg_49_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1056ui_story"].transform.localEulerAngles = arg_49_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1056ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1056ui_story == nil then
				arg_49_1.var_.characterEffect1056ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1056ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_2)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1056ui_story then
				arg_49_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_52_3 = 0
			local var_52_4 = 1.025

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(320161011).content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 41 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 41)

				if (41 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 41)) > 0 and var_52_4 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_8 and arg_49_1.time_ < var_52_3 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320161012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320161012
		arg_53_1.duration_ = 5.5

		local var_53_0 = {
			zh = 4,
			ja = 5.5
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320161013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_56_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_53_1.stage_.transform)

				var_56_0.name = "1089ui_story"
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1089ui_story"] = var_56_0

				local var_56_1 = var_56_0:GetComponentInChildren(typeof(CharacterEffect))

				var_56_1.enabled = true

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_1.transform, false)

				arg_53_1.var_["1089ui_story" .. "Animator"] = var_56_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_53_1.var_["1089ui_story" .. "LipSync"] = var_56_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_3 = arg_53_1.actors_["1089ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1089ui_story = var_56_3.localPosition

				arg_53_1:ShowWeapon(arg_53_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_53_1.time_ - 0) / var_56_4)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			local var_56_5 = arg_53_1.actors_["1089ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1089ui_story == nil then
				arg_53_1.var_.characterEffect1089ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.characterEffect1089ui_story and not isNil(var_56_5) then
					arg_53_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1089ui_story then
				arg_53_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_56_8 = arg_53_1.actors_["1056ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1056ui_story = var_56_8.localPosition
			end

			local var_56_9 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 then
				var_56_8.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_53_1.time_ - 0) / var_56_9)
				var_56_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_8.position).x, (manager.ui.mainCamera.transform.position - var_56_8.position).y, (manager.ui.mainCamera.transform.position - var_56_8.position).z)
				var_56_8.localEulerAngles.z = 0
				var_56_8.localEulerAngles.x = 0
				var_56_8.localEulerAngles = var_56_8.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 then
				var_56_8.localPosition = Vector3.New(0.7, -1, -5.75)
				var_56_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_8.position).x, (manager.ui.mainCamera.transform.position - var_56_8.position).y, (manager.ui.mainCamera.transform.position - var_56_8.position).z)
				var_56_8.localEulerAngles.z = 0
				var_56_8.localEulerAngles.x = 0
				var_56_8.localEulerAngles = var_56_8.localEulerAngles
			end

			local var_56_10 = arg_53_1.actors_["1056ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_10) and arg_53_1.var_.characterEffect1056ui_story == nil then
				arg_53_1.var_.characterEffect1056ui_story = var_56_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_11 and not isNil(var_56_10) then
				if arg_53_1.var_.characterEffect1056ui_story and not isNil(var_56_10) then
					arg_53_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_11)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_11 and arg_53_1.time_ < 0 + var_56_11 + arg_56_0 and not isNil(var_56_10) and arg_53_1.var_.characterEffect1056ui_story then
				arg_53_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_56_12 = 0
			local var_56_13 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(320161012)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 14 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 14)

				if (14 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 14)) > 0 and var_56_13 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17

					if var_56_17 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161012", "story_v_out_320161.awb") ~= 0 then
					local var_56_18 = manager.audio:GetVoiceLength("story_v_out_320161", "320161012", "story_v_out_320161.awb") / 1000

					if var_56_18 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_12
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_320161", "320161012", "story_v_out_320161.awb")

						arg_53_1:RecordAudio("320161012", var_56_19)
						arg_53_1:RecordAudio("320161012", var_56_19)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320161", "320161012", "story_v_out_320161.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320161", "320161012", "story_v_out_320161.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_20 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_20 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_20

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_20 and arg_53_1.time_ < var_56_12 + var_56_20 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320161013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320161013
		arg_57_1.duration_ = 3.9

		local var_57_0 = {
			zh = 3.4,
			ja = 3.9
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
				arg_57_0:Play320161014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1056ui_story"]) and arg_57_1.var_.characterEffect1056ui_story == nil then
				arg_57_1.var_.characterEffect1056ui_story = arg_57_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1056ui_story"]) then
				if arg_57_1.var_.characterEffect1056ui_story and not isNil(arg_57_1.actors_["1056ui_story"]) then
					arg_57_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1056ui_story"]) and arg_57_1.var_.characterEffect1056ui_story then
				arg_57_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_60_2 = arg_57_1.actors_["1089ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1089ui_story == nil then
				arg_57_1.var_.characterEffect1089ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1089ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1089ui_story then
				arg_57_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_60_4 = 0
			local var_60_5 = 0.45

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(320161013)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 18 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 18)

				if (18 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 18)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161013", "story_v_out_320161.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161013", "story_v_out_320161.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_320161", "320161013", "story_v_out_320161.awb")

						arg_57_1:RecordAudio("320161013", var_60_11)
						arg_57_1:RecordAudio("320161013", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320161", "320161013", "story_v_out_320161.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320161", "320161013", "story_v_out_320161.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320161014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320161014
		arg_61_1.duration_ = 7.07

		local var_61_0 = {
			zh = 4.166,
			ja = 7.066
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play320161015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1089ui_story"]) and arg_61_1.var_.characterEffect1089ui_story == nil then
				arg_61_1.var_.characterEffect1089ui_story = arg_61_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1089ui_story"]) then
				if arg_61_1.var_.characterEffect1089ui_story and not isNil(arg_61_1.actors_["1089ui_story"]) then
					arg_61_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1089ui_story"]) and arg_61_1.var_.characterEffect1089ui_story then
				arg_61_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action424")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = arg_61_1.actors_["1056ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1056ui_story == nil then
				arg_61_1.var_.characterEffect1056ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1056ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1056ui_story then
				arg_61_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.475

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(320161014)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 19 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 19)

				if (19 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 19)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161014", "story_v_out_320161.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161014", "story_v_out_320161.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_320161", "320161014", "story_v_out_320161.awb")

						arg_61_1:RecordAudio("320161014", var_64_11)
						arg_61_1:RecordAudio("320161014", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320161", "320161014", "story_v_out_320161.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320161", "320161014", "story_v_out_320161.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320161015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320161015
		arg_65_1.duration_ = 3.73

		local var_65_0 = {
			zh = 3.733,
			ja = 3.3
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
				arg_65_0:Play320161016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.45

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(320161015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 18 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 18)

				if (18 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 18)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161015", "story_v_out_320161.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161015", "story_v_out_320161.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_320161", "320161015", "story_v_out_320161.awb")

						arg_65_1:RecordAudio("320161015", var_68_6)
						arg_65_1:RecordAudio("320161015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320161", "320161015", "story_v_out_320161.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320161", "320161015", "story_v_out_320161.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play320161016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320161016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320161017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1089ui_story = arg_69_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1089ui_story"].transform.position).z)
				arg_69_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1089ui_story"].transform.localEulerAngles = arg_69_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1089ui_story"].transform.position).z)
				arg_69_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1089ui_story"].transform.localEulerAngles = arg_69_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1089ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1089ui_story == nil then
				arg_69_1.var_.characterEffect1089ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1089ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_2)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1089ui_story then
				arg_69_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_72_3 = arg_69_1.actors_["1056ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1056ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, 100, 0)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1056ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1056ui_story == nil then
				arg_69_1.var_.characterEffect1056ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1056ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_6)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1056ui_story then
				arg_69_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_72_7 = 0
			local var_72_8 = 1.275

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(320161016).content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 51 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_9) / 51)

				if (51 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_9) / 51)) > 0 and var_72_8 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_7
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_8, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_7) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_12 and arg_69_1.time_ < var_72_7 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play320161017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320161017
		arg_73_1.duration_ = 8.73

		local var_73_0 = {
			zh = 8.733,
			ja = 5.666
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play320161018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1056ui_story = arg_73_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1056ui_story"].transform.position).z)
				arg_73_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1056ui_story"].transform.localEulerAngles = arg_73_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_73_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1056ui_story"].transform.position).z)
				arg_73_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1056ui_story"].transform.localEulerAngles = arg_73_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1056ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1056ui_story == nil then
				arg_73_1.var_.characterEffect1056ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1056ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1056ui_story then
				arg_73_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_76_4 = 0
			local var_76_5 = 0.875

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(320161017)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 35 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 35)

				if (35 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 35)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161017", "story_v_out_320161.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161017", "story_v_out_320161.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_320161", "320161017", "story_v_out_320161.awb")

						arg_73_1:RecordAudio("320161017", var_76_11)
						arg_73_1:RecordAudio("320161017", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320161", "320161017", "story_v_out_320161.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320161", "320161017", "story_v_out_320161.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320161018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320161018
		arg_77_1.duration_ = 3.4

		local var_77_0 = {
			zh = 2.3,
			ja = 3.4
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
				arg_77_0:Play320161019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1089ui_story"]) and arg_77_1.var_.characterEffect1089ui_story == nil then
				arg_77_1.var_.characterEffect1089ui_story = arg_77_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1089ui_story"]) then
				if arg_77_1.var_.characterEffect1089ui_story and not isNil(arg_77_1.actors_["1089ui_story"]) then
					arg_77_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1089ui_story"]) and arg_77_1.var_.characterEffect1089ui_story then
				arg_77_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_2 = arg_77_1.actors_["1056ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1056ui_story == nil then
				arg_77_1.var_.characterEffect1056ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect1056ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1056ui_story then
				arg_77_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_80_4 = arg_77_1.actors_["1089ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1089ui_story = var_80_4.localPosition
			end

			local var_80_5 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 then
				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_77_1.time_ - 0) / var_80_5)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			local var_80_6 = arg_77_1.actors_["1056ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1056ui_story = var_80_6.localPosition
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_6.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_77_1.time_ - 0) / var_80_7)
				var_80_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_6.position).x, (manager.ui.mainCamera.transform.position - var_80_6.position).y, (manager.ui.mainCamera.transform.position - var_80_6.position).z)
				var_80_6.localEulerAngles.z = 0
				var_80_6.localEulerAngles.x = 0
				var_80_6.localEulerAngles = var_80_6.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_6.localPosition = Vector3.New(0.7, -1, -5.75)
				var_80_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_6.position).x, (manager.ui.mainCamera.transform.position - var_80_6.position).y, (manager.ui.mainCamera.transform.position - var_80_6.position).z)
				var_80_6.localEulerAngles.z = 0
				var_80_6.localEulerAngles.x = 0
				var_80_6.localEulerAngles = var_80_6.localEulerAngles
			end

			local var_80_8 = 0
			local var_80_9 = 0.25

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(320161018)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 10 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 10)

				if (10 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 10)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161018", "story_v_out_320161.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_320161", "320161018", "story_v_out_320161.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_320161", "320161018", "story_v_out_320161.awb")

						arg_77_1:RecordAudio("320161018", var_80_15)
						arg_77_1:RecordAudio("320161018", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320161", "320161018", "story_v_out_320161.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320161", "320161018", "story_v_out_320161.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320161019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320161019
		arg_81_1.duration_ = 12.9

		local var_81_0 = {
			zh = 9.5,
			ja = 12.9
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
				arg_81_0:Play320161020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1056ui_story"]) and arg_81_1.var_.characterEffect1056ui_story == nil then
				arg_81_1.var_.characterEffect1056ui_story = arg_81_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1056ui_story"]) then
				if arg_81_1.var_.characterEffect1056ui_story and not isNil(arg_81_1.actors_["1056ui_story"]) then
					arg_81_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1056ui_story"]) and arg_81_1.var_.characterEffect1056ui_story then
				arg_81_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_84_2 = arg_81_1.actors_["1089ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1089ui_story == nil then
				arg_81_1.var_.characterEffect1089ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1089ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1089ui_story then
				arg_81_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 1.125

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(320161019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 45 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 45)

				if (45 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 45)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161019", "story_v_out_320161.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161019", "story_v_out_320161.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_320161", "320161019", "story_v_out_320161.awb")

						arg_81_1:RecordAudio("320161019", var_84_11)
						arg_81_1:RecordAudio("320161019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_320161", "320161019", "story_v_out_320161.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_320161", "320161019", "story_v_out_320161.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320161020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320161020
		arg_85_1.duration_ = 10.53

		local var_85_0 = {
			zh = 7.566,
			ja = 10.533
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
				arg_85_0:Play320161021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1056ui_story"]) and arg_85_1.var_.characterEffect1056ui_story == nil then
				arg_85_1.var_.characterEffect1056ui_story = arg_85_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1056ui_story"]) then
				if arg_85_1.var_.characterEffect1056ui_story and not isNil(arg_85_1.actors_["1056ui_story"]) then
					arg_85_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1056ui_story"]) and arg_85_1.var_.characterEffect1056ui_story then
				arg_85_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_88_1 = arg_85_1.actors_["1089ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1089ui_story == nil then
				arg_85_1.var_.characterEffect1089ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1089ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1089ui_story then
				arg_85_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.9

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(320161020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 36 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 36)

				if (36 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 36)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161020", "story_v_out_320161.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161020", "story_v_out_320161.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_320161", "320161020", "story_v_out_320161.awb")

						arg_85_1:RecordAudio("320161020", var_88_11)
						arg_85_1:RecordAudio("320161020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320161", "320161020", "story_v_out_320161.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320161", "320161020", "story_v_out_320161.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play320161021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320161021
		arg_89_1.duration_ = 5.87

		local var_89_0 = {
			zh = 4.833,
			ja = 5.866
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
				arg_89_0:Play320161022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_0 = 0
			local var_92_1 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(320161021)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 19 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 19)

				if (19 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 19)) > 0 and var_92_1 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161021", "story_v_out_320161.awb") ~= 0 then
					local var_92_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161021", "story_v_out_320161.awb") / 1000

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end

					if var_92_2.prefab_name ~= "" and arg_89_1.actors_[var_92_2.prefab_name] ~= nil then
						local var_92_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_2.prefab_name].transform, "story_v_out_320161", "320161021", "story_v_out_320161.awb")

						arg_89_1:RecordAudio("320161021", var_92_7)
						arg_89_1:RecordAudio("320161021", var_92_7)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_320161", "320161021", "story_v_out_320161.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_320161", "320161021", "story_v_out_320161.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play320161022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320161022
		arg_93_1.duration_ = 2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play320161023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1056ui_story"]) and arg_93_1.var_.characterEffect1056ui_story == nil then
				arg_93_1.var_.characterEffect1056ui_story = arg_93_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1056ui_story"]) then
				if arg_93_1.var_.characterEffect1056ui_story and not isNil(arg_93_1.actors_["1056ui_story"]) then
					arg_93_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1056ui_story"]) and arg_93_1.var_.characterEffect1056ui_story then
				arg_93_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_96_2 = arg_93_1.actors_["1089ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1089ui_story == nil then
				arg_93_1.var_.characterEffect1089ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect1089ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1089ui_story then
				arg_93_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_96_4 = 0
			local var_96_5 = 0.125

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(320161022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 5 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 5)

				if (5 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 5)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161022", "story_v_out_320161.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161022", "story_v_out_320161.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_320161", "320161022", "story_v_out_320161.awb")

						arg_93_1:RecordAudio("320161022", var_96_11)
						arg_93_1:RecordAudio("320161022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320161", "320161022", "story_v_out_320161.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320161", "320161022", "story_v_out_320161.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play320161023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320161023
		arg_97_1.duration_ = 13.97

		local var_97_0 = {
			zh = 13.966,
			ja = 13.666
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320161024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1089ui_story"]) and arg_97_1.var_.characterEffect1089ui_story == nil then
				arg_97_1.var_.characterEffect1089ui_story = arg_97_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1089ui_story"]) then
				if arg_97_1.var_.characterEffect1089ui_story and not isNil(arg_97_1.actors_["1089ui_story"]) then
					arg_97_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1089ui_story"]) and arg_97_1.var_.characterEffect1089ui_story then
				arg_97_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_100_2 = arg_97_1.actors_["1056ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1056ui_story == nil then
				arg_97_1.var_.characterEffect1056ui_story = var_100_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.characterEffect1056ui_story and not isNil(var_100_2) then
					arg_97_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_3)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1056ui_story then
				arg_97_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_100_4 = 0
			local var_100_5 = 0.95

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(320161023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 38 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 38)

				if (38 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 38)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161023", "story_v_out_320161.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161023", "story_v_out_320161.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_320161", "320161023", "story_v_out_320161.awb")

						arg_97_1:RecordAudio("320161023", var_100_11)
						arg_97_1:RecordAudio("320161023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320161", "320161023", "story_v_out_320161.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320161", "320161023", "story_v_out_320161.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320161024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320161024
		arg_101_1.duration_ = 6.8

		local var_101_0 = {
			zh = 3.9,
			ja = 6.8
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
				arg_101_0:Play320161025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1056ui_story"]) and arg_101_1.var_.characterEffect1056ui_story == nil then
				arg_101_1.var_.characterEffect1056ui_story = arg_101_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1056ui_story"]) then
				if arg_101_1.var_.characterEffect1056ui_story and not isNil(arg_101_1.actors_["1056ui_story"]) then
					arg_101_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1056ui_story"]) and arg_101_1.var_.characterEffect1056ui_story then
				arg_101_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_104_2 = arg_101_1.actors_["1089ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1089ui_story == nil then
				arg_101_1.var_.characterEffect1089ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect1089ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1089ui_story then
				arg_101_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_104_4 = 0
			local var_104_5 = 0.5

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(320161024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 20 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 20)

				if (20 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 20)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161024", "story_v_out_320161.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161024", "story_v_out_320161.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_320161", "320161024", "story_v_out_320161.awb")

						arg_101_1:RecordAudio("320161024", var_104_11)
						arg_101_1:RecordAudio("320161024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320161", "320161024", "story_v_out_320161.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320161", "320161024", "story_v_out_320161.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320161025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320161025
		arg_105_1.duration_ = 11.33

		local var_105_0 = {
			zh = 11.333,
			ja = 7.9
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320161026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(320161025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 59 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 59)

				if (59 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 59)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161025", "story_v_out_320161.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161025", "story_v_out_320161.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_320161", "320161025", "story_v_out_320161.awb")

						arg_105_1:RecordAudio("320161025", var_108_6)
						arg_105_1:RecordAudio("320161025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320161", "320161025", "story_v_out_320161.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320161", "320161025", "story_v_out_320161.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320161026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320161026
		arg_109_1.duration_ = 7.87

		local var_109_0 = {
			zh = 4.066,
			ja = 7.866
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
				arg_109_0:Play320161027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action4_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_112_0 = 0
			local var_112_1 = 0.55

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(320161026)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 22 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 22)

				if (22 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 22)) > 0 and var_112_1 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161026", "story_v_out_320161.awb") ~= 0 then
					local var_112_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161026", "story_v_out_320161.awb") / 1000

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end

					if var_112_2.prefab_name ~= "" and arg_109_1.actors_[var_112_2.prefab_name] ~= nil then
						local var_112_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_2.prefab_name].transform, "story_v_out_320161", "320161026", "story_v_out_320161.awb")

						arg_109_1:RecordAudio("320161026", var_112_7)
						arg_109_1:RecordAudio("320161026", var_112_7)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320161", "320161026", "story_v_out_320161.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320161", "320161026", "story_v_out_320161.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320161027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320161027
		arg_113_1.duration_ = 2.7

		local var_113_0 = {
			zh = 2.7,
			ja = 2.633
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
				arg_113_0:Play320161028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1089ui_story"]) and arg_113_1.var_.characterEffect1089ui_story == nil then
				arg_113_1.var_.characterEffect1089ui_story = arg_113_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1089ui_story"]) then
				if arg_113_1.var_.characterEffect1089ui_story and not isNil(arg_113_1.actors_["1089ui_story"]) then
					arg_113_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1089ui_story"]) and arg_113_1.var_.characterEffect1089ui_story then
				arg_113_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_2 = arg_113_1.actors_["1056ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1056ui_story == nil then
				arg_113_1.var_.characterEffect1056ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect1056ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1056ui_story then
				arg_113_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_116_4 = 0
			local var_116_5 = 0.275

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(320161027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 11 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 11)

				if (11 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 11)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161027", "story_v_out_320161.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161027", "story_v_out_320161.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_320161", "320161027", "story_v_out_320161.awb")

						arg_113_1:RecordAudio("320161027", var_116_11)
						arg_113_1:RecordAudio("320161027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320161", "320161027", "story_v_out_320161.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320161", "320161027", "story_v_out_320161.awb")
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
	Play320161028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320161028
		arg_117_1.duration_ = 6.27

		local var_117_0 = {
			zh = 3.066,
			ja = 6.266
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
				arg_117_0:Play320161029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1056ui_story"]) and arg_117_1.var_.characterEffect1056ui_story == nil then
				arg_117_1.var_.characterEffect1056ui_story = arg_117_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1056ui_story"]) then
				if arg_117_1.var_.characterEffect1056ui_story and not isNil(arg_117_1.actors_["1056ui_story"]) then
					arg_117_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1056ui_story"]) and arg_117_1.var_.characterEffect1056ui_story then
				arg_117_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action4_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_2 = arg_117_1.actors_["1089ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1089ui_story == nil then
				arg_117_1.var_.characterEffect1089ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1089ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1089ui_story then
				arg_117_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_120_4 = 0
			local var_120_5 = 0.45

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(320161028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 18 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 18)

				if (18 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 18)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161028", "story_v_out_320161.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161028", "story_v_out_320161.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_320161", "320161028", "story_v_out_320161.awb")

						arg_117_1:RecordAudio("320161028", var_120_11)
						arg_117_1:RecordAudio("320161028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_320161", "320161028", "story_v_out_320161.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_320161", "320161028", "story_v_out_320161.awb")
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
	Play320161029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320161029
		arg_121_1.duration_ = 3.97

		local var_121_0 = {
			zh = 3.966,
			ja = 3.766
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
				arg_121_0:Play320161030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1089ui_story"]) and arg_121_1.var_.characterEffect1089ui_story == nil then
				arg_121_1.var_.characterEffect1089ui_story = arg_121_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1089ui_story"]) then
				if arg_121_1.var_.characterEffect1089ui_story and not isNil(arg_121_1.actors_["1089ui_story"]) then
					arg_121_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1089ui_story"]) and arg_121_1.var_.characterEffect1089ui_story then
				arg_121_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_124_2 = arg_121_1.actors_["1056ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1056ui_story == nil then
				arg_121_1.var_.characterEffect1056ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1056ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1056ui_story then
				arg_121_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.425

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(320161029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 17 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 17)

				if (17 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 17)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161029", "story_v_out_320161.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161029", "story_v_out_320161.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_320161", "320161029", "story_v_out_320161.awb")

						arg_121_1:RecordAudio("320161029", var_124_11)
						arg_121_1:RecordAudio("320161029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_320161", "320161029", "story_v_out_320161.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_320161", "320161029", "story_v_out_320161.awb")
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
	Play320161030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320161030
		arg_125_1.duration_ = 14.1

		local var_125_0 = {
			zh = 12.033,
			ja = 14.1
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
				arg_125_0:Play320161031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action473")
			end

			local var_128_0 = 0
			local var_128_1 = 1.525

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(320161030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 61 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 61)

				if (61 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 61)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161030", "story_v_out_320161.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161030", "story_v_out_320161.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_out_320161", "320161030", "story_v_out_320161.awb")

						arg_125_1:RecordAudio("320161030", var_128_7)
						arg_125_1:RecordAudio("320161030", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320161", "320161030", "story_v_out_320161.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320161", "320161030", "story_v_out_320161.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320161031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320161031
		arg_129_1.duration_ = 6.7

		local var_129_0 = {
			zh = 6.166,
			ja = 6.7
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
				arg_129_0:Play320161032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.75

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(320161031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 30 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 30)

				if (30 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 30)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161031", "story_v_out_320161.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161031", "story_v_out_320161.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_320161", "320161031", "story_v_out_320161.awb")

						arg_129_1:RecordAudio("320161031", var_132_6)
						arg_129_1:RecordAudio("320161031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320161", "320161031", "story_v_out_320161.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320161", "320161031", "story_v_out_320161.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play320161032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320161032
		arg_133_1.duration_ = 13.7

		local var_133_0 = {
			zh = 13.7,
			ja = 12.766
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
				arg_133_0:Play320161033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(320161032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 59 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 59)

				if (59 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 59)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161032", "story_v_out_320161.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161032", "story_v_out_320161.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_320161", "320161032", "story_v_out_320161.awb")

						arg_133_1:RecordAudio("320161032", var_136_6)
						arg_133_1:RecordAudio("320161032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320161", "320161032", "story_v_out_320161.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320161", "320161032", "story_v_out_320161.awb")
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
	Play320161033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320161033
		arg_137_1.duration_ = 12.73

		local var_137_0 = {
			zh = 11.9,
			ja = 12.733
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
				arg_137_0:Play320161034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_140_0 = 0
			local var_140_1 = 1.25

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(320161033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 50 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 50)

				if (50 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 50)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161033", "story_v_out_320161.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161033", "story_v_out_320161.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_out_320161", "320161033", "story_v_out_320161.awb")

						arg_137_1:RecordAudio("320161033", var_140_7)
						arg_137_1:RecordAudio("320161033", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320161", "320161033", "story_v_out_320161.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320161", "320161033", "story_v_out_320161.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320161034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320161034
		arg_141_1.duration_ = 6

		local var_141_0 = {
			zh = 4.666,
			ja = 6
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
				arg_141_0:Play320161035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1056ui_story"]) and arg_141_1.var_.characterEffect1056ui_story == nil then
				arg_141_1.var_.characterEffect1056ui_story = arg_141_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1056ui_story"]) then
				if arg_141_1.var_.characterEffect1056ui_story and not isNil(arg_141_1.actors_["1056ui_story"]) then
					arg_141_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1056ui_story"]) and arg_141_1.var_.characterEffect1056ui_story then
				arg_141_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_144_2 = arg_141_1.actors_["1089ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1089ui_story == nil then
				arg_141_1.var_.characterEffect1089ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect1089ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1089ui_story then
				arg_141_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_144_4 = 0
			local var_144_5 = 0.425

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(320161034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 17 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 17)

				if (17 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 17)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161034", "story_v_out_320161.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161034", "story_v_out_320161.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_320161", "320161034", "story_v_out_320161.awb")

						arg_141_1:RecordAudio("320161034", var_144_11)
						arg_141_1:RecordAudio("320161034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320161", "320161034", "story_v_out_320161.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320161", "320161034", "story_v_out_320161.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320161035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320161035
		arg_145_1.duration_ = 10.13

		local var_145_0 = {
			zh = 10.133,
			ja = 9.733
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
				arg_145_0:Play320161036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1089ui_story"]) and arg_145_1.var_.characterEffect1089ui_story == nil then
				arg_145_1.var_.characterEffect1089ui_story = arg_145_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1089ui_story"]) then
				if arg_145_1.var_.characterEffect1089ui_story and not isNil(arg_145_1.actors_["1089ui_story"]) then
					arg_145_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1089ui_story"]) and arg_145_1.var_.characterEffect1089ui_story then
				arg_145_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_2 = arg_145_1.actors_["1056ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1056ui_story == nil then
				arg_145_1.var_.characterEffect1056ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect1056ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1056ui_story then
				arg_145_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_148_4 = 0
			local var_148_5 = 1.075

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(320161035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 43 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 43)

				if (43 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 43)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161035", "story_v_out_320161.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161035", "story_v_out_320161.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_320161", "320161035", "story_v_out_320161.awb")

						arg_145_1:RecordAudio("320161035", var_148_11)
						arg_145_1:RecordAudio("320161035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320161", "320161035", "story_v_out_320161.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320161", "320161035", "story_v_out_320161.awb")
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
	Play320161036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320161036
		arg_149_1.duration_ = 3.8

		local var_149_0 = {
			zh = 3.8,
			ja = 2.6
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
				arg_149_0:Play320161037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1056ui_story"]) and arg_149_1.var_.characterEffect1056ui_story == nil then
				arg_149_1.var_.characterEffect1056ui_story = arg_149_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1056ui_story"]) then
				if arg_149_1.var_.characterEffect1056ui_story and not isNil(arg_149_1.actors_["1056ui_story"]) then
					arg_149_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1056ui_story"]) and arg_149_1.var_.characterEffect1056ui_story then
				arg_149_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_152_2 = arg_149_1.actors_["1089ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1089ui_story == nil then
				arg_149_1.var_.characterEffect1089ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1089ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1089ui_story then
				arg_149_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.5

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(320161036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 20 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 20)

				if (20 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 20)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161036", "story_v_out_320161.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161036", "story_v_out_320161.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_320161", "320161036", "story_v_out_320161.awb")

						arg_149_1:RecordAudio("320161036", var_152_11)
						arg_149_1:RecordAudio("320161036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320161", "320161036", "story_v_out_320161.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320161", "320161036", "story_v_out_320161.awb")
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
	Play320161037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320161037
		arg_153_1.duration_ = 4.9

		local var_153_0 = {
			zh = 4.9,
			ja = 2.9
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
				arg_153_0:Play320161038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1089ui_story"]) and arg_153_1.var_.characterEffect1089ui_story == nil then
				arg_153_1.var_.characterEffect1089ui_story = arg_153_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1089ui_story"]) then
				if arg_153_1.var_.characterEffect1089ui_story and not isNil(arg_153_1.actors_["1089ui_story"]) then
					arg_153_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1089ui_story"]) and arg_153_1.var_.characterEffect1089ui_story then
				arg_153_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["1056ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1056ui_story == nil then
				arg_153_1.var_.characterEffect1056ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1056ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1056ui_story then
				arg_153_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 0.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(320161037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 19 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 19)

				if (19 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 19)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161037", "story_v_out_320161.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161037", "story_v_out_320161.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_320161", "320161037", "story_v_out_320161.awb")

						arg_153_1:RecordAudio("320161037", var_156_11)
						arg_153_1:RecordAudio("320161037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320161", "320161037", "story_v_out_320161.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320161", "320161037", "story_v_out_320161.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play320161038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320161038
		arg_157_1.duration_ = 9.83

		local var_157_0 = {
			zh = 6.166,
			ja = 9.833
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
				arg_157_0:Play320161039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_0 = 0
			local var_160_1 = 0.65

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(320161038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 26 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 26)

				if (26 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 26)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161038", "story_v_out_320161.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161038", "story_v_out_320161.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_out_320161", "320161038", "story_v_out_320161.awb")

						arg_157_1:RecordAudio("320161038", var_160_7)
						arg_157_1:RecordAudio("320161038", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_320161", "320161038", "story_v_out_320161.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_320161", "320161038", "story_v_out_320161.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320161039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320161039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play320161040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1089ui_story = arg_161_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1089ui_story"].transform.position).z)
				arg_161_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1089ui_story"].transform.localEulerAngles = arg_161_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1089ui_story"].transform.position).z)
				arg_161_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1089ui_story"].transform.localEulerAngles = arg_161_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1089ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1089ui_story == nil then
				arg_161_1.var_.characterEffect1089ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1089ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1089ui_story then
				arg_161_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_164_3 = arg_161_1.actors_["1056ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1056ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(0, 100, 0)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["1056ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1056ui_story == nil then
				arg_161_1.var_.characterEffect1056ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect1056ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_6)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1056ui_story then
				arg_161_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_164_7 = 0
			local var_164_8 = 1.35

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_7 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(320161039).content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 54 <= 0 and var_164_8 or var_164_8 * (utf8.len(var_164_9) / 54)

				if (54 <= 0 and var_164_8 or var_164_8 * (utf8.len(var_164_9) / 54)) > 0 and var_164_8 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_7 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_7
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_8, arg_161_1.talkMaxDuration)

			if var_164_7 <= arg_161_1.time_ and arg_161_1.time_ < var_164_7 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_7) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_7 + var_164_12 and arg_161_1.time_ < var_164_7 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play320161040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320161040
		arg_165_1.duration_ = 15.77

		local var_165_0 = {
			zh = 15.066,
			ja = 15.766
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play320161041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1056ui_story = arg_165_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1056ui_story"].transform.position).z)
				arg_165_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1056ui_story"].transform.localEulerAngles = arg_165_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_165_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1056ui_story"].transform.position).z)
				arg_165_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1056ui_story"].transform.localEulerAngles = arg_165_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1056ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1056ui_story == nil then
				arg_165_1.var_.characterEffect1056ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1056ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1056ui_story then
				arg_165_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_168_4 = 0
			local var_168_5 = 1.625

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(320161040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 65 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 65)

				if (65 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 65)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161040", "story_v_out_320161.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161040", "story_v_out_320161.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_320161", "320161040", "story_v_out_320161.awb")

						arg_165_1:RecordAudio("320161040", var_168_11)
						arg_165_1:RecordAudio("320161040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320161", "320161040", "story_v_out_320161.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320161", "320161040", "story_v_out_320161.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play320161041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320161041
		arg_169_1.duration_ = 9.87

		local var_169_0 = {
			zh = 8.133,
			ja = 9.866
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
				arg_169_0:Play320161042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(320161041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 40 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 40)

				if (40 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 40)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161041", "story_v_out_320161.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161041", "story_v_out_320161.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_320161", "320161041", "story_v_out_320161.awb")

						arg_169_1:RecordAudio("320161041", var_172_6)
						arg_169_1:RecordAudio("320161041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320161", "320161041", "story_v_out_320161.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320161", "320161041", "story_v_out_320161.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320161042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320161042
		arg_173_1.duration_ = 12

		local var_173_0 = {
			zh = 12,
			ja = 8.133
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
				arg_173_0:Play320161043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1056ui_story"]) and arg_173_1.var_.characterEffect1056ui_story == nil then
				arg_173_1.var_.characterEffect1056ui_story = arg_173_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1056ui_story"]) then
				if arg_173_1.var_.characterEffect1056ui_story and not isNil(arg_173_1.actors_["1056ui_story"]) then
					arg_173_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1056ui_story"]) and arg_173_1.var_.characterEffect1056ui_story then
				arg_173_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action6_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_176_2 = 0
			local var_176_3 = 1.625

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_4 = arg_173_1:GetWordFromCfg(320161042)
				local var_176_5 = arg_173_1:FormatText(var_176_4.content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 65 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 65)

				if (65 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 65)) > 0 and var_176_3 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161042", "story_v_out_320161.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_320161", "320161042", "story_v_out_320161.awb") / 1000

					if var_176_8 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_2
					end

					if var_176_4.prefab_name ~= "" and arg_173_1.actors_[var_176_4.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_4.prefab_name].transform, "story_v_out_320161", "320161042", "story_v_out_320161.awb")

						arg_173_1:RecordAudio("320161042", var_176_9)
						arg_173_1:RecordAudio("320161042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_320161", "320161042", "story_v_out_320161.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_320161", "320161042", "story_v_out_320161.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_10 and arg_173_1.time_ < var_176_2 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320161043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320161043
		arg_177_1.duration_ = 14.6

		local var_177_0 = {
			zh = 10.6,
			ja = 14.6
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
				arg_177_0:Play320161044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1089ui_story"]) and arg_177_1.var_.characterEffect1089ui_story == nil then
				arg_177_1.var_.characterEffect1089ui_story = arg_177_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1089ui_story"]) then
				if arg_177_1.var_.characterEffect1089ui_story and not isNil(arg_177_1.actors_["1089ui_story"]) then
					arg_177_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1089ui_story"]) and arg_177_1.var_.characterEffect1089ui_story then
				arg_177_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_2 = arg_177_1.actors_["1056ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1056ui_story == nil then
				arg_177_1.var_.characterEffect1056ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect1056ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1056ui_story then
				arg_177_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_180_4 = arg_177_1.actors_["1089ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1089ui_story = var_180_4.localPosition
			end

			local var_180_5 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 then
				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_177_1.time_ - 0) / var_180_5)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 then
				var_180_4.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			local var_180_6 = arg_177_1.actors_["1056ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1056ui_story = var_180_6.localPosition
			end

			local var_180_7 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				var_180_6.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_177_1.time_ - 0) / var_180_7)
				var_180_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_6.position).x, (manager.ui.mainCamera.transform.position - var_180_6.position).y, (manager.ui.mainCamera.transform.position - var_180_6.position).z)
				var_180_6.localEulerAngles.z = 0
				var_180_6.localEulerAngles.x = 0
				var_180_6.localEulerAngles = var_180_6.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				var_180_6.localPosition = Vector3.New(0.7, -1, -5.75)
				var_180_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_6.position).x, (manager.ui.mainCamera.transform.position - var_180_6.position).y, (manager.ui.mainCamera.transform.position - var_180_6.position).z)
				var_180_6.localEulerAngles.z = 0
				var_180_6.localEulerAngles.x = 0
				var_180_6.localEulerAngles = var_180_6.localEulerAngles
			end

			local var_180_8 = 0
			local var_180_9 = 1.2

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(320161043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 48 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 48)

				if (48 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 48)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161043", "story_v_out_320161.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_320161", "320161043", "story_v_out_320161.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_320161", "320161043", "story_v_out_320161.awb")

						arg_177_1:RecordAudio("320161043", var_180_15)
						arg_177_1:RecordAudio("320161043", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320161", "320161043", "story_v_out_320161.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320161", "320161043", "story_v_out_320161.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play320161044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320161044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play320161045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1089ui_story = arg_181_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1089ui_story"].transform.position).z)
				arg_181_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1089ui_story"].transform.localEulerAngles = arg_181_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1089ui_story"].transform.position).z)
				arg_181_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1089ui_story"].transform.localEulerAngles = arg_181_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1089ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1089ui_story == nil then
				arg_181_1.var_.characterEffect1089ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1089ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1089ui_story then
				arg_181_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_184_3 = arg_181_1.actors_["1056ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1056ui_story = var_184_3.localPosition
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_3.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_4)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_3.localPosition = Vector3.New(0, 100, 0)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			local var_184_5 = arg_181_1.actors_["1056ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1056ui_story == nil then
				arg_181_1.var_.characterEffect1056ui_story = var_184_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.characterEffect1056ui_story and not isNil(var_184_5) then
					arg_181_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_6)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1056ui_story then
				arg_181_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_184_7 = 0
			local var_184_8 = 0.65

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_7 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_9 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(320161044).content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 26 <= 0 and var_184_8 or var_184_8 * (utf8.len(var_184_9) / 26)

				if (26 <= 0 and var_184_8 or var_184_8 * (utf8.len(var_184_9) / 26)) > 0 and var_184_8 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_7 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_7
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_8, arg_181_1.talkMaxDuration)

			if var_184_7 <= arg_181_1.time_ and arg_181_1.time_ < var_184_7 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_7) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_7 + var_184_12 and arg_181_1.time_ < var_184_7 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play320161045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320161045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play320161046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_188_0 = arg_185_1.actors_["1089ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1089ui_story = var_188_0.localPosition
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_185_1.time_ - 0) / var_188_1)
				var_188_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_0.position).x, (manager.ui.mainCamera.transform.position - var_188_0.position).y, (manager.ui.mainCamera.transform.position - var_188_0.position).z)
				var_188_0.localEulerAngles.z = 0
				var_188_0.localEulerAngles.x = 0
				var_188_0.localEulerAngles = var_188_0.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				var_188_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_0.position).x, (manager.ui.mainCamera.transform.position - var_188_0.position).y, (manager.ui.mainCamera.transform.position - var_188_0.position).z)
				var_188_0.localEulerAngles.z = 0
				var_188_0.localEulerAngles.x = 0
				var_188_0.localEulerAngles = var_188_0.localEulerAngles
			end

			local var_188_2 = arg_185_1.actors_["1089ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1089ui_story == nil then
				arg_185_1.var_.characterEffect1089ui_story = var_188_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_3 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.characterEffect1089ui_story and not isNil(var_188_2) then
					arg_185_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1089ui_story then
				arg_185_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_188_5 = 0
			local var_188_6 = 0.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:GetWordFromCfg(320161045)
				local var_188_8 = arg_185_1:FormatText(var_188_7.content)

				arg_185_1.text_.text = var_188_8

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 20 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_8) / 20)

				if (20 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_8) / 20)) > 0 and var_188_6 < var_188_10 then
					arg_185_1.talkMaxDuration = var_188_10

					if var_188_10 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_8
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161045", "story_v_out_320161.awb") ~= 0 then
					local var_188_11 = manager.audio:GetVoiceLength("story_v_out_320161", "320161045", "story_v_out_320161.awb") / 1000

					if var_188_11 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_5
					end

					if var_188_7.prefab_name ~= "" and arg_185_1.actors_[var_188_7.prefab_name] ~= nil then
						local var_188_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_7.prefab_name].transform, "story_v_out_320161", "320161045", "story_v_out_320161.awb")

						arg_185_1:RecordAudio("320161045", var_188_12)
						arg_185_1:RecordAudio("320161045", var_188_12)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320161", "320161045", "story_v_out_320161.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320161", "320161045", "story_v_out_320161.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_13 and arg_185_1.time_ < var_188_5 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play320161046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320161046
		arg_189_1.duration_ = 2

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play320161047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1056ui_story"]) and arg_189_1.var_.characterEffect1056ui_story == nil then
				arg_189_1.var_.characterEffect1056ui_story = arg_189_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1056ui_story"]) then
				if arg_189_1.var_.characterEffect1056ui_story and not isNil(arg_189_1.actors_["1056ui_story"]) then
					arg_189_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1056ui_story"]) and arg_189_1.var_.characterEffect1056ui_story then
				arg_189_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action6_2")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_2 = arg_189_1.actors_["1089ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1089ui_story == nil then
				arg_189_1.var_.characterEffect1089ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect1089ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1089ui_story then
				arg_189_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_192_4 = arg_189_1.actors_["1056ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1056ui_story = var_192_4.localPosition
			end

			local var_192_5 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_5 then
				var_192_4.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_189_1.time_ - 0) / var_192_5)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_5 and arg_189_1.time_ < 0 + var_192_5 + arg_192_0 then
				var_192_4.localPosition = Vector3.New(0.7, -1, -5.75)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles
			end

			local var_192_6 = 0
			local var_192_7 = 0.1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(320161046)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 4 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 4)

				if (4 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 4)) > 0 and var_192_7 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161046", "story_v_out_320161.awb") ~= 0 then
					local var_192_12 = manager.audio:GetVoiceLength("story_v_out_320161", "320161046", "story_v_out_320161.awb") / 1000

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end

					if var_192_8.prefab_name ~= "" and arg_189_1.actors_[var_192_8.prefab_name] ~= nil then
						local var_192_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_8.prefab_name].transform, "story_v_out_320161", "320161046", "story_v_out_320161.awb")

						arg_189_1:RecordAudio("320161046", var_192_13)
						arg_189_1:RecordAudio("320161046", var_192_13)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320161", "320161046", "story_v_out_320161.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320161", "320161046", "story_v_out_320161.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320161047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320161047
		arg_193_1.duration_ = 14.9

		local var_193_0 = {
			zh = 12.8663333333333,
			ja = 14.8993333333333
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play320161048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1089ui_story"]) and arg_193_1.var_.characterEffect1089ui_story == nil then
				arg_193_1.var_.characterEffect1089ui_story = arg_193_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1089ui_story"]) then
				if arg_193_1.var_.characterEffect1089ui_story and not isNil(arg_193_1.actors_["1089ui_story"]) then
					arg_193_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1089ui_story"]) and arg_193_1.var_.characterEffect1089ui_story then
				arg_193_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_2")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_196_2 = arg_193_1.actors_["1056ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1056ui_story == nil then
				arg_193_1.var_.characterEffect1056ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect1056ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1056ui_story then
				arg_193_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_4 = 0.833333333333333
			local var_196_5 = 1.5

			if 0.833333333333333 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_6 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_6:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(320161047)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 60 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_8) / 60)

				if (60 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_8) / 60)) > 0 and var_196_5 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10
					var_196_4 = var_196_4 + 0.3

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161047", "story_v_out_320161.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_320161", "320161047", "story_v_out_320161.awb") / 1000

					if var_196_11 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_4
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_320161", "320161047", "story_v_out_320161.awb")

						arg_193_1:RecordAudio("320161047", var_196_12)
						arg_193_1:RecordAudio("320161047", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_320161", "320161047", "story_v_out_320161.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_320161", "320161047", "story_v_out_320161.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = var_196_4 + 0.3
			local var_196_14 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_13 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_13) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_13 + var_196_14 and arg_193_1.time_ < var_196_13 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play320161048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 320161048
		arg_199_1.duration_ = 10.7

		local var_199_0 = {
			zh = 10.7,
			ja = 7.833
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
				arg_199_0:Play320161049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.9

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(320161048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 36 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 36)

				if (36 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 36)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161048", "story_v_out_320161.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161048", "story_v_out_320161.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_320161", "320161048", "story_v_out_320161.awb")

						arg_199_1:RecordAudio("320161048", var_202_6)
						arg_199_1:RecordAudio("320161048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_320161", "320161048", "story_v_out_320161.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_320161", "320161048", "story_v_out_320161.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play320161049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 320161049
		arg_203_1.duration_ = 10.03

		local var_203_0 = {
			zh = 10.033,
			ja = 7.566
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
				arg_203_0:Play320161050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(320161049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 52 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 52)

				if (52 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 52)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161049", "story_v_out_320161.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161049", "story_v_out_320161.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_320161", "320161049", "story_v_out_320161.awb")

						arg_203_1:RecordAudio("320161049", var_206_6)
						arg_203_1:RecordAudio("320161049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_320161", "320161049", "story_v_out_320161.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_320161", "320161049", "story_v_out_320161.awb")
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
	Play320161050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 320161050
		arg_207_1.duration_ = 11.1

		local var_207_0 = {
			zh = 11.1,
			ja = 10.966
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
				arg_207_0:Play320161051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 1.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(320161050)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 59 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 59)

				if (59 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 59)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161050", "story_v_out_320161.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161050", "story_v_out_320161.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_320161", "320161050", "story_v_out_320161.awb")

						arg_207_1:RecordAudio("320161050", var_210_6)
						arg_207_1:RecordAudio("320161050", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_320161", "320161050", "story_v_out_320161.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_320161", "320161050", "story_v_out_320161.awb")
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
	Play320161051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 320161051
		arg_211_1.duration_ = 12.37

		local var_211_0 = {
			zh = 12.366,
			ja = 11.066
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
				arg_211_0:Play320161052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_0 = 0
			local var_214_1 = 1.45

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(320161051)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 58 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 58)

				if (58 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 58)) > 0 and var_214_1 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161051", "story_v_out_320161.awb") ~= 0 then
					local var_214_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161051", "story_v_out_320161.awb") / 1000

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end

					if var_214_2.prefab_name ~= "" and arg_211_1.actors_[var_214_2.prefab_name] ~= nil then
						local var_214_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_2.prefab_name].transform, "story_v_out_320161", "320161051", "story_v_out_320161.awb")

						arg_211_1:RecordAudio("320161051", var_214_7)
						arg_211_1:RecordAudio("320161051", var_214_7)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_320161", "320161051", "story_v_out_320161.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_320161", "320161051", "story_v_out_320161.awb")
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
	Play320161052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 320161052
		arg_215_1.duration_ = 12.4

		local var_215_0 = {
			zh = 11.5,
			ja = 12.4
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
				arg_215_0:Play320161053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_0 = 0
			local var_218_1 = 1.2

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(320161052)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 48 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 48)

				if (48 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 48)) > 0 and var_218_1 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161052", "story_v_out_320161.awb") ~= 0 then
					local var_218_6 = manager.audio:GetVoiceLength("story_v_out_320161", "320161052", "story_v_out_320161.awb") / 1000

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end

					if var_218_2.prefab_name ~= "" and arg_215_1.actors_[var_218_2.prefab_name] ~= nil then
						local var_218_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_2.prefab_name].transform, "story_v_out_320161", "320161052", "story_v_out_320161.awb")

						arg_215_1:RecordAudio("320161052", var_218_7)
						arg_215_1:RecordAudio("320161052", var_218_7)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_320161", "320161052", "story_v_out_320161.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_320161", "320161052", "story_v_out_320161.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play320161053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 320161053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play320161054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1089ui_story = arg_219_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1089ui_story"].transform.position).z)
				arg_219_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1089ui_story"].transform.localEulerAngles = arg_219_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1089ui_story"].transform.position).z)
				arg_219_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1089ui_story"].transform.localEulerAngles = arg_219_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1089ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1089ui_story == nil then
				arg_219_1.var_.characterEffect1089ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1089ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_2)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1089ui_story then
				arg_219_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_222_3 = arg_219_1.actors_["1056ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1056ui_story = var_222_3.localPosition
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_3.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_4)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_3.localPosition = Vector3.New(0, 100, 0)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			local var_222_5 = arg_219_1.actors_["1056ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1056ui_story == nil then
				arg_219_1.var_.characterEffect1056ui_story = var_222_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_6 = 0.0166666666666667

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 and not isNil(var_222_5) then
				if arg_219_1.var_.characterEffect1056ui_story and not isNil(var_222_5) then
					arg_219_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_6)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1056ui_story then
				arg_219_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_222_7 = 0
			local var_222_8 = 1

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(320161053).content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 40 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_9) / 40)

				if (40 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_9) / 40)) > 0 and var_222_8 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_7 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_7
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_8, arg_219_1.talkMaxDuration)

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_7) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_7 + var_222_12 and arg_219_1.time_ < var_222_7 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play320161054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 320161054
		arg_223_1.duration_ = 10.8

		local var_223_0 = {
			zh = 6.8,
			ja = 10.8
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
				arg_223_0:Play320161055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1089ui_story = arg_223_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1089ui_story"].transform.position).z)
				arg_223_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1089ui_story"].transform.localEulerAngles = arg_223_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_223_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1089ui_story"].transform.position).z)
				arg_223_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1089ui_story"].transform.localEulerAngles = arg_223_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1089ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1089ui_story == nil then
				arg_223_1.var_.characterEffect1089ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1089ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1089ui_story then
				arg_223_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action435")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.725

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(320161054)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 29 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 29)

				if (29 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 29)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161054", "story_v_out_320161.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_320161", "320161054", "story_v_out_320161.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_320161", "320161054", "story_v_out_320161.awb")

						arg_223_1:RecordAudio("320161054", var_226_11)
						arg_223_1:RecordAudio("320161054", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_320161", "320161054", "story_v_out_320161.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_320161", "320161054", "story_v_out_320161.awb")
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

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play320161055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 320161055
		arg_227_1.duration_ = 23.27

		local var_227_0 = {
			zh = 10.432999999999,
			ja = 23.265999999999
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play320161056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_9001
			local var_230_9000

			if arg_227_1.bgs_.L07k == nil then
				local var_230_0 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L07k")
				var_230_0.name = "L07k"
				var_230_0.transform.parent = arg_227_1.stage_.transform
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_.L07k = var_230_0
			end

			if 1.999999999999 < arg_227_1.time_ and arg_227_1.time_ <= 1.999999999999 + arg_230_0 then
				local var_230_1 = arg_227_1.bgs_.L07k

				arg_227_1.bgs_.L07k.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_2 = var_230_1:GetComponent("SpriteRenderer")

				if var_230_2 and var_230_2.sprite then
					local var_230_3 = 2 * (var_230_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_1.transform.localScale = Vector3.New(var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "L07k" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_4 = 3.999999999999

			if 3.999999999999 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.allBtn_.enabled = false
			end

			if arg_227_1.time_ >= var_230_4 + 0.3 and arg_227_1.time_ < var_230_4 + 0.3 + arg_230_0 then
				arg_227_1.allBtn_.enabled = true
			end

			local var_230_5 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_6 = 2

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_6 then
				local var_230_7 = Color.New(0, 0, 0)

				var_230_7.a = Mathf.Lerp(0, 1, (arg_227_1.time_ - var_230_5) / var_230_6)
				arg_227_1.mask_.color = var_230_7
			end

			if arg_227_1.time_ >= var_230_5 + var_230_6 and arg_227_1.time_ < var_230_5 + var_230_6 + arg_230_0 then
				local var_230_8 = Color.New(0, 0, 0)

				var_230_8.a = 1
				arg_227_1.mask_.color = var_230_8
			end

			local var_230_9 = 2

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_10 = 2

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_10 then
				local var_230_11 = Color.New(0, 0, 0)

				var_230_11.a = Mathf.Lerp(1, 0, (arg_227_1.time_ - var_230_9) / var_230_10)
				arg_227_1.mask_.color = var_230_11
			end

			if arg_227_1.time_ >= var_230_9 + var_230_10 and arg_227_1.time_ < var_230_9 + var_230_10 + arg_230_0 then
				local var_230_12 = Color.New(0, 0, 0)

				arg_227_1.mask_.enabled = false
				var_230_12.a = 0
				arg_227_1.mask_.color = var_230_12
			end

			local var_230_13 = arg_227_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_227_1.time_ and arg_227_1.time_ <= 1.96599999815226 + arg_230_0 then
				arg_227_1.var_.moveOldPos1089ui_story = var_230_13.localPosition
			end

			local var_230_14 = 0.001

			if 1.96599999815226 <= arg_227_1.time_ and arg_227_1.time_ < 1.96599999815226 + var_230_14 then
				var_230_13.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 1.96599999815226) / var_230_14)
				var_230_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_13.position).x, (manager.ui.mainCamera.transform.position - var_230_13.position).y, (manager.ui.mainCamera.transform.position - var_230_13.position).z)
				var_230_13.localEulerAngles.z = 0
				var_230_13.localEulerAngles.x = 0
				var_230_13.localEulerAngles = var_230_13.localEulerAngles
			end

			if arg_227_1.time_ >= 1.96599999815226 + var_230_14 and arg_227_1.time_ < 1.96599999815226 + var_230_14 + arg_230_0 then
				var_230_13.localPosition = Vector3.New(0, 100, 0)
				var_230_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_13.position).x, (manager.ui.mainCamera.transform.position - var_230_13.position).y, (manager.ui.mainCamera.transform.position - var_230_13.position).z)
				var_230_13.localEulerAngles.z = 0
				var_230_13.localEulerAngles.x = 0
				var_230_13.localEulerAngles = var_230_13.localEulerAngles
			end

			local var_230_15 = arg_227_1.actors_["1089ui_story"]

			if 1.96599999815226 < arg_227_1.time_ and arg_227_1.time_ <= 1.96599999815226 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.characterEffect1089ui_story == nil then
				arg_227_1.var_.characterEffect1089ui_story = var_230_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_16 = 0.034000001847744

			if 1.96599999815226 <= arg_227_1.time_ and arg_227_1.time_ < 1.96599999815226 + var_230_16 and not isNil(var_230_15) then
				if arg_227_1.var_.characterEffect1089ui_story and not isNil(var_230_15) then
					arg_227_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 1.96599999815226) / var_230_16)
				end
			end

			if arg_227_1.time_ >= 1.96599999815226 + var_230_16 and arg_227_1.time_ < 1.96599999815226 + var_230_16 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.characterEffect1089ui_story then
				arg_227_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 then
				local var_230_17 = arg_227_1.var_.effectxiayu15

				if not arg_227_1.var_.effectxiayu15 then
					var_230_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), manager.ui.mainCamera.transform)
					var_230_17.name = "xiayu15"
					arg_227_1.var_.effectxiayu15 = var_230_17
				else
					var_230_17.transform:SetParent(var_230_9001)
				end

				var_230_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_230_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_230_19 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_230_20 = var_230_17.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_230_2, iter_230_3 in ipairs((var_230_20:ToTable())) do
					iter_230_3.transform.localScale = Vector3.New(iter_230_3.transform.localScale.x / var_230_19 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_230_20 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_230_3.transform.localScale.y / var_230_19, iter_230_3.transform.localScale.z)
				end
			end

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 then
				local var_230_22 = arg_227_1.var_.effectxiayu16

				if not arg_227_1.var_.effectxiayu16 then
					var_230_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_light"), manager.ui.mainCamera.transform)
					var_230_22.name = "xiayu16"
					arg_227_1.var_.effectxiayu16 = var_230_22
				else
					var_230_22.transform:SetParent(var_230_9000)
				end

				var_230_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_230_22.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_230_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_227_1.bgmTxt_.text ~= var_230_26 and arg_227_1.bgmTxt_.text ~= "" then
						if arg_227_1.bgmTxt2_.text ~= "" then
							arg_227_1.bgmTxt_.text = arg_227_1.bgmTxt2_.text
						end

						arg_227_1.bgmTxt2_.text = var_230_26

						arg_227_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_227_1.bgmTxt_.text = var_230_26
						arg_227_1.bgmTxt2_.text = var_230_26
					end

					if arg_227_1.bgmTimer then
						arg_227_1.bgmTimer:Stop()

						arg_227_1.bgmTimer = nil
					end

					if arg_227_1.settingData.show_music_name == 1 then
						arg_227_1.musicController:SetSelectedState("show")
						arg_227_1.musicAnimator_:Play("open", 0, 0)

						if arg_227_1.settingData.music_time ~= 0 then
							arg_227_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_227_1.settingData.music_time), function()
								if arg_227_1 == nil or isNil(arg_227_1.bgmTxt_) then
									return
								end

								arg_227_1.musicController:SetSelectedState("hide")
								arg_227_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.3 < arg_227_1.time_ and arg_227_1.time_ <= 1.3 + arg_230_0 then
				arg_227_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_28 = 3.999999999999
			local var_230_29 = 0.65

			if 3.999999999999 < arg_227_1.time_ and arg_227_1.time_ <= var_230_28 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_30 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_30:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_227_1.dialogCg_.alpha = arg_232_0
				end))
				var_230_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_31 = arg_227_1:GetWordFromCfg(320161055)
				local var_230_32 = arg_227_1:FormatText(var_230_31.content)

				arg_227_1.text_.text = var_230_32

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_34 = 26 <= 0 and var_230_29 or var_230_29 * (utf8.len(var_230_32) / 26)

				if (26 <= 0 and var_230_29 or var_230_29 * (utf8.len(var_230_32) / 26)) > 0 and var_230_29 < var_230_34 then
					arg_227_1.talkMaxDuration = var_230_34
					var_230_28 = var_230_28 + 0.3

					if var_230_34 + var_230_28 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_34 + var_230_28
					end
				end

				arg_227_1.text_.text = var_230_32
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161055", "story_v_out_320161.awb") ~= 0 then
					local var_230_35 = manager.audio:GetVoiceLength("story_v_out_320161", "320161055", "story_v_out_320161.awb") / 1000

					if var_230_35 + var_230_28 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_35 + var_230_28
					end

					if var_230_31.prefab_name ~= "" and arg_227_1.actors_[var_230_31.prefab_name] ~= nil then
						local var_230_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_31.prefab_name].transform, "story_v_out_320161", "320161055", "story_v_out_320161.awb")

						arg_227_1:RecordAudio("320161055", var_230_36)
						arg_227_1:RecordAudio("320161055", var_230_36)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_320161", "320161055", "story_v_out_320161.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_320161", "320161055", "story_v_out_320161.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_37 = var_230_28 + 0.3
			local var_230_38 = math.max(var_230_29, arg_227_1.talkMaxDuration)

			if var_230_28 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_37 + var_230_38 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_37) / var_230_38

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_37 + var_230_38 and arg_227_1.time_ < var_230_37 + var_230_38 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play320161056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 320161056
		arg_234_1.duration_ = 1.23

		local var_234_0 = {
			zh = 1.233,
			ja = 1.133
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
				arg_234_0:Play320161057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.075

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:GetWordFromCfg(320161056)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 3 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 3)

				if (3 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 3)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161056", "story_v_out_320161.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161056", "story_v_out_320161.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_out_320161", "320161056", "story_v_out_320161.awb")

						arg_234_1:RecordAudio("320161056", var_237_6)
						arg_234_1:RecordAudio("320161056", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_320161", "320161056", "story_v_out_320161.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_320161", "320161056", "story_v_out_320161.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play320161057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 320161057
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play320161058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 1.25

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(320161057).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 50 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 50)

				if (50 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 50)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play320161058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 320161058
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play320161059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.925

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(320161058).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 37 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 37)

				if (37 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 37)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play320161059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 320161059
		arg_246_1.duration_ = 4

		local var_246_0 = {
			zh = 2.266,
			ja = 4
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play320161060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.3

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_1 = arg_246_1:GetWordFromCfg(320161059)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 8 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 8)

				if (8 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 8)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161059", "story_v_out_320161.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161059", "story_v_out_320161.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_320161", "320161059", "story_v_out_320161.awb")

						arg_246_1:RecordAudio("320161059", var_249_6)
						arg_246_1:RecordAudio("320161059", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_320161", "320161059", "story_v_out_320161.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_320161", "320161059", "story_v_out_320161.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play320161060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 320161060
		arg_250_1.duration_ = 3.83

		local var_250_0 = {
			zh = 1.5,
			ja = 3.833
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play320161061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.25

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1040].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:GetWordFromCfg(320161060)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 10 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 10)

				if (10 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 10)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320161", "320161060", "story_v_out_320161.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_320161", "320161060", "story_v_out_320161.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_320161", "320161060", "story_v_out_320161.awb")

						arg_250_1:RecordAudio("320161060", var_253_6)
						arg_250_1:RecordAudio("320161060", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_320161", "320161060", "story_v_out_320161.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_320161", "320161060", "story_v_out_320161.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play320161061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 320161061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play320161062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.925

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(320161061).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 37 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 37)

				if (37 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 37)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play320161062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 320161062
		arg_258_1.duration_ = 50.96

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
			arg_258_1.auto_ = false
		end

		function arg_258_1.playNext_(arg_260_0)
			arg_258_1.onStoryFinished_()
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_0 = 1

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				local var_261_1 = Color.New(0, 0, 0)

				var_261_1.a = Mathf.Lerp(0, 1, (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.mask_.color = var_261_1
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				local var_261_2 = Color.New(0, 0, 0)

				var_261_2.a = 1
				arg_258_1.mask_.color = var_261_2
			end

			local var_261_3 = 1

			if 1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_3 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_4 = 0.1

			if var_261_3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_3 + var_261_4 then
				local var_261_5 = Color.New(0, 0, 0)

				var_261_5.a = Mathf.Lerp(1, 0, (arg_258_1.time_ - var_261_3) / var_261_4)
				arg_258_1.mask_.color = var_261_5
			end

			if arg_258_1.time_ >= var_261_3 + var_261_4 and arg_258_1.time_ < var_261_3 + var_261_4 + arg_261_0 then
				local var_261_6 = Color.New(0, 0, 0)

				arg_258_1.mask_.enabled = false
				var_261_6.a = 0
				arg_258_1.mask_.color = var_261_6
			end

			local var_261_7 = 1

			if 1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 then
				SetActive(arg_258_1.dialog_, false)
				SetActive(arg_258_1.allBtn_.gameObject, false)
				arg_258_1.hideBtnsController_:SetSelectedIndex(1)
				arg_258_1:StopAllVoice()

				arg_258_1.marker = "SXV02"

				manager.video:Play("SofdecAsset/story/story_1032016.usm", function(arg_262_0)
					arg_258_1:Skip(arg_262_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_263_0)
					arg_258_1.state_ = arg_263_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_261_8 = 49.9583333333333

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_8 then
				-- block empty
			end

			if arg_258_1.time_ >= var_261_7 + var_261_8 and arg_258_1.time_ < var_261_7 + var_261_8 + arg_261_0 then
				arg_258_1.marker = ""
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/L07k",
		"SofdecAsset/story/story_1032016.usm"
	},
	voices = {
		"story_v_out_320161.awb"
	},
	skipMarkers = {
		320161062
	}
}
