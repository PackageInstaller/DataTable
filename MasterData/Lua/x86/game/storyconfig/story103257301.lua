return {
	Play325731001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325731001
		arg_1_1.duration_ = 7.6

		local var_1_0 = {
			zh = 7.266,
			ja = 7.6
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
				arg_1_0:Play325731002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1077ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_1_1.time_ - 1.8) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story == nil then
				arg_1_1.var_.characterEffect1077ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect1077ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story then
				arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
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

			local var_4_24 = 1.9
			local var_4_25 = 0.625

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
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

				local var_4_27 = arg_1_1:GetWordFromCfg(325731001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 25 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 25)

				if (25 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 25)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731001", "story_v_out_325731.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_325731", "325731001", "story_v_out_325731.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_325731", "325731001", "story_v_out_325731.awb")

						arg_1_1:RecordAudio("325731001", var_4_32)
						arg_1_1:RecordAudio("325731001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325731", "325731001", "story_v_out_325731.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325731", "325731001", "story_v_out_325731.awb")
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
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325731002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325731002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325731003(arg_8_1)
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
			local var_11_6 = 0.575

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

				local var_11_7 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325731002).content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 23 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 23)

				if (23 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 23)) > 0 and var_11_6 < var_11_9 then
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
	Play325731003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325731003
		arg_12_1.duration_ = 7.23

		local var_12_0 = {
			zh = 6.9,
			ja = 7.233
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
				arg_12_0:Play325731004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1077ui_story = arg_12_1.actors_["1077ui_story"].transform.localPosition

				local var_15_0 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_0 then
					var_15_0:EnableDynamicBone(false)
				end
			end

			local var_15_1 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_1 then
				arg_12_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_12_1.time_ - 0) / var_15_1)
				arg_12_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).z)
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles = arg_12_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_1 and arg_12_1.time_ < 0 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_12_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).z)
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles = arg_12_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_15_2 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(true)
				end
			end

			local var_15_3 = arg_12_1.actors_["1077ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1077ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1077ui_story then
				arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_15_6 = 0
			local var_15_7 = 0.6

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
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

				local var_15_8 = arg_12_1:GetWordFromCfg(325731003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 24 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 24)

				if (24 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 24)) > 0 and var_15_7 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731003", "story_v_out_325731.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_325731", "325731003", "story_v_out_325731.awb") / 1000

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end

					if var_15_8.prefab_name ~= "" and arg_12_1.actors_[var_15_8.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_8.prefab_name].transform, "story_v_out_325731", "325731003", "story_v_out_325731.awb")

						arg_12_1:RecordAudio("325731003", var_15_13)
						arg_12_1:RecordAudio("325731003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325731", "325731003", "story_v_out_325731.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325731", "325731003", "story_v_out_325731.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play325731004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325731004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325731005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1077ui_story = arg_16_1.actors_["1077ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).z)
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles = arg_16_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).z)
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles = arg_16_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["1077ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_4)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_19_5 = 0
			local var_19_6 = 0.65

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_7 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(325731004).content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 26 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_7) / 26)

				if (26 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_7) / 26)) > 0 and var_19_6 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_5 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_5
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_6, arg_16_1.talkMaxDuration)

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_5) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_5 + var_19_10 and arg_16_1.time_ < var_19_5 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play325731005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325731005
		arg_20_1.duration_ = 7.52

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325731006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.bgs_.ST40 == nil then
				local var_23_0 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST40")
				var_23_0.name = "ST40"
				var_23_0.transform.parent = arg_20_1.stage_.transform
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_.ST40 = var_23_0
			end

			if 1.39347279630601 < arg_20_1.time_ and arg_20_1.time_ <= 1.39347279630601 + arg_23_0 then
				local var_23_1 = arg_20_1.bgs_.ST40

				arg_20_1.bgs_.ST40.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_2 = var_23_1:GetComponent("SpriteRenderer")

				if var_23_2 and var_23_2.sprite then
					local var_23_3 = 2 * (var_23_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_1.transform.localScale = Vector3.New(var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST40" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_4 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_4 + 0.3 and arg_20_1.time_ < var_23_4 + 0.3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_5 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_6 = 1.39347279630601

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 then
				local var_23_7 = Color.New(0, 0, 0)

				var_23_7.a = Mathf.Lerp(0, 1, (arg_20_1.time_ - var_23_5) / var_23_6)
				arg_20_1.mask_.color = var_23_7
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 then
				local var_23_8 = Color.New(0, 0, 0)

				var_23_8.a = 1
				arg_20_1.mask_.color = var_23_8
			end

			local var_23_9 = 1.39347279630601

			if 1.39347279630601 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_10 = 1.39347279630601

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_10 then
				local var_23_11 = Color.New(0, 0, 0)

				var_23_11.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_9) / var_23_10)
				arg_20_1.mask_.color = var_23_11
			end

			if arg_20_1.time_ >= var_23_9 + var_23_10 and arg_20_1.time_ < var_23_9 + var_23_10 + arg_23_0 then
				local var_23_12 = Color.New(0, 0, 0)

				arg_20_1.mask_.enabled = false
				var_23_12.a = 0
				arg_20_1.mask_.color = var_23_12
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_13 = 2.51847279630601
			local var_23_14 = 0.875

			if 2.51847279630601 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_15 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_15:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_16 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(325731005).content)

				arg_20_1.text_.text = var_23_16

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_18 = 35 <= 0 and var_23_14 or var_23_14 * (utf8.len(var_23_16) / 35)

				if (35 <= 0 and var_23_14 or var_23_14 * (utf8.len(var_23_16) / 35)) > 0 and var_23_14 < var_23_18 then
					arg_20_1.talkMaxDuration = var_23_18
					var_23_13 = var_23_13 + 0.3

					if var_23_18 + var_23_13 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_13
					end
				end

				arg_20_1.text_.text = var_23_16
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_19 = var_23_13 + 0.3
			local var_23_20 = math.max(var_23_14, arg_20_1.talkMaxDuration)

			if var_23_13 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_19) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_19 + var_23_20 and arg_20_1.time_ < var_23_19 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325731006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 325731006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play325731007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.875

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(325731006).content)

				arg_26_1.text_.text = var_29_1

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_3 = 35 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 35)

				if (35 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 35)) > 0 and var_29_0 < var_29_3 then
					arg_26_1.talkMaxDuration = var_29_3

					if var_29_3 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_3 + 0
					end
				end

				arg_26_1.text_.text = var_29_1
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_4 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_4

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play325731007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 325731007
		arg_30_1.duration_ = 5.1

		local var_30_0 = {
			zh = 3.933,
			ja = 5.1
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
				arg_30_0:Play325731008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.5

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:GetWordFromCfg(325731007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 20 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 20)

				if (20 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 20)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731007", "story_v_out_325731.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_325731", "325731007", "story_v_out_325731.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_325731", "325731007", "story_v_out_325731.awb")

						arg_30_1:RecordAudio("325731007", var_33_6)
						arg_30_1:RecordAudio("325731007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_325731", "325731007", "story_v_out_325731.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_325731", "325731007", "story_v_out_325731.awb")
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
	Play325731008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325731008
		arg_34_1.duration_ = 2.03

		local var_34_0 = {
			zh = 1.4,
			ja = 2.033
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
				arg_34_0:Play325731009(arg_34_1)
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
				arg_34_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_34_1.time_ - 0) / var_37_1)
				arg_34_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1077ui_story"].transform.position).z)
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["1077ui_story"].transform.localEulerAngles = arg_34_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_1 and arg_34_1.time_ < 0 + var_37_1 + arg_37_0 then
				arg_34_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
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
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 and not isNil(var_37_3) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_37_6 = 0
			local var_37_7 = 0.125

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_8 = arg_34_1:GetWordFromCfg(325731008)
				local var_37_9 = arg_34_1:FormatText(var_37_8.content)

				arg_34_1.text_.text = var_37_9

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 5 <= 0 and var_37_7 or var_37_7 * (utf8.len(var_37_9) / 5)

				if (5 <= 0 and var_37_7 or var_37_7 * (utf8.len(var_37_9) / 5)) > 0 and var_37_7 < var_37_11 then
					arg_34_1.talkMaxDuration = var_37_11

					if var_37_11 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_9
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731008", "story_v_out_325731.awb") ~= 0 then
					local var_37_12 = manager.audio:GetVoiceLength("story_v_out_325731", "325731008", "story_v_out_325731.awb") / 1000

					if var_37_12 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_12 + var_37_6
					end

					if var_37_8.prefab_name ~= "" and arg_34_1.actors_[var_37_8.prefab_name] ~= nil then
						local var_37_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_8.prefab_name].transform, "story_v_out_325731", "325731008", "story_v_out_325731.awb")

						arg_34_1:RecordAudio("325731008", var_37_13)
						arg_34_1:RecordAudio("325731008", var_37_13)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_325731", "325731008", "story_v_out_325731.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_325731", "325731008", "story_v_out_325731.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_14 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_14 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_14

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_14 and arg_34_1.time_ < var_37_6 + var_37_14 + arg_37_0 then
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
	Play325731009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325731009
		arg_38_1.duration_ = 3.9

		local var_38_0 = {
			zh = 3.9,
			ja = 3.066
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play325731010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1077ui_story"]) and arg_38_1.var_.characterEffect1077ui_story == nil then
				arg_38_1.var_.characterEffect1077ui_story = arg_38_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1077ui_story"]) then
				if arg_38_1.var_.characterEffect1077ui_story and not isNil(arg_38_1.actors_["1077ui_story"]) then
					arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1077ui_story"]) and arg_38_1.var_.characterEffect1077ui_story then
				arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.4

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:GetWordFromCfg(325731009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_6 = 16 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_4) / 16)

				if (16 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_4) / 16)) > 0 and var_41_2 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731009", "story_v_out_325731.awb") ~= 0 then
					local var_41_7 = manager.audio:GetVoiceLength("story_v_out_325731", "325731009", "story_v_out_325731.awb") / 1000

					if var_41_7 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_1
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_325731", "325731009", "story_v_out_325731.awb")

						arg_38_1:RecordAudio("325731009", var_41_8)
						arg_38_1:RecordAudio("325731009", var_41_8)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_325731", "325731009", "story_v_out_325731.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_325731", "325731009", "story_v_out_325731.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_9 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_9 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_9

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_9 and arg_38_1.time_ < var_41_1 + var_41_9 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play325731010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325731010
		arg_42_1.duration_ = 10.73

		local var_42_0 = {
			zh = 5.666,
			ja = 10.733
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
				arg_42_0:Play325731011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.65

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_1 = arg_42_1:GetWordFromCfg(325731010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 26 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 26)

				if (26 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 26)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731010", "story_v_out_325731.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_325731", "325731010", "story_v_out_325731.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_325731", "325731010", "story_v_out_325731.awb")

						arg_42_1:RecordAudio("325731010", var_45_6)
						arg_42_1:RecordAudio("325731010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_325731", "325731010", "story_v_out_325731.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_325731", "325731010", "story_v_out_325731.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325731011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325731011
		arg_46_1.duration_ = 1.6

		local var_46_0 = {
			zh = 1.2,
			ja = 1.6
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
				arg_46_0:Play325731012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1077ui_story"]) and arg_46_1.var_.characterEffect1077ui_story == nil then
				arg_46_1.var_.characterEffect1077ui_story = arg_46_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1077ui_story"]) then
				if arg_46_1.var_.characterEffect1077ui_story and not isNil(arg_46_1.actors_["1077ui_story"]) then
					arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1077ui_story"]) and arg_46_1.var_.characterEffect1077ui_story then
				arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_49_2 = 0
			local var_49_3 = 0.075

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(325731011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 3 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 3)

				if (3 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 3)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731011", "story_v_out_325731.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731011", "story_v_out_325731.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_325731", "325731011", "story_v_out_325731.awb")

						arg_46_1:RecordAudio("325731011", var_49_9)
						arg_46_1:RecordAudio("325731011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325731", "325731011", "story_v_out_325731.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325731", "325731011", "story_v_out_325731.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_10 and arg_46_1.time_ < var_49_2 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play325731012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325731012
		arg_50_1.duration_ = 3.47

		local var_50_0 = {
			zh = 2.066,
			ja = 3.466
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
				arg_50_0:Play325731013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1077ui_story"]) and arg_50_1.var_.characterEffect1077ui_story == nil then
				arg_50_1.var_.characterEffect1077ui_story = arg_50_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1077ui_story"]) then
				if arg_50_1.var_.characterEffect1077ui_story and not isNil(arg_50_1.actors_["1077ui_story"]) then
					arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1077ui_story"]) and arg_50_1.var_.characterEffect1077ui_story then
				arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_53_1 = 0
			local var_53_2 = 0.175

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(325731012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_6 = 7 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_4) / 7)

				if (7 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_4) / 7)) > 0 and var_53_2 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_1
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731012", "story_v_out_325731.awb") ~= 0 then
					local var_53_7 = manager.audio:GetVoiceLength("story_v_out_325731", "325731012", "story_v_out_325731.awb") / 1000

					if var_53_7 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_1
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_325731", "325731012", "story_v_out_325731.awb")

						arg_50_1:RecordAudio("325731012", var_53_8)
						arg_50_1:RecordAudio("325731012", var_53_8)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325731", "325731012", "story_v_out_325731.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325731", "325731012", "story_v_out_325731.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_9 = math.max(var_53_2, arg_50_1.talkMaxDuration)

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_9 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_1) / var_53_9

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_1 + var_53_9 and arg_50_1.time_ < var_53_1 + var_53_9 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325731013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325731013
		arg_54_1.duration_ = 2.67

		local var_54_0 = {
			zh = 2.266,
			ja = 2.666
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
				arg_54_0:Play325731014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) and arg_54_1.var_.characterEffect1077ui_story == nil then
				arg_54_1.var_.characterEffect1077ui_story = arg_54_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) then
				if arg_54_1.var_.characterEffect1077ui_story and not isNil(arg_54_1.actors_["1077ui_story"]) then
					arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) and arg_54_1.var_.characterEffect1077ui_story then
				arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_57_2 = 0
			local var_57_3 = 0.25

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
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

				local var_57_4 = arg_54_1:GetWordFromCfg(325731013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 10 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 10)

				if (10 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 10)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731013", "story_v_out_325731.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731013", "story_v_out_325731.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_325731", "325731013", "story_v_out_325731.awb")

						arg_54_1:RecordAudio("325731013", var_57_9)
						arg_54_1:RecordAudio("325731013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325731", "325731013", "story_v_out_325731.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325731", "325731013", "story_v_out_325731.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_10 and arg_54_1.time_ < var_57_2 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325731014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325731014
		arg_58_1.duration_ = 7.4

		local var_58_0 = {
			zh = 7.366,
			ja = 7.4
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
				arg_58_0:Play325731015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1077ui_story"]) and arg_58_1.var_.characterEffect1077ui_story == nil then
				arg_58_1.var_.characterEffect1077ui_story = arg_58_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1077ui_story"]) then
				if arg_58_1.var_.characterEffect1077ui_story and not isNil(arg_58_1.actors_["1077ui_story"]) then
					arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1077ui_story"]) and arg_58_1.var_.characterEffect1077ui_story then
				arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.9

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(325731014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_6 = 36 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_4) / 36)

				if (36 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_4) / 36)) > 0 and var_61_2 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731014", "story_v_out_325731.awb") ~= 0 then
					local var_61_7 = manager.audio:GetVoiceLength("story_v_out_325731", "325731014", "story_v_out_325731.awb") / 1000

					if var_61_7 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_1
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_325731", "325731014", "story_v_out_325731.awb")

						arg_58_1:RecordAudio("325731014", var_61_8)
						arg_58_1:RecordAudio("325731014", var_61_8)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325731", "325731014", "story_v_out_325731.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325731", "325731014", "story_v_out_325731.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_9 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_9 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_9

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_9 and arg_58_1.time_ < var_61_1 + var_61_9 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325731015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325731015
		arg_62_1.duration_ = 7.9

		local var_62_0 = {
			zh = 6.2,
			ja = 7.9
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
				arg_62_0:Play325731016(arg_62_1)
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

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_65_2 = 0
			local var_65_3 = 0.825

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
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

				local var_65_4 = arg_62_1:GetWordFromCfg(325731015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 33 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 33)

				if (33 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 33)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731015", "story_v_out_325731.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731015", "story_v_out_325731.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_325731", "325731015", "story_v_out_325731.awb")

						arg_62_1:RecordAudio("325731015", var_65_9)
						arg_62_1:RecordAudio("325731015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325731", "325731015", "story_v_out_325731.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325731", "325731015", "story_v_out_325731.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_10 and arg_62_1.time_ < var_65_2 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325731016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325731016
		arg_66_1.duration_ = 5.73

		local var_66_0 = {
			zh = 5.733,
			ja = 5.533
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
				arg_66_0:Play325731017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = arg_66_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) then
				if arg_66_1.var_.characterEffect1077ui_story and not isNil(arg_66_1.actors_["1077ui_story"]) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_69_1 = 0
			local var_69_2 = 0.7

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(325731016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_6 = 28 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_4) / 28)

				if (28 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_4) / 28)) > 0 and var_69_2 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731016", "story_v_out_325731.awb") ~= 0 then
					local var_69_7 = manager.audio:GetVoiceLength("story_v_out_325731", "325731016", "story_v_out_325731.awb") / 1000

					if var_69_7 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_1
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_325731", "325731016", "story_v_out_325731.awb")

						arg_66_1:RecordAudio("325731016", var_69_8)
						arg_66_1:RecordAudio("325731016", var_69_8)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325731", "325731016", "story_v_out_325731.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325731", "325731016", "story_v_out_325731.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_9 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_9 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_9

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_9 and arg_66_1.time_ < var_69_1 + var_69_9 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325731017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325731017
		arg_70_1.duration_ = 8

		local var_70_0 = {
			zh = 5.9,
			ja = 8
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
				arg_70_0:Play325731018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.725

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(325731017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 29 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 29)

				if (29 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 29)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731017", "story_v_out_325731.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_325731", "325731017", "story_v_out_325731.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_325731", "325731017", "story_v_out_325731.awb")

						arg_70_1:RecordAudio("325731017", var_73_6)
						arg_70_1:RecordAudio("325731017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325731", "325731017", "story_v_out_325731.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325731", "325731017", "story_v_out_325731.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325731018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325731018
		arg_74_1.duration_ = 7.2

		local var_74_0 = {
			zh = 4.8,
			ja = 7.2
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
				arg_74_0:Play325731019(arg_74_1)
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

			local var_77_2 = 0
			local var_77_3 = 0.6

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

				local var_77_4 = arg_74_1:GetWordFromCfg(325731018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 24 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 24)

				if (24 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 24)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731018", "story_v_out_325731.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731018", "story_v_out_325731.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_325731", "325731018", "story_v_out_325731.awb")

						arg_74_1:RecordAudio("325731018", var_77_9)
						arg_74_1:RecordAudio("325731018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325731", "325731018", "story_v_out_325731.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325731", "325731018", "story_v_out_325731.awb")
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
	Play325731019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325731019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325731020(arg_78_1)
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
			local var_81_2 = 0.45

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

				local var_81_3 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(325731019).content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 18 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 18)

				if (18 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 18)) > 0 and var_81_2 < var_81_5 then
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
	Play325731020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325731020
		arg_82_1.duration_ = 6.4

		local var_82_0 = {
			zh = 6.4,
			ja = 4.7
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
				arg_82_0:Play325731021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.825

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:GetWordFromCfg(325731020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 33 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 33)

				if (33 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 33)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731020", "story_v_out_325731.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_325731", "325731020", "story_v_out_325731.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_325731", "325731020", "story_v_out_325731.awb")

						arg_82_1:RecordAudio("325731020", var_85_6)
						arg_82_1:RecordAudio("325731020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325731", "325731020", "story_v_out_325731.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325731", "325731020", "story_v_out_325731.awb")
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
	Play325731021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325731021
		arg_86_1.duration_ = 12.5

		local var_86_0 = {
			zh = 4.366,
			ja = 12.5
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
				arg_86_0:Play325731022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.575

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(325731021)
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

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731021", "story_v_out_325731.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_325731", "325731021", "story_v_out_325731.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_325731", "325731021", "story_v_out_325731.awb")

						arg_86_1:RecordAudio("325731021", var_89_6)
						arg_86_1:RecordAudio("325731021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325731", "325731021", "story_v_out_325731.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325731", "325731021", "story_v_out_325731.awb")
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
	Play325731022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325731022
		arg_90_1.duration_ = 7.57

		local var_90_0 = {
			zh = 7.566,
			ja = 6.9
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
				arg_90_0:Play325731023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1077ui_story"]) and arg_90_1.var_.characterEffect1077ui_story == nil then
				arg_90_1.var_.characterEffect1077ui_story = arg_90_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1077ui_story"]) then
				if arg_90_1.var_.characterEffect1077ui_story and not isNil(arg_90_1.actors_["1077ui_story"]) then
					arg_90_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1077ui_story"]) and arg_90_1.var_.characterEffect1077ui_story then
				arg_90_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_93_2 = 0
			local var_93_3 = 0.775

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:GetWordFromCfg(325731022)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 31 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 31)

				if (31 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 31)) > 0 and var_93_3 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731022", "story_v_out_325731.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731022", "story_v_out_325731.awb") / 1000

					if var_93_8 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_2
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_325731", "325731022", "story_v_out_325731.awb")

						arg_90_1:RecordAudio("325731022", var_93_9)
						arg_90_1:RecordAudio("325731022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325731", "325731022", "story_v_out_325731.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325731", "325731022", "story_v_out_325731.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_10 and arg_90_1.time_ < var_93_2 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325731023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325731023
		arg_94_1.duration_ = 13.4

		local var_94_0 = {
			zh = 11,
			ja = 13.4
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
				arg_94_0:Play325731024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1077ui_story"]) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = arg_94_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1077ui_story"]) then
				if arg_94_1.var_.characterEffect1077ui_story and not isNil(arg_94_1.actors_["1077ui_story"]) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_0)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1077ui_story"]) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_97_1 = 0
			local var_97_2 = 1.45

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(325731023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_6 = 58 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_4) / 58)

				if (58 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_4) / 58)) > 0 and var_97_2 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_1
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731023", "story_v_out_325731.awb") ~= 0 then
					local var_97_7 = manager.audio:GetVoiceLength("story_v_out_325731", "325731023", "story_v_out_325731.awb") / 1000

					if var_97_7 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_1
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_325731", "325731023", "story_v_out_325731.awb")

						arg_94_1:RecordAudio("325731023", var_97_8)
						arg_94_1:RecordAudio("325731023", var_97_8)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325731", "325731023", "story_v_out_325731.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325731", "325731023", "story_v_out_325731.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_9 = math.max(var_97_2, arg_94_1.talkMaxDuration)

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_9 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_1) / var_97_9

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_1 + var_97_9 and arg_94_1.time_ < var_97_1 + var_97_9 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325731024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325731024
		arg_98_1.duration_ = 4.27

		local var_98_0 = {
			zh = 4.266,
			ja = 3.066
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
				arg_98_0:Play325731025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.475

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_1 = arg_98_1:GetWordFromCfg(325731024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 19 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 19)

				if (19 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 19)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731024", "story_v_out_325731.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_325731", "325731024", "story_v_out_325731.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_325731", "325731024", "story_v_out_325731.awb")

						arg_98_1:RecordAudio("325731024", var_101_6)
						arg_98_1:RecordAudio("325731024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325731", "325731024", "story_v_out_325731.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325731", "325731024", "story_v_out_325731.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325731025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325731025
		arg_102_1.duration_ = 4.6

		local var_102_0 = {
			zh = 2.366,
			ja = 4.6
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
				arg_102_0:Play325731026(arg_102_1)
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

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_105_2 = 0

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.allBtn_.enabled = false
			end

			if arg_102_1.time_ >= var_105_2 + 0.85 and arg_102_1.time_ < var_105_2 + 0.85 + arg_105_0 then
				arg_102_1.allBtn_.enabled = true
			end

			if arg_102_1.frameCnt_ <= 1 then
				arg_102_1.dialog_:SetActive(false)
			end

			local var_105_3 = 0.7
			local var_105_4 = 0.15

			if 0.7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				arg_102_1.dialog_:SetActive(true)

				arg_102_1.dialogCg_.alpha = 0

				local var_105_5 = LeanTween.value(arg_102_1.dialog_, 0, 1, 0.3)

				var_105_5:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_102_1.dialogCg_.alpha = arg_106_0
				end))
				var_105_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_102_1.dialog_)
					var_105_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_102_1.duration_ = arg_102_1.duration_ + 0.3

				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(325731025)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 6 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_7) / 6)

				if (6 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_7) / 6)) > 0 and var_105_4 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9
					var_105_3 = var_105_3 + 0.3

					if var_105_9 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_3
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731025", "story_v_out_325731.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_325731", "325731025", "story_v_out_325731.awb") / 1000

					if var_105_10 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_3
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_325731", "325731025", "story_v_out_325731.awb")

						arg_102_1:RecordAudio("325731025", var_105_11)
						arg_102_1:RecordAudio("325731025", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325731", "325731025", "story_v_out_325731.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325731", "325731025", "story_v_out_325731.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = var_105_3 + 0.3
			local var_105_13 = math.max(var_105_4, arg_102_1.talkMaxDuration)

			if var_105_3 + 0.3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_13 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_12) / var_105_13

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_12 + var_105_13 and arg_102_1.time_ < var_105_12 + var_105_13 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325731026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325731026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325731027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1077ui_story"]) and arg_108_1.var_.characterEffect1077ui_story == nil then
				arg_108_1.var_.characterEffect1077ui_story = arg_108_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1077ui_story"]) then
				if arg_108_1.var_.characterEffect1077ui_story and not isNil(arg_108_1.actors_["1077ui_story"]) then
					arg_108_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1077ui_story"]) and arg_108_1.var_.characterEffect1077ui_story then
				arg_108_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.625

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(325731026).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 25 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 25)

				if (25 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 25)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325731027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325731027
		arg_112_1.duration_ = 7.77

		local var_112_0 = {
			zh = 7.766,
			ja = 4.566
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325731028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.925

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:GetWordFromCfg(325731027)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 37 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 37)

				if (37 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 37)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731027", "story_v_out_325731.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_325731", "325731027", "story_v_out_325731.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_325731", "325731027", "story_v_out_325731.awb")

						arg_112_1:RecordAudio("325731027", var_115_6)
						arg_112_1:RecordAudio("325731027", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325731", "325731027", "story_v_out_325731.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325731", "325731027", "story_v_out_325731.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325731028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325731028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325731029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1077ui_story = arg_116_1.actors_["1077ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1077ui_story"].transform.position).z)
				arg_116_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1077ui_story"].transform.localEulerAngles = arg_116_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1077ui_story"].transform.position).z)
				arg_116_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1077ui_story"].transform.localEulerAngles = arg_116_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			local var_119_3 = 0
			local var_119_4 = 0.875

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_5 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(325731028).content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 35 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_5) / 35)

				if (35 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_5) / 35)) > 0 and var_119_4 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_3 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_3
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_4, arg_116_1.talkMaxDuration)

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_3) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_3 + var_119_8 and arg_116_1.time_ < var_119_3 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play325731029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325731029
		arg_120_1.duration_ = 6.1

		local var_120_0 = {
			zh = 5,
			ja = 6.1
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325731030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1077ui_story = arg_120_1.actors_["1077ui_story"].transform.localPosition

				local var_123_0 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_0 then
					var_123_0:EnableDynamicBone(false)
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_120_1.time_ - 0) / var_123_1)
				arg_120_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1077ui_story"].transform.position).z)
				arg_120_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1077ui_story"].transform.localEulerAngles = arg_120_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_120_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1077ui_story"].transform.position).z)
				arg_120_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1077ui_story"].transform.localEulerAngles = arg_120_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_123_2 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(true)
				end
			end

			local var_123_3 = arg_120_1.actors_["1077ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1077ui_story == nil then
				arg_120_1.var_.characterEffect1077ui_story = var_123_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 and not isNil(var_123_3) then
				if arg_120_1.var_.characterEffect1077ui_story and not isNil(var_123_3) then
					arg_120_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1077ui_story then
				arg_120_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_123_6 = 0
			local var_123_7 = 0.525

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(325731029)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 21 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 21)

				if (21 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 21)) > 0 and var_123_7 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731029", "story_v_out_325731.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_out_325731", "325731029", "story_v_out_325731.awb") / 1000

					if var_123_12 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_6
					end

					if var_123_8.prefab_name ~= "" and arg_120_1.actors_[var_123_8.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_8.prefab_name].transform, "story_v_out_325731", "325731029", "story_v_out_325731.awb")

						arg_120_1:RecordAudio("325731029", var_123_13)
						arg_120_1:RecordAudio("325731029", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_325731", "325731029", "story_v_out_325731.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_325731", "325731029", "story_v_out_325731.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play325731030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325731030
		arg_124_1.duration_ = 5.1

		local var_124_0 = {
			zh = 5.1,
			ja = 4.2
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325731031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1077ui_story"]) and arg_124_1.var_.characterEffect1077ui_story == nil then
				arg_124_1.var_.characterEffect1077ui_story = arg_124_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1077ui_story"]) then
				if arg_124_1.var_.characterEffect1077ui_story and not isNil(arg_124_1.actors_["1077ui_story"]) then
					arg_124_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1077ui_story"]) and arg_124_1.var_.characterEffect1077ui_story then
				arg_124_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_127_1 = 0
			local var_127_2 = 0.675

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(325731030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 27 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_4) / 27)

				if (27 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_4) / 27)) > 0 and var_127_2 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731030", "story_v_out_325731.awb") ~= 0 then
					local var_127_7 = manager.audio:GetVoiceLength("story_v_out_325731", "325731030", "story_v_out_325731.awb") / 1000

					if var_127_7 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_1
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_325731", "325731030", "story_v_out_325731.awb")

						arg_124_1:RecordAudio("325731030", var_127_8)
						arg_124_1:RecordAudio("325731030", var_127_8)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325731", "325731030", "story_v_out_325731.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325731", "325731030", "story_v_out_325731.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_9 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_9 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_9

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_9 and arg_124_1.time_ < var_127_1 + var_127_9 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325731031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325731031
		arg_128_1.duration_ = 14.87

		local var_128_0 = {
			zh = 9.233,
			ja = 14.866
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
			arg_128_1.auto_ = false
		end

		function arg_128_1.playNext_(arg_130_0)
			arg_128_1.onStoryFinished_()
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_131_1 = 0
			local var_131_2 = 1.25

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(325731031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_6 = 50 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_4) / 50)

				if (50 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_4) / 50)) > 0 and var_131_2 < var_131_6 then
					arg_128_1.talkMaxDuration = var_131_6

					if var_131_6 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731031", "story_v_out_325731.awb") ~= 0 then
					local var_131_7 = manager.audio:GetVoiceLength("story_v_out_325731", "325731031", "story_v_out_325731.awb") / 1000

					if var_131_7 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_1
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_325731", "325731031", "story_v_out_325731.awb")

						arg_128_1:RecordAudio("325731031", var_131_8)
						arg_128_1:RecordAudio("325731031", var_131_8)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325731", "325731031", "story_v_out_325731.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325731", "325731031", "story_v_out_325731.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_9 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_9 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_9

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_9 and arg_128_1.time_ < var_131_1 + var_131_9 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST40"
	},
	voices = {
		"story_v_out_325731.awb"
	}
}
