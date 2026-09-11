return {
	Play324102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324102001
		arg_1_1.duration_ = 4.7

		local var_1_0 = {
			zh = 4.666,
			ja = 4.7
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
				arg_1_0:Play324102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J27g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27g")
				var_4_0.name = "J27g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J27g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J27g

				arg_1_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J27g" then
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

			local var_4_9 = "6148ui_story"

			if arg_1_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["6148ui_story"].transform

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos6148ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_1_1.time_ - 1.63333333333333) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_15 and arg_1_1.time_ < 1.63333333333333 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["6148ui_story"]

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect6148ui_story == nil then
				arg_1_1.var_.characterEffect6148ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect6148ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_18 and arg_1_1.time_ < 1.63333333333333 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect6148ui_story then
				arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_150", "se_story_150_huatian", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

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
			local var_4_26 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(324102001)
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

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102001", "story_v_out_324102.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_324102", "324102001", "story_v_out_324102.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_324102", "324102001", "story_v_out_324102.awb")

						arg_1_1:RecordAudio("324102001", var_4_33)
						arg_1_1:RecordAudio("324102001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324102", "324102001", "story_v_out_324102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324102", "324102001", "story_v_out_324102.awb")
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
				actorName = "6148ui_story",
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
	Play324102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324102002
		arg_8_1.duration_ = 10.43

		local var_8_0 = {
			zh = 10.433,
			ja = 6.466
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
				arg_8_0:Play324102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1054ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1054ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1054ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1054ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1054ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1054ui_story = var_11_3.localPosition

				local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_4 then
					var_11_4:EnableDynamicBone(false)
				end
			end

			local var_11_5 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_5 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_8_1.time_ - 0) / var_11_5)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_5 and arg_8_1.time_ < 0 + var_11_5 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles

				local var_11_6 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_6 then
					var_11_6:EnableDynamicBone(true)
				end
			end

			local var_11_7 = arg_8_1.actors_["1054ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1054ui_story == nil then
				arg_8_1.var_.characterEffect1054ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect1054ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1054ui_story then
				arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_11_10 = arg_8_1.actors_["6148ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect6148ui_story == nil then
				arg_8_1.var_.characterEffect6148ui_story = var_11_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_11 and not isNil(var_11_10) then
				if arg_8_1.var_.characterEffect6148ui_story and not isNil(var_11_10) then
					arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_11)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_11 and arg_8_1.time_ < 0 + var_11_11 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect6148ui_story then
				arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_11_12 = "1036ui_story"

			if arg_8_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_11_13 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_8_1.stage_.transform)

				var_11_13.name = var_11_12
				var_11_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_12] = var_11_13

				local var_11_14 = var_11_13:GetComponentInChildren(typeof(CharacterEffect))

				var_11_14.enabled = true

				local var_11_15 = GameObjectTools.GetOrAddComponent(var_11_13, typeof(DynamicBoneHelper))

				if var_11_15 then
					var_11_15:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_14.transform, false)

				arg_8_1.var_[var_11_12 .. "Animator"] = var_11_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_12 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_12 .. "LipSync"] = var_11_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_16 = 0
			local var_11_17 = 1.175

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_18 = arg_8_1:GetWordFromCfg(324102002)
				local var_11_19 = arg_8_1:FormatText(var_11_18.content)

				arg_8_1.text_.text = var_11_19

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 47 <= 0 and var_11_17 or var_11_17 * (utf8.len(var_11_19) / 47)

				if (47 <= 0 and var_11_17 or var_11_17 * (utf8.len(var_11_19) / 47)) > 0 and var_11_17 < var_11_21 then
					arg_8_1.talkMaxDuration = var_11_21

					if var_11_21 + var_11_16 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_16
					end
				end

				arg_8_1.text_.text = var_11_19
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102002", "story_v_out_324102.awb") ~= 0 then
					local var_11_22 = manager.audio:GetVoiceLength("story_v_out_324102", "324102002", "story_v_out_324102.awb") / 1000

					if var_11_22 + var_11_16 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_16
					end

					if var_11_18.prefab_name ~= "" and arg_8_1.actors_[var_11_18.prefab_name] ~= nil then
						local var_11_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_18.prefab_name].transform, "story_v_out_324102", "324102002", "story_v_out_324102.awb")

						arg_8_1:RecordAudio("324102002", var_11_23)
						arg_8_1:RecordAudio("324102002", var_11_23)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324102", "324102002", "story_v_out_324102.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324102", "324102002", "story_v_out_324102.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_24 = math.max(var_11_17, arg_8_1.talkMaxDuration)

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_24 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_16) / var_11_24

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_16 + var_11_24 and arg_8_1.time_ < var_11_16 + var_11_24 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324102003
		arg_12_1.duration_ = 11.37

		local var_12_0 = {
			zh = 7.4,
			ja = 11.366
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
				arg_12_0:Play324102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["6148ui_story"]) and arg_12_1.var_.characterEffect6148ui_story == nil then
				arg_12_1.var_.characterEffect6148ui_story = arg_12_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["6148ui_story"]) then
				if arg_12_1.var_.characterEffect6148ui_story and not isNil(arg_12_1.actors_["6148ui_story"]) then
					arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["6148ui_story"]) and arg_12_1.var_.characterEffect6148ui_story then
				arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["1054ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1054ui_story == nil then
				arg_12_1.var_.characterEffect1054ui_story = var_15_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_3 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.characterEffect1054ui_story and not isNil(var_15_2) then
					arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_3)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1054ui_story then
				arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_15_4 = 0
			local var_15_5 = 0.85

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_6 = arg_12_1:GetWordFromCfg(324102003)
				local var_15_7 = arg_12_1:FormatText(var_15_6.content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 34 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 34)

				if (34 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 34)) > 0 and var_15_5 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102003", "story_v_out_324102.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_324102", "324102003", "story_v_out_324102.awb") / 1000

					if var_15_10 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_4
					end

					if var_15_6.prefab_name ~= "" and arg_12_1.actors_[var_15_6.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_6.prefab_name].transform, "story_v_out_324102", "324102003", "story_v_out_324102.awb")

						arg_12_1:RecordAudio("324102003", var_15_11)
						arg_12_1:RecordAudio("324102003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324102", "324102003", "story_v_out_324102.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324102", "324102003", "story_v_out_324102.awb")
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
	Play324102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324102004
		arg_16_1.duration_ = 5.97

		local var_16_0 = {
			zh = 5.966,
			ja = 4.933
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
				arg_16_0:Play324102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1054ui_story"]) and arg_16_1.var_.characterEffect1054ui_story == nil then
				arg_16_1.var_.characterEffect1054ui_story = arg_16_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1054ui_story"]) then
				if arg_16_1.var_.characterEffect1054ui_story and not isNil(arg_16_1.actors_["1054ui_story"]) then
					arg_16_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1054ui_story"]) and arg_16_1.var_.characterEffect1054ui_story then
				arg_16_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_19_2 = arg_16_1.actors_["6148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_3 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_2) then
					arg_16_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_16_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_3)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect6148ui_story then
				arg_16_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_16_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_19_4 = 0
			local var_19_5 = 0.65

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(324102004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 26 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 26)

				if (26 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 26)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102004", "story_v_out_324102.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_324102", "324102004", "story_v_out_324102.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_324102", "324102004", "story_v_out_324102.awb")

						arg_16_1:RecordAudio("324102004", var_19_11)
						arg_16_1:RecordAudio("324102004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324102", "324102004", "story_v_out_324102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324102", "324102004", "story_v_out_324102.awb")
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
	Play324102005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324102005
		arg_20_1.duration_ = 5.97

		local var_20_0 = {
			zh = 3.866,
			ja = 5.966
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
				arg_20_0:Play324102006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["6148ui_story"]) and arg_20_1.var_.characterEffect6148ui_story == nil then
				arg_20_1.var_.characterEffect6148ui_story = arg_20_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["6148ui_story"]) then
				if arg_20_1.var_.characterEffect6148ui_story and not isNil(arg_20_1.actors_["6148ui_story"]) then
					arg_20_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["6148ui_story"]) and arg_20_1.var_.characterEffect6148ui_story then
				arg_20_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1054ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1054ui_story == nil then
				arg_20_1.var_.characterEffect1054ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1054ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1054ui_story then
				arg_20_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_23_4 = 0
			local var_23_5 = 0.325

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(324102005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 13 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 13)

				if (13 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 13)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102005", "story_v_out_324102.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_324102", "324102005", "story_v_out_324102.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_324102", "324102005", "story_v_out_324102.awb")

						arg_20_1:RecordAudio("324102005", var_23_11)
						arg_20_1:RecordAudio("324102005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324102", "324102005", "story_v_out_324102.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324102", "324102005", "story_v_out_324102.awb")
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
	Play324102006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324102006
		arg_24_1.duration_ = 9.1

		local var_24_0 = {
			zh = 6.6,
			ja = 9.1
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
				arg_24_0:Play324102007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1054ui_story"]) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = arg_24_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1054ui_story"]) then
				if arg_24_1.var_.characterEffect1054ui_story and not isNil(arg_24_1.actors_["1054ui_story"]) then
					arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1054ui_story"]) and arg_24_1.var_.characterEffect1054ui_story then
				arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["6148ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect6148ui_story == nil then
				arg_24_1.var_.characterEffect6148ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect6148ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_24_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect6148ui_story then
				arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_24_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_2")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_4 = 0
			local var_27_5 = 0.575

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(324102006)
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

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102006", "story_v_out_324102.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_324102", "324102006", "story_v_out_324102.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_324102", "324102006", "story_v_out_324102.awb")

						arg_24_1:RecordAudio("324102006", var_27_11)
						arg_24_1:RecordAudio("324102006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324102", "324102006", "story_v_out_324102.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324102", "324102006", "story_v_out_324102.awb")
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
	Play324102007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324102007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324102008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1054ui_story"]) and arg_28_1.var_.characterEffect1054ui_story == nil then
				arg_28_1.var_.characterEffect1054ui_story = arg_28_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1054ui_story"]) then
				if arg_28_1.var_.characterEffect1054ui_story and not isNil(arg_28_1.actors_["1054ui_story"]) then
					arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1054ui_story"]) and arg_28_1.var_.characterEffect1054ui_story then
				arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.65

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(324102007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 26 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 26)

				if (26 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 26)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324102008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324102008
		arg_32_1.duration_ = 4.3

		local var_32_0 = {
			zh = 2.8,
			ja = 4.3
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
				arg_32_0:Play324102009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["6148ui_story"]) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = arg_32_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["6148ui_story"]) then
				if arg_32_1.var_.characterEffect6148ui_story and not isNil(arg_32_1.actors_["6148ui_story"]) then
					arg_32_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["6148ui_story"]) and arg_32_1.var_.characterEffect6148ui_story then
				arg_32_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_35_2 = 0
			local var_35_3 = 0.175

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(324102008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 7 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 7)

				if (7 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 7)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102008", "story_v_out_324102.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_324102", "324102008", "story_v_out_324102.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_324102", "324102008", "story_v_out_324102.awb")

						arg_32_1:RecordAudio("324102008", var_35_9)
						arg_32_1:RecordAudio("324102008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324102", "324102008", "story_v_out_324102.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324102", "324102008", "story_v_out_324102.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324102009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324102009
		arg_36_1.duration_ = 5.73

		local var_36_0 = {
			zh = 2.3,
			ja = 5.733
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
				arg_36_0:Play324102010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1054ui_story"]) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = arg_36_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1054ui_story"]) then
				if arg_36_1.var_.characterEffect1054ui_story and not isNil(arg_36_1.actors_["1054ui_story"]) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1054ui_story"]) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["6148ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect6148ui_story == nil then
				arg_36_1.var_.characterEffect6148ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect6148ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_36_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect6148ui_story then
				arg_36_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_36_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_4 = 0
			local var_39_5 = 0.225

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(324102009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 9 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 9)

				if (9 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 9)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102009", "story_v_out_324102.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_324102", "324102009", "story_v_out_324102.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_324102", "324102009", "story_v_out_324102.awb")

						arg_36_1:RecordAudio("324102009", var_39_11)
						arg_36_1:RecordAudio("324102009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324102", "324102009", "story_v_out_324102.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324102", "324102009", "story_v_out_324102.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324102010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324102010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324102011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = arg_40_1.actors_["1054ui_story"].transform.localPosition

				local var_43_0 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_0 then
					var_43_0:EnableDynamicBone(false)
				end
			end

			local var_43_1 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_1)
				arg_40_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).z)
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles = arg_40_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).z)
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles = arg_40_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_43_2 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(true)
				end
			end

			local var_43_3 = arg_40_1.actors_["6148ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos6148ui_story = var_43_3.localPosition

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(false)
				end
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_5)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0, 100, 0)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(true)
				end
			end

			local var_43_7 = arg_40_1.actors_["1054ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_8)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_43_9 = 0
			local var_43_10 = 0.875

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_11 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(324102010).content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 35 <= 0 and var_43_10 or var_43_10 * (utf8.len(var_43_11) / 35)

				if (35 <= 0 and var_43_10 or var_43_10 * (utf8.len(var_43_11) / 35)) > 0 and var_43_10 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_9 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_9
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_10, arg_40_1.talkMaxDuration)

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_9) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_9 + var_43_14 and arg_40_1.time_ < var_43_9 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play324102011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324102011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324102012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(324102011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 45 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 45)

				if (45 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 45)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324102012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324102012
		arg_48_1.duration_ = 2.63

		local var_48_0 = {
			zh = 2.333,
			ja = 2.633
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
				arg_48_0:Play324102013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos6148ui_story = arg_48_1.actors_["6148ui_story"].transform.localPosition

				local var_51_0 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_0 then
					var_51_0:EnableDynamicBone(false)
				end
			end

			local var_51_1 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 then
				arg_48_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_48_1.time_ - 0) / var_51_1)
				arg_48_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).z)
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles = arg_48_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 then
				arg_48_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_48_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).z)
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles = arg_48_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_51_2 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(true)
				end
			end

			local var_51_3 = arg_48_1.actors_["6148ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect6148ui_story == nil then
				arg_48_1.var_.characterEffect6148ui_story = var_51_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_4 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 and not isNil(var_51_3) then
				if arg_48_1.var_.characterEffect6148ui_story and not isNil(var_51_3) then
					arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect6148ui_story then
				arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_51_6 = 0
			local var_51_7 = 0.25

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(324102012)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 10 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 10)

				if (10 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 10)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102012", "story_v_out_324102.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_324102", "324102012", "story_v_out_324102.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_324102", "324102012", "story_v_out_324102.awb")

						arg_48_1:RecordAudio("324102012", var_51_13)
						arg_48_1:RecordAudio("324102012", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324102", "324102012", "story_v_out_324102.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324102", "324102012", "story_v_out_324102.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play324102013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324102013
		arg_52_1.duration_ = 4.07

		local var_52_0 = {
			zh = 3.166,
			ja = 4.066
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
				arg_52_0:Play324102014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1054ui_story = arg_52_1.actors_["1054ui_story"].transform.localPosition

				local var_55_0 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_0 then
					var_55_0:EnableDynamicBone(false)
				end
			end

			local var_55_1 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 then
				arg_52_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_52_1.time_ - 0) / var_55_1)
				arg_52_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1054ui_story"].transform.position).z)
				arg_52_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1054ui_story"].transform.localEulerAngles = arg_52_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 then
				arg_52_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_52_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1054ui_story"].transform.position).z)
				arg_52_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1054ui_story"].transform.localEulerAngles = arg_52_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_55_2 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(true)
				end
			end

			local var_55_3 = arg_52_1.actors_["1054ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1054ui_story == nil then
				arg_52_1.var_.characterEffect1054ui_story = var_55_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_4 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 and not isNil(var_55_3) then
				if arg_52_1.var_.characterEffect1054ui_story and not isNil(var_55_3) then
					arg_52_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1054ui_story then
				arg_52_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_55_6 = arg_52_1.actors_["6148ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect6148ui_story == nil then
				arg_52_1.var_.characterEffect6148ui_story = var_55_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 and not isNil(var_55_6) then
				if arg_52_1.var_.characterEffect6148ui_story and not isNil(var_55_6) then
					arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_52_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_7)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect6148ui_story then
				arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_52_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_55_8 = 0
			local var_55_9 = 0.325

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_10 = arg_52_1:GetWordFromCfg(324102013)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 13 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 13)

				if (13 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 13)) > 0 and var_55_9 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324102", "324102013", "story_v_out_324102.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_324102", "324102013", "story_v_out_324102.awb") / 1000

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end

					if var_55_10.prefab_name ~= "" and arg_52_1.actors_[var_55_10.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_10.prefab_name].transform, "story_v_out_324102", "324102013", "story_v_out_324102.awb")

						arg_52_1:RecordAudio("324102013", var_55_15)
						arg_52_1:RecordAudio("324102013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324102", "324102013", "story_v_out_324102.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324102", "324102013", "story_v_out_324102.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_16 and arg_52_1.time_ < var_55_8 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play324102014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324102014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
			arg_56_1.auto_ = false
		end

		function arg_56_1.playNext_(arg_58_0)
			arg_56_1.onStoryFinished_()
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1054ui_story"]) and arg_56_1.var_.characterEffect1054ui_story == nil then
				arg_56_1.var_.characterEffect1054ui_story = arg_56_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1054ui_story"]) then
				if arg_56_1.var_.characterEffect1054ui_story and not isNil(arg_56_1.actors_["1054ui_story"]) then
					arg_56_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1054ui_story"]) and arg_56_1.var_.characterEffect1054ui_story then
				arg_56_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.3

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(324102014).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 12 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 12)

				if (12 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 12)) > 0 and var_59_2 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_6 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_6 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_6

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_6 and arg_56_1.time_ < var_59_1 + var_59_6 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27g"
	},
	voices = {
		"story_v_out_324102.awb"
	}
}
