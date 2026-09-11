return {
	Play325051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325051001
		arg_1_1.duration_ = 5.2

		local var_1_0 = {
			zh = 5.2,
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
				arg_1_0:Play325051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST47 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_4_0.name = "ST47"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST47 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST47

				arg_1_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST47" then
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

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1077ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_1_1.time_ - 1.66666666666667) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_15 and arg_1_1.time_ < 1.66666666666667 + var_4_15 + arg_4_0 then
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

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story == nil then
				arg_1_1.var_.characterEffect1077ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect1077ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_18 and arg_1_1.time_ < 1.66666666666667 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story then
				arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

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

			local var_4_24 = 2
			local var_4_25 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
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

				local var_4_27 = arg_1_1:GetWordFromCfg(325051001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 7 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 7)

				if (7 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 7)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051001", "story_v_out_325051.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_325051", "325051001", "story_v_out_325051.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_325051", "325051001", "story_v_out_325051.awb")

						arg_1_1:RecordAudio("325051001", var_4_32)
						arg_1_1:RecordAudio("325051001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325051", "325051001", "story_v_out_325051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325051", "325051001", "story_v_out_325051.awb")
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
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325051003(arg_8_1)
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
				arg_8_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_1)
				arg_8_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).z)
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles = arg_8_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).z)
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles = arg_8_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_11_2 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(true)
				end
			end

			local var_11_3 = arg_8_1.actors_["1077ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1077ui_story == nil then
				arg_8_1.var_.characterEffect1077ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1077ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1077ui_story then
				arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_11_5 = 0
			local var_11_6 = 1.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_7 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325051002).content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 54 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 54)

				if (54 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 54)) > 0 and var_11_6 < var_11_9 then
					arg_8_1.talkMaxDuration = var_11_9

					if var_11_9 + var_11_5 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_9 + var_11_5
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_6, arg_8_1.talkMaxDuration)

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_5) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_5 + var_11_10 and arg_8_1.time_ < var_11_5 + var_11_10 + arg_11_0 then
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
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play325051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325051003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.375

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325051003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 55 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 55)

				if (55 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 55)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325051004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.7

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(325051004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 68 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 68)

				if (68 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 68)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325051005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.45

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

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(325051005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 58 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 58)

				if (58 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 58)) > 0 and var_23_0 < var_23_3 then
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
	Play325051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325051006
		arg_24_1.duration_ = 2.37

		local var_24_0 = {
			zh = 2.366,
			ja = 2.2
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
				arg_24_0:Play325051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1077ui_story = arg_24_1.actors_["1077ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).z)
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles = arg_24_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_24_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).z)
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles = arg_24_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["1077ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1077ui_story == nil then
				arg_24_1.var_.characterEffect1077ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect1077ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1077ui_story then
				arg_24_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_27_6 = 0
			local var_27_7 = 0.15

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(325051006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 6 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 6)

				if (6 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 6)) > 0 and var_27_7 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051006", "story_v_out_325051.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051006", "story_v_out_325051.awb") / 1000

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end

					if var_27_8.prefab_name ~= "" and arg_24_1.actors_[var_27_8.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_8.prefab_name].transform, "story_v_out_325051", "325051006", "story_v_out_325051.awb")

						arg_24_1:RecordAudio("325051006", var_27_13)
						arg_24_1:RecordAudio("325051006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325051", "325051006", "story_v_out_325051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325051", "325051006", "story_v_out_325051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play325051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325051007
		arg_28_1.duration_ = 11.33

		local var_28_0 = {
			zh = 11.333,
			ja = 11.3
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
				arg_28_0:Play325051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_9000

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				local var_31_0 = arg_28_1.bgs_.ST47

				arg_28_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_1 = var_31_0:GetComponent("SpriteRenderer")

				if var_31_1 and var_31_1.sprite then
					local var_31_2 = 2 * (var_31_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_0.transform.localScale = Vector3.New(var_31_2 / var_31_1.sprite.bounds.size.y < var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x and var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x or var_31_2 / var_31_1.sprite.bounds.size.y, var_31_2 / var_31_1.sprite.bounds.size.y < var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x and var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x or var_31_2 / var_31_1.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "ST47" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_3 = "ST32"

			if arg_28_1.bgs_.ST32 == nil then
				local var_31_4 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_31_3)
				var_31_4.name = var_31_3
				var_31_4.transform.parent = arg_28_1.stage_.transform
				var_31_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_[var_31_3] = var_31_4
			end

			if 1.8 < arg_28_1.time_ and arg_28_1.time_ <= 1.8 + arg_31_0 then
				local var_31_5 = arg_28_1.bgs_.ST32

				arg_28_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_6 = var_31_5:GetComponent("SpriteRenderer")

				if var_31_6 and var_31_6.sprite then
					local var_31_7 = 2 * (var_31_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_5.transform.localScale = Vector3.New(var_31_7 / var_31_6.sprite.bounds.size.y < var_31_7 * manager.ui.mainCameraCom_.aspect / var_31_6.sprite.bounds.size.x and var_31_7 * manager.ui.mainCameraCom_.aspect / var_31_6.sprite.bounds.size.x or var_31_7 / var_31_6.sprite.bounds.size.y, var_31_7 / var_31_6.sprite.bounds.size.y < var_31_7 * manager.ui.mainCameraCom_.aspect / var_31_6.sprite.bounds.size.x and var_31_7 * manager.ui.mainCameraCom_.aspect / var_31_6.sprite.bounds.size.x or var_31_7 / var_31_6.sprite.bounds.size.y, 0)
				end

				for iter_31_2, iter_31_3 in pairs(arg_28_1.bgs_) do
					if iter_31_2 ~= "ST32" then
						iter_31_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_8 = 1.8

			if 1.8 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_8 + 0.3 and arg_28_1.time_ < var_31_8 + 0.3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_9 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_10 = 1.8

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

			local var_31_13 = arg_28_1.actors_["1077ui_story"].transform

			if 3.56666666666667 < arg_28_1.time_ and arg_28_1.time_ <= 3.56666666666667 + arg_31_0 then
				arg_28_1.var_.moveOldPos1077ui_story = var_31_13.localPosition

				local var_31_14 = GameObjectTools.GetOrAddComponent(var_31_13.gameObject, typeof(DynamicBoneHelper))

				if var_31_14 then
					var_31_14:EnableDynamicBone(false)
				end
			end

			local var_31_15 = 0.001

			if 3.56666666666667 <= arg_28_1.time_ and arg_28_1.time_ < 3.56666666666667 + var_31_15 then
				var_31_13.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_28_1.time_ - 3.56666666666667) / var_31_15)
				var_31_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_13.position).x, (manager.ui.mainCamera.transform.position - var_31_13.position).y, (manager.ui.mainCamera.transform.position - var_31_13.position).z)
				var_31_13.localEulerAngles.z = 0
				var_31_13.localEulerAngles.x = 0
				var_31_13.localEulerAngles = var_31_13.localEulerAngles
			end

			if arg_28_1.time_ >= 3.56666666666667 + var_31_15 and arg_28_1.time_ < 3.56666666666667 + var_31_15 + arg_31_0 then
				var_31_13.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_31_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_13.position).x, (manager.ui.mainCamera.transform.position - var_31_13.position).y, (manager.ui.mainCamera.transform.position - var_31_13.position).z)
				var_31_13.localEulerAngles.z = 0
				var_31_13.localEulerAngles.x = 0
				var_31_13.localEulerAngles = var_31_13.localEulerAngles

				local var_31_16 = GameObjectTools.GetOrAddComponent(var_31_13.gameObject, typeof(DynamicBoneHelper))

				if var_31_16 then
					var_31_16:EnableDynamicBone(true)
				end
			end

			if 3.56666666666667 < arg_28_1.time_ and arg_28_1.time_ <= 3.56666666666667 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			if 3.56666666666667 < arg_28_1.time_ and arg_28_1.time_ <= 3.56666666666667 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.775 < arg_28_1.time_ and arg_28_1.time_ <= 0.775 + arg_31_0 then
				local var_31_17 = arg_28_1.var_.effect342

				if not arg_28_1.var_.effect342 then
					var_31_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_31_17.name = "342"
					arg_28_1.var_.effect342 = var_31_17
				else
					var_31_17.transform:SetParent(var_31_9000)
				end

				var_31_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_31_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.23333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 4.23333333333333 + arg_31_0 then
				if arg_28_1.var_.effect342 then
					Object.Destroy(arg_28_1.var_.effect342)

					arg_28_1.var_.effect342 = nil
				end
			end

			local var_31_20 = arg_28_1.actors_["1077ui_story"]

			if 3.60066666851441 < arg_28_1.time_ and arg_28_1.time_ <= 3.60066666851441 + arg_31_0 and not isNil(var_31_20) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_21 = 0.200000002980232

			if 3.60066666851441 <= arg_28_1.time_ and arg_28_1.time_ < 3.60066666851441 + var_31_21 and not isNil(var_31_20) then
				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_20) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 3.60066666851441 + var_31_21 and arg_28_1.time_ < 3.60066666851441 + var_31_21 + arg_31_0 and not isNil(var_31_20) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_31_23 = arg_28_1.actors_["1077ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1077ui_story = var_31_23.localPosition

				local var_31_24 = GameObjectTools.GetOrAddComponent(var_31_23.gameObject, typeof(DynamicBoneHelper))

				if var_31_24 then
					var_31_24:EnableDynamicBone(false)
				end
			end

			local var_31_25 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_25 then
				var_31_23.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_25)
				var_31_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_23.position).x, (manager.ui.mainCamera.transform.position - var_31_23.position).y, (manager.ui.mainCamera.transform.position - var_31_23.position).z)
				var_31_23.localEulerAngles.z = 0
				var_31_23.localEulerAngles.x = 0
				var_31_23.localEulerAngles = var_31_23.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_25 and arg_28_1.time_ < 0 + var_31_25 + arg_31_0 then
				var_31_23.localPosition = Vector3.New(0, 100, 0)
				var_31_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_23.position).x, (manager.ui.mainCamera.transform.position - var_31_23.position).y, (manager.ui.mainCamera.transform.position - var_31_23.position).z)
				var_31_23.localEulerAngles.z = 0
				var_31_23.localEulerAngles.x = 0
				var_31_23.localEulerAngles = var_31_23.localEulerAngles

				local var_31_26 = GameObjectTools.GetOrAddComponent(var_31_23.gameObject, typeof(DynamicBoneHelper))

				if var_31_26 then
					var_31_26:EnableDynamicBone(true)
				end
			end

			if 1.2 < arg_28_1.time_ and arg_28_1.time_ <= 1.2 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_28_1.time_ and arg_28_1.time_ <= 0.1 + arg_31_0 then
				arg_28_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_29 = 3.8
			local var_31_30 = 0.775

			if 3.8 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_31 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_31:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_32 = arg_28_1:GetWordFromCfg(325051007)
				local var_31_33 = arg_28_1:FormatText(var_31_32.content)

				arg_28_1.text_.text = var_31_33

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_35 = 31 <= 0 and var_31_30 or var_31_30 * (utf8.len(var_31_33) / 31)

				if (31 <= 0 and var_31_30 or var_31_30 * (utf8.len(var_31_33) / 31)) > 0 and var_31_30 < var_31_35 then
					arg_28_1.talkMaxDuration = var_31_35
					var_31_29 = var_31_29 + 0.3

					if var_31_35 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_35 + var_31_29
					end
				end

				arg_28_1.text_.text = var_31_33
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051007", "story_v_out_325051.awb") ~= 0 then
					local var_31_36 = manager.audio:GetVoiceLength("story_v_out_325051", "325051007", "story_v_out_325051.awb") / 1000

					if var_31_36 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_36 + var_31_29
					end

					if var_31_32.prefab_name ~= "" and arg_28_1.actors_[var_31_32.prefab_name] ~= nil then
						local var_31_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_32.prefab_name].transform, "story_v_out_325051", "325051007", "story_v_out_325051.awb")

						arg_28_1:RecordAudio("325051007", var_31_37)
						arg_28_1:RecordAudio("325051007", var_31_37)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325051", "325051007", "story_v_out_325051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325051", "325051007", "story_v_out_325051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_38 = var_31_29 + 0.3
			local var_31_39 = math.max(var_31_30, arg_28_1.talkMaxDuration)

			if var_31_29 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_38 + var_31_39 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_38) / var_31_39

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_38 + var_31_39 and arg_28_1.time_ < var_31_38 + var_31_39 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325051008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325051008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play325051009(arg_34_1)
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

			local var_37_3 = arg_34_1.actors_["1077ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_3) and arg_34_1.var_.characterEffect1077ui_story == nil then
				arg_34_1.var_.characterEffect1077ui_story = var_37_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_4 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 and not isNil(var_37_3) then
				if arg_34_1.var_.characterEffect1077ui_story and not isNil(var_37_3) then
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_4)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 and not isNil(var_37_3) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_37_5 = 0
			local var_37_6 = 0.7

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_7 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(325051008).content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 28 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_7) / 28)

				if (28 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_7) / 28)) > 0 and var_37_6 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_5
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_6, arg_34_1.talkMaxDuration)

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_5) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_5 + var_37_10 and arg_34_1.time_ < var_37_5 + var_37_10 + arg_37_0 then
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
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play325051009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325051009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play325051010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.875

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

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(325051009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 35 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 35)

				if (35 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 35)) > 0 and var_41_0 < var_41_3 then
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
	Play325051010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325051010
		arg_42_1.duration_ = 13.93

		local var_42_0 = {
			zh = 9.366,
			ja = 13.933
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
				arg_42_0:Play325051011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1077ui_story = arg_42_1.actors_["1077ui_story"].transform.localPosition

				local var_45_0 = GameObjectTools.GetOrAddComponent(arg_42_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_45_0 then
					var_45_0:EnableDynamicBone(false)
				end
			end

			local var_45_1 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 then
				arg_42_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_42_1.time_ - 0) / var_45_1)
				arg_42_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1077ui_story"].transform.position).z)
				arg_42_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1077ui_story"].transform.localEulerAngles = arg_42_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 then
				arg_42_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_42_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1077ui_story"].transform.position).z)
				arg_42_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1077ui_story"].transform.localEulerAngles = arg_42_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_45_2 = GameObjectTools.GetOrAddComponent(arg_42_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(true)
				end
			end

			local var_45_3 = arg_42_1.actors_["1077ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect1077ui_story == nil then
				arg_42_1.var_.characterEffect1077ui_story = var_45_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_3) then
				if arg_42_1.var_.characterEffect1077ui_story and not isNil(var_45_3) then
					arg_42_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect1077ui_story then
				arg_42_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_45_6 = 0
			local var_45_7 = 0.825

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_8 = arg_42_1:GetWordFromCfg(325051010)
				local var_45_9 = arg_42_1:FormatText(var_45_8.content)

				arg_42_1.text_.text = var_45_9

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 33 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 33)

				if (33 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 33)) > 0 and var_45_7 < var_45_11 then
					arg_42_1.talkMaxDuration = var_45_11

					if var_45_11 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_9
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051010", "story_v_out_325051.awb") ~= 0 then
					local var_45_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051010", "story_v_out_325051.awb") / 1000

					if var_45_12 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_12 + var_45_6
					end

					if var_45_8.prefab_name ~= "" and arg_42_1.actors_[var_45_8.prefab_name] ~= nil then
						local var_45_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_8.prefab_name].transform, "story_v_out_325051", "325051010", "story_v_out_325051.awb")

						arg_42_1:RecordAudio("325051010", var_45_13)
						arg_42_1:RecordAudio("325051010", var_45_13)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_325051", "325051010", "story_v_out_325051.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_325051", "325051010", "story_v_out_325051.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_14 and arg_42_1.time_ < var_45_6 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play325051011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325051011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325051012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1077ui_story = arg_46_1.actors_["1077ui_story"].transform.localPosition

				local var_49_0 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_0 then
					var_49_0:EnableDynamicBone(false)
				end
			end

			local var_49_1 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_1 then
				arg_46_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_1)
				arg_46_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).z)
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles = arg_46_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_1 and arg_46_1.time_ < 0 + var_49_1 + arg_49_0 then
				arg_46_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).z)
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles = arg_46_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_49_2 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(true)
				end
			end

			local var_49_3 = arg_46_1.actors_["1077ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1077ui_story == nil then
				arg_46_1.var_.characterEffect1077ui_story = var_49_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_4 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 and not isNil(var_49_3) then
				if arg_46_1.var_.characterEffect1077ui_story and not isNil(var_49_3) then
					arg_46_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_4)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1077ui_story then
				arg_46_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_49_5 = 0
			local var_49_6 = 0.9

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(325051011).content)

				arg_46_1.text_.text = var_49_7

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 36 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_7) / 36)

				if (36 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_7) / 36)) > 0 and var_49_6 < var_49_9 then
					arg_46_1.talkMaxDuration = var_49_9

					if var_49_9 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_9 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_7
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_10 and arg_46_1.time_ < var_49_5 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play325051012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325051012
		arg_50_1.duration_ = 3.37

		local var_50_0 = {
			zh = 2.533,
			ja = 3.366
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
				arg_50_0:Play325051013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1077ui_story = arg_50_1.actors_["1077ui_story"].transform.localPosition

				local var_53_0 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_0 then
					var_53_0:EnableDynamicBone(false)
				end
			end

			local var_53_1 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 then
				arg_50_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_50_1.time_ - 0) / var_53_1)
				arg_50_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).z)
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles = arg_50_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 then
				arg_50_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_50_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).z)
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles = arg_50_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_53_2 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(true)
				end
			end

			local var_53_3 = arg_50_1.actors_["1077ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect1077ui_story == nil then
				arg_50_1.var_.characterEffect1077ui_story = var_53_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 and not isNil(var_53_3) then
				if arg_50_1.var_.characterEffect1077ui_story and not isNil(var_53_3) then
					arg_50_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect1077ui_story then
				arg_50_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_53_6 = 0
			local var_53_7 = 0.275

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_8 = arg_50_1:GetWordFromCfg(325051012)
				local var_53_9 = arg_50_1:FormatText(var_53_8.content)

				arg_50_1.text_.text = var_53_9

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 11 <= 0 and var_53_7 or var_53_7 * (utf8.len(var_53_9) / 11)

				if (11 <= 0 and var_53_7 or var_53_7 * (utf8.len(var_53_9) / 11)) > 0 and var_53_7 < var_53_11 then
					arg_50_1.talkMaxDuration = var_53_11

					if var_53_11 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_9
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051012", "story_v_out_325051.awb") ~= 0 then
					local var_53_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051012", "story_v_out_325051.awb") / 1000

					if var_53_12 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_12 + var_53_6
					end

					if var_53_8.prefab_name ~= "" and arg_50_1.actors_[var_53_8.prefab_name] ~= nil then
						local var_53_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_8.prefab_name].transform, "story_v_out_325051", "325051012", "story_v_out_325051.awb")

						arg_50_1:RecordAudio("325051012", var_53_13)
						arg_50_1:RecordAudio("325051012", var_53_13)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325051", "325051012", "story_v_out_325051.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325051", "325051012", "story_v_out_325051.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play325051013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325051013
		arg_54_1.duration_ = 2.6

		local var_54_0 = {
			zh = 2.6,
			ja = 2.366
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
				arg_54_0:Play325051014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) and arg_54_1.var_.characterEffect1077ui_story == nil then
				arg_54_1.var_.characterEffect1077ui_story = arg_54_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) then
				if arg_54_1.var_.characterEffect1077ui_story and not isNil(arg_54_1.actors_["1077ui_story"]) then
					arg_54_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_0)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) and arg_54_1.var_.characterEffect1077ui_story then
				arg_54_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_57_1 = 0
			local var_57_2 = 0.3

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(325051013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_6 = 12 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_4) / 12)

				if (12 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_4) / 12)) > 0 and var_57_2 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051013", "story_v_out_325051.awb") ~= 0 then
					local var_57_7 = manager.audio:GetVoiceLength("story_v_out_325051", "325051013", "story_v_out_325051.awb") / 1000

					if var_57_7 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_1
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_325051", "325051013", "story_v_out_325051.awb")

						arg_54_1:RecordAudio("325051013", var_57_8)
						arg_54_1:RecordAudio("325051013", var_57_8)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325051", "325051013", "story_v_out_325051.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325051", "325051013", "story_v_out_325051.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_9 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_9 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_9

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_9 and arg_54_1.time_ < var_57_1 + var_57_9 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325051014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325051014
		arg_58_1.duration_ = 4.2

		local var_58_0 = {
			zh = 3.9,
			ja = 4.2
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
				arg_58_0:Play325051015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1077ui_story"]) and arg_58_1.var_.characterEffect1077ui_story == nil then
				arg_58_1.var_.characterEffect1077ui_story = arg_58_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1077ui_story"]) then
				if arg_58_1.var_.characterEffect1077ui_story and not isNil(arg_58_1.actors_["1077ui_story"]) then
					arg_58_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1077ui_story"]) and arg_58_1.var_.characterEffect1077ui_story then
				arg_58_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_61_2 = 0
			local var_61_3 = 0.375

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(325051014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 15 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 15)

				if (15 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 15)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051014", "story_v_out_325051.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051014", "story_v_out_325051.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_325051", "325051014", "story_v_out_325051.awb")

						arg_58_1:RecordAudio("325051014", var_61_9)
						arg_58_1:RecordAudio("325051014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325051", "325051014", "story_v_out_325051.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325051", "325051014", "story_v_out_325051.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325051015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325051015
		arg_62_1.duration_ = 6.5

		local var_62_0 = {
			zh = 4.8,
			ja = 6.5
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
				arg_62_0:Play325051016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = arg_62_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) then
				if arg_62_1.var_.characterEffect1077ui_story and not isNil(arg_62_1.actors_["1077ui_story"]) then
					arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) and arg_62_1.var_.characterEffect1077ui_story then
				arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.675

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(325051015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 27 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 27)

				if (27 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 27)) > 0 and var_65_2 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051015", "story_v_out_325051.awb") ~= 0 then
					local var_65_7 = manager.audio:GetVoiceLength("story_v_out_325051", "325051015", "story_v_out_325051.awb") / 1000

					if var_65_7 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_1
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_325051", "325051015", "story_v_out_325051.awb")

						arg_62_1:RecordAudio("325051015", var_65_8)
						arg_62_1:RecordAudio("325051015", var_65_8)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325051", "325051015", "story_v_out_325051.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325051", "325051015", "story_v_out_325051.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_9 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_9 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_9

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_9 and arg_62_1.time_ < var_65_1 + var_65_9 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325051016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325051016
		arg_66_1.duration_ = 3.73

		local var_66_0 = {
			zh = 3.733,
			ja = 2
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
				arg_66_0:Play325051017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = arg_66_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) then
				if arg_66_1.var_.characterEffect1077ui_story and not isNil(arg_66_1.actors_["1077ui_story"]) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_2 = 0
			local var_69_3 = 0.3

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(325051016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 12 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 12)

				if (12 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 12)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051016", "story_v_out_325051.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051016", "story_v_out_325051.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_325051", "325051016", "story_v_out_325051.awb")

						arg_66_1:RecordAudio("325051016", var_69_9)
						arg_66_1:RecordAudio("325051016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325051", "325051016", "story_v_out_325051.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325051", "325051016", "story_v_out_325051.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_10 and arg_66_1.time_ < var_69_2 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325051017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325051017
		arg_70_1.duration_ = 10.47

		local var_70_0 = {
			zh = 8.2,
			ja = 10.466
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
				arg_70_0:Play325051018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1077ui_story"]) and arg_70_1.var_.characterEffect1077ui_story == nil then
				arg_70_1.var_.characterEffect1077ui_story = arg_70_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1077ui_story"]) then
				if arg_70_1.var_.characterEffect1077ui_story and not isNil(arg_70_1.actors_["1077ui_story"]) then
					arg_70_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1077ui_story"]) and arg_70_1.var_.characterEffect1077ui_story then
				arg_70_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 1.05

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(325051017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_6 = 42 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_4) / 42)

				if (42 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_4) / 42)) > 0 and var_73_2 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051017", "story_v_out_325051.awb") ~= 0 then
					local var_73_7 = manager.audio:GetVoiceLength("story_v_out_325051", "325051017", "story_v_out_325051.awb") / 1000

					if var_73_7 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_1
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_325051", "325051017", "story_v_out_325051.awb")

						arg_70_1:RecordAudio("325051017", var_73_8)
						arg_70_1:RecordAudio("325051017", var_73_8)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325051", "325051017", "story_v_out_325051.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325051", "325051017", "story_v_out_325051.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_9 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_9 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_9

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_9 and arg_70_1.time_ < var_73_1 + var_73_9 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325051018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325051018
		arg_74_1.duration_ = 8.9

		local var_74_0 = {
			zh = 5.766,
			ja = 8.9
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
				arg_74_0:Play325051019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1077ui_story"]) and arg_74_1.var_.characterEffect1077ui_story == nil then
				arg_74_1.var_.characterEffect1077ui_story = arg_74_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1077ui_story"]) then
				if arg_74_1.var_.characterEffect1077ui_story and not isNil(arg_74_1.actors_["1077ui_story"]) then
					arg_74_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1077ui_story"]) and arg_74_1.var_.characterEffect1077ui_story then
				arg_74_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action423")
			end

			local var_77_2 = 0
			local var_77_3 = 0.725

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
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

				local var_77_4 = arg_74_1:GetWordFromCfg(325051018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 29 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 29)

				if (29 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 29)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051018", "story_v_out_325051.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051018", "story_v_out_325051.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_325051", "325051018", "story_v_out_325051.awb")

						arg_74_1:RecordAudio("325051018", var_77_9)
						arg_74_1:RecordAudio("325051018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325051", "325051018", "story_v_out_325051.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325051", "325051018", "story_v_out_325051.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_10 and arg_74_1.time_ < var_77_2 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325051019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325051019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325051020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1077ui_story"]) and arg_78_1.var_.characterEffect1077ui_story == nil then
				arg_78_1.var_.characterEffect1077ui_story = arg_78_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1077ui_story"]) then
				if arg_78_1.var_.characterEffect1077ui_story and not isNil(arg_78_1.actors_["1077ui_story"]) then
					arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1077ui_story"]) and arg_78_1.var_.characterEffect1077ui_story then
				arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_81_1 = 0
			local var_81_2 = 0.725

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(325051019).content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 29 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 29)

				if (29 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 29)) > 0 and var_81_2 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_1
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_6 = math.max(var_81_2, arg_78_1.talkMaxDuration)

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_6 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_1) / var_81_6

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_1 + var_81_6 and arg_78_1.time_ < var_81_1 + var_81_6 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325051020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325051020
		arg_82_1.duration_ = 4.2

		local var_82_0 = {
			zh = 3.233,
			ja = 4.2
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
				arg_82_0:Play325051021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.35

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:GetWordFromCfg(325051020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 14 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 14)

				if (14 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 14)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051020", "story_v_out_325051.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051020", "story_v_out_325051.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_325051", "325051020", "story_v_out_325051.awb")

						arg_82_1:RecordAudio("325051020", var_85_6)
						arg_82_1:RecordAudio("325051020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325051", "325051020", "story_v_out_325051.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325051", "325051020", "story_v_out_325051.awb")
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
	Play325051021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325051021
		arg_86_1.duration_ = 18.9

		local var_86_0 = {
			zh = 8.566,
			ja = 18.9
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
				arg_86_0:Play325051022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1077ui_story"]) and arg_86_1.var_.characterEffect1077ui_story == nil then
				arg_86_1.var_.characterEffect1077ui_story = arg_86_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1077ui_story"]) then
				if arg_86_1.var_.characterEffect1077ui_story and not isNil(arg_86_1.actors_["1077ui_story"]) then
					arg_86_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1077ui_story"]) and arg_86_1.var_.characterEffect1077ui_story then
				arg_86_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_89_2 = 0
			local var_89_3 = 0.975

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_4 = arg_86_1:GetWordFromCfg(325051021)
				local var_89_5 = arg_86_1:FormatText(var_89_4.content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 39 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 39)

				if (39 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 39)) > 0 and var_89_3 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051021", "story_v_out_325051.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051021", "story_v_out_325051.awb") / 1000

					if var_89_8 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_2
					end

					if var_89_4.prefab_name ~= "" and arg_86_1.actors_[var_89_4.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_4.prefab_name].transform, "story_v_out_325051", "325051021", "story_v_out_325051.awb")

						arg_86_1:RecordAudio("325051021", var_89_9)
						arg_86_1:RecordAudio("325051021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325051", "325051021", "story_v_out_325051.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325051", "325051021", "story_v_out_325051.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_10 and arg_86_1.time_ < var_89_2 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325051022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325051022
		arg_90_1.duration_ = 9.73

		local var_90_0 = {
			zh = 6.766,
			ja = 9.733
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
				arg_90_0:Play325051023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1077ui_story"]) and arg_90_1.var_.characterEffect1077ui_story == nil then
				arg_90_1.var_.characterEffect1077ui_story = arg_90_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1077ui_story"]) then
				if arg_90_1.var_.characterEffect1077ui_story and not isNil(arg_90_1.actors_["1077ui_story"]) then
					arg_90_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1077ui_story"]) and arg_90_1.var_.characterEffect1077ui_story then
				arg_90_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.85

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(325051022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 34 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_4) / 34)

				if (34 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_4) / 34)) > 0 and var_93_2 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051022", "story_v_out_325051.awb") ~= 0 then
					local var_93_7 = manager.audio:GetVoiceLength("story_v_out_325051", "325051022", "story_v_out_325051.awb") / 1000

					if var_93_7 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_1
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_325051", "325051022", "story_v_out_325051.awb")

						arg_90_1:RecordAudio("325051022", var_93_8)
						arg_90_1:RecordAudio("325051022", var_93_8)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325051", "325051022", "story_v_out_325051.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325051", "325051022", "story_v_out_325051.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_9 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_9 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_9

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_9 and arg_90_1.time_ < var_93_1 + var_93_9 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325051023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325051023
		arg_94_1.duration_ = 6.33

		local var_94_0 = {
			zh = 4.766,
			ja = 6.333
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
				arg_94_0:Play325051024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1077ui_story"]) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = arg_94_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1077ui_story"]) then
				if arg_94_1.var_.characterEffect1077ui_story and not isNil(arg_94_1.actors_["1077ui_story"]) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1077ui_story"]) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_97_2 = 0
			local var_97_3 = 0.5

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
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

				local var_97_4 = arg_94_1:GetWordFromCfg(325051023)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 20 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 20)

				if (20 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 20)) > 0 and var_97_3 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051023", "story_v_out_325051.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051023", "story_v_out_325051.awb") / 1000

					if var_97_8 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_2
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_out_325051", "325051023", "story_v_out_325051.awb")

						arg_94_1:RecordAudio("325051023", var_97_9)
						arg_94_1:RecordAudio("325051023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325051", "325051023", "story_v_out_325051.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325051", "325051023", "story_v_out_325051.awb")
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
	Play325051024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325051024
		arg_98_1.duration_ = 9.3

		local var_98_0 = {
			zh = 6.433,
			ja = 9.3
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
				arg_98_0:Play325051025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1077ui_story"]) and arg_98_1.var_.characterEffect1077ui_story == nil then
				arg_98_1.var_.characterEffect1077ui_story = arg_98_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1077ui_story"]) then
				if arg_98_1.var_.characterEffect1077ui_story and not isNil(arg_98_1.actors_["1077ui_story"]) then
					arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1077ui_story"]) and arg_98_1.var_.characterEffect1077ui_story then
				arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_101_1 = 0
			local var_101_2 = 0.8

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(325051024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 32 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_4) / 32)

				if (32 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_4) / 32)) > 0 and var_101_2 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051024", "story_v_out_325051.awb") ~= 0 then
					local var_101_7 = manager.audio:GetVoiceLength("story_v_out_325051", "325051024", "story_v_out_325051.awb") / 1000

					if var_101_7 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_1
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_325051", "325051024", "story_v_out_325051.awb")

						arg_98_1:RecordAudio("325051024", var_101_8)
						arg_98_1:RecordAudio("325051024", var_101_8)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325051", "325051024", "story_v_out_325051.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325051", "325051024", "story_v_out_325051.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_9 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_9 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_9

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_9 and arg_98_1.time_ < var_101_1 + var_101_9 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325051025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325051025
		arg_102_1.duration_ = 14.6

		local var_102_0 = {
			zh = 10.3,
			ja = 14.6
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
				arg_102_0:Play325051026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1077ui_story"]) and arg_102_1.var_.characterEffect1077ui_story == nil then
				arg_102_1.var_.characterEffect1077ui_story = arg_102_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1077ui_story"]) then
				if arg_102_1.var_.characterEffect1077ui_story and not isNil(arg_102_1.actors_["1077ui_story"]) then
					arg_102_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1077ui_story"]) and arg_102_1.var_.characterEffect1077ui_story then
				arg_102_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_105_2 = 0
			local var_105_3 = 0.925

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(325051025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 37 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 37)

				if (37 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 37)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051025", "story_v_out_325051.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051025", "story_v_out_325051.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_325051", "325051025", "story_v_out_325051.awb")

						arg_102_1:RecordAudio("325051025", var_105_9)
						arg_102_1:RecordAudio("325051025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325051", "325051025", "story_v_out_325051.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325051", "325051025", "story_v_out_325051.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_10 and arg_102_1.time_ < var_105_2 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325051026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325051026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325051027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1077ui_story"]) and arg_106_1.var_.characterEffect1077ui_story == nil then
				arg_106_1.var_.characterEffect1077ui_story = arg_106_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1077ui_story"]) then
				if arg_106_1.var_.characterEffect1077ui_story and not isNil(arg_106_1.actors_["1077ui_story"]) then
					arg_106_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1077ui_story"]) and arg_106_1.var_.characterEffect1077ui_story then
				arg_106_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 0.975

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(325051026).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 39 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 39)

				if (39 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 39)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325051027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325051027
		arg_110_1.duration_ = 9.5

		local var_110_0 = {
			zh = 7,
			ja = 9.5
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
				arg_110_0:Play325051028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.9

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:GetWordFromCfg(325051027)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 36 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 36)

				if (36 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 36)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051027", "story_v_out_325051.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051027", "story_v_out_325051.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_325051", "325051027", "story_v_out_325051.awb")

						arg_110_1:RecordAudio("325051027", var_113_6)
						arg_110_1:RecordAudio("325051027", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325051", "325051027", "story_v_out_325051.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325051", "325051027", "story_v_out_325051.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325051028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325051028
		arg_114_1.duration_ = 10.57

		local var_114_0 = {
			zh = 7.366,
			ja = 10.566
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
				arg_114_0:Play325051029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.9

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:GetWordFromCfg(325051028)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 36 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 36)

				if (36 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 36)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051028", "story_v_out_325051.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051028", "story_v_out_325051.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_325051", "325051028", "story_v_out_325051.awb")

						arg_114_1:RecordAudio("325051028", var_117_6)
						arg_114_1:RecordAudio("325051028", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325051", "325051028", "story_v_out_325051.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325051", "325051028", "story_v_out_325051.awb")
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
	Play325051029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325051029
		arg_118_1.duration_ = 4.47

		local var_118_0 = {
			zh = 4.466,
			ja = 4.266
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
				arg_118_0:Play325051030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1077ui_story"]) and arg_118_1.var_.characterEffect1077ui_story == nil then
				arg_118_1.var_.characterEffect1077ui_story = arg_118_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1077ui_story"]) then
				if arg_118_1.var_.characterEffect1077ui_story and not isNil(arg_118_1.actors_["1077ui_story"]) then
					arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1077ui_story"]) and arg_118_1.var_.characterEffect1077ui_story then
				arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_121_2 = 0
			local var_121_3 = 0.6

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_4 = arg_118_1:GetWordFromCfg(325051029)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 24 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 24)

				if (24 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 24)) > 0 and var_121_3 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051029", "story_v_out_325051.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051029", "story_v_out_325051.awb") / 1000

					if var_121_8 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_2
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_325051", "325051029", "story_v_out_325051.awb")

						arg_118_1:RecordAudio("325051029", var_121_9)
						arg_118_1:RecordAudio("325051029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325051", "325051029", "story_v_out_325051.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325051", "325051029", "story_v_out_325051.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_10 and arg_118_1.time_ < var_121_2 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325051030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325051030
		arg_122_1.duration_ = 8.2

		local var_122_0 = {
			zh = 6.8,
			ja = 8.2
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
				arg_122_0:Play325051031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1077ui_story"]) and arg_122_1.var_.characterEffect1077ui_story == nil then
				arg_122_1.var_.characterEffect1077ui_story = arg_122_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1077ui_story"]) then
				if arg_122_1.var_.characterEffect1077ui_story and not isNil(arg_122_1.actors_["1077ui_story"]) then
					arg_122_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1077ui_story"]) and arg_122_1.var_.characterEffect1077ui_story then
				arg_122_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_125_1 = 0
			local var_125_2 = 0.95

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(325051030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 38 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 38)

				if (38 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 38)) > 0 and var_125_2 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051030", "story_v_out_325051.awb") ~= 0 then
					local var_125_7 = manager.audio:GetVoiceLength("story_v_out_325051", "325051030", "story_v_out_325051.awb") / 1000

					if var_125_7 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_1
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_325051", "325051030", "story_v_out_325051.awb")

						arg_122_1:RecordAudio("325051030", var_125_8)
						arg_122_1:RecordAudio("325051030", var_125_8)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325051", "325051030", "story_v_out_325051.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325051", "325051030", "story_v_out_325051.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_9 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_9 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_9

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_9 and arg_122_1.time_ < var_125_1 + var_125_9 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325051031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325051031
		arg_126_1.duration_ = 14.6

		local var_126_0 = {
			zh = 9.4,
			ja = 14.6
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
				arg_126_0:Play325051032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.275

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_1 = arg_126_1:GetWordFromCfg(325051031)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 51 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 51)

				if (51 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 51)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051031", "story_v_out_325051.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051031", "story_v_out_325051.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_325051", "325051031", "story_v_out_325051.awb")

						arg_126_1:RecordAudio("325051031", var_129_6)
						arg_126_1:RecordAudio("325051031", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325051", "325051031", "story_v_out_325051.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325051", "325051031", "story_v_out_325051.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325051032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325051032
		arg_130_1.duration_ = 4.8

		local var_130_0 = {
			zh = 3.966,
			ja = 4.8
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
				arg_130_0:Play325051033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.525

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_1 = arg_130_1:GetWordFromCfg(325051032)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 21 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 21)

				if (21 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 21)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051032", "story_v_out_325051.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051032", "story_v_out_325051.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_325051", "325051032", "story_v_out_325051.awb")

						arg_130_1:RecordAudio("325051032", var_133_6)
						arg_130_1:RecordAudio("325051032", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325051", "325051032", "story_v_out_325051.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325051", "325051032", "story_v_out_325051.awb")
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
	Play325051033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325051033
		arg_134_1.duration_ = 12.93

		local var_134_0 = {
			zh = 9.9,
			ja = 12.933
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
				arg_134_0:Play325051034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1077ui_story"]) and arg_134_1.var_.characterEffect1077ui_story == nil then
				arg_134_1.var_.characterEffect1077ui_story = arg_134_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1077ui_story"]) then
				if arg_134_1.var_.characterEffect1077ui_story and not isNil(arg_134_1.actors_["1077ui_story"]) then
					arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1077ui_story"]) and arg_134_1.var_.characterEffect1077ui_story then
				arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action465")
			end

			local var_137_2 = 0
			local var_137_3 = 1.125

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:GetWordFromCfg(325051033)
				local var_137_5 = arg_134_1:FormatText(var_137_4.content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 45 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 45)

				if (45 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 45)) > 0 and var_137_3 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051033", "story_v_out_325051.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051033", "story_v_out_325051.awb") / 1000

					if var_137_8 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_2
					end

					if var_137_4.prefab_name ~= "" and arg_134_1.actors_[var_137_4.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_4.prefab_name].transform, "story_v_out_325051", "325051033", "story_v_out_325051.awb")

						arg_134_1:RecordAudio("325051033", var_137_9)
						arg_134_1:RecordAudio("325051033", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325051", "325051033", "story_v_out_325051.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325051", "325051033", "story_v_out_325051.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_10 and arg_134_1.time_ < var_137_2 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325051034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325051034
		arg_138_1.duration_ = 6.53

		local var_138_0 = {
			zh = 5,
			ja = 6.533
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
				arg_138_0:Play325051035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.7

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
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

				local var_141_1 = arg_138_1:GetWordFromCfg(325051034)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 28 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 28)

				if (28 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 28)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051034", "story_v_out_325051.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051034", "story_v_out_325051.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_out_325051", "325051034", "story_v_out_325051.awb")

						arg_138_1:RecordAudio("325051034", var_141_6)
						arg_138_1:RecordAudio("325051034", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325051", "325051034", "story_v_out_325051.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325051", "325051034", "story_v_out_325051.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play325051035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325051035
		arg_142_1.duration_ = 6.97

		local var_142_0 = {
			zh = 4.6,
			ja = 6.966
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
				arg_142_0:Play325051036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) and arg_142_1.var_.characterEffect1077ui_story == nil then
				arg_142_1.var_.characterEffect1077ui_story = arg_142_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) then
				if arg_142_1.var_.characterEffect1077ui_story and not isNil(arg_142_1.actors_["1077ui_story"]) then
					arg_142_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) and arg_142_1.var_.characterEffect1077ui_story then
				arg_142_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 0.575

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(325051035)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_6 = 23 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_4) / 23)

				if (23 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_4) / 23)) > 0 and var_145_2 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051035", "story_v_out_325051.awb") ~= 0 then
					local var_145_7 = manager.audio:GetVoiceLength("story_v_out_325051", "325051035", "story_v_out_325051.awb") / 1000

					if var_145_7 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_1
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_325051", "325051035", "story_v_out_325051.awb")

						arg_142_1:RecordAudio("325051035", var_145_8)
						arg_142_1:RecordAudio("325051035", var_145_8)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325051", "325051035", "story_v_out_325051.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325051", "325051035", "story_v_out_325051.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_9 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_9 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_9

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_9 and arg_142_1.time_ < var_145_1 + var_145_9 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play325051036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325051036
		arg_146_1.duration_ = 2

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325051037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1077ui_story"]) and arg_146_1.var_.characterEffect1077ui_story == nil then
				arg_146_1.var_.characterEffect1077ui_story = arg_146_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1077ui_story"]) then
				if arg_146_1.var_.characterEffect1077ui_story and not isNil(arg_146_1.actors_["1077ui_story"]) then
					arg_146_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1077ui_story"]) and arg_146_1.var_.characterEffect1077ui_story then
				arg_146_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_149_2 = 0
			local var_149_3 = 0.075

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_4 = arg_146_1:GetWordFromCfg(325051036)
				local var_149_5 = arg_146_1:FormatText(var_149_4.content)

				arg_146_1.text_.text = var_149_5

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_7 = 3 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 3)

				if (3 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 3)) > 0 and var_149_3 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_5
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051036", "story_v_out_325051.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_325051", "325051036", "story_v_out_325051.awb") / 1000

					if var_149_8 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_2
					end

					if var_149_4.prefab_name ~= "" and arg_146_1.actors_[var_149_4.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_4.prefab_name].transform, "story_v_out_325051", "325051036", "story_v_out_325051.awb")

						arg_146_1:RecordAudio("325051036", var_149_9)
						arg_146_1:RecordAudio("325051036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_325051", "325051036", "story_v_out_325051.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_325051", "325051036", "story_v_out_325051.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_10 and arg_146_1.time_ < var_149_2 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play325051037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325051037
		arg_150_1.duration_ = 7.73

		local var_150_0 = {
			zh = 6.833,
			ja = 7.733
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
				arg_150_0:Play325051038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 1.4 < arg_150_1.time_ and arg_150_1.time_ <= 1.4 + arg_153_0 then
				local var_153_0 = arg_150_1.bgs_.ST32

				arg_150_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_153_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_1 = var_153_0:GetComponent("SpriteRenderer")

				if var_153_1 and var_153_1.sprite then
					local var_153_2 = 2 * (var_153_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_153_0.transform.localScale = Vector3.New(var_153_2 / var_153_1.sprite.bounds.size.y < var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x and var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x or var_153_2 / var_153_1.sprite.bounds.size.y, var_153_2 / var_153_1.sprite.bounds.size.y < var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x and var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x or var_153_2 / var_153_1.sprite.bounds.size.y, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "ST32" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_3 = 1.4

			if 1.4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_3 + arg_153_0 then
				arg_150_1.allBtn_.enabled = false
			end

			if arg_150_1.time_ >= var_153_3 + 0.3 and arg_150_1.time_ < var_153_3 + 0.3 + arg_153_0 then
				arg_150_1.allBtn_.enabled = true
			end

			local var_153_4 = 0

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_5 = 1.4

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_5 then
				local var_153_6 = Color.New(0, 0, 0)

				var_153_6.a = Mathf.Lerp(0, 1, (arg_150_1.time_ - var_153_4) / var_153_5)
				arg_150_1.mask_.color = var_153_6
			end

			if arg_150_1.time_ >= var_153_4 + var_153_5 and arg_150_1.time_ < var_153_4 + var_153_5 + arg_153_0 then
				local var_153_7 = Color.New(0, 0, 0)

				var_153_7.a = 1
				arg_150_1.mask_.color = var_153_7
			end

			local var_153_8 = 1.4

			if 1.4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_9 = 1.83333333333333

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_9 then
				local var_153_10 = Color.New(0, 0, 0)

				var_153_10.a = Mathf.Lerp(1, 0, (arg_150_1.time_ - var_153_8) / var_153_9)
				arg_150_1.mask_.color = var_153_10
			end

			if arg_150_1.time_ >= var_153_8 + var_153_9 and arg_150_1.time_ < var_153_8 + var_153_9 + arg_153_0 then
				local var_153_11 = Color.New(0, 0, 0)

				arg_150_1.mask_.enabled = false
				var_153_11.a = 0
				arg_150_1.mask_.color = var_153_11
			end

			local var_153_12 = arg_150_1.actors_["1077ui_story"].transform

			if 1.4 < arg_150_1.time_ and arg_150_1.time_ <= 1.4 + arg_153_0 then
				arg_150_1.var_.moveOldPos1077ui_story = var_153_12.localPosition

				local var_153_13 = GameObjectTools.GetOrAddComponent(var_153_12.gameObject, typeof(DynamicBoneHelper))

				if var_153_13 then
					var_153_13:EnableDynamicBone(false)
				end
			end

			local var_153_14 = 0.001

			if 1.4 <= arg_150_1.time_ and arg_150_1.time_ < 1.4 + var_153_14 then
				var_153_12.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 1.4) / var_153_14)
				var_153_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_12.position).x, (manager.ui.mainCamera.transform.position - var_153_12.position).y, (manager.ui.mainCamera.transform.position - var_153_12.position).z)
				var_153_12.localEulerAngles.z = 0
				var_153_12.localEulerAngles.x = 0
				var_153_12.localEulerAngles = var_153_12.localEulerAngles
			end

			if arg_150_1.time_ >= 1.4 + var_153_14 and arg_150_1.time_ < 1.4 + var_153_14 + arg_153_0 then
				var_153_12.localPosition = Vector3.New(0, 100, 0)
				var_153_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_12.position).x, (manager.ui.mainCamera.transform.position - var_153_12.position).y, (manager.ui.mainCamera.transform.position - var_153_12.position).z)
				var_153_12.localEulerAngles.z = 0
				var_153_12.localEulerAngles.x = 0
				var_153_12.localEulerAngles = var_153_12.localEulerAngles

				local var_153_15 = GameObjectTools.GetOrAddComponent(var_153_12.gameObject, typeof(DynamicBoneHelper))

				if var_153_15 then
					var_153_15:EnableDynamicBone(true)
				end
			end

			local var_153_16 = arg_150_1.actors_["1077ui_story"]

			if 1.4 < arg_150_1.time_ and arg_150_1.time_ <= 1.4 + arg_153_0 and not isNil(var_153_16) and arg_150_1.var_.characterEffect1077ui_story == nil then
				arg_150_1.var_.characterEffect1077ui_story = var_153_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_17 = 0.200000002980232

			if 1.4 <= arg_150_1.time_ and arg_150_1.time_ < 1.4 + var_153_17 and not isNil(var_153_16) then
				if arg_150_1.var_.characterEffect1077ui_story and not isNil(var_153_16) then
					arg_150_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 1.4) / var_153_17)
				end
			end

			if arg_150_1.time_ >= 1.4 + var_153_17 and arg_150_1.time_ < 1.4 + var_153_17 + arg_153_0 and not isNil(var_153_16) and arg_150_1.var_.characterEffect1077ui_story then
				arg_150_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_18 = 2.7
			local var_153_19 = 0.325

			if 2.7 < arg_150_1.time_ and arg_150_1.time_ <= var_153_18 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_20 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_20:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_21 = arg_150_1:GetWordFromCfg(325051037)
				local var_153_22 = arg_150_1:FormatText(var_153_21.content)

				arg_150_1.text_.text = var_153_22

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_24 = 13 <= 0 and var_153_19 or var_153_19 * (utf8.len(var_153_22) / 13)

				if (13 <= 0 and var_153_19 or var_153_19 * (utf8.len(var_153_22) / 13)) > 0 and var_153_19 < var_153_24 then
					arg_150_1.talkMaxDuration = var_153_24
					var_153_18 = var_153_18 + 0.3

					if var_153_24 + var_153_18 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_24 + var_153_18
					end
				end

				arg_150_1.text_.text = var_153_22
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051037", "story_v_out_325051.awb") ~= 0 then
					local var_153_25 = manager.audio:GetVoiceLength("story_v_out_325051", "325051037", "story_v_out_325051.awb") / 1000

					if var_153_25 + var_153_18 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_25 + var_153_18
					end

					if var_153_21.prefab_name ~= "" and arg_150_1.actors_[var_153_21.prefab_name] ~= nil then
						local var_153_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_21.prefab_name].transform, "story_v_out_325051", "325051037", "story_v_out_325051.awb")

						arg_150_1:RecordAudio("325051037", var_153_26)
						arg_150_1:RecordAudio("325051037", var_153_26)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325051", "325051037", "story_v_out_325051.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325051", "325051037", "story_v_out_325051.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_27 = var_153_18 + 0.3
			local var_153_28 = math.max(var_153_19, arg_150_1.talkMaxDuration)

			if var_153_18 + 0.3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_27 + var_153_28 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_27) / var_153_28

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_27 + var_153_28 and arg_150_1.time_ < var_153_27 + var_153_28 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play325051038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325051038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325051039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.625

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(325051038).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 25 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 25)

				if (25 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 25)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325051039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325051039
		arg_160_1.duration_ = 3.33

		local var_160_0 = {
			zh = 2.8,
			ja = 3.333
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325051040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1077ui_story = arg_160_1.actors_["1077ui_story"].transform.localPosition

				local var_163_0 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_0 then
					var_163_0:EnableDynamicBone(false)
				end
			end

			local var_163_1 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				arg_160_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_160_1.time_ - 0) / var_163_1)
				arg_160_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).z)
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles = arg_160_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 then
				arg_160_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_160_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).z)
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles = arg_160_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_163_2 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(true)
				end
			end

			local var_163_3 = arg_160_1.actors_["1077ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1077ui_story == nil then
				arg_160_1.var_.characterEffect1077ui_story = var_163_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 and not isNil(var_163_3) then
				if arg_160_1.var_.characterEffect1077ui_story and not isNil(var_163_3) then
					arg_160_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1077ui_story then
				arg_160_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_163_6 = 0
			local var_163_7 = 0.275

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(325051039)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 11 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_9) / 11)

				if (11 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_9) / 11)) > 0 and var_163_7 < var_163_11 then
					arg_160_1.talkMaxDuration = var_163_11

					if var_163_11 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051039", "story_v_out_325051.awb") ~= 0 then
					local var_163_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051039", "story_v_out_325051.awb") / 1000

					if var_163_12 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_6
					end

					if var_163_8.prefab_name ~= "" and arg_160_1.actors_[var_163_8.prefab_name] ~= nil then
						local var_163_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_8.prefab_name].transform, "story_v_out_325051", "325051039", "story_v_out_325051.awb")

						arg_160_1:RecordAudio("325051039", var_163_13)
						arg_160_1:RecordAudio("325051039", var_163_13)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325051", "325051039", "story_v_out_325051.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325051", "325051039", "story_v_out_325051.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play325051040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325051040
		arg_164_1.duration_ = 3.9

		local var_164_0 = {
			zh = 3.533,
			ja = 3.9
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
				arg_164_0:Play325051041(arg_164_1)
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

			local var_167_3 = "1053ui_story"

			if arg_164_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_167_4 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_164_1.stage_.transform)

				var_167_4.name = var_167_3
				var_167_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_[var_167_3] = var_167_4

				local var_167_5 = var_167_4:GetComponentInChildren(typeof(CharacterEffect))

				var_167_5.enabled = true

				local var_167_6 = GameObjectTools.GetOrAddComponent(var_167_4, typeof(DynamicBoneHelper))

				if var_167_6 then
					var_167_6:EnableDynamicBone(false)
				end

				arg_164_1:ShowWeapon(var_167_5.transform, false)

				arg_164_1.var_[var_167_3 .. "Animator"] = var_167_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_164_1.var_[var_167_3 .. "Animator"].applyRootMotion = true
				arg_164_1.var_[var_167_3 .. "LipSync"] = var_167_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_167_7 = arg_164_1.actors_["1053ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1053ui_story = var_167_7.localPosition

				local var_167_8 = GameObjectTools.GetOrAddComponent(var_167_7.gameObject, typeof(DynamicBoneHelper))

				if var_167_8 then
					var_167_8:EnableDynamicBone(false)
				end
			end

			local var_167_9 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_9 then
				var_167_7.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_164_1.time_ - 0) / var_167_9)
				var_167_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_7.position).x, (manager.ui.mainCamera.transform.position - var_167_7.position).y, (manager.ui.mainCamera.transform.position - var_167_7.position).z)
				var_167_7.localEulerAngles.z = 0
				var_167_7.localEulerAngles.x = 0
				var_167_7.localEulerAngles = var_167_7.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_9 and arg_164_1.time_ < 0 + var_167_9 + arg_167_0 then
				var_167_7.localPosition = Vector3.New(0.7, -1.08, -6)
				var_167_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_7.position).x, (manager.ui.mainCamera.transform.position - var_167_7.position).y, (manager.ui.mainCamera.transform.position - var_167_7.position).z)
				var_167_7.localEulerAngles.z = 0
				var_167_7.localEulerAngles.x = 0
				var_167_7.localEulerAngles = var_167_7.localEulerAngles

				local var_167_10 = GameObjectTools.GetOrAddComponent(var_167_7.gameObject, typeof(DynamicBoneHelper))

				if var_167_10 then
					var_167_10:EnableDynamicBone(true)
				end
			end

			local var_167_11 = arg_164_1.actors_["1053ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect1053ui_story == nil then
				arg_164_1.var_.characterEffect1053ui_story = var_167_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_12 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_12 and not isNil(var_167_11) then
				if arg_164_1.var_.characterEffect1053ui_story and not isNil(var_167_11) then
					arg_164_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_12 and arg_164_1.time_ < 0 + var_167_12 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect1053ui_story then
				arg_164_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_167_14 = arg_164_1.actors_["1077ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_14) and arg_164_1.var_.characterEffect1077ui_story == nil then
				arg_164_1.var_.characterEffect1077ui_story = var_167_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_15 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_15 and not isNil(var_167_14) then
				if arg_164_1.var_.characterEffect1077ui_story and not isNil(var_167_14) then
					arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_15)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_15 and arg_164_1.time_ < 0 + var_167_15 + arg_167_0 and not isNil(var_167_14) and arg_164_1.var_.characterEffect1077ui_story then
				arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_167_16 = 0
			local var_167_17 = 0.375

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(325051040)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_21 = 15 <= 0 and var_167_17 or var_167_17 * (utf8.len(var_167_19) / 15)

				if (15 <= 0 and var_167_17 or var_167_17 * (utf8.len(var_167_19) / 15)) > 0 and var_167_17 < var_167_21 then
					arg_164_1.talkMaxDuration = var_167_21

					if var_167_21 + var_167_16 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_21 + var_167_16
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051040", "story_v_out_325051.awb") ~= 0 then
					local var_167_22 = manager.audio:GetVoiceLength("story_v_out_325051", "325051040", "story_v_out_325051.awb") / 1000

					if var_167_22 + var_167_16 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_16
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_out_325051", "325051040", "story_v_out_325051.awb")

						arg_164_1:RecordAudio("325051040", var_167_23)
						arg_164_1:RecordAudio("325051040", var_167_23)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_325051", "325051040", "story_v_out_325051.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_325051", "325051040", "story_v_out_325051.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_24 = math.max(var_167_17, arg_164_1.talkMaxDuration)

			if var_167_16 <= arg_164_1.time_ and arg_164_1.time_ < var_167_16 + var_167_24 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_16) / var_167_24

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_16 + var_167_24 and arg_164_1.time_ < var_167_16 + var_167_24 + arg_167_0 then
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
				actorName = "1053ui_story",
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
	Play325051041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325051041
		arg_168_1.duration_ = 7.8

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325051042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 1.43333333333333 < arg_168_1.time_ and arg_168_1.time_ <= 1.43333333333333 + arg_171_0 then
				local var_171_0 = arg_168_1.bgs_.ST47

				arg_168_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_171_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_171_1 = var_171_0:GetComponent("SpriteRenderer")

				if var_171_1 and var_171_1.sprite then
					local var_171_2 = 2 * (var_171_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_171_0.transform.localScale = Vector3.New(var_171_2 / var_171_1.sprite.bounds.size.y < var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x and var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x or var_171_2 / var_171_1.sprite.bounds.size.y, var_171_2 / var_171_1.sprite.bounds.size.y < var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x and var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x or var_171_2 / var_171_1.sprite.bounds.size.y, 0)
				end

				for iter_171_0, iter_171_1 in pairs(arg_168_1.bgs_) do
					if iter_171_0 ~= "ST47" then
						iter_171_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_171_3 = 1.43333333333333

			if 1.43333333333333 < arg_168_1.time_ and arg_168_1.time_ <= var_171_3 + arg_171_0 then
				arg_168_1.allBtn_.enabled = false
			end

			if arg_168_1.time_ >= var_171_3 + 0.3 and arg_168_1.time_ < var_171_3 + 0.3 + arg_171_0 then
				arg_168_1.allBtn_.enabled = true
			end

			local var_171_4 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_5 = 1.43333333333333

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_5 then
				local var_171_6 = Color.New(0, 0, 0)

				var_171_6.a = Mathf.Lerp(0, 1, (arg_168_1.time_ - var_171_4) / var_171_5)
				arg_168_1.mask_.color = var_171_6
			end

			if arg_168_1.time_ >= var_171_4 + var_171_5 and arg_168_1.time_ < var_171_4 + var_171_5 + arg_171_0 then
				local var_171_7 = Color.New(0, 0, 0)

				var_171_7.a = 1
				arg_168_1.mask_.color = var_171_7
			end

			local var_171_8 = 1.43333333333333

			if 1.43333333333333 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_9 = 2

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_9 then
				local var_171_10 = Color.New(0, 0, 0)

				var_171_10.a = Mathf.Lerp(1, 0, (arg_168_1.time_ - var_171_8) / var_171_9)
				arg_168_1.mask_.color = var_171_10
			end

			if arg_168_1.time_ >= var_171_8 + var_171_9 and arg_168_1.time_ < var_171_8 + var_171_9 + arg_171_0 then
				local var_171_11 = Color.New(0, 0, 0)

				arg_168_1.mask_.enabled = false
				var_171_11.a = 0
				arg_168_1.mask_.color = var_171_11
			end

			local var_171_12 = arg_168_1.actors_["1053ui_story"].transform

			if 1.43333333333333 < arg_168_1.time_ and arg_168_1.time_ <= 1.43333333333333 + arg_171_0 then
				arg_168_1.var_.moveOldPos1053ui_story = var_171_12.localPosition

				local var_171_13 = GameObjectTools.GetOrAddComponent(var_171_12.gameObject, typeof(DynamicBoneHelper))

				if var_171_13 then
					var_171_13:EnableDynamicBone(false)
				end
			end

			local var_171_14 = 0.001

			if 1.43333333333333 <= arg_168_1.time_ and arg_168_1.time_ < 1.43333333333333 + var_171_14 then
				var_171_12.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 1.43333333333333) / var_171_14)
				var_171_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_12.position).x, (manager.ui.mainCamera.transform.position - var_171_12.position).y, (manager.ui.mainCamera.transform.position - var_171_12.position).z)
				var_171_12.localEulerAngles.z = 0
				var_171_12.localEulerAngles.x = 0
				var_171_12.localEulerAngles = var_171_12.localEulerAngles
			end

			if arg_168_1.time_ >= 1.43333333333333 + var_171_14 and arg_168_1.time_ < 1.43333333333333 + var_171_14 + arg_171_0 then
				var_171_12.localPosition = Vector3.New(0, 100, 0)
				var_171_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_12.position).x, (manager.ui.mainCamera.transform.position - var_171_12.position).y, (manager.ui.mainCamera.transform.position - var_171_12.position).z)
				var_171_12.localEulerAngles.z = 0
				var_171_12.localEulerAngles.x = 0
				var_171_12.localEulerAngles = var_171_12.localEulerAngles

				local var_171_15 = GameObjectTools.GetOrAddComponent(var_171_12.gameObject, typeof(DynamicBoneHelper))

				if var_171_15 then
					var_171_15:EnableDynamicBone(true)
				end
			end

			local var_171_16 = arg_168_1.actors_["1077ui_story"].transform

			if 1.43333333333333 < arg_168_1.time_ and arg_168_1.time_ <= 1.43333333333333 + arg_171_0 then
				arg_168_1.var_.moveOldPos1077ui_story = var_171_16.localPosition

				local var_171_17 = GameObjectTools.GetOrAddComponent(var_171_16.gameObject, typeof(DynamicBoneHelper))

				if var_171_17 then
					var_171_17:EnableDynamicBone(false)
				end
			end

			local var_171_18 = 0.001

			if 1.43333333333333 <= arg_168_1.time_ and arg_168_1.time_ < 1.43333333333333 + var_171_18 then
				var_171_16.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 1.43333333333333) / var_171_18)
				var_171_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_16.position).x, (manager.ui.mainCamera.transform.position - var_171_16.position).y, (manager.ui.mainCamera.transform.position - var_171_16.position).z)
				var_171_16.localEulerAngles.z = 0
				var_171_16.localEulerAngles.x = 0
				var_171_16.localEulerAngles = var_171_16.localEulerAngles
			end

			if arg_168_1.time_ >= 1.43333333333333 + var_171_18 and arg_168_1.time_ < 1.43333333333333 + var_171_18 + arg_171_0 then
				var_171_16.localPosition = Vector3.New(0, 100, 0)
				var_171_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_16.position).x, (manager.ui.mainCamera.transform.position - var_171_16.position).y, (manager.ui.mainCamera.transform.position - var_171_16.position).z)
				var_171_16.localEulerAngles.z = 0
				var_171_16.localEulerAngles.x = 0
				var_171_16.localEulerAngles = var_171_16.localEulerAngles

				local var_171_19 = GameObjectTools.GetOrAddComponent(var_171_16.gameObject, typeof(DynamicBoneHelper))

				if var_171_19 then
					var_171_19:EnableDynamicBone(true)
				end
			end

			local var_171_20 = arg_168_1.actors_["1053ui_story"]

			if 1.43333333333333 < arg_168_1.time_ and arg_168_1.time_ <= 1.43333333333333 + arg_171_0 and not isNil(var_171_20) and arg_168_1.var_.characterEffect1053ui_story == nil then
				arg_168_1.var_.characterEffect1053ui_story = var_171_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_21 = 0.200000002980232

			if 1.43333333333333 <= arg_168_1.time_ and arg_168_1.time_ < 1.43333333333333 + var_171_21 and not isNil(var_171_20) then
				if arg_168_1.var_.characterEffect1053ui_story and not isNil(var_171_20) then
					arg_168_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 1.43333333333333) / var_171_21)
				end
			end

			if arg_168_1.time_ >= 1.43333333333333 + var_171_21 and arg_168_1.time_ < 1.43333333333333 + var_171_21 + arg_171_0 and not isNil(var_171_20) and arg_168_1.var_.characterEffect1053ui_story then
				arg_168_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_168_1.time_ and arg_168_1.time_ <= 1.2 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if 0.1 < arg_168_1.time_ and arg_168_1.time_ <= 0.1 + arg_171_0 then
				arg_168_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_168_1.frameCnt_ <= 1 then
				arg_168_1.dialog_:SetActive(false)
			end

			local var_171_24 = 2.8
			local var_171_25 = 0.975

			if 2.8 < arg_168_1.time_ and arg_168_1.time_ <= var_171_24 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				arg_168_1.dialog_:SetActive(true)

				arg_168_1.dialogCg_.alpha = 0

				local var_171_26 = LeanTween.value(arg_168_1.dialog_, 0, 1, 0.3)

				var_171_26:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_168_1.dialogCg_.alpha = arg_172_0
				end))
				var_171_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_168_1.dialog_)
					var_171_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_168_1.duration_ = arg_168_1.duration_ + 0.3

				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_27 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(325051041).content)

				arg_168_1.text_.text = var_171_27

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_29 = 39 <= 0 and var_171_25 or var_171_25 * (utf8.len(var_171_27) / 39)

				if (39 <= 0 and var_171_25 or var_171_25 * (utf8.len(var_171_27) / 39)) > 0 and var_171_25 < var_171_29 then
					arg_168_1.talkMaxDuration = var_171_29
					var_171_24 = var_171_24 + 0.3

					if var_171_29 + var_171_24 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_29 + var_171_24
					end
				end

				arg_168_1.text_.text = var_171_27
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_30 = var_171_24 + 0.3
			local var_171_31 = math.max(var_171_25, arg_168_1.talkMaxDuration)

			if var_171_24 + 0.3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_30 + var_171_31 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_30) / var_171_31

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_30 + var_171_31 and arg_168_1.time_ < var_171_30 + var_171_31 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play325051042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325051042
		arg_174_1.duration_ = 6.27

		local var_174_0 = {
			zh = 3.466,
			ja = 6.266
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play325051043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1053ui_story = arg_174_1.actors_["1053ui_story"].transform.localPosition

				local var_177_0 = GameObjectTools.GetOrAddComponent(arg_174_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_177_0 then
					var_177_0:EnableDynamicBone(false)
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_174_1.time_ - 0) / var_177_1)
				arg_174_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1053ui_story"].transform.position).z)
				arg_174_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1053ui_story"].transform.localEulerAngles = arg_174_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_174_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1053ui_story"].transform.position).z)
				arg_174_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1053ui_story"].transform.localEulerAngles = arg_174_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_177_2 = GameObjectTools.GetOrAddComponent(arg_174_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_177_2 then
					var_177_2:EnableDynamicBone(true)
				end
			end

			local var_177_3 = arg_174_1.actors_["1053ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_3) and arg_174_1.var_.characterEffect1053ui_story == nil then
				arg_174_1.var_.characterEffect1053ui_story = var_177_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_4 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 and not isNil(var_177_3) then
				if arg_174_1.var_.characterEffect1053ui_story and not isNil(var_177_3) then
					arg_174_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 and not isNil(var_177_3) and arg_174_1.var_.characterEffect1053ui_story then
				arg_174_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action435")
			end

			local var_177_6 = 0
			local var_177_7 = 0.35

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_8 = arg_174_1:GetWordFromCfg(325051042)
				local var_177_9 = arg_174_1:FormatText(var_177_8.content)

				arg_174_1.text_.text = var_177_9

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 14 <= 0 and var_177_7 or var_177_7 * (utf8.len(var_177_9) / 14)

				if (14 <= 0 and var_177_7 or var_177_7 * (utf8.len(var_177_9) / 14)) > 0 and var_177_7 < var_177_11 then
					arg_174_1.talkMaxDuration = var_177_11

					if var_177_11 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_9
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051042", "story_v_out_325051.awb") ~= 0 then
					local var_177_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051042", "story_v_out_325051.awb") / 1000

					if var_177_12 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_12 + var_177_6
					end

					if var_177_8.prefab_name ~= "" and arg_174_1.actors_[var_177_8.prefab_name] ~= nil then
						local var_177_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_8.prefab_name].transform, "story_v_out_325051", "325051042", "story_v_out_325051.awb")

						arg_174_1:RecordAudio("325051042", var_177_13)
						arg_174_1:RecordAudio("325051042", var_177_13)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_325051", "325051042", "story_v_out_325051.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_325051", "325051042", "story_v_out_325051.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_14 and arg_174_1.time_ < var_177_6 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play325051043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325051043
		arg_178_1.duration_ = 5.07

		local var_178_0 = {
			zh = 5.066,
			ja = 5.033
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play325051044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1053ui_story = arg_178_1.actors_["1053ui_story"].transform.localPosition

				local var_181_0 = GameObjectTools.GetOrAddComponent(arg_178_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_181_0 then
					var_181_0:EnableDynamicBone(false)
				end
			end

			local var_181_1 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_1 then
				arg_178_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1053ui_story, Vector3.New(-0.7, -1.08, -6), (arg_178_1.time_ - 0) / var_181_1)
				arg_178_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1053ui_story"].transform.position).z)
				arg_178_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1053ui_story"].transform.localEulerAngles = arg_178_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_1 and arg_178_1.time_ < 0 + var_181_1 + arg_181_0 then
				arg_178_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6)
				arg_178_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1053ui_story"].transform.position).z)
				arg_178_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1053ui_story"].transform.localEulerAngles = arg_178_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_181_2 = GameObjectTools.GetOrAddComponent(arg_178_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_181_2 then
					var_181_2:EnableDynamicBone(true)
				end
			end

			local var_181_3 = arg_178_1.actors_["1077ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1077ui_story = var_181_3.localPosition

				local var_181_4 = GameObjectTools.GetOrAddComponent(var_181_3.gameObject, typeof(DynamicBoneHelper))

				if var_181_4 then
					var_181_4:EnableDynamicBone(false)
				end
			end

			local var_181_5 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_5 then
				var_181_3.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_178_1.time_ - 0) / var_181_5)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_5 and arg_178_1.time_ < 0 + var_181_5 + arg_181_0 then
				var_181_3.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles

				local var_181_6 = GameObjectTools.GetOrAddComponent(var_181_3.gameObject, typeof(DynamicBoneHelper))

				if var_181_6 then
					var_181_6:EnableDynamicBone(true)
				end
			end

			local var_181_7 = arg_178_1.actors_["1077ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_7) and arg_178_1.var_.characterEffect1077ui_story == nil then
				arg_178_1.var_.characterEffect1077ui_story = var_181_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_8 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_8 and not isNil(var_181_7) then
				if arg_178_1.var_.characterEffect1077ui_story and not isNil(var_181_7) then
					arg_178_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_8 and arg_178_1.time_ < 0 + var_181_8 + arg_181_0 and not isNil(var_181_7) and arg_178_1.var_.characterEffect1077ui_story then
				arg_178_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_181_10 = arg_178_1.actors_["1053ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_10) and arg_178_1.var_.characterEffect1053ui_story == nil then
				arg_178_1.var_.characterEffect1053ui_story = var_181_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_11 and not isNil(var_181_10) then
				if arg_178_1.var_.characterEffect1053ui_story and not isNil(var_181_10) then
					arg_178_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_11)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_11 and arg_178_1.time_ < 0 + var_181_11 + arg_181_0 and not isNil(var_181_10) and arg_178_1.var_.characterEffect1053ui_story then
				arg_178_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_181_12 = 0
			local var_181_13 = 0.475

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_14 = arg_178_1:GetWordFromCfg(325051043)
				local var_181_15 = arg_178_1:FormatText(var_181_14.content)

				arg_178_1.text_.text = var_181_15

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_17 = 19 <= 0 and var_181_13 or var_181_13 * (utf8.len(var_181_15) / 19)

				if (19 <= 0 and var_181_13 or var_181_13 * (utf8.len(var_181_15) / 19)) > 0 and var_181_13 < var_181_17 then
					arg_178_1.talkMaxDuration = var_181_17

					if var_181_17 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_17 + var_181_12
					end
				end

				arg_178_1.text_.text = var_181_15
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051043", "story_v_out_325051.awb") ~= 0 then
					local var_181_18 = manager.audio:GetVoiceLength("story_v_out_325051", "325051043", "story_v_out_325051.awb") / 1000

					if var_181_18 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_18 + var_181_12
					end

					if var_181_14.prefab_name ~= "" and arg_178_1.actors_[var_181_14.prefab_name] ~= nil then
						local var_181_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_14.prefab_name].transform, "story_v_out_325051", "325051043", "story_v_out_325051.awb")

						arg_178_1:RecordAudio("325051043", var_181_19)
						arg_178_1:RecordAudio("325051043", var_181_19)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_325051", "325051043", "story_v_out_325051.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_325051", "325051043", "story_v_out_325051.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_20 = math.max(var_181_13, arg_178_1.talkMaxDuration)

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_20 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_12) / var_181_20

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_12 + var_181_20 and arg_178_1.time_ < var_181_12 + var_181_20 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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

		arg_178_1:InitPlayNodeList()
	end,
	Play325051044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325051044
		arg_182_1.duration_ = 7.93

		local var_182_0 = {
			zh = 7.933,
			ja = 7.233
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play325051045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1053ui_story"]) and arg_182_1.var_.characterEffect1053ui_story == nil then
				arg_182_1.var_.characterEffect1053ui_story = arg_182_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1053ui_story"]) then
				if arg_182_1.var_.characterEffect1053ui_story and not isNil(arg_182_1.actors_["1053ui_story"]) then
					arg_182_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1053ui_story"]) and arg_182_1.var_.characterEffect1053ui_story then
				arg_182_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_185_2 = arg_182_1.actors_["1077ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.characterEffect1077ui_story == nil then
				arg_182_1.var_.characterEffect1077ui_story = var_185_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_3 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_3 and not isNil(var_185_2) then
				if arg_182_1.var_.characterEffect1077ui_story and not isNil(var_185_2) then
					arg_182_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_3)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_3 and arg_182_1.time_ < 0 + var_185_3 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.characterEffect1077ui_story then
				arg_182_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_185_4 = 0
			local var_185_5 = 0.85

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(325051044)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 34 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 34)

				if (34 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 34)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051044", "story_v_out_325051.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051044", "story_v_out_325051.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_325051", "325051044", "story_v_out_325051.awb")

						arg_182_1:RecordAudio("325051044", var_185_11)
						arg_182_1:RecordAudio("325051044", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_325051", "325051044", "story_v_out_325051.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_325051", "325051044", "story_v_out_325051.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play325051045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325051045
		arg_186_1.duration_ = 4.63

		local var_186_0 = {
			zh = 4.233,
			ja = 4.633
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play325051046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1077ui_story"]) and arg_186_1.var_.characterEffect1077ui_story == nil then
				arg_186_1.var_.characterEffect1077ui_story = arg_186_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1077ui_story"]) then
				if arg_186_1.var_.characterEffect1077ui_story and not isNil(arg_186_1.actors_["1077ui_story"]) then
					arg_186_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1077ui_story"]) and arg_186_1.var_.characterEffect1077ui_story then
				arg_186_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_189_2 = arg_186_1.actors_["1053ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.characterEffect1053ui_story == nil then
				arg_186_1.var_.characterEffect1053ui_story = var_189_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_3 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 and not isNil(var_189_2) then
				if arg_186_1.var_.characterEffect1053ui_story and not isNil(var_189_2) then
					arg_186_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_3)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.characterEffect1053ui_story then
				arg_186_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_189_4 = 0
			local var_189_5 = 0.625

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(325051045)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 25 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 25)

				if (25 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 25)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051045", "story_v_out_325051.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051045", "story_v_out_325051.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_out_325051", "325051045", "story_v_out_325051.awb")

						arg_186_1:RecordAudio("325051045", var_189_11)
						arg_186_1:RecordAudio("325051045", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_325051", "325051045", "story_v_out_325051.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_325051", "325051045", "story_v_out_325051.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play325051046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 325051046
		arg_190_1.duration_ = 10.47

		local var_190_0 = {
			zh = 5.666,
			ja = 10.466
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play325051047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_2")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_193_0 = 0
			local var_193_1 = 0.675

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(325051046)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 27 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 27)

				if (27 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 27)) > 0 and var_193_1 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051046", "story_v_out_325051.awb") ~= 0 then
					local var_193_6 = manager.audio:GetVoiceLength("story_v_out_325051", "325051046", "story_v_out_325051.awb") / 1000

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end

					if var_193_2.prefab_name ~= "" and arg_190_1.actors_[var_193_2.prefab_name] ~= nil then
						local var_193_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_2.prefab_name].transform, "story_v_out_325051", "325051046", "story_v_out_325051.awb")

						arg_190_1:RecordAudio("325051046", var_193_7)
						arg_190_1:RecordAudio("325051046", var_193_7)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_325051", "325051046", "story_v_out_325051.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_325051", "325051046", "story_v_out_325051.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play325051047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 325051047
		arg_194_1.duration_ = 15.17

		local var_194_0 = {
			zh = 6.533,
			ja = 15.166
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play325051048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1053ui_story"]) and arg_194_1.var_.characterEffect1053ui_story == nil then
				arg_194_1.var_.characterEffect1053ui_story = arg_194_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1053ui_story"]) then
				if arg_194_1.var_.characterEffect1053ui_story and not isNil(arg_194_1.actors_["1053ui_story"]) then
					arg_194_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1053ui_story"]) and arg_194_1.var_.characterEffect1053ui_story then
				arg_194_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_197_2 = arg_194_1.actors_["1077ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1077ui_story == nil then
				arg_194_1.var_.characterEffect1077ui_story = var_197_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_3 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.characterEffect1077ui_story and not isNil(var_197_2) then
					arg_194_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_3)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1077ui_story then
				arg_194_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_197_4 = 0
			local var_197_5 = 0.625

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_6 = arg_194_1:GetWordFromCfg(325051047)
				local var_197_7 = arg_194_1:FormatText(var_197_6.content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 25 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 25)

				if (25 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 25)) > 0 and var_197_5 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051047", "story_v_out_325051.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051047", "story_v_out_325051.awb") / 1000

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end

					if var_197_6.prefab_name ~= "" and arg_194_1.actors_[var_197_6.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_6.prefab_name].transform, "story_v_out_325051", "325051047", "story_v_out_325051.awb")

						arg_194_1:RecordAudio("325051047", var_197_11)
						arg_194_1:RecordAudio("325051047", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_325051", "325051047", "story_v_out_325051.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_325051", "325051047", "story_v_out_325051.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_12 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_12 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_4) / var_197_12

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_4 + var_197_12 and arg_194_1.time_ < var_197_4 + var_197_12 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play325051048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325051048
		arg_198_1.duration_ = 6.7

		local var_198_0 = {
			zh = 6.7,
			ja = 2.833
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play325051049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1077ui_story"]) and arg_198_1.var_.characterEffect1077ui_story == nil then
				arg_198_1.var_.characterEffect1077ui_story = arg_198_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1077ui_story"]) then
				if arg_198_1.var_.characterEffect1077ui_story and not isNil(arg_198_1.actors_["1077ui_story"]) then
					arg_198_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1077ui_story"]) and arg_198_1.var_.characterEffect1077ui_story then
				arg_198_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_201_2 = arg_198_1.actors_["1053ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect1053ui_story == nil then
				arg_198_1.var_.characterEffect1053ui_story = var_201_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_3 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.characterEffect1053ui_story and not isNil(var_201_2) then
					arg_198_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_3)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect1053ui_story then
				arg_198_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_201_4 = 0
			local var_201_5 = 0.5

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(325051048)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 20 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 20)

				if (20 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 20)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051048", "story_v_out_325051.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051048", "story_v_out_325051.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_out_325051", "325051048", "story_v_out_325051.awb")

						arg_198_1:RecordAudio("325051048", var_201_11)
						arg_198_1:RecordAudio("325051048", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_325051", "325051048", "story_v_out_325051.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_325051", "325051048", "story_v_out_325051.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play325051049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325051049
		arg_202_1.duration_ = 7.2

		local var_202_0 = {
			zh = 6.6,
			ja = 7.2
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325051050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_205_0 = 0
			local var_205_1 = 0.7

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_2 = arg_202_1:GetWordFromCfg(325051049)
				local var_205_3 = arg_202_1:FormatText(var_205_2.content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 28 <= 0 and var_205_1 or var_205_1 * (utf8.len(var_205_3) / 28)

				if (28 <= 0 and var_205_1 or var_205_1 * (utf8.len(var_205_3) / 28)) > 0 and var_205_1 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051049", "story_v_out_325051.awb") ~= 0 then
					local var_205_6 = manager.audio:GetVoiceLength("story_v_out_325051", "325051049", "story_v_out_325051.awb") / 1000

					if var_205_6 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_0
					end

					if var_205_2.prefab_name ~= "" and arg_202_1.actors_[var_205_2.prefab_name] ~= nil then
						local var_205_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_2.prefab_name].transform, "story_v_out_325051", "325051049", "story_v_out_325051.awb")

						arg_202_1:RecordAudio("325051049", var_205_7)
						arg_202_1:RecordAudio("325051049", var_205_7)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_325051", "325051049", "story_v_out_325051.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_325051", "325051049", "story_v_out_325051.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_8 and arg_202_1.time_ < var_205_0 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play325051050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325051050
		arg_206_1.duration_ = 9

		local var_206_0 = {
			zh = 2.833,
			ja = 9
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325051051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1053ui_story"]) and arg_206_1.var_.characterEffect1053ui_story == nil then
				arg_206_1.var_.characterEffect1053ui_story = arg_206_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1053ui_story"]) then
				if arg_206_1.var_.characterEffect1053ui_story and not isNil(arg_206_1.actors_["1053ui_story"]) then
					arg_206_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1053ui_story"]) and arg_206_1.var_.characterEffect1053ui_story then
				arg_206_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_209_2 = arg_206_1.actors_["1077ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.characterEffect1077ui_story == nil then
				arg_206_1.var_.characterEffect1077ui_story = var_209_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_3 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.characterEffect1077ui_story and not isNil(var_209_2) then
					arg_206_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_3)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.characterEffect1077ui_story then
				arg_206_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_209_4 = 0
			local var_209_5 = 0.3

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:GetWordFromCfg(325051050)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 12 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 12)

				if (12 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 12)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051050", "story_v_out_325051.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051050", "story_v_out_325051.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_out_325051", "325051050", "story_v_out_325051.awb")

						arg_206_1:RecordAudio("325051050", var_209_11)
						arg_206_1:RecordAudio("325051050", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325051", "325051050", "story_v_out_325051.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325051", "325051050", "story_v_out_325051.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_12 and arg_206_1.time_ < var_209_4 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play325051051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325051051
		arg_210_1.duration_ = 3.77

		local var_210_0 = {
			zh = 3.766,
			ja = 3.6
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325051052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1077ui_story"]) and arg_210_1.var_.characterEffect1077ui_story == nil then
				arg_210_1.var_.characterEffect1077ui_story = arg_210_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1077ui_story"]) then
				if arg_210_1.var_.characterEffect1077ui_story and not isNil(arg_210_1.actors_["1077ui_story"]) then
					arg_210_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1077ui_story"]) and arg_210_1.var_.characterEffect1077ui_story then
				arg_210_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_213_2 = arg_210_1.actors_["1053ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1053ui_story == nil then
				arg_210_1.var_.characterEffect1053ui_story = var_213_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_3 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.characterEffect1053ui_story and not isNil(var_213_2) then
					arg_210_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_3)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1053ui_story then
				arg_210_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_213_4 = 0
			local var_213_5 = 0.425

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(325051051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 17 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 17)

				if (17 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 17)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051051", "story_v_out_325051.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051051", "story_v_out_325051.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_325051", "325051051", "story_v_out_325051.awb")

						arg_210_1:RecordAudio("325051051", var_213_11)
						arg_210_1:RecordAudio("325051051", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_325051", "325051051", "story_v_out_325051.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_325051", "325051051", "story_v_out_325051.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play325051052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325051052
		arg_214_1.duration_ = 9.9

		local var_214_0 = {
			zh = 5.533,
			ja = 9.9
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325051053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1053ui_story"]) and arg_214_1.var_.characterEffect1053ui_story == nil then
				arg_214_1.var_.characterEffect1053ui_story = arg_214_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1053ui_story"]) then
				if arg_214_1.var_.characterEffect1053ui_story and not isNil(arg_214_1.actors_["1053ui_story"]) then
					arg_214_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1053ui_story"]) and arg_214_1.var_.characterEffect1053ui_story then
				arg_214_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_217_2 = arg_214_1.actors_["1077ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1077ui_story == nil then
				arg_214_1.var_.characterEffect1077ui_story = var_217_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_3 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.characterEffect1077ui_story and not isNil(var_217_2) then
					arg_214_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_3)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1077ui_story then
				arg_214_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			local var_217_4 = 0
			local var_217_5 = 0.5

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(325051052)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 20 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 20)

				if (20 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 20)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051052", "story_v_out_325051.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051052", "story_v_out_325051.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_out_325051", "325051052", "story_v_out_325051.awb")

						arg_214_1:RecordAudio("325051052", var_217_11)
						arg_214_1:RecordAudio("325051052", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325051", "325051052", "story_v_out_325051.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325051", "325051052", "story_v_out_325051.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play325051053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325051053
		arg_218_1.duration_ = 6.8

		local var_218_0 = {
			zh = 4.9,
			ja = 6.8
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325051054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1077ui_story"]) and arg_218_1.var_.characterEffect1077ui_story == nil then
				arg_218_1.var_.characterEffect1077ui_story = arg_218_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1077ui_story"]) then
				if arg_218_1.var_.characterEffect1077ui_story and not isNil(arg_218_1.actors_["1077ui_story"]) then
					arg_218_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1077ui_story"]) and arg_218_1.var_.characterEffect1077ui_story then
				arg_218_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_221_2 = arg_218_1.actors_["1053ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1053ui_story == nil then
				arg_218_1.var_.characterEffect1053ui_story = var_221_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_3 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.characterEffect1053ui_story and not isNil(var_221_2) then
					arg_218_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_3)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1053ui_story then
				arg_218_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_221_4 = 0
			local var_221_5 = 0.525

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(325051053)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 21 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 21)

				if (21 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 21)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051053", "story_v_out_325051.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051053", "story_v_out_325051.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_325051", "325051053", "story_v_out_325051.awb")

						arg_218_1:RecordAudio("325051053", var_221_11)
						arg_218_1:RecordAudio("325051053", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_325051", "325051053", "story_v_out_325051.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_325051", "325051053", "story_v_out_325051.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play325051054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325051054
		arg_222_1.duration_ = 4.8

		local var_222_0 = {
			zh = 4.8,
			ja = 4.3
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325051055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.5

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(325051054)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 20)

				if (20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 20)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051054", "story_v_out_325051.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051054", "story_v_out_325051.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_325051", "325051054", "story_v_out_325051.awb")

						arg_222_1:RecordAudio("325051054", var_225_6)
						arg_222_1:RecordAudio("325051054", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_325051", "325051054", "story_v_out_325051.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_325051", "325051054", "story_v_out_325051.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play325051055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325051055
		arg_226_1.duration_ = 3.87

		local var_226_0 = {
			zh = 2.633,
			ja = 3.866
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325051056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1053ui_story"]) and arg_226_1.var_.characterEffect1053ui_story == nil then
				arg_226_1.var_.characterEffect1053ui_story = arg_226_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1053ui_story"]) then
				if arg_226_1.var_.characterEffect1053ui_story and not isNil(arg_226_1.actors_["1053ui_story"]) then
					arg_226_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1053ui_story"]) and arg_226_1.var_.characterEffect1053ui_story then
				arg_226_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_229_2 = arg_226_1.actors_["1077ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.characterEffect1077ui_story == nil then
				arg_226_1.var_.characterEffect1077ui_story = var_229_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_3 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.characterEffect1077ui_story and not isNil(var_229_2) then
					arg_226_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_3)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.characterEffect1077ui_story then
				arg_226_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.275

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(325051055)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 11 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 11)

				if (11 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 11)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051055", "story_v_out_325051.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051055", "story_v_out_325051.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_out_325051", "325051055", "story_v_out_325051.awb")

						arg_226_1:RecordAudio("325051055", var_229_11)
						arg_226_1:RecordAudio("325051055", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325051", "325051055", "story_v_out_325051.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325051", "325051055", "story_v_out_325051.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play325051056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325051056
		arg_230_1.duration_ = 7.37

		local var_230_0 = {
			zh = 4.933,
			ja = 7.366
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325051057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_2")
			end

			local var_233_0 = 0
			local var_233_1 = 0.55

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_2 = arg_230_1:GetWordFromCfg(325051056)
				local var_233_3 = arg_230_1:FormatText(var_233_2.content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 22 <= 0 and var_233_1 or var_233_1 * (utf8.len(var_233_3) / 22)

				if (22 <= 0 and var_233_1 or var_233_1 * (utf8.len(var_233_3) / 22)) > 0 and var_233_1 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051056", "story_v_out_325051.awb") ~= 0 then
					local var_233_6 = manager.audio:GetVoiceLength("story_v_out_325051", "325051056", "story_v_out_325051.awb") / 1000

					if var_233_6 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_0
					end

					if var_233_2.prefab_name ~= "" and arg_230_1.actors_[var_233_2.prefab_name] ~= nil then
						local var_233_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_2.prefab_name].transform, "story_v_out_325051", "325051056", "story_v_out_325051.awb")

						arg_230_1:RecordAudio("325051056", var_233_7)
						arg_230_1:RecordAudio("325051056", var_233_7)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_325051", "325051056", "story_v_out_325051.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_325051", "325051056", "story_v_out_325051.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_8 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_8 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_8

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_8 and arg_230_1.time_ < var_233_0 + var_233_8 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play325051057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325051057
		arg_234_1.duration_ = 3.2

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325051058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1077ui_story"]) and arg_234_1.var_.characterEffect1077ui_story == nil then
				arg_234_1.var_.characterEffect1077ui_story = arg_234_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1077ui_story"]) then
				if arg_234_1.var_.characterEffect1077ui_story and not isNil(arg_234_1.actors_["1077ui_story"]) then
					arg_234_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1077ui_story"]) and arg_234_1.var_.characterEffect1077ui_story then
				arg_234_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_237_2 = arg_234_1.actors_["1053ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.characterEffect1053ui_story == nil then
				arg_234_1.var_.characterEffect1053ui_story = var_237_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_3 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.characterEffect1053ui_story and not isNil(var_237_2) then
					arg_234_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_3)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.characterEffect1053ui_story then
				arg_234_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_237_4 = 0
			local var_237_5 = 0.25

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(325051057)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 10 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 10)

				if (10 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 10)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051057", "story_v_out_325051.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051057", "story_v_out_325051.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_out_325051", "325051057", "story_v_out_325051.awb")

						arg_234_1:RecordAudio("325051057", var_237_11)
						arg_234_1:RecordAudio("325051057", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325051", "325051057", "story_v_out_325051.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325051", "325051057", "story_v_out_325051.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play325051058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325051058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325051059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1053ui_story = arg_238_1.actors_["1053ui_story"].transform.localPosition

				local var_241_0 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_0 then
					var_241_0:EnableDynamicBone(false)
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_1)
				arg_238_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1053ui_story"].transform.position).z)
				arg_238_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1053ui_story"].transform.localEulerAngles = arg_238_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1053ui_story"].transform.position).z)
				arg_238_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1053ui_story"].transform.localEulerAngles = arg_238_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_241_2 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(true)
				end
			end

			local var_241_3 = arg_238_1.actors_["1077ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1077ui_story = var_241_3.localPosition

				local var_241_4 = GameObjectTools.GetOrAddComponent(var_241_3.gameObject, typeof(DynamicBoneHelper))

				if var_241_4 then
					var_241_4:EnableDynamicBone(false)
				end
			end

			local var_241_5 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_5 then
				var_241_3.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_5)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_5 and arg_238_1.time_ < 0 + var_241_5 + arg_241_0 then
				var_241_3.localPosition = Vector3.New(0, 100, 0)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles

				local var_241_6 = GameObjectTools.GetOrAddComponent(var_241_3.gameObject, typeof(DynamicBoneHelper))

				if var_241_6 then
					var_241_6:EnableDynamicBone(true)
				end
			end

			local var_241_7 = arg_238_1.actors_["1077ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_7) and arg_238_1.var_.characterEffect1077ui_story == nil then
				arg_238_1.var_.characterEffect1077ui_story = var_241_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_8 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_8 and not isNil(var_241_7) then
				if arg_238_1.var_.characterEffect1077ui_story and not isNil(var_241_7) then
					arg_238_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_8)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_8 and arg_238_1.time_ < 0 + var_241_8 + arg_241_0 and not isNil(var_241_7) and arg_238_1.var_.characterEffect1077ui_story then
				arg_238_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_241_9 = 0
			local var_241_10 = 1.175

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_11 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(325051058).content)

				arg_238_1.text_.text = var_241_11

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 47 <= 0 and var_241_10 or var_241_10 * (utf8.len(var_241_11) / 47)

				if (47 <= 0 and var_241_10 or var_241_10 * (utf8.len(var_241_11) / 47)) > 0 and var_241_10 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_9 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_9
					end
				end

				arg_238_1.text_.text = var_241_11
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_14 = math.max(var_241_10, arg_238_1.talkMaxDuration)

			if var_241_9 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_14 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_9) / var_241_14

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_9 + var_241_14 and arg_238_1.time_ < var_241_9 + var_241_14 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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

		arg_238_1:InitPlayNodeList()
	end,
	Play325051059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325051059
		arg_242_1.duration_ = 1.13

		local var_242_0 = {
			zh = 1,
			ja = 1.133
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325051060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1077ui_story = arg_242_1.actors_["1077ui_story"].transform.localPosition

				local var_245_0 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_0 then
					var_245_0:EnableDynamicBone(false)
				end
			end

			local var_245_1 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_1 then
				arg_242_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_1)
				arg_242_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).z)
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles = arg_242_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_1 and arg_242_1.time_ < 0 + var_245_1 + arg_245_0 then
				arg_242_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).z)
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles = arg_242_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_245_2 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(true)
				end
			end

			local var_245_3 = arg_242_1.actors_["1077ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1077ui_story == nil then
				arg_242_1.var_.characterEffect1077ui_story = var_245_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_4 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 and not isNil(var_245_3) then
				if arg_242_1.var_.characterEffect1077ui_story and not isNil(var_245_3) then
					arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1077ui_story then
				arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_245_6 = 0
			local var_245_7 = 0.0329999998211861

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_8 = arg_242_1:GetWordFromCfg(325051059)
				local var_245_9 = arg_242_1:FormatText(var_245_8.content)

				arg_242_1.text_.text = var_245_9

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 1 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 1)

				if (1 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 1)) > 0 and var_245_7 < var_245_11 then
					arg_242_1.talkMaxDuration = var_245_11

					if var_245_11 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_11 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_9
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051059", "story_v_out_325051.awb") ~= 0 then
					local var_245_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051059", "story_v_out_325051.awb") / 1000

					if var_245_12 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_12 + var_245_6
					end

					if var_245_8.prefab_name ~= "" and arg_242_1.actors_[var_245_8.prefab_name] ~= nil then
						local var_245_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_8.prefab_name].transform, "story_v_out_325051", "325051059", "story_v_out_325051.awb")

						arg_242_1:RecordAudio("325051059", var_245_13)
						arg_242_1:RecordAudio("325051059", var_245_13)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325051", "325051059", "story_v_out_325051.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325051", "325051059", "story_v_out_325051.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_14 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_14 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_14

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_14 and arg_242_1.time_ < var_245_6 + var_245_14 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play325051060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325051060
		arg_246_1.duration_ = 6.2

		local var_246_0 = {
			zh = 4.766,
			ja = 6.2
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
				arg_246_0:Play325051061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1077ui_story = arg_246_1.actors_["1077ui_story"].transform.localPosition

				local var_249_0 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_0 then
					var_249_0:EnableDynamicBone(false)
				end
			end

			local var_249_1 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 then
				arg_246_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_1)
				arg_246_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1077ui_story"].transform.position).z)
				arg_246_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1077ui_story"].transform.localEulerAngles = arg_246_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 then
				arg_246_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_246_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1077ui_story"].transform.position).z)
				arg_246_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1077ui_story"].transform.localEulerAngles = arg_246_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_249_2 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_2 then
					var_249_2:EnableDynamicBone(true)
				end
			end

			local var_249_3 = arg_246_1.actors_["1053ui_story"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1053ui_story = var_249_3.localPosition

				local var_249_4 = GameObjectTools.GetOrAddComponent(var_249_3.gameObject, typeof(DynamicBoneHelper))

				if var_249_4 then
					var_249_4:EnableDynamicBone(false)
				end
			end

			local var_249_5 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_5 then
				var_249_3.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_5)
				var_249_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_3.position).x, (manager.ui.mainCamera.transform.position - var_249_3.position).y, (manager.ui.mainCamera.transform.position - var_249_3.position).z)
				var_249_3.localEulerAngles.z = 0
				var_249_3.localEulerAngles.x = 0
				var_249_3.localEulerAngles = var_249_3.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_5 and arg_246_1.time_ < 0 + var_249_5 + arg_249_0 then
				var_249_3.localPosition = Vector3.New(0, 100, 0)
				var_249_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_3.position).x, (manager.ui.mainCamera.transform.position - var_249_3.position).y, (manager.ui.mainCamera.transform.position - var_249_3.position).z)
				var_249_3.localEulerAngles.z = 0
				var_249_3.localEulerAngles.x = 0
				var_249_3.localEulerAngles = var_249_3.localEulerAngles

				local var_249_6 = GameObjectTools.GetOrAddComponent(var_249_3.gameObject, typeof(DynamicBoneHelper))

				if var_249_6 then
					var_249_6:EnableDynamicBone(true)
				end
			end

			local var_249_7 = arg_246_1.actors_["1053ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_7) and arg_246_1.var_.characterEffect1053ui_story == nil then
				arg_246_1.var_.characterEffect1053ui_story = var_249_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_8 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_8 and not isNil(var_249_7) then
				if arg_246_1.var_.characterEffect1053ui_story and not isNil(var_249_7) then
					arg_246_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_8 and arg_246_1.time_ < 0 + var_249_8 + arg_249_0 and not isNil(var_249_7) and arg_246_1.var_.characterEffect1053ui_story then
				arg_246_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_249_10 = arg_246_1.actors_["1077ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_10) and arg_246_1.var_.characterEffect1077ui_story == nil then
				arg_246_1.var_.characterEffect1077ui_story = var_249_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_11 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_11 and not isNil(var_249_10) then
				if arg_246_1.var_.characterEffect1077ui_story and not isNil(var_249_10) then
					arg_246_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_11)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_11 and arg_246_1.time_ < 0 + var_249_11 + arg_249_0 and not isNil(var_249_10) and arg_246_1.var_.characterEffect1077ui_story then
				arg_246_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_249_12 = 0
			local var_249_13 = 0.325

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_12 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_14 = arg_246_1:GetWordFromCfg(325051060)
				local var_249_15 = arg_246_1:FormatText(var_249_14.content)

				arg_246_1.text_.text = var_249_15

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_17 = 13 <= 0 and var_249_13 or var_249_13 * (utf8.len(var_249_15) / 13)

				if (13 <= 0 and var_249_13 or var_249_13 * (utf8.len(var_249_15) / 13)) > 0 and var_249_13 < var_249_17 then
					arg_246_1.talkMaxDuration = var_249_17

					if var_249_17 + var_249_12 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_17 + var_249_12
					end
				end

				arg_246_1.text_.text = var_249_15
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051060", "story_v_out_325051.awb") ~= 0 then
					local var_249_18 = manager.audio:GetVoiceLength("story_v_out_325051", "325051060", "story_v_out_325051.awb") / 1000

					if var_249_18 + var_249_12 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_18 + var_249_12
					end

					if var_249_14.prefab_name ~= "" and arg_246_1.actors_[var_249_14.prefab_name] ~= nil then
						local var_249_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_14.prefab_name].transform, "story_v_out_325051", "325051060", "story_v_out_325051.awb")

						arg_246_1:RecordAudio("325051060", var_249_19)
						arg_246_1:RecordAudio("325051060", var_249_19)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325051", "325051060", "story_v_out_325051.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325051", "325051060", "story_v_out_325051.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_20 = math.max(var_249_13, arg_246_1.talkMaxDuration)

			if var_249_12 <= arg_246_1.time_ and arg_246_1.time_ < var_249_12 + var_249_20 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_12) / var_249_20

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_12 + var_249_20 and arg_246_1.time_ < var_249_12 + var_249_20 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
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
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play325051061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325051061
		arg_250_1.duration_ = 16.8

		local var_250_0 = {
			zh = 11,
			ja = 16.8
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
				arg_250_0:Play325051062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.775

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:GetWordFromCfg(325051061)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 31 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 31)

				if (31 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 31)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051061", "story_v_out_325051.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051061", "story_v_out_325051.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_325051", "325051061", "story_v_out_325051.awb")

						arg_250_1:RecordAudio("325051061", var_253_6)
						arg_250_1:RecordAudio("325051061", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_325051", "325051061", "story_v_out_325051.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_325051", "325051061", "story_v_out_325051.awb")
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
	Play325051062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325051062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325051063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1053ui_story = arg_254_1.actors_["1053ui_story"].transform.localPosition

				local var_257_0 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_0 then
					var_257_0:EnableDynamicBone(false)
				end
			end

			local var_257_1 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_1 then
				arg_254_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_1)
				arg_254_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1053ui_story"].transform.position).z)
				arg_254_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1053ui_story"].transform.localEulerAngles = arg_254_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_1 and arg_254_1.time_ < 0 + var_257_1 + arg_257_0 then
				arg_254_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1053ui_story"].transform.position).z)
				arg_254_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1053ui_story"].transform.localEulerAngles = arg_254_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_257_2 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_2 then
					var_257_2:EnableDynamicBone(true)
				end
			end

			local var_257_3 = arg_254_1.actors_["1077ui_story"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1077ui_story = var_257_3.localPosition

				local var_257_4 = GameObjectTools.GetOrAddComponent(var_257_3.gameObject, typeof(DynamicBoneHelper))

				if var_257_4 then
					var_257_4:EnableDynamicBone(false)
				end
			end

			local var_257_5 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_5 then
				var_257_3.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_5)
				var_257_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_3.position).x, (manager.ui.mainCamera.transform.position - var_257_3.position).y, (manager.ui.mainCamera.transform.position - var_257_3.position).z)
				var_257_3.localEulerAngles.z = 0
				var_257_3.localEulerAngles.x = 0
				var_257_3.localEulerAngles = var_257_3.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_5 and arg_254_1.time_ < 0 + var_257_5 + arg_257_0 then
				var_257_3.localPosition = Vector3.New(0, 100, 0)
				var_257_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_3.position).x, (manager.ui.mainCamera.transform.position - var_257_3.position).y, (manager.ui.mainCamera.transform.position - var_257_3.position).z)
				var_257_3.localEulerAngles.z = 0
				var_257_3.localEulerAngles.x = 0
				var_257_3.localEulerAngles = var_257_3.localEulerAngles

				local var_257_6 = GameObjectTools.GetOrAddComponent(var_257_3.gameObject, typeof(DynamicBoneHelper))

				if var_257_6 then
					var_257_6:EnableDynamicBone(true)
				end
			end

			local var_257_7 = arg_254_1.actors_["1053ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_7) and arg_254_1.var_.characterEffect1053ui_story == nil then
				arg_254_1.var_.characterEffect1053ui_story = var_257_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_8 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_8 and not isNil(var_257_7) then
				if arg_254_1.var_.characterEffect1053ui_story and not isNil(var_257_7) then
					arg_254_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_8)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_8 and arg_254_1.time_ < 0 + var_257_8 + arg_257_0 and not isNil(var_257_7) and arg_254_1.var_.characterEffect1053ui_story then
				arg_254_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_257_9 = 0
			local var_257_10 = 1.625

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_11 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(325051062).content)

				arg_254_1.text_.text = var_257_11

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 65 <= 0 and var_257_10 or var_257_10 * (utf8.len(var_257_11) / 65)

				if (65 <= 0 and var_257_10 or var_257_10 * (utf8.len(var_257_11) / 65)) > 0 and var_257_10 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_9 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_9
					end
				end

				arg_254_1.text_.text = var_257_11
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_10, arg_254_1.talkMaxDuration)

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_9) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_9 + var_257_14 and arg_254_1.time_ < var_257_9 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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

		arg_254_1:InitPlayNodeList()
	end,
	Play325051063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325051063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325051064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1.225

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(325051063).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 49 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 49)

				if (49 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 49)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play325051064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325051064
		arg_262_1.duration_ = 5.13

		local var_262_0 = {
			zh = 4.366,
			ja = 5.133
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
				arg_262_0:Play325051065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1077ui_story = arg_262_1.actors_["1077ui_story"].transform.localPosition

				local var_265_0 = GameObjectTools.GetOrAddComponent(arg_262_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_265_0 then
					var_265_0:EnableDynamicBone(false)
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_262_1.time_ - 0) / var_265_1)
				arg_262_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1077ui_story"].transform.position).z)
				arg_262_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1077ui_story"].transform.localEulerAngles = arg_262_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_262_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1077ui_story"].transform.position).z)
				arg_262_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1077ui_story"].transform.localEulerAngles = arg_262_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_265_2 = GameObjectTools.GetOrAddComponent(arg_262_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(true)
				end
			end

			local var_265_3 = arg_262_1.actors_["1077ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect1077ui_story == nil then
				arg_262_1.var_.characterEffect1077ui_story = var_265_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_4 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 and not isNil(var_265_3) then
				if arg_262_1.var_.characterEffect1077ui_story and not isNil(var_265_3) then
					arg_262_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect1077ui_story then
				arg_262_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_265_6 = 0
			local var_265_7 = 0.275

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_8 = arg_262_1:GetWordFromCfg(325051064)
				local var_265_9 = arg_262_1:FormatText(var_265_8.content)

				arg_262_1.text_.text = var_265_9

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 11 <= 0 and var_265_7 or var_265_7 * (utf8.len(var_265_9) / 11)

				if (11 <= 0 and var_265_7 or var_265_7 * (utf8.len(var_265_9) / 11)) > 0 and var_265_7 < var_265_11 then
					arg_262_1.talkMaxDuration = var_265_11

					if var_265_11 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_9
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051064", "story_v_out_325051.awb") ~= 0 then
					local var_265_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051064", "story_v_out_325051.awb") / 1000

					if var_265_12 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_12 + var_265_6
					end

					if var_265_8.prefab_name ~= "" and arg_262_1.actors_[var_265_8.prefab_name] ~= nil then
						local var_265_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_8.prefab_name].transform, "story_v_out_325051", "325051064", "story_v_out_325051.awb")

						arg_262_1:RecordAudio("325051064", var_265_13)
						arg_262_1:RecordAudio("325051064", var_265_13)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_325051", "325051064", "story_v_out_325051.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_325051", "325051064", "story_v_out_325051.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_14 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_14 and arg_262_1.time_ < var_265_6 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
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

		arg_262_1:InitPlayNodeList()
	end,
	Play325051065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325051065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325051066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1077ui_story = arg_266_1.actors_["1077ui_story"].transform.localPosition

				local var_269_0 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_0 then
					var_269_0:EnableDynamicBone(false)
				end
			end

			local var_269_1 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_1 then
				arg_266_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_1)
				arg_266_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1077ui_story"].transform.position).z)
				arg_266_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1077ui_story"].transform.localEulerAngles = arg_266_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_1 and arg_266_1.time_ < 0 + var_269_1 + arg_269_0 then
				arg_266_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1077ui_story"].transform.position).z)
				arg_266_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1077ui_story"].transform.localEulerAngles = arg_266_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_269_2 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(true)
				end
			end

			local var_269_3 = arg_266_1.actors_["1077ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect1077ui_story == nil then
				arg_266_1.var_.characterEffect1077ui_story = var_269_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_4 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 and not isNil(var_269_3) then
				if arg_266_1.var_.characterEffect1077ui_story and not isNil(var_269_3) then
					arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_4)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect1077ui_story then
				arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_269_5 = 0
			local var_269_6 = 1.375

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(325051065).content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 55 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 55)

				if (55 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 55)) > 0 and var_269_6 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_5
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_6, arg_266_1.talkMaxDuration)

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_5) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_5 + var_269_10 and arg_266_1.time_ < var_269_5 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play325051066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325051066
		arg_270_1.duration_ = 9.87

		local var_270_0 = {
			zh = 9.2057582965903,
			ja = 9.8727582965903
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
				arg_270_0:Play325051067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_9000

			if arg_270_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_273_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_270_1.stage_.transform)

				var_273_0.name = "1075ui_story"
				var_273_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.actors_["1075ui_story"] = var_273_0

				local var_273_1 = var_273_0:GetComponentInChildren(typeof(CharacterEffect))

				var_273_1.enabled = true

				local var_273_2 = GameObjectTools.GetOrAddComponent(var_273_0, typeof(DynamicBoneHelper))

				if var_273_2 then
					var_273_2:EnableDynamicBone(false)
				end

				arg_270_1:ShowWeapon(var_273_1.transform, false)

				arg_270_1.var_["1075ui_story" .. "Animator"] = var_273_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_270_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_270_1.var_["1075ui_story" .. "LipSync"] = var_273_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_273_3 = arg_270_1.actors_["1075ui_story"].transform

			if 2.96666666666667 < arg_270_1.time_ and arg_270_1.time_ <= 2.96666666666667 + arg_273_0 then
				arg_270_1.var_.moveOldPos1075ui_story = var_273_3.localPosition
			end

			local var_273_4 = 0.001

			if 2.96666666666667 <= arg_270_1.time_ and arg_270_1.time_ < 2.96666666666667 + var_273_4 then
				var_273_3.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_270_1.time_ - 2.96666666666667) / var_273_4)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			if arg_270_1.time_ >= 2.96666666666667 + var_273_4 and arg_270_1.time_ < 2.96666666666667 + var_273_4 + arg_273_0 then
				var_273_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			local var_273_5 = arg_270_1.actors_["1075ui_story"]

			if 2.96666666666667 < arg_270_1.time_ and arg_270_1.time_ <= 2.96666666666667 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1075ui_story == nil then
				arg_270_1.var_.characterEffect1075ui_story = var_273_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.200000002980232

			if 2.96666666666667 <= arg_270_1.time_ and arg_270_1.time_ < 2.96666666666667 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.characterEffect1075ui_story and not isNil(var_273_5) then
					arg_270_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 2.96666666666667 + var_273_6 and arg_270_1.time_ < 2.96666666666667 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1075ui_story then
				arg_270_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 2.96666666666667 < arg_270_1.time_ and arg_270_1.time_ <= 2.96666666666667 + arg_273_0 then
				arg_270_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 2.96666666666667 < arg_270_1.time_ and arg_270_1.time_ <= 2.96666666666667 + arg_273_0 then
				arg_270_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_8 = arg_270_1.var_.effectadwd

				if not arg_270_1.var_.effectadwd then
					var_273_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), manager.ui.mainCamera.transform)
					var_273_8.name = "adwd"
					arg_270_1.var_.effectadwd = var_273_8
				else
					var_273_8.transform:SetParent(var_273_9000)
				end

				var_273_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_273_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_273_8.transform.localScale = Vector3.New(var_273_8.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_273_8.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_273_8.transform.localScale.z)
			end

			if 1.8397582965903 < arg_270_1.time_ and arg_270_1.time_ <= 1.8397582965903 + arg_273_0 then
				if arg_270_1.var_.effectadwd then
					Object.Destroy(arg_270_1.var_.effectadwd)

					arg_270_1.var_.effectadwd = nil
				end
			end

			local var_273_11 = 1.26666666666667

			if 1.26666666666667 < arg_270_1.time_ and arg_270_1.time_ <= var_273_11 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_12 = 1.10000000298023

			if var_273_11 <= arg_270_1.time_ and arg_270_1.time_ < var_273_11 + var_273_12 then
				local var_273_13 = Color.New(1, 1, 1)

				var_273_13.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_11) / var_273_12)
				arg_270_1.mask_.color = var_273_13
			end

			if arg_270_1.time_ >= var_273_11 + var_273_12 and arg_270_1.time_ < var_273_11 + var_273_12 + arg_273_0 then
				local var_273_14 = Color.New(1, 1, 1)

				arg_270_1.mask_.enabled = false
				var_273_14.a = 0
				arg_270_1.mask_.color = var_273_14
			end

			local var_273_15 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_15 + 3.66666666666667 and arg_270_1.time_ < var_273_15 + 3.66666666666667 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			if 2.7 < arg_270_1.time_ and arg_270_1.time_ <= 2.7 + arg_273_0 then
				if arg_270_1.var_.characterEffect1075ui_story == nil then
					arg_270_1.var_.characterEffect1075ui_story = arg_270_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_270_1.var_.characterEffect1075ui_story.imageEffect:turnOn(false)
			end

			if 2.7 < arg_270_1.time_ and arg_270_1.time_ <= 2.7 + arg_273_0 then
				if arg_270_1.var_.characterEffect1075ui_story == nil then
					arg_270_1.var_.characterEffect1075ui_story = arg_270_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_273_17 = arg_270_1.var_.characterEffect1075ui_story

				arg_270_1.var_.characterEffect1075ui_story.imageEffect:turnOff()

				var_273_17.interferenceEffect.enabled = true
				var_273_17.interferenceEffect.noise = 0.001
				var_273_17.interferenceEffect.simTimeScale = 1
				var_273_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_18 = 3.4397582965903
			local var_273_19 = 0.625

			if 3.4397582965903 < arg_270_1.time_ and arg_270_1.time_ <= var_273_18 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_20 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_20:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_21 = arg_270_1:GetWordFromCfg(325051066)
				local var_273_22 = arg_270_1:FormatText(var_273_21.content)

				arg_270_1.text_.text = var_273_22

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_24 = 25 <= 0 and var_273_19 or var_273_19 * (utf8.len(var_273_22) / 25)

				if (25 <= 0 and var_273_19 or var_273_19 * (utf8.len(var_273_22) / 25)) > 0 and var_273_19 < var_273_24 then
					arg_270_1.talkMaxDuration = var_273_24
					var_273_18 = var_273_18 + 0.3

					if var_273_24 + var_273_18 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_24 + var_273_18
					end
				end

				arg_270_1.text_.text = var_273_22
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051066", "story_v_out_325051.awb") ~= 0 then
					local var_273_25 = manager.audio:GetVoiceLength("story_v_out_325051", "325051066", "story_v_out_325051.awb") / 1000

					if var_273_25 + var_273_18 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_25 + var_273_18
					end

					if var_273_21.prefab_name ~= "" and arg_270_1.actors_[var_273_21.prefab_name] ~= nil then
						local var_273_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_21.prefab_name].transform, "story_v_out_325051", "325051066", "story_v_out_325051.awb")

						arg_270_1:RecordAudio("325051066", var_273_26)
						arg_270_1:RecordAudio("325051066", var_273_26)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_325051", "325051066", "story_v_out_325051.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_325051", "325051066", "story_v_out_325051.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_27 = var_273_18 + 0.3
			local var_273_28 = math.max(var_273_19, arg_270_1.talkMaxDuration)

			if var_273_18 + 0.3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_27 + var_273_28 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_27) / var_273_28

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_27 + var_273_28 and arg_270_1.time_ < var_273_27 + var_273_28 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play325051067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325051067
		arg_276_1.duration_ = 12.6

		local var_276_0 = {
			zh = 6.466,
			ja = 12.6
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play325051068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1075ui_story = arg_276_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_279_0 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 then
				arg_276_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_276_1.time_ - 0) / var_279_0)
				arg_276_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1075ui_story"].transform.position).z)
				arg_276_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1075ui_story"].transform.localEulerAngles = arg_276_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 then
				arg_276_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_276_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1075ui_story"].transform.position).z)
				arg_276_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1075ui_story"].transform.localEulerAngles = arg_276_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_279_1 = arg_276_1.actors_["1053ui_story"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1053ui_story = var_279_1.localPosition

				local var_279_2 = GameObjectTools.GetOrAddComponent(var_279_1.gameObject, typeof(DynamicBoneHelper))

				if var_279_2 then
					var_279_2:EnableDynamicBone(false)
				end
			end

			local var_279_3 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_3 then
				var_279_1.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_276_1.time_ - 0) / var_279_3)
				var_279_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_279_1.position).x, (manager.ui.mainCamera.transform.position - var_279_1.position).y, (manager.ui.mainCamera.transform.position - var_279_1.position).z)
				var_279_1.localEulerAngles.z = 0
				var_279_1.localEulerAngles.x = 0
				var_279_1.localEulerAngles = var_279_1.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_3 and arg_276_1.time_ < 0 + var_279_3 + arg_279_0 then
				var_279_1.localPosition = Vector3.New(0.7, -1.08, -6)
				var_279_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_279_1.position).x, (manager.ui.mainCamera.transform.position - var_279_1.position).y, (manager.ui.mainCamera.transform.position - var_279_1.position).z)
				var_279_1.localEulerAngles.z = 0
				var_279_1.localEulerAngles.x = 0
				var_279_1.localEulerAngles = var_279_1.localEulerAngles

				local var_279_4 = GameObjectTools.GetOrAddComponent(var_279_1.gameObject, typeof(DynamicBoneHelper))

				if var_279_4 then
					var_279_4:EnableDynamicBone(true)
				end
			end

			local var_279_5 = arg_276_1.actors_["1053ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_5) and arg_276_1.var_.characterEffect1053ui_story == nil then
				arg_276_1.var_.characterEffect1053ui_story = var_279_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_6 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_6 and not isNil(var_279_5) then
				if arg_276_1.var_.characterEffect1053ui_story and not isNil(var_279_5) then
					arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_6 and arg_276_1.time_ < 0 + var_279_6 + arg_279_0 and not isNil(var_279_5) and arg_276_1.var_.characterEffect1053ui_story then
				arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_279_8 = arg_276_1.actors_["1075ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_8) and arg_276_1.var_.characterEffect1075ui_story == nil then
				arg_276_1.var_.characterEffect1075ui_story = var_279_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_9 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_9 and not isNil(var_279_8) then
				if arg_276_1.var_.characterEffect1075ui_story and not isNil(var_279_8) then
					arg_276_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_9)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_9 and arg_276_1.time_ < 0 + var_279_9 + arg_279_0 and not isNil(var_279_8) and arg_276_1.var_.characterEffect1075ui_story then
				arg_276_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_279_10 = 0
			local var_279_11 = 0.625

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_10 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_12 = arg_276_1:GetWordFromCfg(325051067)
				local var_279_13 = arg_276_1:FormatText(var_279_12.content)

				arg_276_1.text_.text = var_279_13

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_15 = 25 <= 0 and var_279_11 or var_279_11 * (utf8.len(var_279_13) / 25)

				if (25 <= 0 and var_279_11 or var_279_11 * (utf8.len(var_279_13) / 25)) > 0 and var_279_11 < var_279_15 then
					arg_276_1.talkMaxDuration = var_279_15

					if var_279_15 + var_279_10 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_15 + var_279_10
					end
				end

				arg_276_1.text_.text = var_279_13
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051067", "story_v_out_325051.awb") ~= 0 then
					local var_279_16 = manager.audio:GetVoiceLength("story_v_out_325051", "325051067", "story_v_out_325051.awb") / 1000

					if var_279_16 + var_279_10 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_16 + var_279_10
					end

					if var_279_12.prefab_name ~= "" and arg_276_1.actors_[var_279_12.prefab_name] ~= nil then
						local var_279_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_12.prefab_name].transform, "story_v_out_325051", "325051067", "story_v_out_325051.awb")

						arg_276_1:RecordAudio("325051067", var_279_17)
						arg_276_1:RecordAudio("325051067", var_279_17)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_325051", "325051067", "story_v_out_325051.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_325051", "325051067", "story_v_out_325051.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_18 = math.max(var_279_11, arg_276_1.talkMaxDuration)

			if var_279_10 <= arg_276_1.time_ and arg_276_1.time_ < var_279_10 + var_279_18 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_10) / var_279_18

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_10 + var_279_18 and arg_276_1.time_ < var_279_10 + var_279_18 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play325051068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325051068
		arg_280_1.duration_ = 13.1

		local var_280_0 = {
			zh = 8.933,
			ja = 13.1
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play325051069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1075ui_story"]) and arg_280_1.var_.characterEffect1075ui_story == nil then
				arg_280_1.var_.characterEffect1075ui_story = arg_280_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1075ui_story"]) then
				if arg_280_1.var_.characterEffect1075ui_story and not isNil(arg_280_1.actors_["1075ui_story"]) then
					arg_280_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1075ui_story"]) and arg_280_1.var_.characterEffect1075ui_story then
				arg_280_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_283_2 = arg_280_1.actors_["1053ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.characterEffect1053ui_story == nil then
				arg_280_1.var_.characterEffect1053ui_story = var_283_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_3 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_3 and not isNil(var_283_2) then
				if arg_280_1.var_.characterEffect1053ui_story and not isNil(var_283_2) then
					arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_3)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_3 and arg_280_1.time_ < 0 + var_283_3 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.characterEffect1053ui_story then
				arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_283_4 = 0
			local var_283_5 = 1

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_6 = arg_280_1:GetWordFromCfg(325051068)
				local var_283_7 = arg_280_1:FormatText(var_283_6.content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 40 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 40)

				if (40 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 40)) > 0 and var_283_5 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051068", "story_v_out_325051.awb") ~= 0 then
					local var_283_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051068", "story_v_out_325051.awb") / 1000

					if var_283_10 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_4
					end

					if var_283_6.prefab_name ~= "" and arg_280_1.actors_[var_283_6.prefab_name] ~= nil then
						local var_283_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_6.prefab_name].transform, "story_v_out_325051", "325051068", "story_v_out_325051.awb")

						arg_280_1:RecordAudio("325051068", var_283_11)
						arg_280_1:RecordAudio("325051068", var_283_11)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325051", "325051068", "story_v_out_325051.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325051", "325051068", "story_v_out_325051.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_12 and arg_280_1.time_ < var_283_4 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play325051069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325051069
		arg_284_1.duration_ = 7.97

		local var_284_0 = {
			zh = 6,
			ja = 7.966
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play325051070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1053ui_story"]) and arg_284_1.var_.characterEffect1053ui_story == nil then
				arg_284_1.var_.characterEffect1053ui_story = arg_284_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1053ui_story"]) then
				if arg_284_1.var_.characterEffect1053ui_story and not isNil(arg_284_1.actors_["1053ui_story"]) then
					arg_284_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1053ui_story"]) and arg_284_1.var_.characterEffect1053ui_story then
				arg_284_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_287_2 = arg_284_1.actors_["1075ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.characterEffect1075ui_story == nil then
				arg_284_1.var_.characterEffect1075ui_story = var_287_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_3 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_3 and not isNil(var_287_2) then
				if arg_284_1.var_.characterEffect1075ui_story and not isNil(var_287_2) then
					arg_284_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_3)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_3 and arg_284_1.time_ < 0 + var_287_3 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.characterEffect1075ui_story then
				arg_284_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_287_4 = 0
			local var_287_5 = 0.525

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_6 = arg_284_1:GetWordFromCfg(325051069)
				local var_287_7 = arg_284_1:FormatText(var_287_6.content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 21 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 21)

				if (21 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 21)) > 0 and var_287_5 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051069", "story_v_out_325051.awb") ~= 0 then
					local var_287_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051069", "story_v_out_325051.awb") / 1000

					if var_287_10 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_4
					end

					if var_287_6.prefab_name ~= "" and arg_284_1.actors_[var_287_6.prefab_name] ~= nil then
						local var_287_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_6.prefab_name].transform, "story_v_out_325051", "325051069", "story_v_out_325051.awb")

						arg_284_1:RecordAudio("325051069", var_287_11)
						arg_284_1:RecordAudio("325051069", var_287_11)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_325051", "325051069", "story_v_out_325051.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_325051", "325051069", "story_v_out_325051.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_12 and arg_284_1.time_ < var_287_4 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play325051070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 325051070
		arg_288_1.duration_ = 6.9

		local var_288_0 = {
			zh = 3.966,
			ja = 6.9
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
				arg_288_0:Play325051071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1075ui_story"]) and arg_288_1.var_.characterEffect1075ui_story == nil then
				arg_288_1.var_.characterEffect1075ui_story = arg_288_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1075ui_story"]) then
				if arg_288_1.var_.characterEffect1075ui_story and not isNil(arg_288_1.actors_["1075ui_story"]) then
					arg_288_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1075ui_story"]) and arg_288_1.var_.characterEffect1075ui_story then
				arg_288_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_291_2 = arg_288_1.actors_["1053ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.characterEffect1053ui_story == nil then
				arg_288_1.var_.characterEffect1053ui_story = var_291_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_3 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_3 and not isNil(var_291_2) then
				if arg_288_1.var_.characterEffect1053ui_story and not isNil(var_291_2) then
					arg_288_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_3)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_3 and arg_288_1.time_ < 0 + var_291_3 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.characterEffect1053ui_story then
				arg_288_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action442")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_291_4 = 0
			local var_291_5 = 0.45

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:GetWordFromCfg(325051070)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 18 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 18)

				if (18 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 18)) > 0 and var_291_5 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051070", "story_v_out_325051.awb") ~= 0 then
					local var_291_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051070", "story_v_out_325051.awb") / 1000

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end

					if var_291_6.prefab_name ~= "" and arg_288_1.actors_[var_291_6.prefab_name] ~= nil then
						local var_291_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_6.prefab_name].transform, "story_v_out_325051", "325051070", "story_v_out_325051.awb")

						arg_288_1:RecordAudio("325051070", var_291_11)
						arg_288_1:RecordAudio("325051070", var_291_11)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_325051", "325051070", "story_v_out_325051.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_325051", "325051070", "story_v_out_325051.awb")
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

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play325051071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 325051071
		arg_292_1.duration_ = 8.33

		local var_292_0 = {
			zh = 7.033,
			ja = 8.333
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
				arg_292_0:Play325051072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1053ui_story"]) and arg_292_1.var_.characterEffect1053ui_story == nil then
				arg_292_1.var_.characterEffect1053ui_story = arg_292_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1053ui_story"]) then
				if arg_292_1.var_.characterEffect1053ui_story and not isNil(arg_292_1.actors_["1053ui_story"]) then
					arg_292_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1053ui_story"]) and arg_292_1.var_.characterEffect1053ui_story then
				arg_292_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_295_2 = arg_292_1.actors_["1075ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect1075ui_story == nil then
				arg_292_1.var_.characterEffect1075ui_story = var_295_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_3 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_3 and not isNil(var_295_2) then
				if arg_292_1.var_.characterEffect1075ui_story and not isNil(var_295_2) then
					arg_292_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_3)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_3 and arg_292_1.time_ < 0 + var_295_3 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect1075ui_story then
				arg_292_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_295_4 = 0
			local var_295_5 = 0.725

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_6 = arg_292_1:GetWordFromCfg(325051071)
				local var_295_7 = arg_292_1:FormatText(var_295_6.content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 29 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 29)

				if (29 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 29)) > 0 and var_295_5 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_4
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051071", "story_v_out_325051.awb") ~= 0 then
					local var_295_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051071", "story_v_out_325051.awb") / 1000

					if var_295_10 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_4
					end

					if var_295_6.prefab_name ~= "" and arg_292_1.actors_[var_295_6.prefab_name] ~= nil then
						local var_295_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_6.prefab_name].transform, "story_v_out_325051", "325051071", "story_v_out_325051.awb")

						arg_292_1:RecordAudio("325051071", var_295_11)
						arg_292_1:RecordAudio("325051071", var_295_11)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_325051", "325051071", "story_v_out_325051.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_325051", "325051071", "story_v_out_325051.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_5, arg_292_1.talkMaxDuration)

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_4) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_4 + var_295_12 and arg_292_1.time_ < var_295_4 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play325051072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 325051072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play325051073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1053ui_story = arg_296_1.actors_["1053ui_story"].transform.localPosition

				local var_299_0 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_0 then
					var_299_0:EnableDynamicBone(false)
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_1)
				arg_296_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).z)
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles = arg_296_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).z)
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles = arg_296_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_299_2 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(true)
				end
			end

			local var_299_3 = arg_296_1.actors_["1075ui_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1075ui_story = var_299_3.localPosition
			end

			local var_299_4 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				var_299_3.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_4)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				var_299_3.localPosition = Vector3.New(0, 100, 0)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			local var_299_5 = arg_296_1.actors_["1053ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect1053ui_story == nil then
				arg_296_1.var_.characterEffect1053ui_story = var_299_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_6 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_6 and not isNil(var_299_5) then
				if arg_296_1.var_.characterEffect1053ui_story and not isNil(var_299_5) then
					arg_296_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_6)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_6 and arg_296_1.time_ < 0 + var_299_6 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect1053ui_story then
				arg_296_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_299_7 = 0
			local var_299_8 = 0.725

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_7 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_9 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(325051072).content)

				arg_296_1.text_.text = var_299_9

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 29 <= 0 and var_299_8 or var_299_8 * (utf8.len(var_299_9) / 29)

				if (29 <= 0 and var_299_8 or var_299_8 * (utf8.len(var_299_9) / 29)) > 0 and var_299_8 < var_299_11 then
					arg_296_1.talkMaxDuration = var_299_11

					if var_299_11 + var_299_7 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_7
					end
				end

				arg_296_1.text_.text = var_299_9
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_8, arg_296_1.talkMaxDuration)

			if var_299_7 <= arg_296_1.time_ and arg_296_1.time_ < var_299_7 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_7) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_7 + var_299_12 and arg_296_1.time_ < var_299_7 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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

		arg_296_1:InitPlayNodeList()
	end,
	Play325051073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 325051073
		arg_300_1.duration_ = 17.13

		local var_300_0 = {
			zh = 10,
			ja = 17.133
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
				arg_300_0:Play325051074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["1053ui_story"]) and arg_300_1.var_.characterEffect1053ui_story == nil then
				arg_300_1.var_.characterEffect1053ui_story = arg_300_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["1053ui_story"]) then
				if arg_300_1.var_.characterEffect1053ui_story and not isNil(arg_300_1.actors_["1053ui_story"]) then
					arg_300_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["1053ui_story"]) and arg_300_1.var_.characterEffect1053ui_story then
				arg_300_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			local var_303_2 = arg_300_1.actors_["1053ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1053ui_story = var_303_2.localPosition

				local var_303_3 = GameObjectTools.GetOrAddComponent(var_303_2.gameObject, typeof(DynamicBoneHelper))

				if var_303_3 then
					var_303_3:EnableDynamicBone(false)
				end
			end

			local var_303_4 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				var_303_2.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_300_1.time_ - 0) / var_303_4)
				var_303_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_2.position).x, (manager.ui.mainCamera.transform.position - var_303_2.position).y, (manager.ui.mainCamera.transform.position - var_303_2.position).z)
				var_303_2.localEulerAngles.z = 0
				var_303_2.localEulerAngles.x = 0
				var_303_2.localEulerAngles = var_303_2.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				var_303_2.localPosition = Vector3.New(0, -1.08, -6)
				var_303_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_2.position).x, (manager.ui.mainCamera.transform.position - var_303_2.position).y, (manager.ui.mainCamera.transform.position - var_303_2.position).z)
				var_303_2.localEulerAngles.z = 0
				var_303_2.localEulerAngles.x = 0
				var_303_2.localEulerAngles = var_303_2.localEulerAngles

				local var_303_5 = GameObjectTools.GetOrAddComponent(var_303_2.gameObject, typeof(DynamicBoneHelper))

				if var_303_5 then
					var_303_5:EnableDynamicBone(true)
				end
			end

			local var_303_6 = 0
			local var_303_7 = 0.95

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(325051073)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 38 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 38)

				if (38 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 38)) > 0 and var_303_7 < var_303_11 then
					arg_300_1.talkMaxDuration = var_303_11

					if var_303_11 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051073", "story_v_out_325051.awb") ~= 0 then
					local var_303_12 = manager.audio:GetVoiceLength("story_v_out_325051", "325051073", "story_v_out_325051.awb") / 1000

					if var_303_12 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_6
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_out_325051", "325051073", "story_v_out_325051.awb")

						arg_300_1:RecordAudio("325051073", var_303_13)
						arg_300_1:RecordAudio("325051073", var_303_13)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_325051", "325051073", "story_v_out_325051.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_325051", "325051073", "story_v_out_325051.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play325051074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 325051074
		arg_304_1.duration_ = 6.27

		local var_304_0 = {
			zh = 4.5,
			ja = 6.266
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play325051075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1053ui_story = arg_304_1.actors_["1053ui_story"].transform.localPosition

				local var_307_0 = GameObjectTools.GetOrAddComponent(arg_304_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_307_0 then
					var_307_0:EnableDynamicBone(false)
				end
			end

			local var_307_1 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_1 then
				arg_304_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1053ui_story, Vector3.New(-0.7, -1.08, -6), (arg_304_1.time_ - 0) / var_307_1)
				arg_304_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1053ui_story"].transform.position).z)
				arg_304_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1053ui_story"].transform.localEulerAngles = arg_304_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_1 and arg_304_1.time_ < 0 + var_307_1 + arg_307_0 then
				arg_304_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6)
				arg_304_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1053ui_story"].transform.position).z)
				arg_304_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1053ui_story"].transform.localEulerAngles = arg_304_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_307_2 = GameObjectTools.GetOrAddComponent(arg_304_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_307_2 then
					var_307_2:EnableDynamicBone(true)
				end
			end

			local var_307_3 = arg_304_1.actors_["1077ui_story"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1077ui_story = var_307_3.localPosition

				local var_307_4 = GameObjectTools.GetOrAddComponent(var_307_3.gameObject, typeof(DynamicBoneHelper))

				if var_307_4 then
					var_307_4:EnableDynamicBone(false)
				end
			end

			local var_307_5 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_5 then
				var_307_3.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_304_1.time_ - 0) / var_307_5)
				var_307_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_3.position).x, (manager.ui.mainCamera.transform.position - var_307_3.position).y, (manager.ui.mainCamera.transform.position - var_307_3.position).z)
				var_307_3.localEulerAngles.z = 0
				var_307_3.localEulerAngles.x = 0
				var_307_3.localEulerAngles = var_307_3.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_5 and arg_304_1.time_ < 0 + var_307_5 + arg_307_0 then
				var_307_3.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_307_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_3.position).x, (manager.ui.mainCamera.transform.position - var_307_3.position).y, (manager.ui.mainCamera.transform.position - var_307_3.position).z)
				var_307_3.localEulerAngles.z = 0
				var_307_3.localEulerAngles.x = 0
				var_307_3.localEulerAngles = var_307_3.localEulerAngles

				local var_307_6 = GameObjectTools.GetOrAddComponent(var_307_3.gameObject, typeof(DynamicBoneHelper))

				if var_307_6 then
					var_307_6:EnableDynamicBone(true)
				end
			end

			local var_307_7 = arg_304_1.actors_["1077ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.characterEffect1077ui_story == nil then
				arg_304_1.var_.characterEffect1077ui_story = var_307_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_8 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_8 and not isNil(var_307_7) then
				if arg_304_1.var_.characterEffect1077ui_story and not isNil(var_307_7) then
					arg_304_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_8 and arg_304_1.time_ < 0 + var_307_8 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.characterEffect1077ui_story then
				arg_304_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_307_10 = arg_304_1.actors_["1053ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_10) and arg_304_1.var_.characterEffect1053ui_story == nil then
				arg_304_1.var_.characterEffect1053ui_story = var_307_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_11 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_11 and not isNil(var_307_10) then
				if arg_304_1.var_.characterEffect1053ui_story and not isNil(var_307_10) then
					arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_11)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_11 and arg_304_1.time_ < 0 + var_307_11 + arg_307_0 and not isNil(var_307_10) and arg_304_1.var_.characterEffect1053ui_story then
				arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_307_12 = 0
			local var_307_13 = 0.4

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_12 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_14 = arg_304_1:GetWordFromCfg(325051074)
				local var_307_15 = arg_304_1:FormatText(var_307_14.content)

				arg_304_1.text_.text = var_307_15

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_17 = 16 <= 0 and var_307_13 or var_307_13 * (utf8.len(var_307_15) / 16)

				if (16 <= 0 and var_307_13 or var_307_13 * (utf8.len(var_307_15) / 16)) > 0 and var_307_13 < var_307_17 then
					arg_304_1.talkMaxDuration = var_307_17

					if var_307_17 + var_307_12 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_17 + var_307_12
					end
				end

				arg_304_1.text_.text = var_307_15
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051074", "story_v_out_325051.awb") ~= 0 then
					local var_307_18 = manager.audio:GetVoiceLength("story_v_out_325051", "325051074", "story_v_out_325051.awb") / 1000

					if var_307_18 + var_307_12 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_18 + var_307_12
					end

					if var_307_14.prefab_name ~= "" and arg_304_1.actors_[var_307_14.prefab_name] ~= nil then
						local var_307_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_14.prefab_name].transform, "story_v_out_325051", "325051074", "story_v_out_325051.awb")

						arg_304_1:RecordAudio("325051074", var_307_19)
						arg_304_1:RecordAudio("325051074", var_307_19)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_325051", "325051074", "story_v_out_325051.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_325051", "325051074", "story_v_out_325051.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_20 = math.max(var_307_13, arg_304_1.talkMaxDuration)

			if var_307_12 <= arg_304_1.time_ and arg_304_1.time_ < var_307_12 + var_307_20 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_12) / var_307_20

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_12 + var_307_20 and arg_304_1.time_ < var_307_12 + var_307_20 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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

		arg_304_1:InitPlayNodeList()
	end,
	Play325051075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 325051075
		arg_308_1.duration_ = 7.7

		local var_308_0 = {
			zh = 5.033,
			ja = 7.7
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play325051076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1053ui_story"]) and arg_308_1.var_.characterEffect1053ui_story == nil then
				arg_308_1.var_.characterEffect1053ui_story = arg_308_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1053ui_story"]) then
				if arg_308_1.var_.characterEffect1053ui_story and not isNil(arg_308_1.actors_["1053ui_story"]) then
					arg_308_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1053ui_story"]) and arg_308_1.var_.characterEffect1053ui_story then
				arg_308_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_311_2 = arg_308_1.actors_["1077ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.characterEffect1077ui_story == nil then
				arg_308_1.var_.characterEffect1077ui_story = var_311_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_3 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_3 and not isNil(var_311_2) then
				if arg_308_1.var_.characterEffect1077ui_story and not isNil(var_311_2) then
					arg_308_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_3)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_3 and arg_308_1.time_ < 0 + var_311_3 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.characterEffect1077ui_story then
				arg_308_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_311_4 = 0
			local var_311_5 = 0.55

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_6 = arg_308_1:GetWordFromCfg(325051075)
				local var_311_7 = arg_308_1:FormatText(var_311_6.content)

				arg_308_1.text_.text = var_311_7

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_9 = 22 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 22)

				if (22 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 22)) > 0 and var_311_5 < var_311_9 then
					arg_308_1.talkMaxDuration = var_311_9

					if var_311_9 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_9 + var_311_4
					end
				end

				arg_308_1.text_.text = var_311_7
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051075", "story_v_out_325051.awb") ~= 0 then
					local var_311_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051075", "story_v_out_325051.awb") / 1000

					if var_311_10 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_4
					end

					if var_311_6.prefab_name ~= "" and arg_308_1.actors_[var_311_6.prefab_name] ~= nil then
						local var_311_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_6.prefab_name].transform, "story_v_out_325051", "325051075", "story_v_out_325051.awb")

						arg_308_1:RecordAudio("325051075", var_311_11)
						arg_308_1:RecordAudio("325051075", var_311_11)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_325051", "325051075", "story_v_out_325051.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_325051", "325051075", "story_v_out_325051.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_12 = math.max(var_311_5, arg_308_1.talkMaxDuration)

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_12 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_4) / var_311_12

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_4 + var_311_12 and arg_308_1.time_ < var_311_4 + var_311_12 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play325051076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 325051076
		arg_312_1.duration_ = 4.63

		local var_312_0 = {
			zh = 4.633,
			ja = 3.733
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play325051077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1077ui_story"]) and arg_312_1.var_.characterEffect1077ui_story == nil then
				arg_312_1.var_.characterEffect1077ui_story = arg_312_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1077ui_story"]) then
				if arg_312_1.var_.characterEffect1077ui_story and not isNil(arg_312_1.actors_["1077ui_story"]) then
					arg_312_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1077ui_story"]) and arg_312_1.var_.characterEffect1077ui_story then
				arg_312_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_315_2 = arg_312_1.actors_["1053ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.characterEffect1053ui_story == nil then
				arg_312_1.var_.characterEffect1053ui_story = var_315_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_3 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.characterEffect1053ui_story and not isNil(var_315_2) then
					arg_312_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_3)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.characterEffect1053ui_story then
				arg_312_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_315_4 = 0
			local var_315_5 = 0.475

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_6 = arg_312_1:GetWordFromCfg(325051076)
				local var_315_7 = arg_312_1:FormatText(var_315_6.content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 19 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 19)

				if (19 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 19)) > 0 and var_315_5 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051076", "story_v_out_325051.awb") ~= 0 then
					local var_315_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051076", "story_v_out_325051.awb") / 1000

					if var_315_10 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_4
					end

					if var_315_6.prefab_name ~= "" and arg_312_1.actors_[var_315_6.prefab_name] ~= nil then
						local var_315_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_6.prefab_name].transform, "story_v_out_325051", "325051076", "story_v_out_325051.awb")

						arg_312_1:RecordAudio("325051076", var_315_11)
						arg_312_1:RecordAudio("325051076", var_315_11)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_325051", "325051076", "story_v_out_325051.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_325051", "325051076", "story_v_out_325051.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_12 and arg_312_1.time_ < var_315_4 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play325051077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 325051077
		arg_316_1.duration_ = 7.13

		local var_316_0 = {
			zh = 5.8,
			ja = 7.133
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play325051078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.725

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_1 = arg_316_1:GetWordFromCfg(325051077)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 29 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 29)

				if (29 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 29)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051077", "story_v_out_325051.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051077", "story_v_out_325051.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_325051", "325051077", "story_v_out_325051.awb")

						arg_316_1:RecordAudio("325051077", var_319_6)
						arg_316_1:RecordAudio("325051077", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_325051", "325051077", "story_v_out_325051.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_325051", "325051077", "story_v_out_325051.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play325051078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 325051078
		arg_320_1.duration_ = 5.8

		local var_320_0 = {
			zh = 5.8,
			ja = 5.633
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
				arg_320_0:Play325051079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_323_0 = 0
			local var_323_1 = 0.75

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_2 = arg_320_1:GetWordFromCfg(325051078)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 30 <= 0 and var_323_1 or var_323_1 * (utf8.len(var_323_3) / 30)

				if (30 <= 0 and var_323_1 or var_323_1 * (utf8.len(var_323_3) / 30)) > 0 and var_323_1 < var_323_5 then
					arg_320_1.talkMaxDuration = var_323_5

					if var_323_5 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051078", "story_v_out_325051.awb") ~= 0 then
					local var_323_6 = manager.audio:GetVoiceLength("story_v_out_325051", "325051078", "story_v_out_325051.awb") / 1000

					if var_323_6 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_0
					end

					if var_323_2.prefab_name ~= "" and arg_320_1.actors_[var_323_2.prefab_name] ~= nil then
						local var_323_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_2.prefab_name].transform, "story_v_out_325051", "325051078", "story_v_out_325051.awb")

						arg_320_1:RecordAudio("325051078", var_323_7)
						arg_320_1:RecordAudio("325051078", var_323_7)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_325051", "325051078", "story_v_out_325051.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_325051", "325051078", "story_v_out_325051.awb")
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
	Play325051079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 325051079
		arg_324_1.duration_ = 9.97

		local var_324_0 = {
			zh = 9.966,
			ja = 6.166
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play325051080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1053ui_story"]) and arg_324_1.var_.characterEffect1053ui_story == nil then
				arg_324_1.var_.characterEffect1053ui_story = arg_324_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1053ui_story"]) then
				if arg_324_1.var_.characterEffect1053ui_story and not isNil(arg_324_1.actors_["1053ui_story"]) then
					arg_324_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1053ui_story"]) and arg_324_1.var_.characterEffect1053ui_story then
				arg_324_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_327_2 = arg_324_1.actors_["1077ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.characterEffect1077ui_story == nil then
				arg_324_1.var_.characterEffect1077ui_story = var_327_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_3 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_3 and not isNil(var_327_2) then
				if arg_324_1.var_.characterEffect1077ui_story and not isNil(var_327_2) then
					arg_324_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_3)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_3 and arg_324_1.time_ < 0 + var_327_3 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.characterEffect1077ui_story then
				arg_324_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_1")
			end

			local var_327_4 = 0
			local var_327_5 = 0.9

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_6 = arg_324_1:GetWordFromCfg(325051079)
				local var_327_7 = arg_324_1:FormatText(var_327_6.content)

				arg_324_1.text_.text = var_327_7

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_9 = 36 <= 0 and var_327_5 or var_327_5 * (utf8.len(var_327_7) / 36)

				if (36 <= 0 and var_327_5 or var_327_5 * (utf8.len(var_327_7) / 36)) > 0 and var_327_5 < var_327_9 then
					arg_324_1.talkMaxDuration = var_327_9

					if var_327_9 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_9 + var_327_4
					end
				end

				arg_324_1.text_.text = var_327_7
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051079", "story_v_out_325051.awb") ~= 0 then
					local var_327_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051079", "story_v_out_325051.awb") / 1000

					if var_327_10 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_10 + var_327_4
					end

					if var_327_6.prefab_name ~= "" and arg_324_1.actors_[var_327_6.prefab_name] ~= nil then
						local var_327_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_6.prefab_name].transform, "story_v_out_325051", "325051079", "story_v_out_325051.awb")

						arg_324_1:RecordAudio("325051079", var_327_11)
						arg_324_1:RecordAudio("325051079", var_327_11)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_325051", "325051079", "story_v_out_325051.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_325051", "325051079", "story_v_out_325051.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_12 = math.max(var_327_5, arg_324_1.talkMaxDuration)

			if var_327_4 <= arg_324_1.time_ and arg_324_1.time_ < var_327_4 + var_327_12 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_4) / var_327_12

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_4 + var_327_12 and arg_324_1.time_ < var_327_4 + var_327_12 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play325051080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 325051080
		arg_328_1.duration_ = 10.5

		local var_328_0 = {
			zh = 6.7,
			ja = 10.5
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play325051081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1077ui_story"]) and arg_328_1.var_.characterEffect1077ui_story == nil then
				arg_328_1.var_.characterEffect1077ui_story = arg_328_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1077ui_story"]) then
				if arg_328_1.var_.characterEffect1077ui_story and not isNil(arg_328_1.actors_["1077ui_story"]) then
					arg_328_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1077ui_story"]) and arg_328_1.var_.characterEffect1077ui_story then
				arg_328_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_331_2 = arg_328_1.actors_["1053ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_2) and arg_328_1.var_.characterEffect1053ui_story == nil then
				arg_328_1.var_.characterEffect1053ui_story = var_331_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_3 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_3 and not isNil(var_331_2) then
				if arg_328_1.var_.characterEffect1053ui_story and not isNil(var_331_2) then
					arg_328_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_3)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_3 and arg_328_1.time_ < 0 + var_331_3 + arg_331_0 and not isNil(var_331_2) and arg_328_1.var_.characterEffect1053ui_story then
				arg_328_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_331_4 = 0
			local var_331_5 = 0.75

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_6 = arg_328_1:GetWordFromCfg(325051080)
				local var_331_7 = arg_328_1:FormatText(var_331_6.content)

				arg_328_1.text_.text = var_331_7

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 30 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 30)

				if (30 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 30)) > 0 and var_331_5 < var_331_9 then
					arg_328_1.talkMaxDuration = var_331_9

					if var_331_9 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_7
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051080", "story_v_out_325051.awb") ~= 0 then
					local var_331_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051080", "story_v_out_325051.awb") / 1000

					if var_331_10 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_4
					end

					if var_331_6.prefab_name ~= "" and arg_328_1.actors_[var_331_6.prefab_name] ~= nil then
						local var_331_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_6.prefab_name].transform, "story_v_out_325051", "325051080", "story_v_out_325051.awb")

						arg_328_1:RecordAudio("325051080", var_331_11)
						arg_328_1:RecordAudio("325051080", var_331_11)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_325051", "325051080", "story_v_out_325051.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_325051", "325051080", "story_v_out_325051.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_12 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_12 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_12

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_12 and arg_328_1.time_ < var_331_4 + var_331_12 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play325051081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 325051081
		arg_332_1.duration_ = 15.33

		local var_332_0 = {
			zh = 7.5,
			ja = 15.333
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play325051082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1053ui_story"]) and arg_332_1.var_.characterEffect1053ui_story == nil then
				arg_332_1.var_.characterEffect1053ui_story = arg_332_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1053ui_story"]) then
				if arg_332_1.var_.characterEffect1053ui_story and not isNil(arg_332_1.actors_["1053ui_story"]) then
					arg_332_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1053ui_story"]) and arg_332_1.var_.characterEffect1053ui_story then
				arg_332_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_335_2 = arg_332_1.actors_["1077ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.characterEffect1077ui_story == nil then
				arg_332_1.var_.characterEffect1077ui_story = var_335_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_3 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_3 and not isNil(var_335_2) then
				if arg_332_1.var_.characterEffect1077ui_story and not isNil(var_335_2) then
					arg_332_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_3)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_3 and arg_332_1.time_ < 0 + var_335_3 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.characterEffect1077ui_story then
				arg_332_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_2")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_335_4 = 0
			local var_335_5 = 0.7

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_6 = arg_332_1:GetWordFromCfg(325051081)
				local var_335_7 = arg_332_1:FormatText(var_335_6.content)

				arg_332_1.text_.text = var_335_7

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_9 = 28 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 28)

				if (28 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 28)) > 0 and var_335_5 < var_335_9 then
					arg_332_1.talkMaxDuration = var_335_9

					if var_335_9 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_4
					end
				end

				arg_332_1.text_.text = var_335_7
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051081", "story_v_out_325051.awb") ~= 0 then
					local var_335_10 = manager.audio:GetVoiceLength("story_v_out_325051", "325051081", "story_v_out_325051.awb") / 1000

					if var_335_10 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_4
					end

					if var_335_6.prefab_name ~= "" and arg_332_1.actors_[var_335_6.prefab_name] ~= nil then
						local var_335_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_6.prefab_name].transform, "story_v_out_325051", "325051081", "story_v_out_325051.awb")

						arg_332_1:RecordAudio("325051081", var_335_11)
						arg_332_1:RecordAudio("325051081", var_335_11)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_325051", "325051081", "story_v_out_325051.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_325051", "325051081", "story_v_out_325051.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_12 = math.max(var_335_5, arg_332_1.talkMaxDuration)

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_12 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_4) / var_335_12

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_4 + var_335_12 and arg_332_1.time_ < var_335_4 + var_335_12 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play325051082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 325051082
		arg_336_1.duration_ = 9.57

		local var_336_0 = {
			zh = 9.566,
			ja = 7.666
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play325051083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 1.05

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_1 = arg_336_1:GetWordFromCfg(325051082)
				local var_339_2 = arg_336_1:FormatText(var_339_1.content)

				arg_336_1.text_.text = var_339_2

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 42 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 42)

				if (42 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 42)) > 0 and var_339_0 < var_339_4 then
					arg_336_1.talkMaxDuration = var_339_4

					if var_339_4 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_4 + 0
					end
				end

				arg_336_1.text_.text = var_339_2
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051082", "story_v_out_325051.awb") ~= 0 then
					local var_339_5 = manager.audio:GetVoiceLength("story_v_out_325051", "325051082", "story_v_out_325051.awb") / 1000

					if var_339_5 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + 0
					end

					if var_339_1.prefab_name ~= "" and arg_336_1.actors_[var_339_1.prefab_name] ~= nil then
						local var_339_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_1.prefab_name].transform, "story_v_out_325051", "325051082", "story_v_out_325051.awb")

						arg_336_1:RecordAudio("325051082", var_339_6)
						arg_336_1:RecordAudio("325051082", var_339_6)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_325051", "325051082", "story_v_out_325051.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_325051", "325051082", "story_v_out_325051.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play325051083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 325051083
		arg_340_1.duration_ = 8.87

		local var_340_0 = {
			zh = 7.866,
			ja = 8.866
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
			arg_340_1.auto_ = false
		end

		function arg_340_1.playNext_(arg_342_0)
			arg_340_1.onStoryFinished_()
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1077ui_story"]) and arg_340_1.var_.characterEffect1077ui_story == nil then
				arg_340_1.var_.characterEffect1077ui_story = arg_340_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1077ui_story"]) then
				if arg_340_1.var_.characterEffect1077ui_story and not isNil(arg_340_1.actors_["1077ui_story"]) then
					arg_340_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1077ui_story"]) and arg_340_1.var_.characterEffect1077ui_story then
				arg_340_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_343_2 = arg_340_1.actors_["1053ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.characterEffect1053ui_story == nil then
				arg_340_1.var_.characterEffect1053ui_story = var_343_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_3 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_3 and not isNil(var_343_2) then
				if arg_340_1.var_.characterEffect1053ui_story and not isNil(var_343_2) then
					arg_340_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_3)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_3 and arg_340_1.time_ < 0 + var_343_3 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.characterEffect1053ui_story then
				arg_340_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_343_5 = 0
			local var_343_6 = 0.575

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_7 = arg_340_1:GetWordFromCfg(325051083)
				local var_343_8 = arg_340_1:FormatText(var_343_7.content)

				arg_340_1.text_.text = var_343_8

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_10 = 23 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 23)

				if (23 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 23)) > 0 and var_343_6 < var_343_10 then
					arg_340_1.talkMaxDuration = var_343_10

					if var_343_10 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_5
					end
				end

				arg_340_1.text_.text = var_343_8
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325051", "325051083", "story_v_out_325051.awb") ~= 0 then
					local var_343_11 = manager.audio:GetVoiceLength("story_v_out_325051", "325051083", "story_v_out_325051.awb") / 1000

					if var_343_11 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_11 + var_343_5
					end

					if var_343_7.prefab_name ~= "" and arg_340_1.actors_[var_343_7.prefab_name] ~= nil then
						local var_343_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_7.prefab_name].transform, "story_v_out_325051", "325051083", "story_v_out_325051.awb")

						arg_340_1:RecordAudio("325051083", var_343_12)
						arg_340_1:RecordAudio("325051083", var_343_12)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_325051", "325051083", "story_v_out_325051.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_325051", "325051083", "story_v_out_325051.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_13 = math.max(var_343_6, arg_340_1.talkMaxDuration)

			if var_343_5 <= arg_340_1.time_ and arg_340_1.time_ < var_343_5 + var_343_13 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_5) / var_343_13

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_5 + var_343_13 and arg_340_1.time_ < var_343_5 + var_343_13 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/ST32"
	},
	voices = {
		"story_v_out_325051.awb"
	}
}
