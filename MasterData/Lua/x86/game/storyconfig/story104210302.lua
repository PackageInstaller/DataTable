return {
	Play421032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421032001
		arg_1_1.duration_ = 6.47

		local var_1_0 = {
			zh = 4.165999999999,
			ja = 6.465999999999
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
				arg_1_0:Play421032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2401 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2401")
				var_4_0.name = "ST2401"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2401 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2401

				arg_1_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2401" then
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

			local var_4_8 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_8 + 0.133333333334333 and arg_1_1.time_ < var_4_8 + 0.133333333334333 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_9 = "10145ui_story"

			if arg_1_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10145ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10145ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10145ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10145ui_story == nil then
				arg_1_1.var_.characterEffect10145ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10145ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10145ui_story then
				arg_1_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
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

			if 0.566666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.566666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 1.999999999999
			local var_4_26 = 0.275

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(421032001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 11 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 11)

				if (11 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 11)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032001", "story_v_out_421032.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_421032", "421032001", "story_v_out_421032.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_421032", "421032001", "story_v_out_421032.awb")

						arg_1_1:RecordAudio("421032001", var_4_33)
						arg_1_1:RecordAudio("421032001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421032", "421032001", "story_v_out_421032.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421032", "421032001", "story_v_out_421032.awb")
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
				actorName = "10145ui_story",
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
	Play421032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421032002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1047ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1047ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1047ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1047ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1047ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1047ui_story = var_12_3.localPosition

				arg_9_1:ShowWeapon(arg_9_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.74, -1.13, -6.2)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1047ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1047ui_story == nil then
				arg_9_1.var_.characterEffect1047ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1047ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1047ui_story then
				arg_9_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_12_8 = arg_9_1.actors_["10145ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect10145ui_story == nil then
				arg_9_1.var_.characterEffect10145ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect10145ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect10145ui_story then
				arg_9_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_12_10 = 0
			local var_12_11 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(421032002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 8 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 8)

				if (8 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 8)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032002", "story_v_out_421032.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_421032", "421032002", "story_v_out_421032.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_421032", "421032002", "story_v_out_421032.awb")

						arg_9_1:RecordAudio("421032002", var_12_17)
						arg_9_1:RecordAudio("421032002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421032", "421032002", "story_v_out_421032.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421032", "421032002", "story_v_out_421032.awb")
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
				actorName = "1047ui_story",
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
	Play421032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421032003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play421032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1047ui_story"]) and arg_13_1.var_.characterEffect1047ui_story == nil then
				arg_13_1.var_.characterEffect1047ui_story = arg_13_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1047ui_story"]) then
				if arg_13_1.var_.characterEffect1047ui_story and not isNil(arg_13_1.actors_["1047ui_story"]) then
					arg_13_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1047ui_story"]) and arg_13_1.var_.characterEffect1047ui_story then
				arg_13_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.25

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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(421032003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 10 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 10)

				if (10 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 10)) > 0 and var_16_2 < var_16_5 then
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
	Play421032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421032004
		arg_17_1.duration_ = 6.8

		local var_17_0 = {
			zh = 6.433,
			ja = 6.8
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
				arg_17_0:Play421032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.bgs_.ST2105 == nil then
				local var_20_0 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2105")
				var_20_0.name = "ST2105"
				var_20_0.transform.parent = arg_17_1.stage_.transform
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_.ST2105 = var_20_0
			end

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= 2 + arg_20_0 then
				local var_20_1 = arg_17_1.bgs_.ST2105

				arg_17_1.bgs_.ST2105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_2 = var_20_1:GetComponent("SpriteRenderer")

				if var_20_2 and var_20_2.sprite then
					local var_20_3 = 2 * (var_20_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_1.transform.localScale = Vector3.New(var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "ST2105" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_4 = 4

			if 4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_4 + 0.0999999999999996 and arg_17_1.time_ < var_20_4 + 0.0999999999999996 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_5 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_6 = 2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 then
				local var_20_7 = Color.New(0, 0, 0)

				var_20_7.a = Mathf.Lerp(0, 1, (arg_17_1.time_ - var_20_5) / var_20_6)
				arg_17_1.mask_.color = var_20_7
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 then
				local var_20_8 = Color.New(0, 0, 0)

				var_20_8.a = 1
				arg_17_1.mask_.color = var_20_8
			end

			local var_20_9 = 2

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_10 = 2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 then
				local var_20_11 = Color.New(0, 0, 0)

				var_20_11.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_9) / var_20_10)
				arg_17_1.mask_.color = var_20_11
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 then
				local var_20_12 = Color.New(0, 0, 0)

				arg_17_1.mask_.enabled = false
				var_20_12.a = 0
				arg_17_1.mask_.color = var_20_12
			end

			local var_20_13 = arg_17_1.actors_["1047ui_story"].transform

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= 2 + arg_20_0 then
				arg_17_1.var_.moveOldPos1047ui_story = var_20_13.localPosition
			end

			local var_20_14 = 0.001

			if 2 <= arg_17_1.time_ and arg_17_1.time_ < 2 + var_20_14 then
				var_20_13.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 2) / var_20_14)
				var_20_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_13.position).x, (manager.ui.mainCamera.transform.position - var_20_13.position).y, (manager.ui.mainCamera.transform.position - var_20_13.position).z)
				var_20_13.localEulerAngles.z = 0
				var_20_13.localEulerAngles.x = 0
				var_20_13.localEulerAngles = var_20_13.localEulerAngles
			end

			if arg_17_1.time_ >= 2 + var_20_14 and arg_17_1.time_ < 2 + var_20_14 + arg_20_0 then
				var_20_13.localPosition = Vector3.New(0, 100, 0)
				var_20_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_13.position).x, (manager.ui.mainCamera.transform.position - var_20_13.position).y, (manager.ui.mainCamera.transform.position - var_20_13.position).z)
				var_20_13.localEulerAngles.z = 0
				var_20_13.localEulerAngles.x = 0
				var_20_13.localEulerAngles = var_20_13.localEulerAngles
			end

			local var_20_15 = arg_17_1.actors_["10145ui_story"].transform

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= 2 + arg_20_0 then
				arg_17_1.var_.moveOldPos10145ui_story = var_20_15.localPosition
			end

			local var_20_16 = 0.001

			if 2 <= arg_17_1.time_ and arg_17_1.time_ < 2 + var_20_16 then
				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 2) / var_20_16)
				var_20_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_15.position).x, (manager.ui.mainCamera.transform.position - var_20_15.position).y, (manager.ui.mainCamera.transform.position - var_20_15.position).z)
				var_20_15.localEulerAngles.z = 0
				var_20_15.localEulerAngles.x = 0
				var_20_15.localEulerAngles = var_20_15.localEulerAngles
			end

			if arg_17_1.time_ >= 2 + var_20_16 and arg_17_1.time_ < 2 + var_20_16 + arg_20_0 then
				var_20_15.localPosition = Vector3.New(0, 100, 0)
				var_20_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_15.position).x, (manager.ui.mainCamera.transform.position - var_20_15.position).y, (manager.ui.mainCamera.transform.position - var_20_15.position).z)
				var_20_15.localEulerAngles.z = 0
				var_20_15.localEulerAngles.x = 0
				var_20_15.localEulerAngles = var_20_15.localEulerAngles
			end

			local var_20_17 = "10102ui_story"

			if arg_17_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_20_18 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_17_1.stage_.transform)

				var_20_18.name = var_20_17
				var_20_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_17] = var_20_18

				local var_20_19 = var_20_18:GetComponentInChildren(typeof(CharacterEffect))

				var_20_19.enabled = true

				local var_20_20 = GameObjectTools.GetOrAddComponent(var_20_18, typeof(DynamicBoneHelper))

				if var_20_20 then
					var_20_20:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_19.transform, false)

				arg_17_1.var_[var_20_17 .. "Animator"] = var_20_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_17 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_17 .. "LipSync"] = var_20_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_21 = arg_17_1.actors_["10102ui_story"].transform

			if 3.83333333333333 < arg_17_1.time_ and arg_17_1.time_ <= 3.83333333333333 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102ui_story = var_20_21.localPosition
			end

			local var_20_22 = 0.001

			if 3.83333333333333 <= arg_17_1.time_ and arg_17_1.time_ < 3.83333333333333 + var_20_22 then
				var_20_21.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_17_1.time_ - 3.83333333333333) / var_20_22)
				var_20_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_21.position).x, (manager.ui.mainCamera.transform.position - var_20_21.position).y, (manager.ui.mainCamera.transform.position - var_20_21.position).z)
				var_20_21.localEulerAngles.z = 0
				var_20_21.localEulerAngles.x = 0
				var_20_21.localEulerAngles = var_20_21.localEulerAngles
			end

			if arg_17_1.time_ >= 3.83333333333333 + var_20_22 and arg_17_1.time_ < 3.83333333333333 + var_20_22 + arg_20_0 then
				var_20_21.localPosition = Vector3.New(0, -0.985, -6.275)
				var_20_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_21.position).x, (manager.ui.mainCamera.transform.position - var_20_21.position).y, (manager.ui.mainCamera.transform.position - var_20_21.position).z)
				var_20_21.localEulerAngles.z = 0
				var_20_21.localEulerAngles.x = 0
				var_20_21.localEulerAngles = var_20_21.localEulerAngles
			end

			local var_20_23 = arg_17_1.actors_["10102ui_story"]

			if 3.83333333333333 < arg_17_1.time_ and arg_17_1.time_ <= 3.83333333333333 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect10102ui_story == nil then
				arg_17_1.var_.characterEffect10102ui_story = var_20_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_24 = 0.200000002980232

			if 3.83333333333333 <= arg_17_1.time_ and arg_17_1.time_ < 3.83333333333333 + var_20_24 and not isNil(var_20_23) then
				if arg_17_1.var_.characterEffect10102ui_story and not isNil(var_20_23) then
					arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 3.83333333333333 + var_20_24 and arg_17_1.time_ < 3.83333333333333 + var_20_24 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect10102ui_story then
				arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_17_1.time_ and arg_17_1.time_ <= 3.83333333333333 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 3.83333333333333 < arg_17_1.time_ and arg_17_1.time_ <= 3.83333333333333 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_17_1.time_ and arg_17_1.time_ <= 0.1 + arg_20_0 then
				arg_17_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if 1.6 < arg_17_1.time_ and arg_17_1.time_ <= 1.6 + arg_20_0 then
				arg_17_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_28 = 4
			local var_20_29 = 0.35

			if 4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_30 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_30:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_31 = arg_17_1:GetWordFromCfg(421032004)
				local var_20_32 = arg_17_1:FormatText(var_20_31.content)

				arg_17_1.text_.text = var_20_32

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_34 = 14 <= 0 and var_20_29 or var_20_29 * (utf8.len(var_20_32) / 14)

				if (14 <= 0 and var_20_29 or var_20_29 * (utf8.len(var_20_32) / 14)) > 0 and var_20_29 < var_20_34 then
					arg_17_1.talkMaxDuration = var_20_34
					var_20_28 = var_20_28 + 0.3

					if var_20_34 + var_20_28 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_28
					end
				end

				arg_17_1.text_.text = var_20_32
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032004", "story_v_out_421032.awb") ~= 0 then
					local var_20_35 = manager.audio:GetVoiceLength("story_v_out_421032", "421032004", "story_v_out_421032.awb") / 1000

					if var_20_35 + var_20_28 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_35 + var_20_28
					end

					if var_20_31.prefab_name ~= "" and arg_17_1.actors_[var_20_31.prefab_name] ~= nil then
						local var_20_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_31.prefab_name].transform, "story_v_out_421032", "421032004", "story_v_out_421032.awb")

						arg_17_1:RecordAudio("421032004", var_20_36)
						arg_17_1:RecordAudio("421032004", var_20_36)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421032", "421032004", "story_v_out_421032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421032", "421032004", "story_v_out_421032.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_37 = var_20_28 + 0.3
			local var_20_38 = math.max(var_20_29, arg_17_1.talkMaxDuration)

			if var_20_28 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_37 + var_20_38 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_37) / var_20_38

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_37 + var_20_38 and arg_17_1.time_ < var_20_37 + var_20_38 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play421032005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 421032005
		arg_23_1.duration_ = 6.17

		local var_23_0 = {
			zh = 3.366,
			ja = 6.166
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
				arg_23_0:Play421032006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10102ui_story = arg_23_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["10102ui_story"].transform.position).z)
				arg_23_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["10102ui_story"].transform.localEulerAngles = arg_23_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["10102ui_story"].transform.position).z)
				arg_23_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["10102ui_story"].transform.localEulerAngles = arg_23_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["10145ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10145ui_story = var_26_1.localPosition
			end

			local var_26_2 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				var_26_1.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_23_1.time_ - 0) / var_26_2)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = Vector3.New(0, -1, -6.2)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			local var_26_3 = arg_23_1.actors_["10145ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect10145ui_story == nil then
				arg_23_1.var_.characterEffect10145ui_story = var_26_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_4 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 and not isNil(var_26_3) then
				if arg_23_1.var_.characterEffect10145ui_story and not isNil(var_26_3) then
					arg_23_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect10145ui_story then
				arg_23_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_26_6 = arg_23_1.actors_["10102ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect10102ui_story == nil then
				arg_23_1.var_.characterEffect10102ui_story = var_26_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_7 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 and not isNil(var_26_6) then
				if arg_23_1.var_.characterEffect10102ui_story and not isNil(var_26_6) then
					arg_23_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_23_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_7)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect10102ui_story then
				arg_23_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_23_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_26_8 = 0
			local var_26_9 = 0.475

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(421032005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 19 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 19)

				if (19 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 19)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032005", "story_v_out_421032.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_421032", "421032005", "story_v_out_421032.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_421032", "421032005", "story_v_out_421032.awb")

						arg_23_1:RecordAudio("421032005", var_26_15)
						arg_23_1:RecordAudio("421032005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_421032", "421032005", "story_v_out_421032.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_421032", "421032005", "story_v_out_421032.awb")
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
				actorName = "10145ui_story",
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
	Play421032006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 421032006
		arg_27_1.duration_ = 2.37

		local var_27_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_27_0:Play421032007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1047ui_story = arg_27_1.actors_["1047ui_story"].transform.localPosition

				arg_27_1:ShowWeapon(arg_27_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1047ui_story"].transform.position).z)
				arg_27_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1047ui_story"].transform.localEulerAngles = arg_27_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_27_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1047ui_story"].transform.position).z)
				arg_27_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1047ui_story"].transform.localEulerAngles = arg_27_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1047ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1047ui_story == nil then
				arg_27_1.var_.characterEffect1047ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1047ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1047ui_story then
				arg_27_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_30_4 = arg_27_1.actors_["10145ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect10145ui_story == nil then
				arg_27_1.var_.characterEffect10145ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_5 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 and not isNil(var_30_4) then
				if arg_27_1.var_.characterEffect10145ui_story and not isNil(var_30_4) then
					arg_27_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_27_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_5)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect10145ui_story then
				arg_27_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_27_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_30_6 = arg_27_1.actors_["10145ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10145ui_story = var_30_6.localPosition
			end

			local var_30_7 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				var_30_6.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_27_1.time_ - 0) / var_30_7)
				var_30_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_6.position).x, (manager.ui.mainCamera.transform.position - var_30_6.position).y, (manager.ui.mainCamera.transform.position - var_30_6.position).z)
				var_30_6.localEulerAngles.z = 0
				var_30_6.localEulerAngles.x = 0
				var_30_6.localEulerAngles = var_30_6.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				var_30_6.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_30_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_6.position).x, (manager.ui.mainCamera.transform.position - var_30_6.position).y, (manager.ui.mainCamera.transform.position - var_30_6.position).z)
				var_30_6.localEulerAngles.z = 0
				var_30_6.localEulerAngles.x = 0
				var_30_6.localEulerAngles = var_30_6.localEulerAngles
			end

			local var_30_8 = 0
			local var_30_9 = 0.125

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:GetWordFromCfg(421032006)
				local var_30_11 = arg_27_1:FormatText(var_30_10.content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 5 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 5)

				if (5 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 5)) > 0 and var_30_9 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032006", "story_v_out_421032.awb") ~= 0 then
					local var_30_14 = manager.audio:GetVoiceLength("story_v_out_421032", "421032006", "story_v_out_421032.awb") / 1000

					if var_30_14 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_14 + var_30_8
					end

					if var_30_10.prefab_name ~= "" and arg_27_1.actors_[var_30_10.prefab_name] ~= nil then
						local var_30_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_10.prefab_name].transform, "story_v_out_421032", "421032006", "story_v_out_421032.awb")

						arg_27_1:RecordAudio("421032006", var_30_15)
						arg_27_1:RecordAudio("421032006", var_30_15)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_421032", "421032006", "story_v_out_421032.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_421032", "421032006", "story_v_out_421032.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 421032007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play421032008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1047ui_story = arg_31_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1047ui_story"].transform.position).z)
				arg_31_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1047ui_story"].transform.localEulerAngles = arg_31_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1047ui_story"].transform.position).z)
				arg_31_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1047ui_story"].transform.localEulerAngles = arg_31_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["10145ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10145ui_story = var_34_1.localPosition
			end

			local var_34_2 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 then
				var_34_1.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_2)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 then
				var_34_1.localPosition = Vector3.New(0, 100, 0)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			if 0.1 < arg_31_1.time_ and arg_31_1.time_ <= 0.1 + arg_34_0 then
				arg_31_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_34_4 = 0
			local var_34_5 = 1.05

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(421032007).content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_8 = 42 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 42)

				if (42 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 42)) > 0 and var_34_5 < var_34_8 then
					arg_31_1.talkMaxDuration = var_34_8

					if var_34_8 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_9 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_9 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_9

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_9 and arg_31_1.time_ < var_34_4 + var_34_9 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 421032008
		arg_35_1.duration_ = 4.77

		local var_35_0 = {
			zh = 3.4,
			ja = 4.766
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
				arg_35_0:Play421032009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10145ui_story = arg_35_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10145ui_story"].transform.position).z)
				arg_35_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10145ui_story"].transform.localEulerAngles = arg_35_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_35_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10145ui_story"].transform.position).z)
				arg_35_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10145ui_story"].transform.localEulerAngles = arg_35_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["10145ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10145ui_story == nil then
				arg_35_1.var_.characterEffect10145ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect10145ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10145ui_story then
				arg_35_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_2")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_38_4 = 0
			local var_38_5 = 0.575

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(421032008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 23 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 23)

				if (23 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 23)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032008", "story_v_out_421032.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_421032", "421032008", "story_v_out_421032.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_421032", "421032008", "story_v_out_421032.awb")

						arg_35_1:RecordAudio("421032008", var_38_11)
						arg_35_1:RecordAudio("421032008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_421032", "421032008", "story_v_out_421032.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_421032", "421032008", "story_v_out_421032.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 421032009
		arg_39_1.duration_ = 4.6

		local var_39_0 = {
			zh = 4.066,
			ja = 4.6
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
				arg_39_0:Play421032010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_42_0 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_39_1.stage_.transform)

				var_42_0.name = "10143ui_story"
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["10143ui_story"] = var_42_0

				local var_42_1 = var_42_0:GetComponentInChildren(typeof(CharacterEffect))

				var_42_1.enabled = true

				local var_42_2 = GameObjectTools.GetOrAddComponent(var_42_0, typeof(DynamicBoneHelper))

				if var_42_2 then
					var_42_2:EnableDynamicBone(false)
				end

				arg_39_1:ShowWeapon(var_42_1.transform, false)

				arg_39_1.var_["10143ui_story" .. "Animator"] = var_42_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_39_1.var_["10143ui_story" .. "Animator"].applyRootMotion = true
				arg_39_1.var_["10143ui_story" .. "LipSync"] = var_42_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_42_3 = arg_39_1.actors_["10143ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10143ui_story = var_42_3.localPosition
			end

			local var_42_4 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				var_42_3.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_39_1.time_ - 0) / var_42_4)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				var_42_3.localPosition = Vector3.New(0.78, -1.06, -6)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			local var_42_5 = arg_39_1.actors_["10143ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect10143ui_story == nil then
				arg_39_1.var_.characterEffect10143ui_story = var_42_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_6 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 and not isNil(var_42_5) then
				if arg_39_1.var_.characterEffect10143ui_story and not isNil(var_42_5) then
					arg_39_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect10143ui_story then
				arg_39_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_42_8 = arg_39_1.actors_["10145ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_8) and arg_39_1.var_.characterEffect10145ui_story == nil then
				arg_39_1.var_.characterEffect10145ui_story = var_42_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_9 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_9 and not isNil(var_42_8) then
				if arg_39_1.var_.characterEffect10145ui_story and not isNil(var_42_8) then
					arg_39_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_9)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_9 and arg_39_1.time_ < 0 + var_42_9 + arg_42_0 and not isNil(var_42_8) and arg_39_1.var_.characterEffect10145ui_story then
				arg_39_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action8_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_42_10 = 0
			local var_42_11 = 0.425

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_12 = arg_39_1:GetWordFromCfg(421032009)
				local var_42_13 = arg_39_1:FormatText(var_42_12.content)

				arg_39_1.text_.text = var_42_13

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_15 = 17 <= 0 and var_42_11 or var_42_11 * (utf8.len(var_42_13) / 17)

				if (17 <= 0 and var_42_11 or var_42_11 * (utf8.len(var_42_13) / 17)) > 0 and var_42_11 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_10
					end
				end

				arg_39_1.text_.text = var_42_13
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032009", "story_v_out_421032.awb") ~= 0 then
					local var_42_16 = manager.audio:GetVoiceLength("story_v_out_421032", "421032009", "story_v_out_421032.awb") / 1000

					if var_42_16 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_16 + var_42_10
					end

					if var_42_12.prefab_name ~= "" and arg_39_1.actors_[var_42_12.prefab_name] ~= nil then
						local var_42_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_12.prefab_name].transform, "story_v_out_421032", "421032009", "story_v_out_421032.awb")

						arg_39_1:RecordAudio("421032009", var_42_17)
						arg_39_1:RecordAudio("421032009", var_42_17)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_421032", "421032009", "story_v_out_421032.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_421032", "421032009", "story_v_out_421032.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_18 = math.max(var_42_11, arg_39_1.talkMaxDuration)

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_18 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_10) / var_42_18

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_10 + var_42_18 and arg_39_1.time_ < var_42_10 + var_42_18 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play421032010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 421032010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play421032011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10143ui_story = arg_43_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10143ui_story"].transform.position).z)
				arg_43_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10143ui_story"].transform.localEulerAngles = arg_43_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10143ui_story"].transform.position).z)
				arg_43_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10143ui_story"].transform.localEulerAngles = arg_43_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["10145ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10145ui_story = var_46_1.localPosition
			end

			local var_46_2 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 then
				var_46_1.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_2)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 then
				var_46_1.localPosition = Vector3.New(0, 100, 0)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			local var_46_3 = 0
			local var_46_4 = 1.2

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_5 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(421032010).content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 48 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_5) / 48)

				if (48 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_5) / 48)) > 0 and var_46_4 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_3
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_4, arg_43_1.talkMaxDuration)

			if var_46_3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_3 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_3) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_3 + var_46_8 and arg_43_1.time_ < var_46_3 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421032011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 421032011
		arg_47_1.duration_ = 5.6

		local var_47_0 = {
			zh = 5.6,
			ja = 4.066
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
				arg_47_0:Play421032012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0.933333333333333 < arg_47_1.time_ and arg_47_1.time_ <= 0.933333333333333 + arg_50_0 then
				arg_47_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_50_0 = 0.566666666666667

			if 0.933333333333333 <= arg_47_1.time_ and arg_47_1.time_ < 0.933333333333333 + var_50_0 then
				local var_50_1, var_50_2 = math.modf((arg_47_1.time_ - 0.933333333333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_50_2 * 0.13, var_50_2 * 0.13, var_50_2 * 0.13) + arg_47_1.var_.shakeOldPos
			end

			if arg_47_1.time_ >= 0.933333333333333 + var_50_0 and arg_47_1.time_ < 0.933333333333333 + var_50_0 + arg_50_0 then
				manager.ui.mainCamera.transform.localPosition = arg_47_1.var_.shakeOldPos
			end

			local var_50_3 = arg_47_1.actors_["11"]

			if 0.6 < arg_47_1.time_ and arg_47_1.time_ <= 0.6 + arg_50_0 then
				local var_50_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_50_4 then
					var_50_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_50_4.radialBlurScale = 0
					var_50_4.radialBlurGradient = 1
					var_50_4.radialBlurIntensity = 1

					if var_50_3 then
						var_50_4.radialBlurTarget = var_50_3.transform
					end
				end
			end

			local var_50_5 = 1.3

			if 0.6 <= arg_47_1.time_ and arg_47_1.time_ < 0.6 + var_50_5 then
				local var_50_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_50_6 then
					var_50_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_50_6.radialBlurScale = Mathf.Lerp(0, 1, (arg_47_1.time_ - 0.6) / var_50_5)
					var_50_6.radialBlurGradient = Mathf.Lerp(1, 1, (arg_47_1.time_ - 0.6) / var_50_5)
					var_50_6.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_47_1.time_ - 0.6) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0.6 + var_50_5 and arg_47_1.time_ < 0.6 + var_50_5 + arg_50_0 then
				local var_50_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_50_7 then
					var_50_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_50_7.radialBlurScale = 1
					var_50_7.radialBlurGradient = 1
					var_50_7.radialBlurIntensity = 1
				end
			end

			local var_50_8 = 0
			local var_50_9 = 0.6

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10145")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_10 = arg_47_1:GetWordFromCfg(421032011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 24 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 24)

				if (24 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 24)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032011", "story_v_out_421032.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_421032", "421032011", "story_v_out_421032.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_421032", "421032011", "story_v_out_421032.awb")

						arg_47_1:RecordAudio("421032011", var_50_15)
						arg_47_1:RecordAudio("421032011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_421032", "421032011", "story_v_out_421032.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_421032", "421032011", "story_v_out_421032.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play421032012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 421032012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play421032013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.3

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(421032012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 52 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 52)

				if (52 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 52)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play421032013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 421032013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play421032014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0.1 < arg_55_1.time_ and arg_55_1.time_ <= 0.1 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car02", "")
			end

			local var_58_1 = 0
			local var_58_2 = 0.975

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

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(421032013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 39 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 39)

				if (39 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 39)) > 0 and var_58_2 < var_58_5 then
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
	Play421032014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 421032014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play421032015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0.666666666666667 < arg_59_1.time_ and arg_59_1.time_ <= 0.666666666666667 + arg_62_0 then
				local var_62_0 = arg_59_1.var_.effect2014

				if not arg_59_1.var_.effect2014 then
					var_62_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_62_0.name = "2014"
					arg_59_1.var_.effect2014 = var_62_0
				else
					var_62_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_62_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_62_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.46666666666667 < arg_59_1.time_ and arg_59_1.time_ <= 2.46666666666667 + arg_62_0 then
				if arg_59_1.var_.effect2014 then
					Object.Destroy(arg_59_1.var_.effect2014)

					arg_59_1.var_.effect2014 = nil
				end
			end

			local var_62_3 = arg_59_1.actors_["11"]

			if 0.666666666666667 < arg_59_1.time_ and arg_59_1.time_ <= 0.666666666666667 + arg_62_0 then
				local var_62_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_62_4 then
					var_62_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_62_4.radialBlurScale = 0
					var_62_4.radialBlurGradient = 1
					var_62_4.radialBlurIntensity = 1

					if var_62_3 then
						var_62_4.radialBlurTarget = var_62_3.transform
					end
				end
			end

			local var_62_5 = 1.36666666666667

			if 0.666666666666667 <= arg_59_1.time_ and arg_59_1.time_ < 0.666666666666667 + var_62_5 then
				local var_62_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_62_6 then
					var_62_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_62_6.radialBlurScale = Mathf.Lerp(0, 0, (arg_59_1.time_ - 0.666666666666667) / var_62_5)
					var_62_6.radialBlurGradient = Mathf.Lerp(1, 1, (arg_59_1.time_ - 0.666666666666667) / var_62_5)
					var_62_6.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_59_1.time_ - 0.666666666666667) / var_62_5)
				end
			end

			if arg_59_1.time_ >= 0.666666666666667 + var_62_5 and arg_59_1.time_ < 0.666666666666667 + var_62_5 + arg_62_0 then
				local var_62_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_62_7 then
					var_62_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_62_7.radialBlurScale = 0
					var_62_7.radialBlurGradient = 1
					var_62_7.radialBlurIntensity = 1
				end
			end

			if 0.28 < arg_59_1.time_ and arg_59_1.time_ <= 0.28 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_143", "se_story_143_car", "")
			end

			local var_62_9 = 0
			local var_62_10 = 1.25

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_11 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(421032014).content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 50 <= 0 and var_62_10 or var_62_10 * (utf8.len(var_62_11) / 50)

				if (50 <= 0 and var_62_10 or var_62_10 * (utf8.len(var_62_11) / 50)) > 0 and var_62_10 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_9 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_9
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_10, arg_59_1.talkMaxDuration)

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_9) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_9 + var_62_14 and arg_59_1.time_ < var_62_9 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play421032015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 421032015
		arg_63_1.duration_ = 2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
			arg_63_1.auto_ = false
		end

		function arg_63_1.playNext_(arg_65_0)
			arg_63_1.onStoryFinished_()
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1047ui_story = arg_63_1.actors_["1047ui_story"].transform.localPosition

				arg_63_1:ShowWeapon(arg_63_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1047ui_story"].transform.position).z)
				arg_63_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1047ui_story"].transform.localEulerAngles = arg_63_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_63_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1047ui_story"].transform.position).z)
				arg_63_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1047ui_story"].transform.localEulerAngles = arg_63_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1047ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1047ui_story == nil then
				arg_63_1.var_.characterEffect1047ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1047ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1047ui_story then
				arg_63_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_66_4 = 0
			local var_66_5 = 0.15

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(421032015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 6 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 6)

				if (6 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 6)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421032", "421032015", "story_v_out_421032.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_421032", "421032015", "story_v_out_421032.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_421032", "421032015", "story_v_out_421032.awb")

						arg_63_1:RecordAudio("421032015", var_66_11)
						arg_63_1:RecordAudio("421032015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_421032", "421032015", "story_v_out_421032.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_421032", "421032015", "story_v_out_421032.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	assets = {
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/ST2105"
	},
	voices = {
		"story_v_out_421032.awb"
	}
}
