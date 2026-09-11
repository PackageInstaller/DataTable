return {
	Play325062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325062001
		arg_1_1.duration_ = 5.27

		local var_1_0 = {
			zh = 3.89933333631357,
			ja = 5.26633333631356
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
				arg_1_0:Play325062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J11 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J11")
				var_4_0.name = "J11"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J11 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J11

				arg_1_1.bgs_.J11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J11" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1077ui_story"

			if arg_1_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1077ui_story"].transform

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1077ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_1_1.time_ - 1.63333333333333) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_15 and arg_1_1.time_ < 1.63333333333333 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["1077ui_story"]

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story == nil then
				arg_1_1.var_.characterEffect1077ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect1077ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_18 and arg_1_1.time_ < 1.63333333333333 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story then
				arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_loop_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 1.83333333631357
			local var_4_25 = 0.225

			if 1.83333333631357 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(325062001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 9 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 9)

				if (9 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 9)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062001", "story_v_out_325062.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_325062", "325062001", "story_v_out_325062.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_325062", "325062001", "story_v_out_325062.awb")

						arg_1_1:RecordAudio("325062001", var_4_32)
						arg_1_1:RecordAudio("325062001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325062", "325062001", "story_v_out_325062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325062", "325062001", "story_v_out_325062.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325062002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325062002
		arg_8_1.duration_ = 3.67

		local var_8_0 = {
			zh = 3.566,
			ja = 3.666
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
				arg_8_0:Play325062003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1077ui_story = arg_8_1.actors_["1077ui_story"].transform.localPosition

				local var_11_0 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_0 then
					var_11_0:EnableDynamicBone(false)
				end
			end

			local var_11_1 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_1 then
				arg_8_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_8_1.time_ - 0) / var_11_1)
				arg_8_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).z)
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles = arg_8_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				arg_8_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).z)
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles = arg_8_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_11_2 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(true)
				end
			end

			local var_11_3 = "1061ui_story"

			if arg_8_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_11_4 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_8_1.stage_.transform)

				var_11_4.name = var_11_3
				var_11_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_3] = var_11_4

				local var_11_5 = var_11_4:GetComponentInChildren(typeof(CharacterEffect))

				var_11_5.enabled = true

				local var_11_6 = GameObjectTools.GetOrAddComponent(var_11_4, typeof(DynamicBoneHelper))

				if var_11_6 then
					var_11_6:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_5.transform, false)

				arg_8_1.var_[var_11_3 .. "Animator"] = var_11_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_3 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_3 .. "LipSync"] = var_11_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_7 = arg_8_1.actors_["1061ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1061ui_story = var_11_7.localPosition
			end

			local var_11_8 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 then
				var_11_7.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_8_1.time_ - 0) / var_11_8)
				var_11_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_7.position).x, (manager.ui.mainCamera.transform.position - var_11_7.position).y, (manager.ui.mainCamera.transform.position - var_11_7.position).z)
				var_11_7.localEulerAngles.z = 0
				var_11_7.localEulerAngles.x = 0
				var_11_7.localEulerAngles = var_11_7.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 then
				var_11_7.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_11_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_7.position).x, (manager.ui.mainCamera.transform.position - var_11_7.position).y, (manager.ui.mainCamera.transform.position - var_11_7.position).z)
				var_11_7.localEulerAngles.z = 0
				var_11_7.localEulerAngles.x = 0
				var_11_7.localEulerAngles = var_11_7.localEulerAngles
			end

			local var_11_9 = arg_8_1.actors_["1061ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1061ui_story == nil then
				arg_8_1.var_.characterEffect1061ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_10 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 and not isNil(var_11_9) then
				if arg_8_1.var_.characterEffect1061ui_story and not isNil(var_11_9) then
					arg_8_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1061ui_story then
				arg_8_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_11_12 = arg_8_1.actors_["1077ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.characterEffect1077ui_story == nil then
				arg_8_1.var_.characterEffect1077ui_story = var_11_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_13 and not isNil(var_11_12) then
				if arg_8_1.var_.characterEffect1077ui_story and not isNil(var_11_12) then
					arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_13)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_13 and arg_8_1.time_ < 0 + var_11_13 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.characterEffect1077ui_story then
				arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_14 = 0
			local var_11_15 = 0.25

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_16 = arg_8_1:GetWordFromCfg(325062002)
				local var_11_17 = arg_8_1:FormatText(var_11_16.content)

				arg_8_1.text_.text = var_11_17

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 10 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 10)

				if (10 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 10)) > 0 and var_11_15 < var_11_19 then
					arg_8_1.talkMaxDuration = var_11_19

					if var_11_19 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_19 + var_11_14
					end
				end

				arg_8_1.text_.text = var_11_17
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062002", "story_v_out_325062.awb") ~= 0 then
					local var_11_20 = manager.audio:GetVoiceLength("story_v_out_325062", "325062002", "story_v_out_325062.awb") / 1000

					if var_11_20 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_14
					end

					if var_11_16.prefab_name ~= "" and arg_8_1.actors_[var_11_16.prefab_name] ~= nil then
						local var_11_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_16.prefab_name].transform, "story_v_out_325062", "325062002", "story_v_out_325062.awb")

						arg_8_1:RecordAudio("325062002", var_11_21)
						arg_8_1:RecordAudio("325062002", var_11_21)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325062", "325062002", "story_v_out_325062.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325062", "325062002", "story_v_out_325062.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_22 = math.max(var_11_15, arg_8_1.talkMaxDuration)

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_14) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_14 + var_11_22 and arg_8_1.time_ < var_11_14 + var_11_22 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_8_1:InitPlayNodeList()
	end,
	Play325062003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325062003
		arg_12_1.duration_ = 10.07

		local var_12_0 = {
			zh = 7.4,
			ja = 10.066
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
				arg_12_0:Play325062004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1077ui_story"]) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = arg_12_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1077ui_story"]) then
				if arg_12_1.var_.characterEffect1077ui_story and not isNil(arg_12_1.actors_["1077ui_story"]) then
					arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1077ui_story"]) and arg_12_1.var_.characterEffect1077ui_story then
				arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["1061ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1061ui_story == nil then
				arg_12_1.var_.characterEffect1061ui_story = var_15_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_3 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.characterEffect1061ui_story and not isNil(var_15_2) then
					arg_12_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_3)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1061ui_story then
				arg_12_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			local var_15_4 = 0
			local var_15_5 = 0.975

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_6 = arg_12_1:GetWordFromCfg(325062003)
				local var_15_7 = arg_12_1:FormatText(var_15_6.content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 39 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 39)

				if (39 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 39)) > 0 and var_15_5 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062003", "story_v_out_325062.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062003", "story_v_out_325062.awb") / 1000

					if var_15_10 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_4
					end

					if var_15_6.prefab_name ~= "" and arg_12_1.actors_[var_15_6.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_6.prefab_name].transform, "story_v_out_325062", "325062003", "story_v_out_325062.awb")

						arg_12_1:RecordAudio("325062003", var_15_11)
						arg_12_1:RecordAudio("325062003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325062", "325062003", "story_v_out_325062.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325062", "325062003", "story_v_out_325062.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_12 = math.max(var_15_5, arg_12_1.talkMaxDuration)

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_12 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_4) / var_15_12

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_4 + var_15_12 and arg_12_1.time_ < var_15_4 + var_15_12 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325062004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325062004
		arg_16_1.duration_ = 5.43

		local var_16_0 = {
			zh = 1.833,
			ja = 5.433
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
				arg_16_0:Play325062005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1061ui_story"]) and arg_16_1.var_.characterEffect1061ui_story == nil then
				arg_16_1.var_.characterEffect1061ui_story = arg_16_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1061ui_story"]) then
				if arg_16_1.var_.characterEffect1061ui_story and not isNil(arg_16_1.actors_["1061ui_story"]) then
					arg_16_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1061ui_story"]) and arg_16_1.var_.characterEffect1061ui_story then
				arg_16_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_19_2 = arg_16_1.actors_["1077ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_3 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_2) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_3)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_19_4 = 0
			local var_19_5 = 0.2

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(325062004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 8 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 8)

				if (8 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 8)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062004", "story_v_out_325062.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062004", "story_v_out_325062.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_325062", "325062004", "story_v_out_325062.awb")

						arg_16_1:RecordAudio("325062004", var_19_11)
						arg_16_1:RecordAudio("325062004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325062", "325062004", "story_v_out_325062.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325062", "325062004", "story_v_out_325062.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325062005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325062005
		arg_20_1.duration_ = 5.73

		local var_20_0 = {
			zh = 5.733,
			ja = 5.7
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
				arg_20_0:Play325062006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1077ui_story"]) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = arg_20_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1077ui_story"]) then
				if arg_20_1.var_.characterEffect1077ui_story and not isNil(arg_20_1.actors_["1077ui_story"]) then
					arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1077ui_story"]) and arg_20_1.var_.characterEffect1077ui_story then
				arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1061ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1061ui_story == nil then
				arg_20_1.var_.characterEffect1061ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1061ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1061ui_story then
				arg_20_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_4 = 0
			local var_23_5 = 0.75

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(325062005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 30 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 30)

				if (30 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 30)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062005", "story_v_out_325062.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062005", "story_v_out_325062.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_325062", "325062005", "story_v_out_325062.awb")

						arg_20_1:RecordAudio("325062005", var_23_11)
						arg_20_1:RecordAudio("325062005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325062", "325062005", "story_v_out_325062.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325062", "325062005", "story_v_out_325062.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325062006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325062006
		arg_24_1.duration_ = 7.07

		local var_24_0 = {
			zh = 5.4,
			ja = 7.066
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
				arg_24_0:Play325062007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1061ui_story"]) and arg_24_1.var_.characterEffect1061ui_story == nil then
				arg_24_1.var_.characterEffect1061ui_story = arg_24_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1061ui_story"]) then
				if arg_24_1.var_.characterEffect1061ui_story and not isNil(arg_24_1.actors_["1061ui_story"]) then
					arg_24_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1061ui_story"]) and arg_24_1.var_.characterEffect1061ui_story then
				arg_24_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1077ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1077ui_story == nil then
				arg_24_1.var_.characterEffect1077ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1077ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1077ui_story then
				arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_4 = 0
			local var_27_5 = 0.575

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(325062006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 23 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 23)

				if (23 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 23)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062006", "story_v_out_325062.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062006", "story_v_out_325062.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_325062", "325062006", "story_v_out_325062.awb")

						arg_24_1:RecordAudio("325062006", var_27_11)
						arg_24_1:RecordAudio("325062006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325062", "325062006", "story_v_out_325062.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325062", "325062006", "story_v_out_325062.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325062007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325062007
		arg_28_1.duration_ = 7.07

		local var_28_0 = {
			zh = 6.13266666666667,
			ja = 7.06666666666667
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
				arg_28_0:Play325062008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.bgs_.J03h == nil then
				local var_31_0 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03h")
				var_31_0.name = "J03h"
				var_31_0.transform.parent = arg_28_1.stage_.transform
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_.J03h = var_31_0
			end

			if 1.63333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.63333333333333 + arg_31_0 then
				local var_31_1 = arg_28_1.bgs_.J03h

				arg_28_1.bgs_.J03h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_2 = var_31_1:GetComponent("SpriteRenderer")

				if var_31_2 and var_31_2.sprite then
					local var_31_3 = 2 * (var_31_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_1.transform.localScale = Vector3.New(var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "J03h" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_4 = 1.63333333333333

			if 1.63333333333333 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_4 + 0.3 and arg_28_1.time_ < var_31_4 + 0.3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_5 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_6 = 1.63333333333333

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 then
				local var_31_7 = Color.New(0, 0, 0)

				var_31_7.a = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_5) / var_31_6)
				arg_28_1.mask_.color = var_31_7
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 then
				local var_31_8 = Color.New(0, 0, 0)

				var_31_8.a = 1
				arg_28_1.mask_.color = var_31_8
			end

			local var_31_9 = 1.63333333333333

			if 1.63333333333333 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_10 = 2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 then
				local var_31_11 = Color.New(0, 0, 0)

				var_31_11.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_9) / var_31_10)
				arg_28_1.mask_.color = var_31_11
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 then
				local var_31_12 = Color.New(0, 0, 0)

				arg_28_1.mask_.enabled = false
				var_31_12.a = 0
				arg_28_1.mask_.color = var_31_12
			end

			local var_31_13 = arg_28_1.actors_["1077ui_story"]

			if 1.63333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.63333333333333 + arg_31_0 and not isNil(var_31_13) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_14 = 0.200000002980232

			if 1.63333333333333 <= arg_28_1.time_ and arg_28_1.time_ < 1.63333333333333 + var_31_14 and not isNil(var_31_13) then
				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_13) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 1.63333333333333 + var_31_14 and arg_28_1.time_ < 1.63333333333333 + var_31_14 + arg_31_0 and not isNil(var_31_13) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_31_16 = arg_28_1.actors_["1061ui_story"]

			if 1.63333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.63333333333333 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1061ui_story == nil then
				arg_28_1.var_.characterEffect1061ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_17 = 0.200000002980232

			if 1.63333333333333 <= arg_28_1.time_ and arg_28_1.time_ < 1.63333333333333 + var_31_17 and not isNil(var_31_16) then
				if arg_28_1.var_.characterEffect1061ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 1.63333333333333) / var_31_17)
				end
			end

			if arg_28_1.time_ >= 1.63333333333333 + var_31_17 and arg_28_1.time_ < 1.63333333333333 + var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1061ui_story then
				arg_28_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_31_18 = arg_28_1.actors_["1061ui_story"].transform

			if 1.63333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.63333333333333 + arg_31_0 then
				arg_28_1.var_.moveOldPos1061ui_story = var_31_18.localPosition
			end

			local var_31_19 = 0.001

			if 1.63333333333333 <= arg_28_1.time_ and arg_28_1.time_ < 1.63333333333333 + var_31_19 then
				var_31_18.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 1.63333333333333) / var_31_19)
				var_31_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_18.position).x, (manager.ui.mainCamera.transform.position - var_31_18.position).y, (manager.ui.mainCamera.transform.position - var_31_18.position).z)
				var_31_18.localEulerAngles.z = 0
				var_31_18.localEulerAngles.x = 0
				var_31_18.localEulerAngles = var_31_18.localEulerAngles
			end

			if arg_28_1.time_ >= 1.63333333333333 + var_31_19 and arg_28_1.time_ < 1.63333333333333 + var_31_19 + arg_31_0 then
				var_31_18.localPosition = Vector3.New(0, 100, 0)
				var_31_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_18.position).x, (manager.ui.mainCamera.transform.position - var_31_18.position).y, (manager.ui.mainCamera.transform.position - var_31_18.position).z)
				var_31_18.localEulerAngles.z = 0
				var_31_18.localEulerAngles.x = 0
				var_31_18.localEulerAngles = var_31_18.localEulerAngles
			end

			local var_31_20 = arg_28_1.actors_["1077ui_story"].transform

			if 1.63333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.63333333333333 + arg_31_0 then
				arg_28_1.var_.moveOldPos1077ui_story = var_31_20.localPosition

				local var_31_21 = GameObjectTools.GetOrAddComponent(var_31_20.gameObject, typeof(DynamicBoneHelper))

				if var_31_21 then
					var_31_21:EnableDynamicBone(false)
				end
			end

			local var_31_22 = 0.001

			if 1.63333333333333 <= arg_28_1.time_ and arg_28_1.time_ < 1.63333333333333 + var_31_22 then
				var_31_20.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 1.63333333333333) / var_31_22)
				var_31_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_20.position).x, (manager.ui.mainCamera.transform.position - var_31_20.position).y, (manager.ui.mainCamera.transform.position - var_31_20.position).z)
				var_31_20.localEulerAngles.z = 0
				var_31_20.localEulerAngles.x = 0
				var_31_20.localEulerAngles = var_31_20.localEulerAngles
			end

			if arg_28_1.time_ >= 1.63333333333333 + var_31_22 and arg_28_1.time_ < 1.63333333333333 + var_31_22 + arg_31_0 then
				var_31_20.localPosition = Vector3.New(0, 100, 0)
				var_31_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_20.position).x, (manager.ui.mainCamera.transform.position - var_31_20.position).y, (manager.ui.mainCamera.transform.position - var_31_20.position).z)
				var_31_20.localEulerAngles.z = 0
				var_31_20.localEulerAngles.x = 0
				var_31_20.localEulerAngles = var_31_20.localEulerAngles

				local var_31_23 = GameObjectTools.GetOrAddComponent(var_31_20.gameObject, typeof(DynamicBoneHelper))

				if var_31_23 then
					var_31_23:EnableDynamicBone(true)
				end
			end

			if 1.2 < arg_28_1.time_ and arg_28_1.time_ <= 1.2 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_151", "se_story_151_amb_rock", "")
			end

			if 0.1 < arg_28_1.time_ and arg_28_1.time_ <= 0.1 + arg_31_0 then
				arg_28_1:AudioAction("stop", "effect", "se_story_1210", "se_story_1210_loop_wind", "")
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_26 = 3.16666666666667
			local var_31_27 = 0.225

			if 3.16666666666667 < arg_28_1.time_ and arg_28_1.time_ <= var_31_26 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_28 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_28:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_29 = arg_28_1:GetWordFromCfg(325062007)
				local var_31_30 = arg_28_1:FormatText(var_31_29.content)

				arg_28_1.text_.text = var_31_30

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_32 = 9 <= 0 and var_31_27 or var_31_27 * (utf8.len(var_31_30) / 9)

				if (9 <= 0 and var_31_27 or var_31_27 * (utf8.len(var_31_30) / 9)) > 0 and var_31_27 < var_31_32 then
					arg_28_1.talkMaxDuration = var_31_32
					var_31_26 = var_31_26 + 0.3

					if var_31_32 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_32 + var_31_26
					end
				end

				arg_28_1.text_.text = var_31_30
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062007", "story_v_out_325062.awb") ~= 0 then
					local var_31_33 = manager.audio:GetVoiceLength("story_v_out_325062", "325062007", "story_v_out_325062.awb") / 1000

					if var_31_33 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_33 + var_31_26
					end

					if var_31_29.prefab_name ~= "" and arg_28_1.actors_[var_31_29.prefab_name] ~= nil then
						local var_31_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_29.prefab_name].transform, "story_v_out_325062", "325062007", "story_v_out_325062.awb")

						arg_28_1:RecordAudio("325062007", var_31_34)
						arg_28_1:RecordAudio("325062007", var_31_34)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325062", "325062007", "story_v_out_325062.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325062", "325062007", "story_v_out_325062.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_35 = var_31_26 + 0.3
			local var_31_36 = math.max(var_31_27, arg_28_1.talkMaxDuration)

			if var_31_26 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_36 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_35) / var_31_36

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_35 + var_31_36 and arg_28_1.time_ < var_31_35 + var_31_36 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325062008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325062008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play325062009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1077ui_story = arg_34_1.actors_["1077ui_story"].transform.localPosition

				local var_37_0 = GameObjectTools.GetOrAddComponent(arg_34_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_37_0 then
					var_37_0:EnableDynamicBone(false)
				end
			end

			local var_37_1 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_1 then
				arg_34_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_1)
				arg_34_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).z)
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles = arg_34_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_1 and arg_34_1.time_ < 0 + var_37_1 + arg_37_0 then
				arg_34_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).z)
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles = arg_34_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_37_2 = GameObjectTools.GetOrAddComponent(arg_34_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_37_2 then
					var_37_2:EnableDynamicBone(true)
				end
			end

			local var_37_3 = arg_34_1.actors_["1061ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1061ui_story = var_37_3.localPosition
			end

			local var_37_4 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_3.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_4)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_3.localPosition = Vector3.New(0, 100, 0)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			local var_37_5 = arg_34_1.actors_["1077ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1077ui_story == nil then
				arg_34_1.var_.characterEffect1077ui_story = var_37_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_6 and not isNil(var_37_5) then
				if arg_34_1.var_.characterEffect1077ui_story and not isNil(var_37_5) then
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_6)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_6 and arg_34_1.time_ < 0 + var_37_6 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_37_7 = 0
			local var_37_8 = 1.025

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_7 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_9 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(325062008).content)

				arg_34_1.text_.text = var_37_9

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 41 <= 0 and var_37_8 or var_37_8 * (utf8.len(var_37_9) / 41)

				if (41 <= 0 and var_37_8 or var_37_8 * (utf8.len(var_37_9) / 41)) > 0 and var_37_8 < var_37_11 then
					arg_34_1.talkMaxDuration = var_37_11

					if var_37_11 + var_37_7 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_7
					end
				end

				arg_34_1.text_.text = var_37_9
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_8, arg_34_1.talkMaxDuration)

			if var_37_7 <= arg_34_1.time_ and arg_34_1.time_ < var_37_7 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_7) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_7 + var_37_12 and arg_34_1.time_ < var_37_7 + var_37_12 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_34_1:InitPlayNodeList()
	end,
	Play325062009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325062009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play325062010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 1.25

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(325062009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 50 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 50)

				if (50 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 50)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play325062010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325062010
		arg_42_1.duration_ = 15.57

		local var_42_0 = {
			zh = 8.9,
			ja = 15.566
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325062011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1061ui_story = arg_42_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_45_0 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				arg_42_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_42_1.time_ - 0) / var_45_0)
				arg_42_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1061ui_story"].transform.position).z)
				arg_42_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1061ui_story"].transform.localEulerAngles = arg_42_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				arg_42_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_42_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1061ui_story"].transform.position).z)
				arg_42_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1061ui_story"].transform.localEulerAngles = arg_42_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_45_1 = arg_42_1.actors_["1061ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1061ui_story == nil then
				arg_42_1.var_.characterEffect1061ui_story = var_45_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_2 and not isNil(var_45_1) then
				if arg_42_1.var_.characterEffect1061ui_story and not isNil(var_45_1) then
					arg_42_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_2 and arg_42_1.time_ < 0 + var_45_2 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1061ui_story then
				arg_42_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_45_4 = 0
			local var_45_5 = 1.025

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_6 = arg_42_1:GetWordFromCfg(325062010)
				local var_45_7 = arg_42_1:FormatText(var_45_6.content)

				arg_42_1.text_.text = var_45_7

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_9 = 41 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 41)

				if (41 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 41)) > 0 and var_45_5 < var_45_9 then
					arg_42_1.talkMaxDuration = var_45_9

					if var_45_9 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_7
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062010", "story_v_out_325062.awb") ~= 0 then
					local var_45_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062010", "story_v_out_325062.awb") / 1000

					if var_45_10 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_4
					end

					if var_45_6.prefab_name ~= "" and arg_42_1.actors_[var_45_6.prefab_name] ~= nil then
						local var_45_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_6.prefab_name].transform, "story_v_out_325062", "325062010", "story_v_out_325062.awb")

						arg_42_1:RecordAudio("325062010", var_45_11)
						arg_42_1:RecordAudio("325062010", var_45_11)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_325062", "325062010", "story_v_out_325062.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_325062", "325062010", "story_v_out_325062.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_12 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_12 and arg_42_1.time_ < var_45_4 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play325062011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325062011
		arg_46_1.duration_ = 14.57

		local var_46_0 = {
			zh = 12.533,
			ja = 14.566
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325062012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 1.4

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(325062011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 56 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 56)

				if (56 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 56)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062011", "story_v_out_325062.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062011", "story_v_out_325062.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_325062", "325062011", "story_v_out_325062.awb")

						arg_46_1:RecordAudio("325062011", var_49_6)
						arg_46_1:RecordAudio("325062011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325062", "325062011", "story_v_out_325062.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325062", "325062011", "story_v_out_325062.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play325062012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325062012
		arg_50_1.duration_ = 10.9

		local var_50_0 = {
			zh = 4.3,
			ja = 10.9
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325062013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.425

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:GetWordFromCfg(325062012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 17 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 17)

				if (17 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 17)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062012", "story_v_out_325062.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062012", "story_v_out_325062.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_325062", "325062012", "story_v_out_325062.awb")

						arg_50_1:RecordAudio("325062012", var_53_6)
						arg_50_1:RecordAudio("325062012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325062", "325062012", "story_v_out_325062.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325062", "325062012", "story_v_out_325062.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325062013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325062013
		arg_54_1.duration_ = 4.4

		local var_54_0 = {
			zh = 3.166,
			ja = 4.4
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325062014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1061ui_story = arg_54_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).z)
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles = arg_54_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_54_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).z)
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles = arg_54_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["1077ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1077ui_story = var_57_1.localPosition

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_1.gameObject, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end
			end

			local var_57_3 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 then
				var_57_1.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_54_1.time_ - 0) / var_57_3)
				var_57_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_1.position).x, (manager.ui.mainCamera.transform.position - var_57_1.position).y, (manager.ui.mainCamera.transform.position - var_57_1.position).z)
				var_57_1.localEulerAngles.z = 0
				var_57_1.localEulerAngles.x = 0
				var_57_1.localEulerAngles = var_57_1.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 then
				var_57_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_57_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_1.position).x, (manager.ui.mainCamera.transform.position - var_57_1.position).y, (manager.ui.mainCamera.transform.position - var_57_1.position).z)
				var_57_1.localEulerAngles.z = 0
				var_57_1.localEulerAngles.x = 0
				var_57_1.localEulerAngles = var_57_1.localEulerAngles

				local var_57_4 = GameObjectTools.GetOrAddComponent(var_57_1.gameObject, typeof(DynamicBoneHelper))

				if var_57_4 then
					var_57_4:EnableDynamicBone(true)
				end
			end

			local var_57_5 = arg_54_1.actors_["1077ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect1077ui_story == nil then
				arg_54_1.var_.characterEffect1077ui_story = var_57_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_6 and not isNil(var_57_5) then
				if arg_54_1.var_.characterEffect1077ui_story and not isNil(var_57_5) then
					arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_6 and arg_54_1.time_ < 0 + var_57_6 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect1077ui_story then
				arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_57_8 = arg_54_1.actors_["1061ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.characterEffect1061ui_story == nil then
				arg_54_1.var_.characterEffect1061ui_story = var_57_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_9 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_9 and not isNil(var_57_8) then
				if arg_54_1.var_.characterEffect1061ui_story and not isNil(var_57_8) then
					arg_54_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_9)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_9 and arg_54_1.time_ < 0 + var_57_9 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.characterEffect1061ui_story then
				arg_54_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_57_10 = 0
			local var_57_11 = 0.5

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_12 = arg_54_1:GetWordFromCfg(325062013)
				local var_57_13 = arg_54_1:FormatText(var_57_12.content)

				arg_54_1.text_.text = var_57_13

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_15 = 20 <= 0 and var_57_11 or var_57_11 * (utf8.len(var_57_13) / 20)

				if (20 <= 0 and var_57_11 or var_57_11 * (utf8.len(var_57_13) / 20)) > 0 and var_57_11 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_10
					end
				end

				arg_54_1.text_.text = var_57_13
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062013", "story_v_out_325062.awb") ~= 0 then
					local var_57_16 = manager.audio:GetVoiceLength("story_v_out_325062", "325062013", "story_v_out_325062.awb") / 1000

					if var_57_16 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_16 + var_57_10
					end

					if var_57_12.prefab_name ~= "" and arg_54_1.actors_[var_57_12.prefab_name] ~= nil then
						local var_57_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_12.prefab_name].transform, "story_v_out_325062", "325062013", "story_v_out_325062.awb")

						arg_54_1:RecordAudio("325062013", var_57_17)
						arg_54_1:RecordAudio("325062013", var_57_17)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325062", "325062013", "story_v_out_325062.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325062", "325062013", "story_v_out_325062.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_18 = math.max(var_57_11, arg_54_1.talkMaxDuration)

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_18 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_10) / var_57_18

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_10 + var_57_18 and arg_54_1.time_ < var_57_10 + var_57_18 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play325062014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325062014
		arg_58_1.duration_ = 4.37

		local var_58_0 = {
			zh = 4.1,
			ja = 4.366
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325062015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1061ui_story"]) and arg_58_1.var_.characterEffect1061ui_story == nil then
				arg_58_1.var_.characterEffect1061ui_story = arg_58_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1061ui_story"]) then
				if arg_58_1.var_.characterEffect1061ui_story and not isNil(arg_58_1.actors_["1061ui_story"]) then
					arg_58_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1061ui_story"]) and arg_58_1.var_.characterEffect1061ui_story then
				arg_58_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_61_2 = arg_58_1.actors_["1077ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1077ui_story == nil then
				arg_58_1.var_.characterEffect1077ui_story = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.characterEffect1077ui_story and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_3)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1077ui_story then
				arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_61_4 = 0
			local var_61_5 = 0.4

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_6 = arg_58_1:GetWordFromCfg(325062014)
				local var_61_7 = arg_58_1:FormatText(var_61_6.content)

				arg_58_1.text_.text = var_61_7

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 16 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 16)

				if (16 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 16)) > 0 and var_61_5 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_7
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062014", "story_v_out_325062.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062014", "story_v_out_325062.awb") / 1000

					if var_61_10 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_4
					end

					if var_61_6.prefab_name ~= "" and arg_58_1.actors_[var_61_6.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_6.prefab_name].transform, "story_v_out_325062", "325062014", "story_v_out_325062.awb")

						arg_58_1:RecordAudio("325062014", var_61_11)
						arg_58_1:RecordAudio("325062014", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325062", "325062014", "story_v_out_325062.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325062", "325062014", "story_v_out_325062.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_12 and arg_58_1.time_ < var_61_4 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325062015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325062015
		arg_62_1.duration_ = 3.73

		local var_62_0 = {
			zh = 3.733,
			ja = 2.7
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325062016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = arg_62_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) then
				if arg_62_1.var_.characterEffect1077ui_story and not isNil(arg_62_1.actors_["1077ui_story"]) then
					arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) and arg_62_1.var_.characterEffect1077ui_story then
				arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["1061ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1061ui_story == nil then
				arg_62_1.var_.characterEffect1061ui_story = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_3 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.characterEffect1061ui_story and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_3)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1061ui_story then
				arg_62_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_65_4 = 0
			local var_65_5 = 0.325

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(325062015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 13 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 13)

				if (13 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 13)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062015", "story_v_out_325062.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062015", "story_v_out_325062.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_out_325062", "325062015", "story_v_out_325062.awb")

						arg_62_1:RecordAudio("325062015", var_65_11)
						arg_62_1:RecordAudio("325062015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325062", "325062015", "story_v_out_325062.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325062", "325062015", "story_v_out_325062.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_12 and arg_62_1.time_ < var_65_4 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325062016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325062016
		arg_66_1.duration_ = 14.17

		local var_66_0 = {
			zh = 10.133,
			ja = 14.166
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325062017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1061ui_story"]) and arg_66_1.var_.characterEffect1061ui_story == nil then
				arg_66_1.var_.characterEffect1061ui_story = arg_66_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1061ui_story"]) then
				if arg_66_1.var_.characterEffect1061ui_story and not isNil(arg_66_1.actors_["1061ui_story"]) then
					arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1061ui_story"]) and arg_66_1.var_.characterEffect1061ui_story then
				arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["1077ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_3 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_2) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_3)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_69_4 = 0
			local var_69_5 = 1.05

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(325062016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 42 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 42)

				if (42 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 42)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062016", "story_v_out_325062.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062016", "story_v_out_325062.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_325062", "325062016", "story_v_out_325062.awb")

						arg_66_1:RecordAudio("325062016", var_69_11)
						arg_66_1:RecordAudio("325062016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325062", "325062016", "story_v_out_325062.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325062", "325062016", "story_v_out_325062.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325062017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325062017
		arg_70_1.duration_ = 8.53

		local var_70_0 = {
			zh = 7.7,
			ja = 8.533
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play325062018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1077ui_story"]) and arg_70_1.var_.characterEffect1077ui_story == nil then
				arg_70_1.var_.characterEffect1077ui_story = arg_70_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1077ui_story"]) then
				if arg_70_1.var_.characterEffect1077ui_story and not isNil(arg_70_1.actors_["1077ui_story"]) then
					arg_70_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1077ui_story"]) and arg_70_1.var_.characterEffect1077ui_story then
				arg_70_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1061ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1061ui_story == nil then
				arg_70_1.var_.characterEffect1061ui_story = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect1061ui_story and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1061ui_story then
				arg_70_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_73_4 = 0
			local var_73_5 = 0.9

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(325062017)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 36 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 36)

				if (36 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 36)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062017", "story_v_out_325062.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062017", "story_v_out_325062.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_out_325062", "325062017", "story_v_out_325062.awb")

						arg_70_1:RecordAudio("325062017", var_73_11)
						arg_70_1:RecordAudio("325062017", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325062", "325062017", "story_v_out_325062.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325062", "325062017", "story_v_out_325062.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_12 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_12 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_12

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_12 and arg_70_1.time_ < var_73_4 + var_73_12 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325062018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325062018
		arg_74_1.duration_ = 3.4

		local var_74_0 = {
			zh = 3.233,
			ja = 3.4
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325062019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_77_0 = 0
			local var_77_1 = 0.425

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(325062018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 17 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 17)

				if (17 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 17)) > 0 and var_77_1 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062018", "story_v_out_325062.awb") ~= 0 then
					local var_77_6 = manager.audio:GetVoiceLength("story_v_out_325062", "325062018", "story_v_out_325062.awb") / 1000

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end

					if var_77_2.prefab_name ~= "" and arg_74_1.actors_[var_77_2.prefab_name] ~= nil then
						local var_77_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_2.prefab_name].transform, "story_v_out_325062", "325062018", "story_v_out_325062.awb")

						arg_74_1:RecordAudio("325062018", var_77_7)
						arg_74_1:RecordAudio("325062018", var_77_7)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325062", "325062018", "story_v_out_325062.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325062", "325062018", "story_v_out_325062.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325062019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325062019
		arg_78_1.duration_ = 6.03

		local var_78_0 = {
			zh = 6.033,
			ja = 3.366
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
				arg_78_0:Play325062020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1061ui_story"]) and arg_78_1.var_.characterEffect1061ui_story == nil then
				arg_78_1.var_.characterEffect1061ui_story = arg_78_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1061ui_story"]) then
				if arg_78_1.var_.characterEffect1061ui_story and not isNil(arg_78_1.actors_["1061ui_story"]) then
					arg_78_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1061ui_story"]) and arg_78_1.var_.characterEffect1061ui_story then
				arg_78_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["1077ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1077ui_story == nil then
				arg_78_1.var_.characterEffect1077ui_story = var_81_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.characterEffect1077ui_story and not isNil(var_81_2) then
					arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1077ui_story then
				arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action453")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_81_4 = 0
			local var_81_5 = 0.775

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
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

				local var_81_6 = arg_78_1:GetWordFromCfg(325062019)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 31 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 31)

				if (31 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 31)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062019", "story_v_out_325062.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062019", "story_v_out_325062.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_325062", "325062019", "story_v_out_325062.awb")

						arg_78_1:RecordAudio("325062019", var_81_11)
						arg_78_1:RecordAudio("325062019", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325062", "325062019", "story_v_out_325062.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325062", "325062019", "story_v_out_325062.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325062020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325062020
		arg_82_1.duration_ = 10.07

		local var_82_0 = {
			zh = 8.833,
			ja = 10.066
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
				arg_82_0:Play325062021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.875

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
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

				local var_85_1 = arg_82_1:GetWordFromCfg(325062020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 35 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 35)

				if (35 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 35)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062020", "story_v_out_325062.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062020", "story_v_out_325062.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_325062", "325062020", "story_v_out_325062.awb")

						arg_82_1:RecordAudio("325062020", var_85_6)
						arg_82_1:RecordAudio("325062020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325062", "325062020", "story_v_out_325062.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325062", "325062020", "story_v_out_325062.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325062021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325062021
		arg_86_1.duration_ = 6.27

		local var_86_0 = {
			zh = 5.7,
			ja = 6.266
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
				arg_86_0:Play325062022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.575

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(325062021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 23 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 23)

				if (23 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 23)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062021", "story_v_out_325062.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062021", "story_v_out_325062.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_325062", "325062021", "story_v_out_325062.awb")

						arg_86_1:RecordAudio("325062021", var_89_6)
						arg_86_1:RecordAudio("325062021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325062", "325062021", "story_v_out_325062.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325062", "325062021", "story_v_out_325062.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325062022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325062022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325062023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1061ui_story = arg_90_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_93_0 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 then
				arg_90_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_90_1.time_ - 0) / var_93_0)
				arg_90_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).z)
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles = arg_90_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 then
				arg_90_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1061ui_story"].transform.position).z)
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1061ui_story"].transform.localEulerAngles = arg_90_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_93_1 = arg_90_1.actors_["1077ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1077ui_story = var_93_1.localPosition

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_1.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end
			end

			local var_93_3 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 then
				var_93_1.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_90_1.time_ - 0) / var_93_3)
				var_93_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_1.position).x, (manager.ui.mainCamera.transform.position - var_93_1.position).y, (manager.ui.mainCamera.transform.position - var_93_1.position).z)
				var_93_1.localEulerAngles.z = 0
				var_93_1.localEulerAngles.x = 0
				var_93_1.localEulerAngles = var_93_1.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 then
				var_93_1.localPosition = Vector3.New(0, 100, 0)
				var_93_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_1.position).x, (manager.ui.mainCamera.transform.position - var_93_1.position).y, (manager.ui.mainCamera.transform.position - var_93_1.position).z)
				var_93_1.localEulerAngles.z = 0
				var_93_1.localEulerAngles.x = 0
				var_93_1.localEulerAngles = var_93_1.localEulerAngles

				local var_93_4 = GameObjectTools.GetOrAddComponent(var_93_1.gameObject, typeof(DynamicBoneHelper))

				if var_93_4 then
					var_93_4:EnableDynamicBone(true)
				end
			end

			local var_93_5 = arg_90_1.actors_["1061ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1061ui_story == nil then
				arg_90_1.var_.characterEffect1061ui_story = var_93_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_6 and not isNil(var_93_5) then
				if arg_90_1.var_.characterEffect1061ui_story and not isNil(var_93_5) then
					arg_90_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_6)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_6 and arg_90_1.time_ < 0 + var_93_6 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1061ui_story then
				arg_90_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_93_7 = 0
			local var_93_8 = 1.1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_9 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(325062022).content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 44 <= 0 and var_93_8 or var_93_8 * (utf8.len(var_93_9) / 44)

				if (44 <= 0 and var_93_8 or var_93_8 * (utf8.len(var_93_9) / 44)) > 0 and var_93_8 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_7 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_7
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_8, arg_90_1.talkMaxDuration)

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_7) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_7 + var_93_12 and arg_90_1.time_ < var_93_7 + var_93_12 + arg_93_0 then
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
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325062023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325062023
		arg_94_1.duration_ = 5.5

		local var_94_0 = {
			zh = 4.9,
			ja = 5.5
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
				arg_94_0:Play325062024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1077ui_story = arg_94_1.actors_["1077ui_story"].transform.localPosition

				local var_97_0 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_0 then
					var_97_0:EnableDynamicBone(false)
				end
			end

			local var_97_1 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 then
				arg_94_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_94_1.time_ - 0) / var_97_1)
				arg_94_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).z)
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles = arg_94_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 then
				arg_94_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_94_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).z)
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles = arg_94_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_97_2 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(true)
				end
			end

			local var_97_3 = arg_94_1.actors_["1077ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect1077ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_97_6 = 0
			local var_97_7 = 0.35

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_8 = arg_94_1:GetWordFromCfg(325062023)
				local var_97_9 = arg_94_1:FormatText(var_97_8.content)

				arg_94_1.text_.text = var_97_9

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 14 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 14)

				if (14 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 14)) > 0 and var_97_7 < var_97_11 then
					arg_94_1.talkMaxDuration = var_97_11

					if var_97_11 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_9
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062023", "story_v_out_325062.awb") ~= 0 then
					local var_97_12 = manager.audio:GetVoiceLength("story_v_out_325062", "325062023", "story_v_out_325062.awb") / 1000

					if var_97_12 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_6
					end

					if var_97_8.prefab_name ~= "" and arg_94_1.actors_[var_97_8.prefab_name] ~= nil then
						local var_97_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_8.prefab_name].transform, "story_v_out_325062", "325062023", "story_v_out_325062.awb")

						arg_94_1:RecordAudio("325062023", var_97_13)
						arg_94_1:RecordAudio("325062023", var_97_13)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325062", "325062023", "story_v_out_325062.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325062", "325062023", "story_v_out_325062.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play325062024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325062024
		arg_98_1.duration_ = 14.17

		local var_98_0 = {
			zh = 8.966,
			ja = 14.166
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
				arg_98_0:Play325062025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1077ui_story = arg_98_1.actors_["1077ui_story"].transform.localPosition

				local var_101_0 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_0 then
					var_101_0:EnableDynamicBone(false)
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_98_1.time_ - 0) / var_101_1)
				arg_98_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1077ui_story"].transform.position).z)
				arg_98_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1077ui_story"].transform.localEulerAngles = arg_98_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0.8, -1.02, -5.92)
				arg_98_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1077ui_story"].transform.position).z)
				arg_98_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1077ui_story"].transform.localEulerAngles = arg_98_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_101_2 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(true)
				end
			end

			local var_101_3 = arg_98_1.actors_["1061ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1061ui_story = var_101_3.localPosition
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_3.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_98_1.time_ - 0) / var_101_4)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_3.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			local var_101_5 = arg_98_1.actors_["1061ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect1061ui_story == nil then
				arg_98_1.var_.characterEffect1061ui_story = var_101_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_6 and not isNil(var_101_5) then
				if arg_98_1.var_.characterEffect1061ui_story and not isNil(var_101_5) then
					arg_98_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_6 and arg_98_1.time_ < 0 + var_101_6 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect1061ui_story then
				arg_98_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_101_8 = arg_98_1.actors_["1077ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.characterEffect1077ui_story == nil then
				arg_98_1.var_.characterEffect1077ui_story = var_101_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_9 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_9 and not isNil(var_101_8) then
				if arg_98_1.var_.characterEffect1077ui_story and not isNil(var_101_8) then
					arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_9)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_9 and arg_98_1.time_ < 0 + var_101_9 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.characterEffect1077ui_story then
				arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_101_10 = 0
			local var_101_11 = 1.1

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
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

				local var_101_12 = arg_98_1:GetWordFromCfg(325062024)
				local var_101_13 = arg_98_1:FormatText(var_101_12.content)

				arg_98_1.text_.text = var_101_13

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_15 = 44 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 44)

				if (44 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 44)) > 0 and var_101_11 < var_101_15 then
					arg_98_1.talkMaxDuration = var_101_15

					if var_101_15 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_15 + var_101_10
					end
				end

				arg_98_1.text_.text = var_101_13
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062024", "story_v_out_325062.awb") ~= 0 then
					local var_101_16 = manager.audio:GetVoiceLength("story_v_out_325062", "325062024", "story_v_out_325062.awb") / 1000

					if var_101_16 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_16 + var_101_10
					end

					if var_101_12.prefab_name ~= "" and arg_98_1.actors_[var_101_12.prefab_name] ~= nil then
						local var_101_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_12.prefab_name].transform, "story_v_out_325062", "325062024", "story_v_out_325062.awb")

						arg_98_1:RecordAudio("325062024", var_101_17)
						arg_98_1:RecordAudio("325062024", var_101_17)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325062", "325062024", "story_v_out_325062.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325062", "325062024", "story_v_out_325062.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_18 = math.max(var_101_11, arg_98_1.talkMaxDuration)

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_18 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_10) / var_101_18

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_10 + var_101_18 and arg_98_1.time_ < var_101_10 + var_101_18 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_98_1:InitPlayNodeList()
	end,
	Play325062025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325062025
		arg_102_1.duration_ = 10.6

		local var_102_0 = {
			zh = 9.8,
			ja = 10.6
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
				arg_102_0:Play325062026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.175

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(325062025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 47 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 47)

				if (47 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 47)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062025", "story_v_out_325062.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062025", "story_v_out_325062.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_325062", "325062025", "story_v_out_325062.awb")

						arg_102_1:RecordAudio("325062025", var_105_6)
						arg_102_1:RecordAudio("325062025", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325062", "325062025", "story_v_out_325062.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325062", "325062025", "story_v_out_325062.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325062026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325062026
		arg_106_1.duration_ = 4.5

		local var_106_0 = {
			zh = 2.966,
			ja = 4.5
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
				arg_106_0:Play325062027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1077ui_story"]) and arg_106_1.var_.characterEffect1077ui_story == nil then
				arg_106_1.var_.characterEffect1077ui_story = arg_106_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1077ui_story"]) then
				if arg_106_1.var_.characterEffect1077ui_story and not isNil(arg_106_1.actors_["1077ui_story"]) then
					arg_106_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1077ui_story"]) and arg_106_1.var_.characterEffect1077ui_story then
				arg_106_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["1061ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect1061ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1061ui_story then
				arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_109_4 = 0
			local var_109_5 = 0.375

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(325062026)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 14 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 14)

				if (14 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 14)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062026", "story_v_out_325062.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062026", "story_v_out_325062.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_325062", "325062026", "story_v_out_325062.awb")

						arg_106_1:RecordAudio("325062026", var_109_11)
						arg_106_1:RecordAudio("325062026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325062", "325062026", "story_v_out_325062.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325062", "325062026", "story_v_out_325062.awb")
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
	Play325062027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325062027
		arg_110_1.duration_ = 5

		local var_110_0 = {
			zh = 3.9,
			ja = 5
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
				arg_110_0:Play325062028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1061ui_story"]) and arg_110_1.var_.characterEffect1061ui_story == nil then
				arg_110_1.var_.characterEffect1061ui_story = arg_110_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1061ui_story"]) then
				if arg_110_1.var_.characterEffect1061ui_story and not isNil(arg_110_1.actors_["1061ui_story"]) then
					arg_110_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1061ui_story"]) and arg_110_1.var_.characterEffect1061ui_story then
				arg_110_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["1077ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1077ui_story == nil then
				arg_110_1.var_.characterEffect1077ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect1077ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1077ui_story then
				arg_110_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_113_4 = 0
			local var_113_5 = 0.35

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
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

				local var_113_6 = arg_110_1:GetWordFromCfg(325062027)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 14 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 14)

				if (14 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 14)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062027", "story_v_out_325062.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062027", "story_v_out_325062.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_325062", "325062027", "story_v_out_325062.awb")

						arg_110_1:RecordAudio("325062027", var_113_11)
						arg_110_1:RecordAudio("325062027", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325062", "325062027", "story_v_out_325062.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325062", "325062027", "story_v_out_325062.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325062028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325062028
		arg_114_1.duration_ = 11.1

		local var_114_0 = {
			zh = 8.533,
			ja = 11.1
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
				arg_114_0:Play325062029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.075

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(325062028)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 43 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 43)

				if (43 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 43)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062028", "story_v_out_325062.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062028", "story_v_out_325062.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_325062", "325062028", "story_v_out_325062.awb")

						arg_114_1:RecordAudio("325062028", var_117_6)
						arg_114_1:RecordAudio("325062028", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325062", "325062028", "story_v_out_325062.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325062", "325062028", "story_v_out_325062.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325062029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325062029
		arg_118_1.duration_ = 9

		local var_118_0 = {
			zh = 8.566,
			ja = 9
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
				arg_118_0:Play325062030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.9

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
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

				local var_121_1 = arg_118_1:GetWordFromCfg(325062029)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 36 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 36)

				if (36 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 36)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062029", "story_v_out_325062.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062029", "story_v_out_325062.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_325062", "325062029", "story_v_out_325062.awb")

						arg_118_1:RecordAudio("325062029", var_121_6)
						arg_118_1:RecordAudio("325062029", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325062", "325062029", "story_v_out_325062.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325062", "325062029", "story_v_out_325062.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325062030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325062030
		arg_122_1.duration_ = 9.03

		local var_122_0 = {
			zh = 6,
			ja = 9.033
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
				arg_122_0:Play325062031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1077ui_story"]) and arg_122_1.var_.characterEffect1077ui_story == nil then
				arg_122_1.var_.characterEffect1077ui_story = arg_122_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1077ui_story"]) then
				if arg_122_1.var_.characterEffect1077ui_story and not isNil(arg_122_1.actors_["1077ui_story"]) then
					arg_122_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1077ui_story"]) and arg_122_1.var_.characterEffect1077ui_story then
				arg_122_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["1061ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1061ui_story == nil then
				arg_122_1.var_.characterEffect1061ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect1061ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1061ui_story then
				arg_122_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_125_4 = 0
			local var_125_5 = 0.525

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(325062030)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 21 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 21)

				if (21 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 21)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062030", "story_v_out_325062.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062030", "story_v_out_325062.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_325062", "325062030", "story_v_out_325062.awb")

						arg_122_1:RecordAudio("325062030", var_125_11)
						arg_122_1:RecordAudio("325062030", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325062", "325062030", "story_v_out_325062.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325062", "325062030", "story_v_out_325062.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325062031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325062031
		arg_126_1.duration_ = 10.8

		local var_126_0 = {
			zh = 7.733,
			ja = 10.8
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
				arg_126_0:Play325062032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1061ui_story"]) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = arg_126_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1061ui_story"]) then
				if arg_126_1.var_.characterEffect1061ui_story and not isNil(arg_126_1.actors_["1061ui_story"]) then
					arg_126_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1061ui_story"]) and arg_126_1.var_.characterEffect1061ui_story then
				arg_126_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_129_2 = arg_126_1.actors_["1077ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1077ui_story == nil then
				arg_126_1.var_.characterEffect1077ui_story = var_129_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_3 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.characterEffect1077ui_story and not isNil(var_129_2) then
					arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_3)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1077ui_story then
				arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_4 = 0
			local var_129_5 = 0.9

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(325062031)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 36 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 36)

				if (36 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 36)) > 0 and var_129_5 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062031", "story_v_out_325062.awb") ~= 0 then
					local var_129_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062031", "story_v_out_325062.awb") / 1000

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end

					if var_129_6.prefab_name ~= "" and arg_126_1.actors_[var_129_6.prefab_name] ~= nil then
						local var_129_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_6.prefab_name].transform, "story_v_out_325062", "325062031", "story_v_out_325062.awb")

						arg_126_1:RecordAudio("325062031", var_129_11)
						arg_126_1:RecordAudio("325062031", var_129_11)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325062", "325062031", "story_v_out_325062.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325062", "325062031", "story_v_out_325062.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_12 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_12 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_12

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_12 and arg_126_1.time_ < var_129_4 + var_129_12 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325062032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325062032
		arg_130_1.duration_ = 12.2

		local var_130_0 = {
			zh = 9.966,
			ja = 12.2
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
				arg_130_0:Play325062033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 1.1

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
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

				local var_133_1 = arg_130_1:GetWordFromCfg(325062032)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 44 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 44)

				if (44 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 44)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062032", "story_v_out_325062.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062032", "story_v_out_325062.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_325062", "325062032", "story_v_out_325062.awb")

						arg_130_1:RecordAudio("325062032", var_133_6)
						arg_130_1:RecordAudio("325062032", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325062", "325062032", "story_v_out_325062.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325062", "325062032", "story_v_out_325062.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play325062033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325062033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325062034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1061ui_story = arg_134_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).z)
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles = arg_134_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).z)
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles = arg_134_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["1077ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1077ui_story = var_137_1.localPosition

				local var_137_2 = GameObjectTools.GetOrAddComponent(var_137_1.gameObject, typeof(DynamicBoneHelper))

				if var_137_2 then
					var_137_2:EnableDynamicBone(false)
				end
			end

			local var_137_3 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 then
				var_137_1.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 0) / var_137_3)
				var_137_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_1.position).x, (manager.ui.mainCamera.transform.position - var_137_1.position).y, (manager.ui.mainCamera.transform.position - var_137_1.position).z)
				var_137_1.localEulerAngles.z = 0
				var_137_1.localEulerAngles.x = 0
				var_137_1.localEulerAngles = var_137_1.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 then
				var_137_1.localPosition = Vector3.New(0, 100, 0)
				var_137_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_1.position).x, (manager.ui.mainCamera.transform.position - var_137_1.position).y, (manager.ui.mainCamera.transform.position - var_137_1.position).z)
				var_137_1.localEulerAngles.z = 0
				var_137_1.localEulerAngles.x = 0
				var_137_1.localEulerAngles = var_137_1.localEulerAngles

				local var_137_4 = GameObjectTools.GetOrAddComponent(var_137_1.gameObject, typeof(DynamicBoneHelper))

				if var_137_4 then
					var_137_4:EnableDynamicBone(true)
				end
			end

			local var_137_5 = arg_134_1.actors_["1061ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_6 and not isNil(var_137_5) then
				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_5) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_6)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_6 and arg_134_1.time_ < 0 + var_137_6 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_137_7 = 0
			local var_137_8 = 1.35

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_7 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_9 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(325062033).content)

				arg_134_1.text_.text = var_137_9

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 54 <= 0 and var_137_8 or var_137_8 * (utf8.len(var_137_9) / 54)

				if (54 <= 0 and var_137_8 or var_137_8 * (utf8.len(var_137_9) / 54)) > 0 and var_137_8 < var_137_11 then
					arg_134_1.talkMaxDuration = var_137_11

					if var_137_11 + var_137_7 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_11 + var_137_7
					end
				end

				arg_134_1.text_.text = var_137_9
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_8, arg_134_1.talkMaxDuration)

			if var_137_7 <= arg_134_1.time_ and arg_134_1.time_ < var_137_7 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_7) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_7 + var_137_12 and arg_134_1.time_ < var_137_7 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325062034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325062034
		arg_138_1.duration_ = 4.43

		local var_138_0 = {
			zh = 2.866,
			ja = 4.433
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
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325062035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1077ui_story = arg_138_1.actors_["1077ui_story"].transform.localPosition

				local var_141_0 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_0 then
					var_141_0:EnableDynamicBone(false)
				end
			end

			local var_141_1 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 then
				arg_138_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_138_1.time_ - 0) / var_141_1)
				arg_138_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).z)
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles = arg_138_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 then
				arg_138_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_138_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).z)
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles = arg_138_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_141_2 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(true)
				end
			end

			local var_141_3 = arg_138_1.actors_["1077ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect1077ui_story == nil then
				arg_138_1.var_.characterEffect1077ui_story = var_141_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 and not isNil(var_141_3) then
				if arg_138_1.var_.characterEffect1077ui_story and not isNil(var_141_3) then
					arg_138_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect1077ui_story then
				arg_138_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_141_6 = 0
			local var_141_7 = 0.3

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(325062034)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 12 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 12)

				if (12 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 12)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062034", "story_v_out_325062.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_325062", "325062034", "story_v_out_325062.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_325062", "325062034", "story_v_out_325062.awb")

						arg_138_1:RecordAudio("325062034", var_141_13)
						arg_138_1:RecordAudio("325062034", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325062", "325062034", "story_v_out_325062.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325062", "325062034", "story_v_out_325062.awb")
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

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play325062035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325062035
		arg_142_1.duration_ = 7.53

		local var_142_0 = {
			zh = 2.933,
			ja = 7.533
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325062036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1077ui_story = arg_142_1.actors_["1077ui_story"].transform.localPosition

				local var_145_0 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_0 then
					var_145_0:EnableDynamicBone(false)
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_142_1.time_ - 0) / var_145_1)
				arg_142_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1077ui_story"].transform.position).z)
				arg_142_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1077ui_story"].transform.localEulerAngles = arg_142_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0.8, -1.02, -5.92)
				arg_142_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1077ui_story"].transform.position).z)
				arg_142_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1077ui_story"].transform.localEulerAngles = arg_142_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_145_2 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(true)
				end
			end

			local var_145_3 = arg_142_1.actors_["1061ui_story"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1061ui_story = var_145_3.localPosition
			end

			local var_145_4 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				var_145_3.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_142_1.time_ - 0) / var_145_4)
				var_145_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_3.position).x, (manager.ui.mainCamera.transform.position - var_145_3.position).y, (manager.ui.mainCamera.transform.position - var_145_3.position).z)
				var_145_3.localEulerAngles.z = 0
				var_145_3.localEulerAngles.x = 0
				var_145_3.localEulerAngles = var_145_3.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				var_145_3.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_145_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_3.position).x, (manager.ui.mainCamera.transform.position - var_145_3.position).y, (manager.ui.mainCamera.transform.position - var_145_3.position).z)
				var_145_3.localEulerAngles.z = 0
				var_145_3.localEulerAngles.x = 0
				var_145_3.localEulerAngles = var_145_3.localEulerAngles
			end

			local var_145_5 = arg_142_1.actors_["1061ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_5) and arg_142_1.var_.characterEffect1061ui_story == nil then
				arg_142_1.var_.characterEffect1061ui_story = var_145_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_6 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_6 and not isNil(var_145_5) then
				if arg_142_1.var_.characterEffect1061ui_story and not isNil(var_145_5) then
					arg_142_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_6 and arg_142_1.time_ < 0 + var_145_6 + arg_145_0 and not isNil(var_145_5) and arg_142_1.var_.characterEffect1061ui_story then
				arg_142_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_145_8 = arg_142_1.actors_["1077ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.characterEffect1077ui_story == nil then
				arg_142_1.var_.characterEffect1077ui_story = var_145_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_9 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_9 and not isNil(var_145_8) then
				if arg_142_1.var_.characterEffect1077ui_story and not isNil(var_145_8) then
					arg_142_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_9)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_9 and arg_142_1.time_ < 0 + var_145_9 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.characterEffect1077ui_story then
				arg_142_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_145_10 = 0
			local var_145_11 = 0.375

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_12 = arg_142_1:GetWordFromCfg(325062035)
				local var_145_13 = arg_142_1:FormatText(var_145_12.content)

				arg_142_1.text_.text = var_145_13

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_15 = 15 <= 0 and var_145_11 or var_145_11 * (utf8.len(var_145_13) / 15)

				if (15 <= 0 and var_145_11 or var_145_11 * (utf8.len(var_145_13) / 15)) > 0 and var_145_11 < var_145_15 then
					arg_142_1.talkMaxDuration = var_145_15

					if var_145_15 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_10
					end
				end

				arg_142_1.text_.text = var_145_13
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062035", "story_v_out_325062.awb") ~= 0 then
					local var_145_16 = manager.audio:GetVoiceLength("story_v_out_325062", "325062035", "story_v_out_325062.awb") / 1000

					if var_145_16 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_16 + var_145_10
					end

					if var_145_12.prefab_name ~= "" and arg_142_1.actors_[var_145_12.prefab_name] ~= nil then
						local var_145_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_12.prefab_name].transform, "story_v_out_325062", "325062035", "story_v_out_325062.awb")

						arg_142_1:RecordAudio("325062035", var_145_17)
						arg_142_1:RecordAudio("325062035", var_145_17)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325062", "325062035", "story_v_out_325062.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325062", "325062035", "story_v_out_325062.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_18 = math.max(var_145_11, arg_142_1.talkMaxDuration)

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_18 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_10) / var_145_18

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_10 + var_145_18 and arg_142_1.time_ < var_145_10 + var_145_18 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_142_1:InitPlayNodeList()
	end,
	Play325062036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325062036
		arg_146_1.duration_ = 11.37

		local var_146_0 = {
			zh = 8.366,
			ja = 11.366
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325062037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.95

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:GetWordFromCfg(325062036)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 38 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 38)

				if (38 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 38)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062036", "story_v_out_325062.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062036", "story_v_out_325062.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_325062", "325062036", "story_v_out_325062.awb")

						arg_146_1:RecordAudio("325062036", var_149_6)
						arg_146_1:RecordAudio("325062036", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_325062", "325062036", "story_v_out_325062.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_325062", "325062036", "story_v_out_325062.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play325062037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325062037
		arg_150_1.duration_ = 5.77

		local var_150_0 = {
			zh = 4.266,
			ja = 5.766
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play325062038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1077ui_story"]) and arg_150_1.var_.characterEffect1077ui_story == nil then
				arg_150_1.var_.characterEffect1077ui_story = arg_150_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1077ui_story"]) then
				if arg_150_1.var_.characterEffect1077ui_story and not isNil(arg_150_1.actors_["1077ui_story"]) then
					arg_150_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1077ui_story"]) and arg_150_1.var_.characterEffect1077ui_story then
				arg_150_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_153_2 = arg_150_1.actors_["1061ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1061ui_story == nil then
				arg_150_1.var_.characterEffect1061ui_story = var_153_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_3 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.characterEffect1061ui_story and not isNil(var_153_2) then
					arg_150_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_3)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1061ui_story then
				arg_150_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_153_4 = 0
			local var_153_5 = 0.475

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_6 = arg_150_1:GetWordFromCfg(325062037)
				local var_153_7 = arg_150_1:FormatText(var_153_6.content)

				arg_150_1.text_.text = var_153_7

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 19 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 19)

				if (19 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 19)) > 0 and var_153_5 < var_153_9 then
					arg_150_1.talkMaxDuration = var_153_9

					if var_153_9 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_4
					end
				end

				arg_150_1.text_.text = var_153_7
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062037", "story_v_out_325062.awb") ~= 0 then
					local var_153_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062037", "story_v_out_325062.awb") / 1000

					if var_153_10 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_4
					end

					if var_153_6.prefab_name ~= "" and arg_150_1.actors_[var_153_6.prefab_name] ~= nil then
						local var_153_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_6.prefab_name].transform, "story_v_out_325062", "325062037", "story_v_out_325062.awb")

						arg_150_1:RecordAudio("325062037", var_153_11)
						arg_150_1:RecordAudio("325062037", var_153_11)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325062", "325062037", "story_v_out_325062.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325062", "325062037", "story_v_out_325062.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_12 = math.max(var_153_5, arg_150_1.talkMaxDuration)

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_4) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_4 + var_153_12 and arg_150_1.time_ < var_153_4 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play325062038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325062038
		arg_154_1.duration_ = 4.07

		local var_154_0 = {
			zh = 3.9,
			ja = 4.066
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play325062039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1061ui_story"]) and arg_154_1.var_.characterEffect1061ui_story == nil then
				arg_154_1.var_.characterEffect1061ui_story = arg_154_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1061ui_story"]) then
				if arg_154_1.var_.characterEffect1061ui_story and not isNil(arg_154_1.actors_["1061ui_story"]) then
					arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1061ui_story"]) and arg_154_1.var_.characterEffect1061ui_story then
				arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_157_2 = arg_154_1.actors_["1077ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1077ui_story == nil then
				arg_154_1.var_.characterEffect1077ui_story = var_157_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_3 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.characterEffect1077ui_story and not isNil(var_157_2) then
					arg_154_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_3)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1077ui_story then
				arg_154_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_157_4 = 0
			local var_157_5 = 0.3

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(325062038)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 12 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 12)

				if (12 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 12)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062038", "story_v_out_325062.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062038", "story_v_out_325062.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_out_325062", "325062038", "story_v_out_325062.awb")

						arg_154_1:RecordAudio("325062038", var_157_11)
						arg_154_1:RecordAudio("325062038", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325062", "325062038", "story_v_out_325062.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325062", "325062038", "story_v_out_325062.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play325062039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325062039
		arg_158_1.duration_ = 7.97

		local var_158_0 = {
			zh = 6.9,
			ja = 7.966
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play325062040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 1.999999999999 < arg_158_1.time_ and arg_158_1.time_ <= 1.999999999999 + arg_161_0 then
				local var_161_0 = arg_158_1.bgs_.J03h

				arg_158_1.bgs_.J03h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_161_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_161_1 = var_161_0:GetComponent("SpriteRenderer")

				if var_161_1 and var_161_1.sprite then
					local var_161_2 = 2 * (var_161_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_161_0.transform.localScale = Vector3.New(var_161_2 / var_161_1.sprite.bounds.size.y < var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x and var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x or var_161_2 / var_161_1.sprite.bounds.size.y, var_161_2 / var_161_1.sprite.bounds.size.y < var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x and var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x or var_161_2 / var_161_1.sprite.bounds.size.y, 0)
				end

				for iter_161_0, iter_161_1 in pairs(arg_158_1.bgs_) do
					if iter_161_0 ~= "J03h" then
						iter_161_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_161_3 = 0

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_3 + arg_161_0 then
				arg_158_1.allBtn_.enabled = false
			end

			if arg_158_1.time_ >= var_161_3 + 0.3 and arg_158_1.time_ < var_161_3 + 0.3 + arg_161_0 then
				arg_158_1.allBtn_.enabled = true
			end

			local var_161_4 = 0

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_5 = 2

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_5 then
				local var_161_6 = Color.New(0, 0, 0)

				var_161_6.a = Mathf.Lerp(0, 1, (arg_158_1.time_ - var_161_4) / var_161_5)
				arg_158_1.mask_.color = var_161_6
			end

			if arg_158_1.time_ >= var_161_4 + var_161_5 and arg_158_1.time_ < var_161_4 + var_161_5 + arg_161_0 then
				local var_161_7 = Color.New(0, 0, 0)

				var_161_7.a = 1
				arg_158_1.mask_.color = var_161_7
			end

			local var_161_8 = 2

			if 2 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_9 = 2

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_9 then
				local var_161_10 = Color.New(0, 0, 0)

				var_161_10.a = Mathf.Lerp(1, 0, (arg_158_1.time_ - var_161_8) / var_161_9)
				arg_158_1.mask_.color = var_161_10
			end

			if arg_158_1.time_ >= var_161_8 + var_161_9 and arg_158_1.time_ < var_161_8 + var_161_9 + arg_161_0 then
				local var_161_11 = Color.New(0, 0, 0)

				arg_158_1.mask_.enabled = false
				var_161_11.a = 0
				arg_158_1.mask_.color = var_161_11
			end

			local var_161_12 = arg_158_1.actors_["1061ui_story"].transform

			if 2 < arg_158_1.time_ and arg_158_1.time_ <= 2 + arg_161_0 then
				arg_158_1.var_.moveOldPos1061ui_story = var_161_12.localPosition
			end

			local var_161_13 = 0.001

			if 2 <= arg_158_1.time_ and arg_158_1.time_ < 2 + var_161_13 then
				var_161_12.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_158_1.time_ - 2) / var_161_13)
				var_161_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_12.position).x, (manager.ui.mainCamera.transform.position - var_161_12.position).y, (manager.ui.mainCamera.transform.position - var_161_12.position).z)
				var_161_12.localEulerAngles.z = 0
				var_161_12.localEulerAngles.x = 0
				var_161_12.localEulerAngles = var_161_12.localEulerAngles
			end

			if arg_158_1.time_ >= 2 + var_161_13 and arg_158_1.time_ < 2 + var_161_13 + arg_161_0 then
				var_161_12.localPosition = Vector3.New(0, 100, 0)
				var_161_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_12.position).x, (manager.ui.mainCamera.transform.position - var_161_12.position).y, (manager.ui.mainCamera.transform.position - var_161_12.position).z)
				var_161_12.localEulerAngles.z = 0
				var_161_12.localEulerAngles.x = 0
				var_161_12.localEulerAngles = var_161_12.localEulerAngles
			end

			local var_161_14 = arg_158_1.actors_["1077ui_story"].transform

			if 2 < arg_158_1.time_ and arg_158_1.time_ <= 2 + arg_161_0 then
				arg_158_1.var_.moveOldPos1077ui_story = var_161_14.localPosition

				local var_161_15 = GameObjectTools.GetOrAddComponent(var_161_14.gameObject, typeof(DynamicBoneHelper))

				if var_161_15 then
					var_161_15:EnableDynamicBone(false)
				end
			end

			local var_161_16 = 0.001

			if 2 <= arg_158_1.time_ and arg_158_1.time_ < 2 + var_161_16 then
				var_161_14.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_158_1.time_ - 2) / var_161_16)
				var_161_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_14.position).x, (manager.ui.mainCamera.transform.position - var_161_14.position).y, (manager.ui.mainCamera.transform.position - var_161_14.position).z)
				var_161_14.localEulerAngles.z = 0
				var_161_14.localEulerAngles.x = 0
				var_161_14.localEulerAngles = var_161_14.localEulerAngles
			end

			if arg_158_1.time_ >= 2 + var_161_16 and arg_158_1.time_ < 2 + var_161_16 + arg_161_0 then
				var_161_14.localPosition = Vector3.New(0, 100, 0)
				var_161_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_14.position).x, (manager.ui.mainCamera.transform.position - var_161_14.position).y, (manager.ui.mainCamera.transform.position - var_161_14.position).z)
				var_161_14.localEulerAngles.z = 0
				var_161_14.localEulerAngles.x = 0
				var_161_14.localEulerAngles = var_161_14.localEulerAngles

				local var_161_17 = GameObjectTools.GetOrAddComponent(var_161_14.gameObject, typeof(DynamicBoneHelper))

				if var_161_17 then
					var_161_17:EnableDynamicBone(true)
				end
			end

			local var_161_18 = arg_158_1.actors_["1077ui_story"].transform

			if 3.6 < arg_158_1.time_ and arg_158_1.time_ <= 3.6 + arg_161_0 then
				arg_158_1.var_.moveOldPos1077ui_story = var_161_18.localPosition

				local var_161_19 = GameObjectTools.GetOrAddComponent(var_161_18.gameObject, typeof(DynamicBoneHelper))

				if var_161_19 then
					var_161_19:EnableDynamicBone(false)
				end
			end

			local var_161_20 = 0.001

			if 3.6 <= arg_158_1.time_ and arg_158_1.time_ < 3.6 + var_161_20 then
				var_161_18.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_158_1.time_ - 3.6) / var_161_20)
				var_161_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_18.position).x, (manager.ui.mainCamera.transform.position - var_161_18.position).y, (manager.ui.mainCamera.transform.position - var_161_18.position).z)
				var_161_18.localEulerAngles.z = 0
				var_161_18.localEulerAngles.x = 0
				var_161_18.localEulerAngles = var_161_18.localEulerAngles
			end

			if arg_158_1.time_ >= 3.6 + var_161_20 and arg_158_1.time_ < 3.6 + var_161_20 + arg_161_0 then
				var_161_18.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_161_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_18.position).x, (manager.ui.mainCamera.transform.position - var_161_18.position).y, (manager.ui.mainCamera.transform.position - var_161_18.position).z)
				var_161_18.localEulerAngles.z = 0
				var_161_18.localEulerAngles.x = 0
				var_161_18.localEulerAngles = var_161_18.localEulerAngles

				local var_161_21 = GameObjectTools.GetOrAddComponent(var_161_18.gameObject, typeof(DynamicBoneHelper))

				if var_161_21 then
					var_161_21:EnableDynamicBone(true)
				end
			end

			local var_161_22 = arg_158_1.actors_["1077ui_story"]

			if 3.6 < arg_158_1.time_ and arg_158_1.time_ <= 3.6 + arg_161_0 and not isNil(var_161_22) and arg_158_1.var_.characterEffect1077ui_story == nil then
				arg_158_1.var_.characterEffect1077ui_story = var_161_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_23 = 0.200000002980232

			if 3.6 <= arg_158_1.time_ and arg_158_1.time_ < 3.6 + var_161_23 and not isNil(var_161_22) then
				if arg_158_1.var_.characterEffect1077ui_story and not isNil(var_161_22) then
					arg_158_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 3.6 + var_161_23 and arg_158_1.time_ < 3.6 + var_161_23 + arg_161_0 and not isNil(var_161_22) and arg_158_1.var_.characterEffect1077ui_story then
				arg_158_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_161_25 = arg_158_1.actors_["1061ui_story"]

			if 3.6 < arg_158_1.time_ and arg_158_1.time_ <= 3.6 + arg_161_0 and not isNil(var_161_25) and arg_158_1.var_.characterEffect1061ui_story == nil then
				arg_158_1.var_.characterEffect1061ui_story = var_161_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_26 = 0.200000002980232

			if 3.6 <= arg_158_1.time_ and arg_158_1.time_ < 3.6 + var_161_26 and not isNil(var_161_25) then
				if arg_158_1.var_.characterEffect1061ui_story and not isNil(var_161_25) then
					arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 3.6) / var_161_26)
				end
			end

			if arg_158_1.time_ >= 3.6 + var_161_26 and arg_158_1.time_ < 3.6 + var_161_26 + arg_161_0 and not isNil(var_161_25) and arg_158_1.var_.characterEffect1061ui_story then
				arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 3.6 < arg_158_1.time_ and arg_158_1.time_ <= 3.6 + arg_161_0 then
				arg_158_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if arg_158_1.frameCnt_ <= 1 then
				arg_158_1.dialog_:SetActive(false)
			end

			local var_161_27 = 4
			local var_161_28 = 0.225

			if 4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_27 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0

				arg_158_1.dialog_:SetActive(true)

				arg_158_1.dialogCg_.alpha = 0

				local var_161_29 = LeanTween.value(arg_158_1.dialog_, 0, 1, 0.3)

				var_161_29:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_158_1.dialogCg_.alpha = arg_162_0
				end))
				var_161_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_158_1.dialog_)
					var_161_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_158_1.duration_ = arg_158_1.duration_ + 0.3

				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_30 = arg_158_1:GetWordFromCfg(325062039)
				local var_161_31 = arg_158_1:FormatText(var_161_30.content)

				arg_158_1.text_.text = var_161_31

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_33 = 9 <= 0 and var_161_28 or var_161_28 * (utf8.len(var_161_31) / 9)

				if (9 <= 0 and var_161_28 or var_161_28 * (utf8.len(var_161_31) / 9)) > 0 and var_161_28 < var_161_33 then
					arg_158_1.talkMaxDuration = var_161_33
					var_161_27 = var_161_27 + 0.3

					if var_161_33 + var_161_27 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_33 + var_161_27
					end
				end

				arg_158_1.text_.text = var_161_31
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062039", "story_v_out_325062.awb") ~= 0 then
					local var_161_34 = manager.audio:GetVoiceLength("story_v_out_325062", "325062039", "story_v_out_325062.awb") / 1000

					if var_161_34 + var_161_27 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_34 + var_161_27
					end

					if var_161_30.prefab_name ~= "" and arg_158_1.actors_[var_161_30.prefab_name] ~= nil then
						local var_161_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_30.prefab_name].transform, "story_v_out_325062", "325062039", "story_v_out_325062.awb")

						arg_158_1:RecordAudio("325062039", var_161_35)
						arg_158_1:RecordAudio("325062039", var_161_35)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325062", "325062039", "story_v_out_325062.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325062", "325062039", "story_v_out_325062.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_36 = var_161_27 + 0.3
			local var_161_37 = math.max(var_161_28, arg_158_1.talkMaxDuration)

			if var_161_27 + 0.3 <= arg_158_1.time_ and arg_158_1.time_ < var_161_36 + var_161_37 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_36) / var_161_37

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_36 + var_161_37 and arg_158_1.time_ < var_161_36 + var_161_37 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play325062040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325062040
		arg_164_1.duration_ = 3.3

		local var_164_0 = {
			zh = 3.3,
			ja = 2.633
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325062041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1077ui_story = arg_164_1.actors_["1077ui_story"].transform.localPosition

				local var_167_0 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_0 then
					var_167_0:EnableDynamicBone(false)
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_164_1.time_ - 0) / var_167_1)
				arg_164_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1077ui_story"].transform.position).z)
				arg_164_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1077ui_story"].transform.localEulerAngles = arg_164_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				arg_164_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1077ui_story"].transform.position).z)
				arg_164_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1077ui_story"].transform.localEulerAngles = arg_164_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_167_2 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(true)
				end
			end

			local var_167_3 = arg_164_1.actors_["1061ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1061ui_story = var_167_3.localPosition
			end

			local var_167_4 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				var_167_3.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_164_1.time_ - 0) / var_167_4)
				var_167_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_3.position).x, (manager.ui.mainCamera.transform.position - var_167_3.position).y, (manager.ui.mainCamera.transform.position - var_167_3.position).z)
				var_167_3.localEulerAngles.z = 0
				var_167_3.localEulerAngles.x = 0
				var_167_3.localEulerAngles = var_167_3.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				var_167_3.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_167_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_3.position).x, (manager.ui.mainCamera.transform.position - var_167_3.position).y, (manager.ui.mainCamera.transform.position - var_167_3.position).z)
				var_167_3.localEulerAngles.z = 0
				var_167_3.localEulerAngles.x = 0
				var_167_3.localEulerAngles = var_167_3.localEulerAngles
			end

			local var_167_5 = arg_164_1.actors_["1061ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_5) and arg_164_1.var_.characterEffect1061ui_story == nil then
				arg_164_1.var_.characterEffect1061ui_story = var_167_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_6 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_6 and not isNil(var_167_5) then
				if arg_164_1.var_.characterEffect1061ui_story and not isNil(var_167_5) then
					arg_164_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_6 and arg_164_1.time_ < 0 + var_167_6 + arg_167_0 and not isNil(var_167_5) and arg_164_1.var_.characterEffect1061ui_story then
				arg_164_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_167_8 = arg_164_1.actors_["1077ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_8) and arg_164_1.var_.characterEffect1077ui_story == nil then
				arg_164_1.var_.characterEffect1077ui_story = var_167_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_9 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_9 and not isNil(var_167_8) then
				if arg_164_1.var_.characterEffect1077ui_story and not isNil(var_167_8) then
					arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_9)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_9 and arg_164_1.time_ < 0 + var_167_9 + arg_167_0 and not isNil(var_167_8) and arg_164_1.var_.characterEffect1077ui_story then
				arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_167_10 = 0
			local var_167_11 = 0.4

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_12 = arg_164_1:GetWordFromCfg(325062040)
				local var_167_13 = arg_164_1:FormatText(var_167_12.content)

				arg_164_1.text_.text = var_167_13

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_15 = 16 <= 0 and var_167_11 or var_167_11 * (utf8.len(var_167_13) / 16)

				if (16 <= 0 and var_167_11 or var_167_11 * (utf8.len(var_167_13) / 16)) > 0 and var_167_11 < var_167_15 then
					arg_164_1.talkMaxDuration = var_167_15

					if var_167_15 + var_167_10 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_15 + var_167_10
					end
				end

				arg_164_1.text_.text = var_167_13
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062040", "story_v_out_325062.awb") ~= 0 then
					local var_167_16 = manager.audio:GetVoiceLength("story_v_out_325062", "325062040", "story_v_out_325062.awb") / 1000

					if var_167_16 + var_167_10 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_16 + var_167_10
					end

					if var_167_12.prefab_name ~= "" and arg_164_1.actors_[var_167_12.prefab_name] ~= nil then
						local var_167_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_12.prefab_name].transform, "story_v_out_325062", "325062040", "story_v_out_325062.awb")

						arg_164_1:RecordAudio("325062040", var_167_17)
						arg_164_1:RecordAudio("325062040", var_167_17)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_325062", "325062040", "story_v_out_325062.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_325062", "325062040", "story_v_out_325062.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_18 = math.max(var_167_11, arg_164_1.talkMaxDuration)

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_18 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_10) / var_167_18

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_10 + var_167_18 and arg_164_1.time_ < var_167_10 + var_167_18 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_164_1:InitPlayNodeList()
	end,
	Play325062041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325062041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325062042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1061ui_story = arg_168_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1061ui_story"].transform.position).z)
				arg_168_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1061ui_story"].transform.localEulerAngles = arg_168_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1061ui_story"].transform.position).z)
				arg_168_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1061ui_story"].transform.localEulerAngles = arg_168_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["1077ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1077ui_story = var_171_1.localPosition

				local var_171_2 = GameObjectTools.GetOrAddComponent(var_171_1.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(false)
				end
			end

			local var_171_3 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 then
				var_171_1.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_3)
				var_171_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_1.position).x, (manager.ui.mainCamera.transform.position - var_171_1.position).y, (manager.ui.mainCamera.transform.position - var_171_1.position).z)
				var_171_1.localEulerAngles.z = 0
				var_171_1.localEulerAngles.x = 0
				var_171_1.localEulerAngles = var_171_1.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 then
				var_171_1.localPosition = Vector3.New(0, 100, 0)
				var_171_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_1.position).x, (manager.ui.mainCamera.transform.position - var_171_1.position).y, (manager.ui.mainCamera.transform.position - var_171_1.position).z)
				var_171_1.localEulerAngles.z = 0
				var_171_1.localEulerAngles.x = 0
				var_171_1.localEulerAngles = var_171_1.localEulerAngles

				local var_171_4 = GameObjectTools.GetOrAddComponent(var_171_1.gameObject, typeof(DynamicBoneHelper))

				if var_171_4 then
					var_171_4:EnableDynamicBone(true)
				end
			end

			local var_171_5 = arg_168_1.actors_["1061ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.characterEffect1061ui_story == nil then
				arg_168_1.var_.characterEffect1061ui_story = var_171_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_6 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_6 and not isNil(var_171_5) then
				if arg_168_1.var_.characterEffect1061ui_story and not isNil(var_171_5) then
					arg_168_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_6)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_6 and arg_168_1.time_ < 0 + var_171_6 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.characterEffect1061ui_story then
				arg_168_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_171_7 = 0
			local var_171_8 = 1.05

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_9 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(325062041).content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 42 <= 0 and var_171_8 or var_171_8 * (utf8.len(var_171_9) / 42)

				if (42 <= 0 and var_171_8 or var_171_8 * (utf8.len(var_171_9) / 42)) > 0 and var_171_8 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_7 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_7
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_8, arg_168_1.talkMaxDuration)

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_7) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_7 + var_171_12 and arg_168_1.time_ < var_171_7 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play325062042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325062042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325062043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 1 < arg_172_1.time_ and arg_172_1.time_ <= 1 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword11", "")
			end

			if 0.3 < arg_172_1.time_ and arg_172_1.time_ <= 0.3 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_15", "se_story_15_ui", "")
			end

			local var_175_2 = 0
			local var_175_3 = 1.5

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_4 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(325062042).content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_6 = 60 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_4) / 60)

				if (60 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_4) / 60)) > 0 and var_175_3 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_2 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_2
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_3, arg_172_1.talkMaxDuration)

			if var_175_2 <= arg_172_1.time_ and arg_172_1.time_ < var_175_2 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_2) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_2 + var_175_7 and arg_172_1.time_ < var_175_2 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play325062043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325062043
		arg_176_1.duration_ = 7.67

		local var_176_0 = {
			zh = 6.933,
			ja = 7.666
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325062044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1061ui_story = arg_176_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).z)
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles = arg_176_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_176_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).z)
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles = arg_176_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_179_1 = arg_176_1.actors_["1061ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1061ui_story == nil then
				arg_176_1.var_.characterEffect1061ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect1061ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1061ui_story then
				arg_176_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_4 = 0
			local var_179_5 = 0.825

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_6 = arg_176_1:GetWordFromCfg(325062043)
				local var_179_7 = arg_176_1:FormatText(var_179_6.content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 33 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 33)

				if (33 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 33)) > 0 and var_179_5 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062043", "story_v_out_325062.awb") ~= 0 then
					local var_179_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062043", "story_v_out_325062.awb") / 1000

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end

					if var_179_6.prefab_name ~= "" and arg_176_1.actors_[var_179_6.prefab_name] ~= nil then
						local var_179_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_6.prefab_name].transform, "story_v_out_325062", "325062043", "story_v_out_325062.awb")

						arg_176_1:RecordAudio("325062043", var_179_11)
						arg_176_1:RecordAudio("325062043", var_179_11)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_325062", "325062043", "story_v_out_325062.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_325062", "325062043", "story_v_out_325062.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_12 and arg_176_1.time_ < var_179_4 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play325062044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325062044
		arg_180_1.duration_ = 9.93

		local var_180_0 = {
			zh = 5.2,
			ja = 9.933
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325062045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			local var_183_0 = 0
			local var_183_1 = 0.65

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_2 = arg_180_1:GetWordFromCfg(325062044)
				local var_183_3 = arg_180_1:FormatText(var_183_2.content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 26 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 26)

				if (26 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 26)) > 0 and var_183_1 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062044", "story_v_out_325062.awb") ~= 0 then
					local var_183_6 = manager.audio:GetVoiceLength("story_v_out_325062", "325062044", "story_v_out_325062.awb") / 1000

					if var_183_6 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_0
					end

					if var_183_2.prefab_name ~= "" and arg_180_1.actors_[var_183_2.prefab_name] ~= nil then
						local var_183_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_2.prefab_name].transform, "story_v_out_325062", "325062044", "story_v_out_325062.awb")

						arg_180_1:RecordAudio("325062044", var_183_7)
						arg_180_1:RecordAudio("325062044", var_183_7)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325062", "325062044", "story_v_out_325062.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325062", "325062044", "story_v_out_325062.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_8 and arg_180_1.time_ < var_183_0 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play325062045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325062045
		arg_184_1.duration_ = 10.83

		local var_184_0 = {
			zh = 9.1,
			ja = 10.833
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325062046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1061ui_story = arg_184_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1061ui_story"].transform.position).z)
				arg_184_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1061ui_story"].transform.localEulerAngles = arg_184_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_184_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1061ui_story"].transform.position).z)
				arg_184_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1061ui_story"].transform.localEulerAngles = arg_184_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["1077ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1077ui_story = var_187_1.localPosition

				local var_187_2 = GameObjectTools.GetOrAddComponent(var_187_1.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(false)
				end
			end

			local var_187_3 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 then
				var_187_1.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_184_1.time_ - 0) / var_187_3)
				var_187_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_1.position).x, (manager.ui.mainCamera.transform.position - var_187_1.position).y, (manager.ui.mainCamera.transform.position - var_187_1.position).z)
				var_187_1.localEulerAngles.z = 0
				var_187_1.localEulerAngles.x = 0
				var_187_1.localEulerAngles = var_187_1.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 then
				var_187_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_187_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_1.position).x, (manager.ui.mainCamera.transform.position - var_187_1.position).y, (manager.ui.mainCamera.transform.position - var_187_1.position).z)
				var_187_1.localEulerAngles.z = 0
				var_187_1.localEulerAngles.x = 0
				var_187_1.localEulerAngles = var_187_1.localEulerAngles

				local var_187_4 = GameObjectTools.GetOrAddComponent(var_187_1.gameObject, typeof(DynamicBoneHelper))

				if var_187_4 then
					var_187_4:EnableDynamicBone(true)
				end
			end

			local var_187_5 = arg_184_1.actors_["1077ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_5) and arg_184_1.var_.characterEffect1077ui_story == nil then
				arg_184_1.var_.characterEffect1077ui_story = var_187_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_6 and not isNil(var_187_5) then
				if arg_184_1.var_.characterEffect1077ui_story and not isNil(var_187_5) then
					arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_6 and arg_184_1.time_ < 0 + var_187_6 + arg_187_0 and not isNil(var_187_5) and arg_184_1.var_.characterEffect1077ui_story then
				arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_187_8 = arg_184_1.actors_["1061ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.characterEffect1061ui_story == nil then
				arg_184_1.var_.characterEffect1061ui_story = var_187_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_9 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_9 and not isNil(var_187_8) then
				if arg_184_1.var_.characterEffect1061ui_story and not isNil(var_187_8) then
					arg_184_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_9)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_9 and arg_184_1.time_ < 0 + var_187_9 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.characterEffect1061ui_story then
				arg_184_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action423")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_187_10 = 0
			local var_187_11 = 1.15

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_12 = arg_184_1:GetWordFromCfg(325062045)
				local var_187_13 = arg_184_1:FormatText(var_187_12.content)

				arg_184_1.text_.text = var_187_13

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_15 = 46 <= 0 and var_187_11 or var_187_11 * (utf8.len(var_187_13) / 46)

				if (46 <= 0 and var_187_11 or var_187_11 * (utf8.len(var_187_13) / 46)) > 0 and var_187_11 < var_187_15 then
					arg_184_1.talkMaxDuration = var_187_15

					if var_187_15 + var_187_10 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_15 + var_187_10
					end
				end

				arg_184_1.text_.text = var_187_13
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062045", "story_v_out_325062.awb") ~= 0 then
					local var_187_16 = manager.audio:GetVoiceLength("story_v_out_325062", "325062045", "story_v_out_325062.awb") / 1000

					if var_187_16 + var_187_10 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_16 + var_187_10
					end

					if var_187_12.prefab_name ~= "" and arg_184_1.actors_[var_187_12.prefab_name] ~= nil then
						local var_187_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_12.prefab_name].transform, "story_v_out_325062", "325062045", "story_v_out_325062.awb")

						arg_184_1:RecordAudio("325062045", var_187_17)
						arg_184_1:RecordAudio("325062045", var_187_17)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325062", "325062045", "story_v_out_325062.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325062", "325062045", "story_v_out_325062.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_18 = math.max(var_187_11, arg_184_1.talkMaxDuration)

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_18 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_10) / var_187_18

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_10 + var_187_18 and arg_184_1.time_ < var_187_10 + var_187_18 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play325062046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325062046
		arg_188_1.duration_ = 8

		local var_188_0 = {
			zh = 7.266,
			ja = 8
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325062047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.95

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:GetWordFromCfg(325062046)
				local var_191_2 = arg_188_1:FormatText(var_191_1.content)

				arg_188_1.text_.text = var_191_2

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 38 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 38)

				if (38 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 38)) > 0 and var_191_0 < var_191_4 then
					arg_188_1.talkMaxDuration = var_191_4

					if var_191_4 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_4 + 0
					end
				end

				arg_188_1.text_.text = var_191_2
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062046", "story_v_out_325062.awb") ~= 0 then
					local var_191_5 = manager.audio:GetVoiceLength("story_v_out_325062", "325062046", "story_v_out_325062.awb") / 1000

					if var_191_5 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + 0
					end

					if var_191_1.prefab_name ~= "" and arg_188_1.actors_[var_191_1.prefab_name] ~= nil then
						local var_191_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_1.prefab_name].transform, "story_v_out_325062", "325062046", "story_v_out_325062.awb")

						arg_188_1:RecordAudio("325062046", var_191_6)
						arg_188_1:RecordAudio("325062046", var_191_6)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325062", "325062046", "story_v_out_325062.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325062", "325062046", "story_v_out_325062.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325062047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325062047
		arg_192_1.duration_ = 5.63

		local var_192_0 = {
			zh = 1.999999999999,
			ja = 5.633
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325062048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1061ui_story"]) and arg_192_1.var_.characterEffect1061ui_story == nil then
				arg_192_1.var_.characterEffect1061ui_story = arg_192_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1061ui_story"]) then
				if arg_192_1.var_.characterEffect1061ui_story and not isNil(arg_192_1.actors_["1061ui_story"]) then
					arg_192_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1061ui_story"]) and arg_192_1.var_.characterEffect1061ui_story then
				arg_192_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_195_2 = arg_192_1.actors_["1077ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1077ui_story == nil then
				arg_192_1.var_.characterEffect1077ui_story = var_195_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_3 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.characterEffect1077ui_story and not isNil(var_195_2) then
					arg_192_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_3)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1077ui_story then
				arg_192_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_195_4 = 0
			local var_195_5 = 0.15

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(325062047)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 6 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 6)

				if (6 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 6)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062047", "story_v_out_325062.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062047", "story_v_out_325062.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_325062", "325062047", "story_v_out_325062.awb")

						arg_192_1:RecordAudio("325062047", var_195_11)
						arg_192_1:RecordAudio("325062047", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325062", "325062047", "story_v_out_325062.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325062", "325062047", "story_v_out_325062.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_12 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_12 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_12

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_12 and arg_192_1.time_ < var_195_4 + var_195_12 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325062048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325062048
		arg_196_1.duration_ = 9.6

		local var_196_0 = {
			zh = 8.966,
			ja = 9.6
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325062049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1077ui_story"]) and arg_196_1.var_.characterEffect1077ui_story == nil then
				arg_196_1.var_.characterEffect1077ui_story = arg_196_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1077ui_story"]) then
				if arg_196_1.var_.characterEffect1077ui_story and not isNil(arg_196_1.actors_["1077ui_story"]) then
					arg_196_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1077ui_story"]) and arg_196_1.var_.characterEffect1077ui_story then
				arg_196_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_199_2 = arg_196_1.actors_["1061ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1061ui_story == nil then
				arg_196_1.var_.characterEffect1061ui_story = var_199_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_3 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.characterEffect1061ui_story and not isNil(var_199_2) then
					arg_196_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_3)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1061ui_story then
				arg_196_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_199_4 = 0
			local var_199_5 = 0.975

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(325062048)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 39 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 39)

				if (39 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 39)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062048", "story_v_out_325062.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062048", "story_v_out_325062.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_out_325062", "325062048", "story_v_out_325062.awb")

						arg_196_1:RecordAudio("325062048", var_199_11)
						arg_196_1:RecordAudio("325062048", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325062", "325062048", "story_v_out_325062.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325062", "325062048", "story_v_out_325062.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play325062049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325062049
		arg_200_1.duration_ = 6.4

		local var_200_0 = {
			zh = 1.233,
			ja = 6.4
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325062050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1061ui_story"]) and arg_200_1.var_.characterEffect1061ui_story == nil then
				arg_200_1.var_.characterEffect1061ui_story = arg_200_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1061ui_story"]) then
				if arg_200_1.var_.characterEffect1061ui_story and not isNil(arg_200_1.actors_["1061ui_story"]) then
					arg_200_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1061ui_story"]) and arg_200_1.var_.characterEffect1061ui_story then
				arg_200_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_203_2 = arg_200_1.actors_["1077ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1077ui_story == nil then
				arg_200_1.var_.characterEffect1077ui_story = var_203_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_3 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.characterEffect1077ui_story and not isNil(var_203_2) then
					arg_200_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_3)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1077ui_story then
				arg_200_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_203_4 = 0
			local var_203_5 = 0.125

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(325062049)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 5 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 5)

				if (5 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 5)) > 0 and var_203_5 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062049", "story_v_out_325062.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062049", "story_v_out_325062.awb") / 1000

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end

					if var_203_6.prefab_name ~= "" and arg_200_1.actors_[var_203_6.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_6.prefab_name].transform, "story_v_out_325062", "325062049", "story_v_out_325062.awb")

						arg_200_1:RecordAudio("325062049", var_203_11)
						arg_200_1:RecordAudio("325062049", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_325062", "325062049", "story_v_out_325062.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_325062", "325062049", "story_v_out_325062.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_12 and arg_200_1.time_ < var_203_4 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play325062050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325062050
		arg_204_1.duration_ = 5.9

		local var_204_0 = {
			zh = 4.233,
			ja = 5.9
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play325062051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1077ui_story"]) and arg_204_1.var_.characterEffect1077ui_story == nil then
				arg_204_1.var_.characterEffect1077ui_story = arg_204_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1077ui_story"]) then
				if arg_204_1.var_.characterEffect1077ui_story and not isNil(arg_204_1.actors_["1077ui_story"]) then
					arg_204_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1077ui_story"]) and arg_204_1.var_.characterEffect1077ui_story then
				arg_204_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_207_2 = arg_204_1.actors_["1061ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1061ui_story == nil then
				arg_204_1.var_.characterEffect1061ui_story = var_207_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_3 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.characterEffect1061ui_story and not isNil(var_207_2) then
					arg_204_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_3)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1061ui_story then
				arg_204_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_207_4 = 0
			local var_207_5 = 0.475

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:GetWordFromCfg(325062050)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 19 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 19)

				if (19 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 19)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062050", "story_v_out_325062.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062050", "story_v_out_325062.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_325062", "325062050", "story_v_out_325062.awb")

						arg_204_1:RecordAudio("325062050", var_207_11)
						arg_204_1:RecordAudio("325062050", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325062", "325062050", "story_v_out_325062.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325062", "325062050", "story_v_out_325062.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play325062051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325062051
		arg_208_1.duration_ = 6.63

		local var_208_0 = {
			zh = 4.1,
			ja = 6.633
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play325062052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1061ui_story"]) and arg_208_1.var_.characterEffect1061ui_story == nil then
				arg_208_1.var_.characterEffect1061ui_story = arg_208_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1061ui_story"]) then
				if arg_208_1.var_.characterEffect1061ui_story and not isNil(arg_208_1.actors_["1061ui_story"]) then
					arg_208_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1061ui_story"]) and arg_208_1.var_.characterEffect1061ui_story then
				arg_208_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_211_2 = arg_208_1.actors_["1077ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect1077ui_story == nil then
				arg_208_1.var_.characterEffect1077ui_story = var_211_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_3 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.characterEffect1077ui_story and not isNil(var_211_2) then
					arg_208_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_3)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect1077ui_story then
				arg_208_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_211_4 = 0
			local var_211_5 = 0.35

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_6 = arg_208_1:GetWordFromCfg(325062051)
				local var_211_7 = arg_208_1:FormatText(var_211_6.content)

				arg_208_1.text_.text = var_211_7

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_9 = 14 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 14)

				if (14 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 14)) > 0 and var_211_5 < var_211_9 then
					arg_208_1.talkMaxDuration = var_211_9

					if var_211_9 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_4
					end
				end

				arg_208_1.text_.text = var_211_7
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062051", "story_v_out_325062.awb") ~= 0 then
					local var_211_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062051", "story_v_out_325062.awb") / 1000

					if var_211_10 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_4
					end

					if var_211_6.prefab_name ~= "" and arg_208_1.actors_[var_211_6.prefab_name] ~= nil then
						local var_211_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_6.prefab_name].transform, "story_v_out_325062", "325062051", "story_v_out_325062.awb")

						arg_208_1:RecordAudio("325062051", var_211_11)
						arg_208_1:RecordAudio("325062051", var_211_11)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325062", "325062051", "story_v_out_325062.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325062", "325062051", "story_v_out_325062.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_12 = math.max(var_211_5, arg_208_1.talkMaxDuration)

			if var_211_4 <= arg_208_1.time_ and arg_208_1.time_ < var_211_4 + var_211_12 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_4) / var_211_12

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_4 + var_211_12 and arg_208_1.time_ < var_211_4 + var_211_12 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play325062052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325062052
		arg_212_1.duration_ = 8.37

		local var_212_0 = {
			zh = 8.366,
			ja = 6.4
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325062053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1077ui_story"]) and arg_212_1.var_.characterEffect1077ui_story == nil then
				arg_212_1.var_.characterEffect1077ui_story = arg_212_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1077ui_story"]) then
				if arg_212_1.var_.characterEffect1077ui_story and not isNil(arg_212_1.actors_["1077ui_story"]) then
					arg_212_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1077ui_story"]) and arg_212_1.var_.characterEffect1077ui_story then
				arg_212_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_215_2 = arg_212_1.actors_["1061ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1061ui_story == nil then
				arg_212_1.var_.characterEffect1061ui_story = var_215_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_3 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.characterEffect1061ui_story and not isNil(var_215_2) then
					arg_212_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_3)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1061ui_story then
				arg_212_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_215_4 = 0
			local var_215_5 = 0.8

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(325062052)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 32 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 32)

				if (32 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 32)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062052", "story_v_out_325062.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062052", "story_v_out_325062.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_out_325062", "325062052", "story_v_out_325062.awb")

						arg_212_1:RecordAudio("325062052", var_215_11)
						arg_212_1:RecordAudio("325062052", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_325062", "325062052", "story_v_out_325062.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_325062", "325062052", "story_v_out_325062.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play325062053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325062053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325062054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1061ui_story = arg_216_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1061ui_story"].transform.position).z)
				arg_216_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1061ui_story"].transform.localEulerAngles = arg_216_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1061ui_story"].transform.position).z)
				arg_216_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1061ui_story"].transform.localEulerAngles = arg_216_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["1077ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1077ui_story = var_219_1.localPosition

				local var_219_2 = GameObjectTools.GetOrAddComponent(var_219_1.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(false)
				end
			end

			local var_219_3 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 then
				var_219_1.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_3)
				var_219_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_1.position).x, (manager.ui.mainCamera.transform.position - var_219_1.position).y, (manager.ui.mainCamera.transform.position - var_219_1.position).z)
				var_219_1.localEulerAngles.z = 0
				var_219_1.localEulerAngles.x = 0
				var_219_1.localEulerAngles = var_219_1.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 then
				var_219_1.localPosition = Vector3.New(0, 100, 0)
				var_219_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_1.position).x, (manager.ui.mainCamera.transform.position - var_219_1.position).y, (manager.ui.mainCamera.transform.position - var_219_1.position).z)
				var_219_1.localEulerAngles.z = 0
				var_219_1.localEulerAngles.x = 0
				var_219_1.localEulerAngles = var_219_1.localEulerAngles

				local var_219_4 = GameObjectTools.GetOrAddComponent(var_219_1.gameObject, typeof(DynamicBoneHelper))

				if var_219_4 then
					var_219_4:EnableDynamicBone(true)
				end
			end

			local var_219_5 = arg_216_1.actors_["1077ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.characterEffect1077ui_story == nil then
				arg_216_1.var_.characterEffect1077ui_story = var_219_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_6 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_6 and not isNil(var_219_5) then
				if arg_216_1.var_.characterEffect1077ui_story and not isNil(var_219_5) then
					arg_216_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_6)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_6 and arg_216_1.time_ < 0 + var_219_6 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.characterEffect1077ui_story then
				arg_216_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_219_7 = 0
			local var_219_8 = 1.175

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_9 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(325062053).content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 47 <= 0 and var_219_8 or var_219_8 * (utf8.len(var_219_9) / 47)

				if (47 <= 0 and var_219_8 or var_219_8 * (utf8.len(var_219_9) / 47)) > 0 and var_219_8 < var_219_11 then
					arg_216_1.talkMaxDuration = var_219_11

					if var_219_11 + var_219_7 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_11 + var_219_7
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_12 = math.max(var_219_8, arg_216_1.talkMaxDuration)

			if var_219_7 <= arg_216_1.time_ and arg_216_1.time_ < var_219_7 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_7) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_7 + var_219_12 and arg_216_1.time_ < var_219_7 + var_219_12 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play325062054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325062054
		arg_220_1.duration_ = 5.8

		local var_220_0 = {
			zh = 3.7,
			ja = 5.8
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325062055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1061ui_story = arg_220_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1061ui_story"].transform.position).z)
				arg_220_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1061ui_story"].transform.localEulerAngles = arg_220_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_220_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1061ui_story"].transform.position).z)
				arg_220_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1061ui_story"].transform.localEulerAngles = arg_220_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["1061ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1061ui_story == nil then
				arg_220_1.var_.characterEffect1061ui_story = var_223_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_2 and not isNil(var_223_1) then
				if arg_220_1.var_.characterEffect1061ui_story and not isNil(var_223_1) then
					arg_220_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_2 and arg_220_1.time_ < 0 + var_223_2 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1061ui_story then
				arg_220_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_223_4 = 0
			local var_223_5 = 0.2

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(325062054)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 8 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 8)

				if (8 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 8)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062054", "story_v_out_325062.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_325062", "325062054", "story_v_out_325062.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_325062", "325062054", "story_v_out_325062.awb")

						arg_220_1:RecordAudio("325062054", var_223_11)
						arg_220_1:RecordAudio("325062054", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_325062", "325062054", "story_v_out_325062.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_325062", "325062054", "story_v_out_325062.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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

		arg_220_1:InitPlayNodeList()
	end,
	Play325062055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325062055
		arg_224_1.duration_ = 6.63

		local var_224_0 = {
			zh = 5.2,
			ja = 6.633
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325062056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1061ui_story = arg_224_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_227_0 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 then
				arg_224_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_224_1.time_ - 0) / var_227_0)
				arg_224_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1061ui_story"].transform.position).z)
				arg_224_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1061ui_story"].transform.localEulerAngles = arg_224_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 then
				arg_224_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_224_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1061ui_story"].transform.position).z)
				arg_224_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1061ui_story"].transform.localEulerAngles = arg_224_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_227_1 = arg_224_1.actors_["1077ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1077ui_story = var_227_1.localPosition

				local var_227_2 = GameObjectTools.GetOrAddComponent(var_227_1.gameObject, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(false)
				end
			end

			local var_227_3 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 then
				var_227_1.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_224_1.time_ - 0) / var_227_3)
				var_227_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_1.position).x, (manager.ui.mainCamera.transform.position - var_227_1.position).y, (manager.ui.mainCamera.transform.position - var_227_1.position).z)
				var_227_1.localEulerAngles.z = 0
				var_227_1.localEulerAngles.x = 0
				var_227_1.localEulerAngles = var_227_1.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 then
				var_227_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_227_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_1.position).x, (manager.ui.mainCamera.transform.position - var_227_1.position).y, (manager.ui.mainCamera.transform.position - var_227_1.position).z)
				var_227_1.localEulerAngles.z = 0
				var_227_1.localEulerAngles.x = 0
				var_227_1.localEulerAngles = var_227_1.localEulerAngles

				local var_227_4 = GameObjectTools.GetOrAddComponent(var_227_1.gameObject, typeof(DynamicBoneHelper))

				if var_227_4 then
					var_227_4:EnableDynamicBone(true)
				end
			end

			local var_227_5 = arg_224_1.actors_["1077ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect1077ui_story == nil then
				arg_224_1.var_.characterEffect1077ui_story = var_227_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 and not isNil(var_227_5) then
				if arg_224_1.var_.characterEffect1077ui_story and not isNil(var_227_5) then
					arg_224_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect1077ui_story then
				arg_224_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_227_8 = arg_224_1.actors_["1061ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_8) and arg_224_1.var_.characterEffect1061ui_story == nil then
				arg_224_1.var_.characterEffect1061ui_story = var_227_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_9 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_9 and not isNil(var_227_8) then
				if arg_224_1.var_.characterEffect1061ui_story and not isNil(var_227_8) then
					arg_224_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_9)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_9 and arg_224_1.time_ < 0 + var_227_9 + arg_227_0 and not isNil(var_227_8) and arg_224_1.var_.characterEffect1061ui_story then
				arg_224_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_227_10 = 0
			local var_227_11 = 0.475

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_12 = arg_224_1:GetWordFromCfg(325062055)
				local var_227_13 = arg_224_1:FormatText(var_227_12.content)

				arg_224_1.text_.text = var_227_13

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_15 = 19 <= 0 and var_227_11 or var_227_11 * (utf8.len(var_227_13) / 19)

				if (19 <= 0 and var_227_11 or var_227_11 * (utf8.len(var_227_13) / 19)) > 0 and var_227_11 < var_227_15 then
					arg_224_1.talkMaxDuration = var_227_15

					if var_227_15 + var_227_10 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_15 + var_227_10
					end
				end

				arg_224_1.text_.text = var_227_13
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062055", "story_v_out_325062.awb") ~= 0 then
					local var_227_16 = manager.audio:GetVoiceLength("story_v_out_325062", "325062055", "story_v_out_325062.awb") / 1000

					if var_227_16 + var_227_10 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_16 + var_227_10
					end

					if var_227_12.prefab_name ~= "" and arg_224_1.actors_[var_227_12.prefab_name] ~= nil then
						local var_227_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_12.prefab_name].transform, "story_v_out_325062", "325062055", "story_v_out_325062.awb")

						arg_224_1:RecordAudio("325062055", var_227_17)
						arg_224_1:RecordAudio("325062055", var_227_17)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_325062", "325062055", "story_v_out_325062.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_325062", "325062055", "story_v_out_325062.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_18 = math.max(var_227_11, arg_224_1.talkMaxDuration)

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_18 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_10) / var_227_18

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_10 + var_227_18 and arg_224_1.time_ < var_227_10 + var_227_18 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play325062056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325062056
		arg_228_1.duration_ = 4

		local var_228_0 = {
			zh = 3.033,
			ja = 4
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
			arg_228_1.auto_ = false
		end

		function arg_228_1.playNext_(arg_230_0)
			arg_228_1.onStoryFinished_()
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1061ui_story"]) and arg_228_1.var_.characterEffect1061ui_story == nil then
				arg_228_1.var_.characterEffect1061ui_story = arg_228_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1061ui_story"]) then
				if arg_228_1.var_.characterEffect1061ui_story and not isNil(arg_228_1.actors_["1061ui_story"]) then
					arg_228_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1061ui_story"]) and arg_228_1.var_.characterEffect1061ui_story then
				arg_228_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["1077ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1077ui_story == nil then
				arg_228_1.var_.characterEffect1077ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect1077ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1077ui_story then
				arg_228_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_231_5 = 0
			local var_231_6 = 0.225

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_7 = arg_228_1:GetWordFromCfg(325062056)
				local var_231_8 = arg_228_1:FormatText(var_231_7.content)

				arg_228_1.text_.text = var_231_8

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_10 = 9 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 9)

				if (9 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 9)) > 0 and var_231_6 < var_231_10 then
					arg_228_1.talkMaxDuration = var_231_10

					if var_231_10 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_5
					end
				end

				arg_228_1.text_.text = var_231_8
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325062", "325062056", "story_v_out_325062.awb") ~= 0 then
					local var_231_11 = manager.audio:GetVoiceLength("story_v_out_325062", "325062056", "story_v_out_325062.awb") / 1000

					if var_231_11 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_5
					end

					if var_231_7.prefab_name ~= "" and arg_228_1.actors_[var_231_7.prefab_name] ~= nil then
						local var_231_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_7.prefab_name].transform, "story_v_out_325062", "325062056", "story_v_out_325062.awb")

						arg_228_1:RecordAudio("325062056", var_231_12)
						arg_228_1:RecordAudio("325062056", var_231_12)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325062", "325062056", "story_v_out_325062.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325062", "325062056", "story_v_out_325062.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_13 = math.max(var_231_6, arg_228_1.talkMaxDuration)

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_13 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_5) / var_231_13

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_5 + var_231_13 and arg_228_1.time_ < var_231_5 + var_231_13 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J11",
		"TextureConfig/Background/J03h"
	},
	voices = {
		"story_v_out_325062.awb"
	}
}
