return {
	Play324162001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324162001
		arg_1_1.duration_ = 4.4

		local var_1_0 = {
			zh = 4.266,
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
				arg_1_0:Play324162002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J27i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27i")
				var_4_0.name = "J27i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J27i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J27i

				arg_1_1.bgs_.J27i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J27i" then
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

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos6148ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.76666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666667 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_1_1.time_ - 1.76666666666667) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.76666666666667 + var_4_15 and arg_1_1.time_ < 1.76666666666667 + var_4_15 + arg_4_0 then
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

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect6148ui_story == nil then
				arg_1_1.var_.characterEffect6148ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.76666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666667 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect6148ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.76666666666667 + var_4_18 and arg_1_1.time_ < 1.76666666666667 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect6148ui_story then
				arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao")

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
			local var_4_26 = 0.25

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

				local var_4_28 = arg_1_1:GetWordFromCfg(324162001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)

				if (10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162001", "story_v_out_324162.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_324162", "324162001", "story_v_out_324162.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_324162", "324162001", "story_v_out_324162.awb")

						arg_1_1:RecordAudio("324162001", var_4_33)
						arg_1_1:RecordAudio("324162001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324162", "324162001", "story_v_out_324162.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324162", "324162001", "story_v_out_324162.awb")
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
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324162002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324162002
		arg_8_1.duration_ = 2.03

		local var_8_0 = {
			zh = 2.033,
			ja = 1.999999999999
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
				arg_8_0:Play324162003(arg_8_1)
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

			local var_11_7 = arg_8_1.actors_["6148ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect6148ui_story == nil then
				arg_8_1.var_.characterEffect6148ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect6148ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_8)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect6148ui_story then
				arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_11_9 = arg_8_1.actors_["1054ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1054ui_story == nil then
				arg_8_1.var_.characterEffect1054ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_10 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 and not isNil(var_11_9) then
				if arg_8_1.var_.characterEffect1054ui_story and not isNil(var_11_9) then
					arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1054ui_story then
				arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_11_12 = 0
			local var_11_13 = 0.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
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

				local var_11_14 = arg_8_1:GetWordFromCfg(324162002)
				local var_11_15 = arg_8_1:FormatText(var_11_14.content)

				arg_8_1.text_.text = var_11_15

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_17 = 8 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 8)

				if (8 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 8)) > 0 and var_11_13 < var_11_17 then
					arg_8_1.talkMaxDuration = var_11_17

					if var_11_17 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_12
					end
				end

				arg_8_1.text_.text = var_11_15
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162002", "story_v_out_324162.awb") ~= 0 then
					local var_11_18 = manager.audio:GetVoiceLength("story_v_out_324162", "324162002", "story_v_out_324162.awb") / 1000

					if var_11_18 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_12
					end

					if var_11_14.prefab_name ~= "" and arg_8_1.actors_[var_11_14.prefab_name] ~= nil then
						local var_11_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_14.prefab_name].transform, "story_v_out_324162", "324162002", "story_v_out_324162.awb")

						arg_8_1:RecordAudio("324162002", var_11_19)
						arg_8_1:RecordAudio("324162002", var_11_19)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324162", "324162002", "story_v_out_324162.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324162", "324162002", "story_v_out_324162.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_20 = math.max(var_11_13, arg_8_1.talkMaxDuration)

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_20 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_12) / var_11_20

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_12 + var_11_20 and arg_8_1.time_ < var_11_12 + var_11_20 + arg_11_0 then
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
	Play324162003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324162003
		arg_12_1.duration_ = 2.17

		local var_12_0 = {
			zh = 1.666,
			ja = 2.166
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
				arg_12_0:Play324162004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1054ui_story"]) and arg_12_1.var_.characterEffect1054ui_story == nil then
				arg_12_1.var_.characterEffect1054ui_story = arg_12_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1054ui_story"]) then
				if arg_12_1.var_.characterEffect1054ui_story and not isNil(arg_12_1.actors_["1054ui_story"]) then
					arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1054ui_story"]) and arg_12_1.var_.characterEffect1054ui_story then
				arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_15_1 = arg_12_1.actors_["6148ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_1) and arg_12_1.var_.characterEffect6148ui_story == nil then
				arg_12_1.var_.characterEffect6148ui_story = var_15_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_2 and not isNil(var_15_1) then
				if arg_12_1.var_.characterEffect6148ui_story and not isNil(var_15_1) then
					arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_2 and arg_12_1.time_ < 0 + var_15_2 + arg_15_0 and not isNil(var_15_1) and arg_12_1.var_.characterEffect6148ui_story then
				arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_15_4 = 0
			local var_15_5 = 0.15

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

				local var_15_6 = arg_12_1:GetWordFromCfg(324162003)
				local var_15_7 = arg_12_1:FormatText(var_15_6.content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 6 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 6)

				if (6 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 6)) > 0 and var_15_5 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162003", "story_v_out_324162.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_324162", "324162003", "story_v_out_324162.awb") / 1000

					if var_15_10 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_4
					end

					if var_15_6.prefab_name ~= "" and arg_12_1.actors_[var_15_6.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_6.prefab_name].transform, "story_v_out_324162", "324162003", "story_v_out_324162.awb")

						arg_12_1:RecordAudio("324162003", var_15_11)
						arg_12_1:RecordAudio("324162003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324162", "324162003", "story_v_out_324162.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324162", "324162003", "story_v_out_324162.awb")
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
	Play324162004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324162004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324162005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1054ui_story = arg_16_1.actors_["1054ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1054ui_story"].transform.position).z)
				arg_16_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1054ui_story"].transform.localEulerAngles = arg_16_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1054ui_story"].transform.position).z)
				arg_16_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1054ui_story"].transform.localEulerAngles = arg_16_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["6148ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, 100, 0)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = "1037ui_story"

			if arg_16_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_19_8 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_16_1.stage_.transform)

				var_19_8.name = var_19_7
				var_19_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_7] = var_19_8

				local var_19_9 = var_19_8:GetComponentInChildren(typeof(CharacterEffect))

				var_19_9.enabled = true

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_8, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_9.transform, false)

				arg_16_1.var_[var_19_7 .. "Animator"] = var_19_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_7 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_7 .. "LipSync"] = var_19_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_11 = arg_16_1.actors_["1037ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_12 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_12 and not isNil(var_19_11) then
				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_12)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_12 and arg_16_1.time_ < 0 + var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1037ui_story then
				arg_16_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_19_13 = 0
			local var_19_14 = 1.025

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_15 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(324162004).content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 41 <= 0 and var_19_14 or var_19_14 * (utf8.len(var_19_15) / 41)

				if (41 <= 0 and var_19_14 or var_19_14 * (utf8.len(var_19_15) / 41)) > 0 and var_19_14 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_13 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_13
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_14, arg_16_1.talkMaxDuration)

			if var_19_13 <= arg_16_1.time_ and arg_16_1.time_ < var_19_13 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_13) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_13 + var_19_18 and arg_16_1.time_ < var_19_13 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play324162005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324162005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324162006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.7

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(324162005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 28 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 28)

				if (28 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 28)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324162006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324162006
		arg_24_1.duration_ = 5.63

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324162007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0.0333333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 0.0333333333333333 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			if arg_24_1.time_ >= 0.0333333333333333 + 1.33333333333333 and arg_24_1.time_ < 0.0333333333333333 + 1.33333333333333 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			if 0.1 < arg_24_1.time_ and arg_24_1.time_ <= 0.1 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone04", "")
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_1 = 0.633333333333333
			local var_27_2 = 0.9

			if 0.633333333333333 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_3 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_3:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(324162006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 36 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 36)

				if (36 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 36)) > 0 and var_27_2 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6
					var_27_1 = var_27_1 + 0.3

					if var_27_6 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = var_27_1 + 0.3
			local var_27_8 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_7 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_7) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_7 + var_27_8 and arg_24_1.time_ < var_27_7 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 0.5,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.9,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324162007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 324162007
		arg_30_1.duration_ = 2.57

		local var_30_0 = {
			zh = 1.833,
			ja = 2.566
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play324162008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.125

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:GetWordFromCfg(324162007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 5 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 5)

				if (5 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 5)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162007", "story_v_out_324162.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_324162", "324162007", "story_v_out_324162.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_324162", "324162007", "story_v_out_324162.awb")

						arg_30_1:RecordAudio("324162007", var_33_6)
						arg_30_1:RecordAudio("324162007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_324162", "324162007", "story_v_out_324162.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_324162", "324162007", "story_v_out_324162.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play324162008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324162008
		arg_34_1.duration_ = 3.2

		local var_34_0 = {
			zh = 3.2,
			ja = 3.1
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play324162009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_37_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_34_1.stage_.transform)

				var_37_0.name = "1075ui_story"
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["1075ui_story"] = var_37_0

				local var_37_1 = var_37_0:GetComponentInChildren(typeof(CharacterEffect))

				var_37_1.enabled = true

				local var_37_2 = GameObjectTools.GetOrAddComponent(var_37_0, typeof(DynamicBoneHelper))

				if var_37_2 then
					var_37_2:EnableDynamicBone(false)
				end

				arg_34_1:ShowWeapon(var_37_1.transform, false)

				arg_34_1.var_["1075ui_story" .. "Animator"] = var_37_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_34_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_34_1.var_["1075ui_story" .. "LipSync"] = var_37_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_37_3 = arg_34_1.actors_["1075ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1075ui_story = var_37_3.localPosition
			end

			local var_37_4 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_3.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_34_1.time_ - 0) / var_37_4)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			local var_37_5 = arg_34_1.actors_["1075ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1075ui_story == nil then
				arg_34_1.var_.characterEffect1075ui_story = var_37_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_6 and not isNil(var_37_5) then
				if arg_34_1.var_.characterEffect1075ui_story and not isNil(var_37_5) then
					arg_34_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_6 and arg_34_1.time_ < 0 + var_37_6 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1075ui_story then
				arg_34_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_37_8 = "1036ui_story"

			if arg_34_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_37_9 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_34_1.stage_.transform)

				var_37_9.name = var_37_8
				var_37_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_[var_37_8] = var_37_9

				local var_37_10 = var_37_9:GetComponentInChildren(typeof(CharacterEffect))

				var_37_10.enabled = true

				local var_37_11 = GameObjectTools.GetOrAddComponent(var_37_9, typeof(DynamicBoneHelper))

				if var_37_11 then
					var_37_11:EnableDynamicBone(false)
				end

				arg_34_1:ShowWeapon(var_37_10.transform, false)

				arg_34_1.var_[var_37_8 .. "Animator"] = var_37_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_34_1.var_[var_37_8 .. "Animator"].applyRootMotion = true
				arg_34_1.var_[var_37_8 .. "LipSync"] = var_37_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_37_12 = arg_34_1.actors_["1036ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_12) and arg_34_1.var_.characterEffect1036ui_story == nil then
				arg_34_1.var_.characterEffect1036ui_story = var_37_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_13 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_13 and not isNil(var_37_12) then
				if arg_34_1.var_.characterEffect1036ui_story and not isNil(var_37_12) then
					arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_13)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_13 and arg_34_1.time_ < 0 + var_37_13 + arg_37_0 and not isNil(var_37_12) and arg_34_1.var_.characterEffect1036ui_story then
				arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_37_14 = 0
			local var_37_15 = 0.35

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_16 = arg_34_1:GetWordFromCfg(324162008)
				local var_37_17 = arg_34_1:FormatText(var_37_16.content)

				arg_34_1.text_.text = var_37_17

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_19 = 14 <= 0 and var_37_15 or var_37_15 * (utf8.len(var_37_17) / 14)

				if (14 <= 0 and var_37_15 or var_37_15 * (utf8.len(var_37_17) / 14)) > 0 and var_37_15 < var_37_19 then
					arg_34_1.talkMaxDuration = var_37_19

					if var_37_19 + var_37_14 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_19 + var_37_14
					end
				end

				arg_34_1.text_.text = var_37_17
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162008", "story_v_out_324162.awb") ~= 0 then
					local var_37_20 = manager.audio:GetVoiceLength("story_v_out_324162", "324162008", "story_v_out_324162.awb") / 1000

					if var_37_20 + var_37_14 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_20 + var_37_14
					end

					if var_37_16.prefab_name ~= "" and arg_34_1.actors_[var_37_16.prefab_name] ~= nil then
						local var_37_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_16.prefab_name].transform, "story_v_out_324162", "324162008", "story_v_out_324162.awb")

						arg_34_1:RecordAudio("324162008", var_37_21)
						arg_34_1:RecordAudio("324162008", var_37_21)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_324162", "324162008", "story_v_out_324162.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_324162", "324162008", "story_v_out_324162.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_22 = math.max(var_37_15, arg_34_1.talkMaxDuration)

			if var_37_14 <= arg_34_1.time_ and arg_34_1.time_ < var_37_14 + var_37_22 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_14) / var_37_22

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_14 + var_37_22 and arg_34_1.time_ < var_37_14 + var_37_22 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play324162009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324162009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324162010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1036ui_story = arg_38_1.actors_["1036ui_story"].transform.localPosition
			end

			local var_41_0 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				arg_38_1.actors_["1036ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_38_1.time_ - 0) / var_41_0)
				arg_38_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1036ui_story"].transform.position).z)
				arg_38_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1036ui_story"].transform.localEulerAngles = arg_38_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				arg_38_1.actors_["1036ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1036ui_story"].transform.position).z)
				arg_38_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1036ui_story"].transform.localEulerAngles = arg_38_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			local var_41_1 = arg_38_1.actors_["1075ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1075ui_story = var_41_1.localPosition
			end

			local var_41_2 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_2 then
				var_41_1.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_38_1.time_ - 0) / var_41_2)
				var_41_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_1.position).x, (manager.ui.mainCamera.transform.position - var_41_1.position).y, (manager.ui.mainCamera.transform.position - var_41_1.position).z)
				var_41_1.localEulerAngles.z = 0
				var_41_1.localEulerAngles.x = 0
				var_41_1.localEulerAngles = var_41_1.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_2 and arg_38_1.time_ < 0 + var_41_2 + arg_41_0 then
				var_41_1.localPosition = Vector3.New(0, 100, 0)
				var_41_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_1.position).x, (manager.ui.mainCamera.transform.position - var_41_1.position).y, (manager.ui.mainCamera.transform.position - var_41_1.position).z)
				var_41_1.localEulerAngles.z = 0
				var_41_1.localEulerAngles.x = 0
				var_41_1.localEulerAngles = var_41_1.localEulerAngles
			end

			local var_41_3 = arg_38_1.actors_["1075ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect1075ui_story == nil then
				arg_38_1.var_.characterEffect1075ui_story = var_41_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_4 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 and not isNil(var_41_3) then
				if arg_38_1.var_.characterEffect1075ui_story and not isNil(var_41_3) then
					arg_38_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_4)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect1075ui_story then
				arg_38_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_41_5 = 0
			local var_41_6 = 1.375

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_7 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(324162009).content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 55 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_7) / 55)

				if (55 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_7) / 55)) > 0 and var_41_6 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_5
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_6, arg_38_1.talkMaxDuration)

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_5) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_5 + var_41_10 and arg_38_1.time_ < var_41_5 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play324162010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324162010
		arg_42_1.duration_ = 10

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play324162011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				local var_45_0 = arg_42_1.var_.effect3434

				if not arg_42_1.var_.effect3434 then
					var_45_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_45_0.name = "3434"
					arg_42_1.var_.effect3434 = var_45_0
				else
					var_45_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_45_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_45_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5 < arg_42_1.time_ and arg_42_1.time_ <= 5 + arg_45_0 then
				if arg_42_1.var_.effect3434 then
					Object.Destroy(arg_42_1.var_.effect3434)

					arg_42_1.var_.effect3434 = nil
				end
			end

			local var_45_3 = 3.60822483003176e-16

			if 3.60822483003176e-16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			if arg_42_1.time_ >= var_45_3 + 1.83333333333333 and arg_42_1.time_ < var_45_3 + 1.83333333333333 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			if 0.1 < arg_42_1.time_ and arg_42_1.time_ <= 0.1 + arg_45_0 then
				arg_42_1:AudioAction("play", "effect", "se_story_150", "se_story_150_space01", "")
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_5 = 1.36666666666667
			local var_45_6 = 0.9

			if 1.36666666666667 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_7 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_7:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_8 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(324162010).content)

				arg_42_1.text_.text = var_45_8

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_10 = 36 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 36)

				if (36 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 36)) > 0 and var_45_6 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10
					var_45_5 = var_45_5 + 0.3

					if var_45_10 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_5
					end
				end

				arg_42_1.text_.text = var_45_8
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_11 = var_45_5 + 0.3
			local var_45_12 = math.max(var_45_6, arg_42_1.talkMaxDuration)

			if var_45_5 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_11 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_11) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_11 + var_45_12 and arg_42_1.time_ < var_45_11 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play324162011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324162011
		arg_48_1.duration_ = 2.3

		local var_48_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_48_0:Play324162012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if arg_48_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_51_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_48_1.stage_.transform)

				var_51_0.name = "1071ui_story"
				var_51_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["1071ui_story"] = var_51_0

				local var_51_1 = var_51_0:GetComponentInChildren(typeof(CharacterEffect))

				var_51_1.enabled = true

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end

				arg_48_1:ShowWeapon(var_51_1.transform, false)

				arg_48_1.var_["1071ui_story" .. "Animator"] = var_51_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_48_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_48_1.var_["1071ui_story" .. "LipSync"] = var_51_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_51_3 = arg_48_1.actors_["1071ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1071ui_story = var_51_3.localPosition
			end

			local var_51_4 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				var_51_3.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_48_1.time_ - 0) / var_51_4)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			local var_51_5 = arg_48_1.actors_["1071ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1071ui_story == nil then
				arg_48_1.var_.characterEffect1071ui_story = var_51_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_6 and not isNil(var_51_5) then
				if arg_48_1.var_.characterEffect1071ui_story and not isNil(var_51_5) then
					arg_48_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_6 and arg_48_1.time_ < 0 + var_51_6 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1071ui_story then
				arg_48_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_51_8 = 0
			local var_51_9 = 0.225

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:GetWordFromCfg(324162011)
				local var_51_11 = arg_48_1:FormatText(var_51_10.content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 9 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 9)

				if (9 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 9)) > 0 and var_51_9 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162011", "story_v_out_324162.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_324162", "324162011", "story_v_out_324162.awb") / 1000

					if var_51_14 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_8
					end

					if var_51_10.prefab_name ~= "" and arg_48_1.actors_[var_51_10.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_10.prefab_name].transform, "story_v_out_324162", "324162011", "story_v_out_324162.awb")

						arg_48_1:RecordAudio("324162011", var_51_15)
						arg_48_1:RecordAudio("324162011", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324162", "324162011", "story_v_out_324162.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324162", "324162011", "story_v_out_324162.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_16 and arg_48_1.time_ < var_51_8 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play324162012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324162012
		arg_52_1.duration_ = 6

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324162013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_9000

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1071ui_story = arg_52_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1071ui_story"].transform.position).z)
				arg_52_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1071ui_story"].transform.localEulerAngles = arg_52_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1071ui_story"].transform.position).z)
				arg_52_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1071ui_story"].transform.localEulerAngles = arg_52_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1071ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1071ui_story == nil then
				arg_52_1.var_.characterEffect1071ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1071ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_2)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1071ui_story then
				arg_52_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_52_1.time_ and arg_52_1.time_ <= 0.1 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_150", "se_story_150_attack", "")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_4 = arg_52_1.var_.effect432424234

				if not arg_52_1.var_.effect432424234 then
					var_55_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu3"), manager.ui.mainCamera.transform)
					var_55_4.name = "4234"
					arg_52_1.var_.effect432424234 = var_55_4
				else
					var_55_4.transform:SetParent(var_55_9000)
				end

				var_55_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_55_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.766666666666667 < arg_52_1.time_ and arg_52_1.time_ <= 0.766666666666667 + arg_55_0 then
				if arg_52_1.var_.effect432424234 then
					Object.Destroy(arg_52_1.var_.effect432424234)

					arg_52_1.var_.effect432424234 = nil
				end
			end

			local var_55_7 = 0.5

			if 0.5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_8 = 0.6

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_8 then
				local var_55_9 = Color.New(1, 1, 1)

				var_55_9.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_7) / var_55_8)
				arg_52_1.mask_.color = var_55_9
			end

			if arg_52_1.time_ >= var_55_7 + var_55_8 and arg_52_1.time_ < var_55_7 + var_55_8 + arg_55_0 then
				local var_55_10 = Color.New(1, 1, 1)

				arg_52_1.mask_.enabled = false
				var_55_10.a = 0
				arg_52_1.mask_.color = var_55_10
			end

			local var_55_11 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_11 + 1.36666666666667 and arg_52_1.time_ < var_55_11 + 1.36666666666667 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_12 = 1
			local var_55_13 = 1.6

			if 1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_14 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_14:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(324162012).content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 64 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_15) / 64)

				if (64 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_15) / 64)) > 0 and var_55_13 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17
					var_55_12 = var_55_12 + 0.3

					if var_55_17 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_18 = var_55_12 + 0.3
			local var_55_19 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_19 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_18) / var_55_19

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_18 + var_55_19 and arg_52_1.time_ < var_55_18 + var_55_19 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play324162013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324162013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324162014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 1.05

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_1 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(324162013).content)

				arg_58_1.text_.text = var_61_1

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_3 = 42 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 42)

				if (42 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 42)) > 0 and var_61_0 < var_61_3 then
					arg_58_1.talkMaxDuration = var_61_3

					if var_61_3 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_3 + 0
					end
				end

				arg_58_1.text_.text = var_61_1
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_4 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_4

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play324162014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324162014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
			arg_62_1.auto_ = false
		end

		function arg_62_1.playNext_(arg_64_0)
			arg_62_1.onStoryFinished_()
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0.1 < arg_62_1.time_ and arg_62_1.time_ <= 0.1 + arg_65_0 then
				arg_62_1:AudioAction("play", "effect", "se_story_150", "se_story_150_space02", "")
			end

			local var_65_1 = 0
			local var_65_2 = 1.025

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(324162014).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 41 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 41)

				if (41 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 41)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27i"
	},
	voices = {
		"story_v_out_324162.awb"
	}
}
