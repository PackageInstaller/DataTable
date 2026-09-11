return {
	Play322141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322141001
		arg_1_1.duration_ = 3.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L19i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L19i")
				var_4_0.name = "L19i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L19i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L19i

				arg_1_1.bgs_.L19i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L19i" then
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

			local var_4_9 = "1044ui_story"

			if arg_1_1.actors_["1044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1044ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1044ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1044ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1044ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1044ui_story == nil then
				arg_1_1.var_.characterEffect1044ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1044ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1044ui_story then
				arg_1_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_stone_l19f", "")
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

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

			local var_4_25 = 2
			local var_4_26 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(322141001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 5 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 5)

				if (5 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 5)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141001", "story_v_out_322141.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_322141", "322141001", "story_v_out_322141.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_322141", "322141001", "story_v_out_322141.awb")

						arg_1_1:RecordAudio("322141001", var_4_33)
						arg_1_1:RecordAudio("322141001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322141", "322141001", "story_v_out_322141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322141", "322141001", "story_v_out_322141.awb")
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
				actorName = "1044ui_story",
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
	Play322141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322141002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1043ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1043ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1043ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1043ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1043ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1043ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1043ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1043ui_story == nil then
				arg_9_1.var_.characterEffect1043ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1043ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1043ui_story then
				arg_9_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_12_8 = arg_9_1.actors_["1044ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1044ui_story == nil then
				arg_9_1.var_.characterEffect1044ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1044ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1044ui_story then
				arg_9_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_12_10 = 0
			local var_12_11 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(322141002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 7 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 7)

				if (7 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 7)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141002", "story_v_out_322141.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_322141", "322141002", "story_v_out_322141.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_322141", "322141002", "story_v_out_322141.awb")

						arg_9_1:RecordAudio("322141002", var_12_17)
						arg_9_1:RecordAudio("322141002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322141", "322141002", "story_v_out_322141.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322141", "322141002", "story_v_out_322141.awb")
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
				actorName = "1043ui_story",
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
	Play322141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322141003
		arg_13_1.duration_ = 4.17

		local var_13_0 = {
			zh = 4.166,
			ja = 3.066
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
				arg_13_0:Play322141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1044ui_story = arg_13_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1044ui_story"].transform.position).z)
				arg_13_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1044ui_story"].transform.localEulerAngles = arg_13_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_13_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1044ui_story"].transform.position).z)
				arg_13_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1044ui_story"].transform.localEulerAngles = arg_13_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1044ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1044ui_story == nil then
				arg_13_1.var_.characterEffect1044ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1044ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1044ui_story then
				arg_13_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_16_4 = arg_13_1.actors_["1043ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1043ui_story == nil then
				arg_13_1.var_.characterEffect1043ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_5 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 and not isNil(var_16_4) then
				if arg_13_1.var_.characterEffect1043ui_story and not isNil(var_16_4) then
					arg_13_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_5)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1043ui_story then
				arg_13_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_16_6 = 0
			local var_16_7 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(322141003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 14 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 14)

				if (14 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 14)) > 0 and var_16_7 < var_16_11 then
					arg_13_1.talkMaxDuration = var_16_11

					if var_16_11 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141003", "story_v_out_322141.awb") ~= 0 then
					local var_16_12 = manager.audio:GetVoiceLength("story_v_out_322141", "322141003", "story_v_out_322141.awb") / 1000

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end

					if var_16_8.prefab_name ~= "" and arg_13_1.actors_[var_16_8.prefab_name] ~= nil then
						local var_16_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_8.prefab_name].transform, "story_v_out_322141", "322141003", "story_v_out_322141.awb")

						arg_13_1:RecordAudio("322141003", var_16_13)
						arg_13_1:RecordAudio("322141003", var_16_13)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322141", "322141003", "story_v_out_322141.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322141", "322141003", "story_v_out_322141.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322141004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1043ui_story = arg_17_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1043ui_story"].transform.position).z)
				arg_17_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1043ui_story"].transform.localEulerAngles = arg_17_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1043ui_story"].transform.position).z)
				arg_17_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1043ui_story"].transform.localEulerAngles = arg_17_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1044ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1044ui_story = var_20_1.localPosition
			end

			local var_20_2 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 then
				var_20_1.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_2)
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

			local var_20_3 = 0
			local var_20_4 = 1.425

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(322141004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 57 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 57)

				if (57 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 57)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play322141005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322141005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322141006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0.1 < arg_21_1.time_ and arg_21_1.time_ <= 0.1 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword", "")
			end

			local var_24_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_21_1.time_ and arg_21_1.time_ <= 0.1 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = var_24_1.localPosition
			end

			local var_24_2 = 0.433333333333333

			if 0.1 <= arg_21_1.time_ and arg_21_1.time_ < 0.1 + var_24_2 then
				local var_24_3, var_24_4 = math.modf((arg_21_1.time_ - 0.1) / 0.066)

				var_24_1.localPosition = Vector3.New(var_24_4 * 0.13, var_24_4 * 0.13, var_24_4 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= 0.1 + var_24_2 and arg_21_1.time_ < 0.1 + var_24_2 + arg_24_0 then
				var_24_1.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_5 = 0
			local var_24_6 = 0.675

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(322141005).content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 27 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 27)

				if (27 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 27)) > 0 and var_24_6 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_10 and arg_21_1.time_ < var_24_5 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322141006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322141006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play322141007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_9000

			if 0.1 < arg_25_1.time_ and arg_25_1.time_ <= 0.1 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			if 0.1 < arg_25_1.time_ and arg_25_1.time_ <= 0.1 + arg_28_0 then
				local var_28_1 = arg_25_1.var_.effect1116

				if not arg_25_1.var_.effect1116 then
					var_28_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_28_1.name = "1116"
					arg_25_1.var_.effect1116 = var_28_1
				else
					var_28_1.transform:SetParent(var_28_9000)
				end

				var_28_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_28_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_28_3 = manager.ui.mainCamera.transform

			if 0.1 < arg_25_1.time_ and arg_25_1.time_ <= 0.1 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_3.localPosition
			end

			local var_28_4 = 0.533333333333333

			if 0.1 <= arg_25_1.time_ and arg_25_1.time_ < 0.1 + var_28_4 then
				local var_28_5, var_28_6 = math.modf((arg_25_1.time_ - 0.1) / 0.132)

				var_28_3.localPosition = Vector3.New(var_28_6 * 0.13, var_28_6 * 0.13, var_28_6 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 0.1 + var_28_4 and arg_25_1.time_ < 0.1 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_7 = 0
			local var_28_8 = 1.125

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(322141006).content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 45 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_9) / 45)

				if (45 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_9) / 45)) > 0 and var_28_8 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_12 and arg_25_1.time_ < var_28_7 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322141007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322141007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			zh = 2.866,
			ja = 3.9
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
				arg_29_0:Play322141008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				if arg_29_1.var_.effect1116 then
					Object.Destroy(arg_29_1.var_.effect1116)

					arg_29_1.var_.effect1116 = nil
				end
			end

			local var_32_1 = 0
			local var_32_2 = 0.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(322141007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 15 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 15)

				if (15 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 15)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141007", "story_v_out_322141.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_322141", "322141007", "story_v_out_322141.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_322141", "322141007", "story_v_out_322141.awb")

						arg_29_1:RecordAudio("322141007", var_32_8)
						arg_29_1:RecordAudio("322141007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322141", "322141007", "story_v_out_322141.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322141", "322141007", "story_v_out_322141.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322141008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322141008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322141009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(322141008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 54 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 54)

				if (54 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 54)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322141009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322141009
		arg_37_1.duration_ = 4.53

		local var_37_0 = {
			zh = 3.333,
			ja = 4.533
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322141010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1043ui_story = arg_37_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1043ui_story"].transform.position).z)
				arg_37_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1043ui_story"].transform.localEulerAngles = arg_37_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				arg_37_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1043ui_story"].transform.position).z)
				arg_37_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1043ui_story"].transform.localEulerAngles = arg_37_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1043ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1043ui_story == nil then
				arg_37_1.var_.characterEffect1043ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1043ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1043ui_story then
				arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(322141009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 17 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 17)

				if (17 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 17)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141009", "story_v_out_322141.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_322141", "322141009", "story_v_out_322141.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_322141", "322141009", "story_v_out_322141.awb")

						arg_37_1:RecordAudio("322141009", var_40_11)
						arg_37_1:RecordAudio("322141009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322141", "322141009", "story_v_out_322141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322141", "322141009", "story_v_out_322141.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322141010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322141010
		arg_41_1.duration_ = 3.73

		local var_41_0 = {
			zh = 3.733,
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
				arg_41_0:Play322141011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1044ui_story = arg_41_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1044ui_story"].transform.position).z)
				arg_41_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1044ui_story"].transform.localEulerAngles = arg_41_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_41_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1044ui_story"].transform.position).z)
				arg_41_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1044ui_story"].transform.localEulerAngles = arg_41_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1044ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1044ui_story == nil then
				arg_41_1.var_.characterEffect1044ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1044ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1044ui_story then
				arg_41_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1043ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1043ui_story == nil then
				arg_41_1.var_.characterEffect1043ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1043ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1043ui_story then
				arg_41_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			local var_44_6 = 0
			local var_44_7 = 0.4

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(322141010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 16 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 16)

				if (16 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 16)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141010", "story_v_out_322141.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_322141", "322141010", "story_v_out_322141.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_322141", "322141010", "story_v_out_322141.awb")

						arg_41_1:RecordAudio("322141010", var_44_13)
						arg_41_1:RecordAudio("322141010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322141", "322141010", "story_v_out_322141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322141", "322141010", "story_v_out_322141.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play322141011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322141011
		arg_45_1.duration_ = 2.53

		local var_45_0 = {
			zh = 2.533,
			ja = 2.133
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
				arg_45_0:Play322141012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044actionlink/1044action463")
			end

			local var_48_0 = 0
			local var_48_1 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(322141011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 11 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 11)

				if (11 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 11)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141011", "story_v_out_322141.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_322141", "322141011", "story_v_out_322141.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_322141", "322141011", "story_v_out_322141.awb")

						arg_45_1:RecordAudio("322141011", var_48_7)
						arg_45_1:RecordAudio("322141011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322141", "322141011", "story_v_out_322141.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322141", "322141011", "story_v_out_322141.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322141012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322141012
		arg_49_1.duration_ = 6.83

		local var_49_0 = {
			zh = 6.833,
			ja = 5.533
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
				arg_49_0:Play322141013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_52_0 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_49_1.stage_.transform)

				var_52_0.name = "10131ui_story"
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["10131ui_story"] = var_52_0

				local var_52_1 = var_52_0:GetComponentInChildren(typeof(CharacterEffect))

				var_52_1.enabled = true

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_1.transform, false)

				arg_49_1.var_["10131ui_story" .. "Animator"] = var_52_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_["10131ui_story" .. "Animator"].applyRootMotion = true
				arg_49_1.var_["10131ui_story" .. "LipSync"] = var_52_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_3 = arg_49_1.actors_["10131ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10131ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["1043ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1043ui_story = var_52_5.localPosition
			end

			local var_52_6 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 then
				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_6)
				var_52_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_5.position).x, (manager.ui.mainCamera.transform.position - var_52_5.position).y, (manager.ui.mainCamera.transform.position - var_52_5.position).z)
				var_52_5.localEulerAngles.z = 0
				var_52_5.localEulerAngles.x = 0
				var_52_5.localEulerAngles = var_52_5.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0, 100, 0)
				var_52_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_5.position).x, (manager.ui.mainCamera.transform.position - var_52_5.position).y, (manager.ui.mainCamera.transform.position - var_52_5.position).z)
				var_52_5.localEulerAngles.z = 0
				var_52_5.localEulerAngles.x = 0
				var_52_5.localEulerAngles = var_52_5.localEulerAngles
			end

			local var_52_7 = arg_49_1.actors_["10131ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.characterEffect10131ui_story == nil then
				arg_49_1.var_.characterEffect10131ui_story = var_52_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_8 and not isNil(var_52_7) then
				if arg_49_1.var_.characterEffect10131ui_story and not isNil(var_52_7) then
					arg_49_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_8 and arg_49_1.time_ < 0 + var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.characterEffect10131ui_story then
				arg_49_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_52_10 = arg_49_1.actors_["1044ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_10) and arg_49_1.var_.characterEffect1044ui_story == nil then
				arg_49_1.var_.characterEffect1044ui_story = var_52_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_11 and not isNil(var_52_10) then
				if arg_49_1.var_.characterEffect1044ui_story and not isNil(var_52_10) then
					arg_49_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_11)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_11 and arg_49_1.time_ < 0 + var_52_11 + arg_52_0 and not isNil(var_52_10) and arg_49_1.var_.characterEffect1044ui_story then
				arg_49_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_12 = 0
			local var_52_13 = 0.7

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(322141012)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 28 <= 0 and var_52_13 or var_52_13 * (utf8.len(var_52_15) / 28)

				if (28 <= 0 and var_52_13 or var_52_13 * (utf8.len(var_52_15) / 28)) > 0 and var_52_13 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141012", "story_v_out_322141.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_322141", "322141012", "story_v_out_322141.awb") / 1000

					if var_52_18 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_12
					end

					if var_52_14.prefab_name ~= "" and arg_49_1.actors_[var_52_14.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_14.prefab_name].transform, "story_v_out_322141", "322141012", "story_v_out_322141.awb")

						arg_49_1:RecordAudio("322141012", var_52_19)
						arg_49_1:RecordAudio("322141012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322141", "322141012", "story_v_out_322141.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322141", "322141012", "story_v_out_322141.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_20 and arg_49_1.time_ < var_52_12 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322141013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322141013
		arg_53_1.duration_ = 4.6

		local var_53_0 = {
			zh = 3.9,
			ja = 4.6
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
				arg_53_0:Play322141014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1044ui_story"]) and arg_53_1.var_.characterEffect1044ui_story == nil then
				arg_53_1.var_.characterEffect1044ui_story = arg_53_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1044ui_story"]) then
				if arg_53_1.var_.characterEffect1044ui_story and not isNil(arg_53_1.actors_["1044ui_story"]) then
					arg_53_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1044ui_story"]) and arg_53_1.var_.characterEffect1044ui_story then
				arg_53_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_56_2 = arg_53_1.actors_["10131ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10131ui_story == nil then
				arg_53_1.var_.characterEffect10131ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect10131ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10131ui_story then
				arg_53_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_56_4 = 0
			local var_56_5 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(322141013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 14 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 14)

				if (14 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 14)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141013", "story_v_out_322141.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_322141", "322141013", "story_v_out_322141.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_322141", "322141013", "story_v_out_322141.awb")

						arg_53_1:RecordAudio("322141013", var_56_11)
						arg_53_1:RecordAudio("322141013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322141", "322141013", "story_v_out_322141.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322141", "322141013", "story_v_out_322141.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322141014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322141014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322141015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1044ui_story = arg_57_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1044ui_story"].transform.position).z)
				arg_57_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1044ui_story"].transform.localEulerAngles = arg_57_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1044ui_story"].transform.position).z)
				arg_57_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1044ui_story"].transform.localEulerAngles = arg_57_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10131ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10131ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = 0
			local var_60_4 = 1.75

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(322141014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 70 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 70)

				if (70 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 70)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play322141015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322141015
		arg_61_1.duration_ = 4.07

		local var_61_0 = {
			zh = 1.633,
			ja = 4.066
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
				arg_61_0:Play322141016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10131ui_story = arg_61_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10131ui_story"].transform.position).z)
				arg_61_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10131ui_story"].transform.localEulerAngles = arg_61_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_61_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10131ui_story"].transform.position).z)
				arg_61_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10131ui_story"].transform.localEulerAngles = arg_61_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10131ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10131ui_story == nil then
				arg_61_1.var_.characterEffect10131ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10131ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10131ui_story then
				arg_61_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_64_4 = 0
			local var_64_5 = 0.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(322141015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 10 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 10)

				if (10 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 10)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141015", "story_v_out_322141.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_322141", "322141015", "story_v_out_322141.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_322141", "322141015", "story_v_out_322141.awb")

						arg_61_1:RecordAudio("322141015", var_64_11)
						arg_61_1:RecordAudio("322141015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322141", "322141015", "story_v_out_322141.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322141", "322141015", "story_v_out_322141.awb")
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

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play322141016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322141016
		arg_65_1.duration_ = 5.9

		local var_65_0 = {
			zh = 5.9,
			ja = 5.8
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
				arg_65_0:Play322141017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1044ui_story = arg_65_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1044ui_story"].transform.position).z)
				arg_65_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1044ui_story"].transform.localEulerAngles = arg_65_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_65_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1044ui_story"].transform.position).z)
				arg_65_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1044ui_story"].transform.localEulerAngles = arg_65_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1044ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1044ui_story == nil then
				arg_65_1.var_.characterEffect1044ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1044ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1044ui_story then
				arg_65_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["10131ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect10131ui_story == nil then
				arg_65_1.var_.characterEffect10131ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect10131ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect10131ui_story then
				arg_65_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_68_6 = 0
			local var_68_7 = 0.65

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(322141016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 26 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 26)

				if (26 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 26)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141016", "story_v_out_322141.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_322141", "322141016", "story_v_out_322141.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_322141", "322141016", "story_v_out_322141.awb")

						arg_65_1:RecordAudio("322141016", var_68_13)
						arg_65_1:RecordAudio("322141016", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322141", "322141016", "story_v_out_322141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322141", "322141016", "story_v_out_322141.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322141017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322141017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play322141018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10131ui_story = arg_69_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).z)
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles = arg_69_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_69_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).z)
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles = arg_69_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10131ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10131ui_story == nil then
				arg_69_1.var_.characterEffect10131ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10131ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10131ui_story then
				arg_69_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["1044ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1044ui_story == nil then
				arg_69_1.var_.characterEffect1044ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_5 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.characterEffect1044ui_story and not isNil(var_72_4) then
					arg_69_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_5)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1044ui_story then
				arg_69_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_72_6 = 0
			local var_72_7 = 0.125

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(322141017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 5 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 5)

				if (5 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 5)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141017", "story_v_out_322141.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_322141", "322141017", "story_v_out_322141.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_322141", "322141017", "story_v_out_322141.awb")

						arg_69_1:RecordAudio("322141017", var_72_13)
						arg_69_1:RecordAudio("322141017", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322141", "322141017", "story_v_out_322141.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322141", "322141017", "story_v_out_322141.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322141018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322141018
		arg_73_1.duration_ = 4.73

		local var_73_0 = {
			zh = 3.8,
			ja = 4.733
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
				arg_73_0:Play322141019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1044ui_story = arg_73_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1044ui_story"].transform.position).z)
				arg_73_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1044ui_story"].transform.localEulerAngles = arg_73_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_73_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1044ui_story"].transform.position).z)
				arg_73_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1044ui_story"].transform.localEulerAngles = arg_73_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1044ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1044ui_story == nil then
				arg_73_1.var_.characterEffect1044ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1044ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1044ui_story then
				arg_73_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_76_4 = arg_73_1.actors_["10131ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10131ui_story == nil then
				arg_73_1.var_.characterEffect10131ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect10131ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10131ui_story then
				arg_73_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_76_6 = "1111ui_story"

			if arg_73_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_76_7 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_73_1.stage_.transform)

				var_76_7.name = var_76_6
				var_76_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_[var_76_6] = var_76_7

				local var_76_8 = var_76_7:GetComponentInChildren(typeof(CharacterEffect))

				var_76_8.enabled = true

				local var_76_9 = GameObjectTools.GetOrAddComponent(var_76_7, typeof(DynamicBoneHelper))

				if var_76_9 then
					var_76_9:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_8.transform, false)

				arg_73_1.var_[var_76_6 .. "Animator"] = var_76_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_[var_76_6 .. "Animator"].applyRootMotion = true
				arg_73_1.var_[var_76_6 .. "LipSync"] = var_76_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_76_10 = 0
			local var_76_11 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_12 = arg_73_1:GetWordFromCfg(322141018)
				local var_76_13 = arg_73_1:FormatText(var_76_12.content)

				arg_73_1.text_.text = var_76_13

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_15 = 12 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_13) / 12)

				if (12 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_13) / 12)) > 0 and var_76_11 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_10
					end
				end

				arg_73_1.text_.text = var_76_13
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141018", "story_v_out_322141.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_322141", "322141018", "story_v_out_322141.awb") / 1000

					if var_76_16 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_10
					end

					if var_76_12.prefab_name ~= "" and arg_73_1.actors_[var_76_12.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_12.prefab_name].transform, "story_v_out_322141", "322141018", "story_v_out_322141.awb")

						arg_73_1:RecordAudio("322141018", var_76_17)
						arg_73_1:RecordAudio("322141018", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322141", "322141018", "story_v_out_322141.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322141", "322141018", "story_v_out_322141.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_18 and arg_73_1.time_ < var_76_10 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322141019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322141019
		arg_77_1.duration_ = 5.43

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play322141020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_9000

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1044ui_story = arg_77_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1044ui_story"].transform.position).z)
				arg_77_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1044ui_story"].transform.localEulerAngles = arg_77_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1044ui_story"].transform.position).z)
				arg_77_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1044ui_story"].transform.localEulerAngles = arg_77_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10131ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10131ui_story = var_80_1.localPosition
			end

			local var_80_2 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_2)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if 0.034000001847744 < arg_77_1.time_ and arg_77_1.time_ <= 0.034000001847744 + arg_80_0 then
				arg_77_1:AudioAction("play", "effect", "se_story_139", "se_story_139_5220115Talk1_4", "")
			end

			if 0.034000001847744 < arg_77_1.time_ and arg_77_1.time_ <= 0.034000001847744 + arg_80_0 then
				local var_80_4 = arg_77_1.var_.effect410192

				if not arg_77_1.var_.effect410192 then
					var_80_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), manager.ui.mainCamera.transform)
					var_80_4.name = "410192"
					arg_77_1.var_.effect410192 = var_80_4
				else
					var_80_4.transform:SetParent(var_80_9000)
				end

				var_80_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_80_6 = manager.ui.mainCamera.transform

			if 0.034000001847744 < arg_77_1.time_ and arg_77_1.time_ <= 0.034000001847744 + arg_80_0 then
				arg_77_1.var_.shakeOldPos = var_80_6.localPosition
			end

			local var_80_7 = 0.4

			if 0.034000001847744 <= arg_77_1.time_ and arg_77_1.time_ < 0.034000001847744 + var_80_7 then
				local var_80_8, var_80_9 = math.modf((arg_77_1.time_ - 0.034000001847744) / 0.066)

				var_80_6.localPosition = Vector3.New(var_80_9 * 0.13, var_80_9 * 0.13, var_80_9 * 0.13) + arg_77_1.var_.shakeOldPos
			end

			if arg_77_1.time_ >= 0.034000001847744 + var_80_7 and arg_77_1.time_ < 0.034000001847744 + var_80_7 + arg_80_0 then
				var_80_6.localPosition = arg_77_1.var_.shakeOldPos
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_10 = 0.434000001847744
			local var_80_11 = 1

			if 0.434000001847744 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_12 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_12:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(322141019).content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 58 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 58)

				if (58 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 58)) > 0 and var_80_11 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15
					var_80_10 = var_80_10 + 0.3

					if var_80_15 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = var_80_10 + 0.3
			local var_80_17 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_16) / var_80_17

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322141020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322141020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322141021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1043ui_story = arg_83_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).z)
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles = arg_83_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_83_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).z)
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles = arg_83_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1043ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1043ui_story == nil then
				arg_83_1.var_.characterEffect1043ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1043ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1043ui_story then
				arg_83_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				if arg_83_1.var_.effect41019 then
					Object.Destroy(arg_83_1.var_.effect41019)

					arg_83_1.var_.effect41019 = nil
				end
			end

			local var_86_5 = 0
			local var_86_6 = 0.075

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(322141020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 3 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 3)

				if (3 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 3)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141020", "story_v_out_322141.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_322141", "322141020", "story_v_out_322141.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_322141", "322141020", "story_v_out_322141.awb")

						arg_83_1:RecordAudio("322141020", var_86_12)
						arg_83_1:RecordAudio("322141020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322141", "322141020", "story_v_out_322141.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322141", "322141020", "story_v_out_322141.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_13 and arg_83_1.time_ < var_86_5 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play322141021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322141021
		arg_87_1.duration_ = 2.93

		local var_87_0 = {
			zh = 2.266,
			ja = 2.933
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
				arg_87_0:Play322141022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1043ui_story = arg_87_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1043ui_story"].transform.position).z)
				arg_87_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1043ui_story"].transform.localEulerAngles = arg_87_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1043ui_story"].transform.position).z)
				arg_87_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1043ui_story"].transform.localEulerAngles = arg_87_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1043ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1043ui_story == nil then
				arg_87_1.var_.characterEffect1043ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1043ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_2)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1043ui_story then
				arg_87_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_90_3 = 0
			local var_90_4 = 0.225

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_5 = arg_87_1:GetWordFromCfg(322141021)
				local var_90_6 = arg_87_1:FormatText(var_90_5.content)

				arg_87_1.text_.text = var_90_6

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 9 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 9)

				if (9 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 9)) > 0 and var_90_4 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_6
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141021", "story_v_out_322141.awb") ~= 0 then
					local var_90_9 = manager.audio:GetVoiceLength("story_v_out_322141", "322141021", "story_v_out_322141.awb") / 1000

					if var_90_9 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_3
					end

					if var_90_5.prefab_name ~= "" and arg_87_1.actors_[var_90_5.prefab_name] ~= nil then
						local var_90_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_5.prefab_name].transform, "story_v_out_322141", "322141021", "story_v_out_322141.awb")

						arg_87_1:RecordAudio("322141021", var_90_10)
						arg_87_1:RecordAudio("322141021", var_90_10)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322141", "322141021", "story_v_out_322141.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322141", "322141021", "story_v_out_322141.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_11 and arg_87_1.time_ < var_90_3 + var_90_11 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322141022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322141022
		arg_91_1.duration_ = 6.37

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322141023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_0 = arg_91_1.var_.effect1022

				if not arg_91_1.var_.effect1022 then
					var_94_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), manager.ui.mainCamera.transform)
					var_94_0.name = "1022"
					arg_91_1.var_.effect1022 = var_94_0
				else
					var_94_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_94_0.transform.localPosition = Vector3.New(0, 0, -4)
				var_94_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_94_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_94_3 = var_94_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_94_0, iter_94_1 in ipairs((var_94_3:ToTable())) do
					iter_94_1.transform.localScale = Vector3.New(iter_94_1.transform.localScale.x / var_94_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_94_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_94_1.transform.localScale.y / var_94_2, iter_94_1.transform.localScale.z)
				end
			end

			local var_94_5 = manager.ui.mainCamera.transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.shakeOldPos = var_94_5.localPosition
			end

			local var_94_6 = 0.833333333333333

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 then
				local var_94_7, var_94_8 = math.modf((arg_91_1.time_ - 0) / 0.066)

				var_94_5.localPosition = Vector3.New(var_94_8 * 0.13, var_94_8 * 0.13, var_94_8 * 0.13) + arg_91_1.var_.shakeOldPos
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 then
				var_94_5.localPosition = arg_91_1.var_.shakeOldPos
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion05", "")
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_10 = 1.36666666666667
			local var_94_11 = 1.575

			if 1.36666666666667 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_12 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_12:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_13 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(322141022).content)

				arg_91_1.text_.text = var_94_13

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_15 = 63 <= 0 and var_94_11 or var_94_11 * (utf8.len(var_94_13) / 63)

				if (63 <= 0 and var_94_11 or var_94_11 * (utf8.len(var_94_13) / 63)) > 0 and var_94_11 < var_94_15 then
					arg_91_1.talkMaxDuration = var_94_15
					var_94_10 = var_94_10 + 0.3

					if var_94_15 + var_94_10 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_15 + var_94_10
					end
				end

				arg_91_1.text_.text = var_94_13
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = var_94_10 + 0.3
			local var_94_17 = math.max(var_94_11, arg_91_1.talkMaxDuration)

			if var_94_10 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_16) / var_94_17

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322141023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322141023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322141024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				if arg_97_1.var_.effect1022 then
					Object.Destroy(arg_97_1.var_.effect1022)

					arg_97_1.var_.effect1022 = nil
				end
			end

			local var_100_1 = 0
			local var_100_2 = 1.275

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(322141023).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 51 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 51)

				if (51 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 51)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322141024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322141024
		arg_101_1.duration_ = 5.07

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322141025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1044ui_story = arg_101_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1044ui_story"].transform.position).z)
				arg_101_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1044ui_story"].transform.localEulerAngles = arg_101_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_101_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1044ui_story"].transform.position).z)
				arg_101_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1044ui_story"].transform.localEulerAngles = arg_101_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1044ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1044ui_story == nil then
				arg_101_1.var_.characterEffect1044ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1044ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1044ui_story then
				arg_101_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			local var_104_4 = 0
			local var_104_5 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(322141024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 18 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 18)

				if (18 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 18)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141024", "story_v_out_322141.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_322141", "322141024", "story_v_out_322141.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_322141", "322141024", "story_v_out_322141.awb")

						arg_101_1:RecordAudio("322141024", var_104_11)
						arg_101_1:RecordAudio("322141024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322141", "322141024", "story_v_out_322141.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322141", "322141024", "story_v_out_322141.awb")
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

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play322141025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322141025
		arg_105_1.duration_ = 2.23

		local var_105_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_105_0:Play322141026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_108_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_105_1.stage_.transform)

				var_108_0.name = "1211ui_story"
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1211ui_story"] = var_108_0

				local var_108_1 = var_108_0:GetComponentInChildren(typeof(CharacterEffect))

				var_108_1.enabled = true

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_1.transform, false)

				arg_105_1.var_["1211ui_story" .. "Animator"] = var_108_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_105_1.var_["1211ui_story" .. "LipSync"] = var_108_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_108_3 = arg_105_1.actors_["1211ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1211ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["1211ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1211ui_story == nil then
				arg_105_1.var_.characterEffect1211ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect1211ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1211ui_story then
				arg_105_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_108_8 = arg_105_1.actors_["1044ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.characterEffect1044ui_story == nil then
				arg_105_1.var_.characterEffect1044ui_story = var_108_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_9 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_9 and not isNil(var_108_8) then
				if arg_105_1.var_.characterEffect1044ui_story and not isNil(var_108_8) then
					arg_105_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_9)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_9 and arg_105_1.time_ < 0 + var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.characterEffect1044ui_story then
				arg_105_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_108_10 = 0
			local var_108_11 = 0.175

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_12 = arg_105_1:GetWordFromCfg(322141025)
				local var_108_13 = arg_105_1:FormatText(var_108_12.content)

				arg_105_1.text_.text = var_108_13

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_15 = 7 <= 0 and var_108_11 or var_108_11 * (utf8.len(var_108_13) / 7)

				if (7 <= 0 and var_108_11 or var_108_11 * (utf8.len(var_108_13) / 7)) > 0 and var_108_11 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_10
					end
				end

				arg_105_1.text_.text = var_108_13
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141025", "story_v_out_322141.awb") ~= 0 then
					local var_108_16 = manager.audio:GetVoiceLength("story_v_out_322141", "322141025", "story_v_out_322141.awb") / 1000

					if var_108_16 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_10
					end

					if var_108_12.prefab_name ~= "" and arg_105_1.actors_[var_108_12.prefab_name] ~= nil then
						local var_108_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_12.prefab_name].transform, "story_v_out_322141", "322141025", "story_v_out_322141.awb")

						arg_105_1:RecordAudio("322141025", var_108_17)
						arg_105_1:RecordAudio("322141025", var_108_17)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322141", "322141025", "story_v_out_322141.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322141", "322141025", "story_v_out_322141.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = math.max(var_108_11, arg_105_1.talkMaxDuration)

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_18 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_10) / var_108_18

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_10 + var_108_18 and arg_105_1.time_ < var_108_10 + var_108_18 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play322141026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322141026
		arg_109_1.duration_ = 2

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322141027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1043ui_story = arg_109_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1043ui_story"].transform.position).z)
				arg_109_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1043ui_story"].transform.localEulerAngles = arg_109_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_109_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1043ui_story"].transform.position).z)
				arg_109_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1043ui_story"].transform.localEulerAngles = arg_109_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1211ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1211ui_story = var_112_1.localPosition
			end

			local var_112_2 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_2)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 then
				var_112_1.localPosition = Vector3.New(0, 100, 0)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			local var_112_3 = arg_109_1.actors_["1044ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1044ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0, 100, 0)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			local var_112_5 = arg_109_1.actors_["1043ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1043ui_story == nil then
				arg_109_1.var_.characterEffect1043ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect1043ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1043ui_story then
				arg_109_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_112_8 = arg_109_1.actors_["1211ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.characterEffect1211ui_story == nil then
				arg_109_1.var_.characterEffect1211ui_story = var_112_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_9 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_9 and not isNil(var_112_8) then
				if arg_109_1.var_.characterEffect1211ui_story and not isNil(var_112_8) then
					arg_109_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_9)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_9 and arg_109_1.time_ < 0 + var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.characterEffect1211ui_story then
				arg_109_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_10 = 0
			local var_112_11 = 0.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_12 = arg_109_1:GetWordFromCfg(322141026)
				local var_112_13 = arg_109_1:FormatText(var_112_12.content)

				arg_109_1.text_.text = var_112_13

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_15 = 5 <= 0 and var_112_11 or var_112_11 * (utf8.len(var_112_13) / 5)

				if (5 <= 0 and var_112_11 or var_112_11 * (utf8.len(var_112_13) / 5)) > 0 and var_112_11 < var_112_15 then
					arg_109_1.talkMaxDuration = var_112_15

					if var_112_15 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_10
					end
				end

				arg_109_1.text_.text = var_112_13
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141026", "story_v_out_322141.awb") ~= 0 then
					local var_112_16 = manager.audio:GetVoiceLength("story_v_out_322141", "322141026", "story_v_out_322141.awb") / 1000

					if var_112_16 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_10
					end

					if var_112_12.prefab_name ~= "" and arg_109_1.actors_[var_112_12.prefab_name] ~= nil then
						local var_112_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_12.prefab_name].transform, "story_v_out_322141", "322141026", "story_v_out_322141.awb")

						arg_109_1:RecordAudio("322141026", var_112_17)
						arg_109_1:RecordAudio("322141026", var_112_17)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322141", "322141026", "story_v_out_322141.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322141", "322141026", "story_v_out_322141.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_18 = math.max(var_112_11, arg_109_1.talkMaxDuration)

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_18 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_10) / var_112_18

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_10 + var_112_18 and arg_109_1.time_ < var_112_10 + var_112_18 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play322141027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322141027
		arg_113_1.duration_ = 6.62

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322141028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_9000

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1043ui_story = arg_113_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1043ui_story"].transform.position).z)
				arg_113_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1043ui_story"].transform.localEulerAngles = arg_113_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1043ui_story"].transform.position).z)
				arg_113_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1043ui_story"].transform.localEulerAngles = arg_113_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_116_1 = 0.733333333333333

			if 0.733333333333333 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.shakeOldPos = arg_113_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_116_2 = 0.266666666666667

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3, var_116_4 = math.modf((arg_113_1.time_ - var_116_1) / 0.066)

				arg_113_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(var_116_4 * 0.13, var_116_4 * 0.13, var_116_4 * 0.13) + arg_113_1.var_.shakeOldPos
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				arg_113_1.actors_["1043ui_story"].transform.localPosition = arg_113_1.var_.shakeOldPos
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				local var_116_5 = arg_113_1.var_.effect1027

				if not arg_113_1.var_.effect1027 then
					var_116_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), manager.ui.mainCamera.transform)
					var_116_5.name = "1027"
					arg_113_1.var_.effect1027 = var_116_5
				else
					var_116_5.transform:SetParent(var_116_9000)
				end

				var_116_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.3 < arg_113_1.time_ and arg_113_1.time_ <= 4.3 + arg_116_0 then
				if arg_113_1.var_.effect1027 then
					Object.Destroy(arg_113_1.var_.effect1027)

					arg_113_1.var_.effect1027 = nil
				end
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_145", "se_story_145_combo", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_9 = 1.61666666666667
			local var_116_10 = 1.325

			if 1.61666666666667 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_11 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_11:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_12 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(322141027).content)

				arg_113_1.text_.text = var_116_12

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_14 = 53 <= 0 and var_116_10 or var_116_10 * (utf8.len(var_116_12) / 53)

				if (53 <= 0 and var_116_10 or var_116_10 * (utf8.len(var_116_12) / 53)) > 0 and var_116_10 < var_116_14 then
					arg_113_1.talkMaxDuration = var_116_14
					var_116_9 = var_116_9 + 0.3

					if var_116_14 + var_116_9 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_9
					end
				end

				arg_113_1.text_.text = var_116_12
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_15 = var_116_9 + 0.3
			local var_116_16 = math.max(var_116_10, arg_113_1.talkMaxDuration)

			if var_116_9 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_16 and arg_113_1.time_ < var_116_15 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play322141028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322141028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play322141029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0.1 < arg_119_1.time_ and arg_119_1.time_ <= 0.1 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_145", "se_story_145_laser", "")
			end

			local var_122_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_119_1.time_ and arg_119_1.time_ <= 0.1 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = var_122_1.localPosition
			end

			local var_122_2 = 0.366666666666667

			if 0.1 <= arg_119_1.time_ and arg_119_1.time_ < 0.1 + var_122_2 then
				local var_122_3, var_122_4 = math.modf((arg_119_1.time_ - 0.1) / 0.099)

				var_122_1.localPosition = Vector3.New(var_122_4 * 0.13, var_122_4 * 0.13, var_122_4 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= 0.1 + var_122_2 and arg_119_1.time_ < 0.1 + var_122_2 + arg_122_0 then
				var_122_1.localPosition = arg_119_1.var_.shakeOldPos
			end

			local var_122_5 = 0
			local var_122_6 = 1.275

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(322141028).content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 51 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_7) / 51)

				if (51 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_7) / 51)) > 0 and var_122_6 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_10 and arg_119_1.time_ < var_122_5 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play322141029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322141029
		arg_123_1.duration_ = 2.17

		local var_123_0 = {
			zh = 2.166,
			ja = 2.133
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
				arg_123_0:Play322141030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_126_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_123_1.stage_.transform)

				var_126_0.name = "1284ui_story"
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["1284ui_story"] = var_126_0

				local var_126_1 = var_126_0:GetComponentInChildren(typeof(CharacterEffect))

				var_126_1.enabled = true

				local var_126_2 = GameObjectTools.GetOrAddComponent(var_126_0, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_1.transform, false)

				arg_123_1.var_["1284ui_story" .. "Animator"] = var_126_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_123_1.var_["1284ui_story" .. "LipSync"] = var_126_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_126_3 = arg_123_1.actors_["1284ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1284ui_story = var_126_3.localPosition

				arg_123_1:ShowWeapon(arg_123_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_3.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_123_1.time_ - 0) / var_126_4)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_3.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			local var_126_5 = arg_123_1.actors_["1284ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect1284ui_story == nil then
				arg_123_1.var_.characterEffect1284ui_story = var_126_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.characterEffect1284ui_story and not isNil(var_126_5) then
					arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect1284ui_story then
				arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_8 = 0
			local var_126_9 = 0.25

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
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

				local var_126_10 = arg_123_1:GetWordFromCfg(322141029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 8 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 8)

				if (8 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 8)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141029", "story_v_out_322141.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_322141", "322141029", "story_v_out_322141.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_322141", "322141029", "story_v_out_322141.awb")

						arg_123_1:RecordAudio("322141029", var_126_15)
						arg_123_1:RecordAudio("322141029", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_322141", "322141029", "story_v_out_322141.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_322141", "322141029", "story_v_out_322141.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play322141030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322141030
		arg_127_1.duration_ = 4.7

		local var_127_0 = {
			zh = 4.2,
			ja = 4.7
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
				arg_127_0:Play322141031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_130_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_127_1.stage_.transform)

				var_130_0.name = "404001ui_story"
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["404001ui_story"] = var_130_0

				local var_130_1 = var_130_0:GetComponentInChildren(typeof(CharacterEffect))

				var_130_1.enabled = true

				local var_130_2 = GameObjectTools.GetOrAddComponent(var_130_0, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_1.transform, false)

				arg_127_1.var_["404001ui_story" .. "Animator"] = var_130_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_127_1.var_["404001ui_story" .. "LipSync"] = var_130_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_3 = arg_127_1.actors_["404001ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos404001ui_story = var_130_3.localPosition
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_3.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_127_1.time_ - 0) / var_130_4)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_3.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			local var_130_5 = arg_127_1.actors_["404001ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect404001ui_story == nil then
				arg_127_1.var_.characterEffect404001ui_story = var_130_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.characterEffect404001ui_story and not isNil(var_130_5) then
					arg_127_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect404001ui_story then
				arg_127_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_130_8 = arg_127_1.actors_["1284ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.characterEffect1284ui_story == nil then
				arg_127_1.var_.characterEffect1284ui_story = var_130_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_9 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_9 and not isNil(var_130_8) then
				if arg_127_1.var_.characterEffect1284ui_story and not isNil(var_130_8) then
					arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_9)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.characterEffect1284ui_story then
				arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_130_10 = 0
			local var_130_11 = 0.45

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_12 = arg_127_1:GetWordFromCfg(322141030)
				local var_130_13 = arg_127_1:FormatText(var_130_12.content)

				arg_127_1.text_.text = var_130_13

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_15 = 18 <= 0 and var_130_11 or var_130_11 * (utf8.len(var_130_13) / 18)

				if (18 <= 0 and var_130_11 or var_130_11 * (utf8.len(var_130_13) / 18)) > 0 and var_130_11 < var_130_15 then
					arg_127_1.talkMaxDuration = var_130_15

					if var_130_15 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_15 + var_130_10
					end
				end

				arg_127_1.text_.text = var_130_13
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141030", "story_v_out_322141.awb") ~= 0 then
					local var_130_16 = manager.audio:GetVoiceLength("story_v_out_322141", "322141030", "story_v_out_322141.awb") / 1000

					if var_130_16 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_10
					end

					if var_130_12.prefab_name ~= "" and arg_127_1.actors_[var_130_12.prefab_name] ~= nil then
						local var_130_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_12.prefab_name].transform, "story_v_out_322141", "322141030", "story_v_out_322141.awb")

						arg_127_1:RecordAudio("322141030", var_130_17)
						arg_127_1:RecordAudio("322141030", var_130_17)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322141", "322141030", "story_v_out_322141.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322141", "322141030", "story_v_out_322141.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_18 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_18 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_10) / var_130_18

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_10 + var_130_18 and arg_127_1.time_ < var_130_10 + var_130_18 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play322141031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322141031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322141032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos404001ui_story = arg_131_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).z)
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles = arg_131_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).z)
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles = arg_131_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1284ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1284ui_story = var_134_1.localPosition
			end

			local var_134_2 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 then
				var_134_1.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_2)
				var_134_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_1.position).x, (manager.ui.mainCamera.transform.position - var_134_1.position).y, (manager.ui.mainCamera.transform.position - var_134_1.position).z)
				var_134_1.localEulerAngles.z = 0
				var_134_1.localEulerAngles.x = 0
				var_134_1.localEulerAngles = var_134_1.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 then
				var_134_1.localPosition = Vector3.New(0, 100, 0)
				var_134_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_1.position).x, (manager.ui.mainCamera.transform.position - var_134_1.position).y, (manager.ui.mainCamera.transform.position - var_134_1.position).z)
				var_134_1.localEulerAngles.z = 0
				var_134_1.localEulerAngles.x = 0
				var_134_1.localEulerAngles = var_134_1.localEulerAngles
			end

			local var_134_3 = 0
			local var_134_4 = 1.2

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_5 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(322141031).content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 49 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 49)

				if (49 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 49)) > 0 and var_134_4 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_3 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_3
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_4, arg_131_1.talkMaxDuration)

			if var_134_3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_3 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_3) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_3 + var_134_8 and arg_131_1.time_ < var_134_3 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play322141032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322141032
		arg_135_1.duration_ = 4.17

		local var_135_0 = {
			zh = 4.166,
			ja = 3.9
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
			arg_135_1.auto_ = false
		end

		function arg_135_1.playNext_(arg_137_0)
			arg_135_1.onStoryFinished_()
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1044ui_story = arg_135_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1044ui_story"].transform.position).z)
				arg_135_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1044ui_story"].transform.localEulerAngles = arg_135_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_135_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1044ui_story"].transform.position).z)
				arg_135_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1044ui_story"].transform.localEulerAngles = arg_135_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1044ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1044ui_story == nil then
				arg_135_1.var_.characterEffect1044ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1044ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1044ui_story then
				arg_135_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			local var_138_4 = 0
			local var_138_5 = 0.3

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(322141032)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 12 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 12)

				if (12 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 12)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141032", "story_v_out_322141.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_322141", "322141032", "story_v_out_322141.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_322141", "322141032", "story_v_out_322141.awb")

						arg_135_1:RecordAudio("322141032", var_138_11)
						arg_135_1:RecordAudio("322141032", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322141", "322141032", "story_v_out_322141.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322141", "322141032", "story_v_out_322141.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L19i"
	},
	voices = {
		"story_v_out_322141.awb"
	}
}
