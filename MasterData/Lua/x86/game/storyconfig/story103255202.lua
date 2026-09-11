return {
	Play325522001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325522001
		arg_1_1.duration_ = 10.33

		local var_1_0 = {
			zh = 10.3333333363136,
			ja = 10.2333333363136
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
				arg_1_0:Play325522002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J21f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21f")
				var_4_0.name = "J21f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J21f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J21f

				arg_1_1.bgs_.J21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J21f" then
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

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos6148ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.73333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.73333333333333 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_1_1.time_ - 1.73333333333333) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.73333333333333 + var_4_15 and arg_1_1.time_ < 1.73333333333333 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.985, -6)
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

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect6148ui_story == nil then
				arg_1_1.var_.characterEffect6148ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.73333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.73333333333333 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect6148ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.73333333333333 + var_4_18 and arg_1_1.time_ < 1.73333333333333 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect6148ui_story then
				arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

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

			local var_4_24 = 1.93333333631357
			local var_4_25 = 0.65

			if 1.93333333631357 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(325522001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 26 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 26)

				if (26 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 26)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522001", "story_v_out_325522.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_325522", "325522001", "story_v_out_325522.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_325522", "325522001", "story_v_out_325522.awb")

						arg_1_1:RecordAudio("325522001", var_4_32)
						arg_1_1:RecordAudio("325522001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325522", "325522001", "story_v_out_325522.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325522", "325522001", "story_v_out_325522.awb")
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325522002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325522002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325522003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos6148ui_story = arg_8_1.actors_["6148ui_story"].transform.localPosition

				local var_11_0 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_0 then
					var_11_0:EnableDynamicBone(false)
				end
			end

			local var_11_1 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_1 then
				arg_8_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_1)
				arg_8_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["6148ui_story"].transform.position).z)
				arg_8_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["6148ui_story"].transform.localEulerAngles = arg_8_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["6148ui_story"].transform.position).z)
				arg_8_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["6148ui_story"].transform.localEulerAngles = arg_8_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_11_2 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(true)
				end
			end

			local var_11_3 = arg_8_1.actors_["6148ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect6148ui_story == nil then
				arg_8_1.var_.characterEffect6148ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect6148ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect6148ui_story then
				arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_11_5 = 0
			local var_11_6 = 1.175

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

				local var_11_7 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325522002).content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 47 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 47)

				if (47 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 47)) > 0 and var_11_6 < var_11_9 then
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
				actorName = "6148ui_story",
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
	Play325522003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325522003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325522004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 1 < arg_12_1.time_ and arg_12_1.time_ <= 1 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_15_1 = 0
			local var_15_2 = 1.1

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325522003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 44 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 44)

				if (44 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 44)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325522004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325522004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325522005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.7

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(325522004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 28 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 28)

				if (28 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 28)) > 0 and var_19_0 < var_19_3 then
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
	Play325522005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325522005
		arg_20_1.duration_ = 6.97

		local var_20_0 = {
			zh = 5.1,
			ja = 6.966
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
				arg_20_0:Play325522006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1170ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1170ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1170ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1170ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1170ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1170ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1170ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1170ui_story = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0.03, -0.95, -6.08)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = arg_20_1.actors_["1170ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1170ui_story == nil then
				arg_20_1.var_.characterEffect1170ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect1170ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1170ui_story then
				arg_20_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_23_10 = 0
			local var_23_11 = 0.65

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(325522005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 26 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 26)

				if (26 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 26)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522005", "story_v_out_325522.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_325522", "325522005", "story_v_out_325522.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_325522", "325522005", "story_v_out_325522.awb")

						arg_20_1:RecordAudio("325522005", var_23_17)
						arg_20_1:RecordAudio("325522005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325522", "325522005", "story_v_out_325522.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325522", "325522005", "story_v_out_325522.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325522006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325522006
		arg_24_1.duration_ = 4.6

		local var_24_0 = {
			zh = 4.133,
			ja = 4.6
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
				arg_24_0:Play325522007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.45

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:GetWordFromCfg(325522006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 18 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 18)

				if (18 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 18)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522006", "story_v_out_325522.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522006", "story_v_out_325522.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_325522", "325522006", "story_v_out_325522.awb")

						arg_24_1:RecordAudio("325522006", var_27_6)
						arg_24_1:RecordAudio("325522006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325522", "325522006", "story_v_out_325522.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325522", "325522006", "story_v_out_325522.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325522007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325522007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325522008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1170ui_story"]) and arg_28_1.var_.characterEffect1170ui_story == nil then
				arg_28_1.var_.characterEffect1170ui_story = arg_28_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1170ui_story"]) then
				if arg_28_1.var_.characterEffect1170ui_story and not isNil(arg_28_1.actors_["1170ui_story"]) then
					arg_28_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1170ui_story"]) and arg_28_1.var_.characterEffect1170ui_story then
				arg_28_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 1

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

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(325522007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 40 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 40)

				if (40 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 40)) > 0 and var_31_2 < var_31_5 then
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
	Play325522008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325522008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325522009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.675

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(325522008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 27 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 27)

				if (27 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 27)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325522009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325522009
		arg_36_1.duration_ = 4.47

		local var_36_0 = {
			zh = 4.333,
			ja = 4.466
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
				arg_36_0:Play325522010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "1054ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1054ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["1054ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["1054ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["1054ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = var_39_3.localPosition

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(false)
				end
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_36_1.time_ - 0) / var_39_5)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, -0.985, -6)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles

				local var_39_6 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_6 then
					var_39_6:EnableDynamicBone(true)
				end
			end

			local var_39_7 = arg_36_1.actors_["1054ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = var_39_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 and not isNil(var_39_7) then
				if arg_36_1.var_.characterEffect1054ui_story and not isNil(var_39_7) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_10 = arg_36_1.actors_["1170ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1170ui_story = var_39_10.localPosition

				local var_39_11 = GameObjectTools.GetOrAddComponent(var_39_10.gameObject, typeof(DynamicBoneHelper))

				if var_39_11 then
					var_39_11:EnableDynamicBone(false)
				end
			end

			local var_39_12 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_12 then
				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_12)
				var_39_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_10.position).x, (manager.ui.mainCamera.transform.position - var_39_10.position).y, (manager.ui.mainCamera.transform.position - var_39_10.position).z)
				var_39_10.localEulerAngles.z = 0
				var_39_10.localEulerAngles.x = 0
				var_39_10.localEulerAngles = var_39_10.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_12 and arg_36_1.time_ < 0 + var_39_12 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 100, 0)
				var_39_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_10.position).x, (manager.ui.mainCamera.transform.position - var_39_10.position).y, (manager.ui.mainCamera.transform.position - var_39_10.position).z)
				var_39_10.localEulerAngles.z = 0
				var_39_10.localEulerAngles.x = 0
				var_39_10.localEulerAngles = var_39_10.localEulerAngles

				local var_39_13 = GameObjectTools.GetOrAddComponent(var_39_10.gameObject, typeof(DynamicBoneHelper))

				if var_39_13 then
					var_39_13:EnableDynamicBone(true)
				end
			end

			local var_39_14 = 0
			local var_39_15 = 0.45

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
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

				local var_39_16 = arg_36_1:GetWordFromCfg(325522009)
				local var_39_17 = arg_36_1:FormatText(var_39_16.content)

				arg_36_1.text_.text = var_39_17

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_19 = 18 <= 0 and var_39_15 or var_39_15 * (utf8.len(var_39_17) / 18)

				if (18 <= 0 and var_39_15 or var_39_15 * (utf8.len(var_39_17) / 18)) > 0 and var_39_15 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19

					if var_39_19 + var_39_14 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_14
					end
				end

				arg_36_1.text_.text = var_39_17
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522009", "story_v_out_325522.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_325522", "325522009", "story_v_out_325522.awb") / 1000

					if var_39_20 + var_39_14 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_14
					end

					if var_39_16.prefab_name ~= "" and arg_36_1.actors_[var_39_16.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_16.prefab_name].transform, "story_v_out_325522", "325522009", "story_v_out_325522.awb")

						arg_36_1:RecordAudio("325522009", var_39_21)
						arg_36_1:RecordAudio("325522009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325522", "325522009", "story_v_out_325522.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325522", "325522009", "story_v_out_325522.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_15, arg_36_1.talkMaxDuration)

			if var_39_14 <= arg_36_1.time_ and arg_36_1.time_ < var_39_14 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_14) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_14 + var_39_22 and arg_36_1.time_ < var_39_14 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325522010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325522010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325522011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1054ui_story"]) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = arg_40_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1054ui_story"]) then
				if arg_40_1.var_.characterEffect1054ui_story and not isNil(arg_40_1.actors_["1054ui_story"]) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1054ui_story"]) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 1

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(325522010).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 40 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 40)

				if (40 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 40)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325522011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325522011
		arg_44_1.duration_ = 8.33

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325522012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.bgs_.J21h == nil then
				local var_47_0 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_47_0.name = "J21h"
				var_47_0.transform.parent = arg_44_1.stage_.transform
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_.J21h = var_47_0
			end

			if 1.999999999999 < arg_44_1.time_ and arg_44_1.time_ <= 1.999999999999 + arg_47_0 then
				local var_47_1 = arg_44_1.bgs_.J21h

				arg_44_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_2 = var_47_1:GetComponent("SpriteRenderer")

				if var_47_2 and var_47_2.sprite then
					local var_47_3 = 2 * (var_47_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_1.transform.localScale = Vector3.New(var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "J21h" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_4 = 1.999999999999

			if 1.999999999999 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			if arg_44_1.time_ >= var_47_4 + 0.3 and arg_44_1.time_ < var_47_4 + 0.3 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_5 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_6 = 2

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 then
				local var_47_7 = Color.New(0, 0, 0)

				var_47_7.a = Mathf.Lerp(0, 1, (arg_44_1.time_ - var_47_5) / var_47_6)
				arg_44_1.mask_.color = var_47_7
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 then
				local var_47_8 = Color.New(0, 0, 0)

				var_47_8.a = 1
				arg_44_1.mask_.color = var_47_8
			end

			local var_47_9 = 1.999999999999

			if 1.999999999999 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_10 = 2

			if var_47_9 <= arg_44_1.time_ and arg_44_1.time_ < var_47_9 + var_47_10 then
				local var_47_11 = Color.New(0, 0, 0)

				var_47_11.a = Mathf.Lerp(1, 0, (arg_44_1.time_ - var_47_9) / var_47_10)
				arg_44_1.mask_.color = var_47_11
			end

			if arg_44_1.time_ >= var_47_9 + var_47_10 and arg_44_1.time_ < var_47_9 + var_47_10 + arg_47_0 then
				local var_47_12 = Color.New(0, 0, 0)

				arg_44_1.mask_.enabled = false
				var_47_12.a = 0
				arg_44_1.mask_.color = var_47_12
			end

			local var_47_13 = arg_44_1.actors_["1054ui_story"].transform

			if 1.999999999999 < arg_44_1.time_ and arg_44_1.time_ <= 1.999999999999 + arg_47_0 then
				arg_44_1.var_.moveOldPos1054ui_story = var_47_13.localPosition

				local var_47_14 = GameObjectTools.GetOrAddComponent(var_47_13.gameObject, typeof(DynamicBoneHelper))

				if var_47_14 then
					var_47_14:EnableDynamicBone(false)
				end
			end

			local var_47_15 = 0.001

			if 1.999999999999 <= arg_44_1.time_ and arg_44_1.time_ < 1.999999999999 + var_47_15 then
				var_47_13.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 1.999999999999) / var_47_15)
				var_47_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_13.position).x, (manager.ui.mainCamera.transform.position - var_47_13.position).y, (manager.ui.mainCamera.transform.position - var_47_13.position).z)
				var_47_13.localEulerAngles.z = 0
				var_47_13.localEulerAngles.x = 0
				var_47_13.localEulerAngles = var_47_13.localEulerAngles
			end

			if arg_44_1.time_ >= 1.999999999999 + var_47_15 and arg_44_1.time_ < 1.999999999999 + var_47_15 + arg_47_0 then
				var_47_13.localPosition = Vector3.New(0, 100, 0)
				var_47_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_13.position).x, (manager.ui.mainCamera.transform.position - var_47_13.position).y, (manager.ui.mainCamera.transform.position - var_47_13.position).z)
				var_47_13.localEulerAngles.z = 0
				var_47_13.localEulerAngles.x = 0
				var_47_13.localEulerAngles = var_47_13.localEulerAngles

				local var_47_16 = GameObjectTools.GetOrAddComponent(var_47_13.gameObject, typeof(DynamicBoneHelper))

				if var_47_16 then
					var_47_16:EnableDynamicBone(true)
				end
			end

			local var_47_17 = "1015ui_story"

			if arg_44_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_47_18 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_44_1.stage_.transform)

				var_47_18.name = var_47_17
				var_47_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_[var_47_17] = var_47_18

				local var_47_19 = var_47_18:GetComponentInChildren(typeof(CharacterEffect))

				var_47_19.enabled = true

				local var_47_20 = GameObjectTools.GetOrAddComponent(var_47_18, typeof(DynamicBoneHelper))

				if var_47_20 then
					var_47_20:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_19.transform, false)

				arg_44_1.var_[var_47_17 .. "Animator"] = var_47_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_[var_47_17 .. "Animator"].applyRootMotion = true
				arg_44_1.var_[var_47_17 .. "LipSync"] = var_47_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_21 = arg_44_1.actors_["1015ui_story"].transform

			if 1.999999999999 < arg_44_1.time_ and arg_44_1.time_ <= 1.999999999999 + arg_47_0 then
				arg_44_1.var_.moveOldPos1015ui_story = var_47_21.localPosition
			end

			local var_47_22 = 0.001

			if 1.999999999999 <= arg_44_1.time_ and arg_44_1.time_ < 1.999999999999 + var_47_22 then
				var_47_21.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 1.999999999999) / var_47_22)
				var_47_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_21.position).x, (manager.ui.mainCamera.transform.position - var_47_21.position).y, (manager.ui.mainCamera.transform.position - var_47_21.position).z)
				var_47_21.localEulerAngles.z = 0
				var_47_21.localEulerAngles.x = 0
				var_47_21.localEulerAngles = var_47_21.localEulerAngles
			end

			if arg_44_1.time_ >= 1.999999999999 + var_47_22 and arg_44_1.time_ < 1.999999999999 + var_47_22 + arg_47_0 then
				var_47_21.localPosition = Vector3.New(0, 100, 0)
				var_47_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_21.position).x, (manager.ui.mainCamera.transform.position - var_47_21.position).y, (manager.ui.mainCamera.transform.position - var_47_21.position).z)
				var_47_21.localEulerAngles.z = 0
				var_47_21.localEulerAngles.x = 0
				var_47_21.localEulerAngles = var_47_21.localEulerAngles
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_23 = 3.33333333333333
			local var_47_24 = 0.825

			if 3.33333333333333 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_25 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_25:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_26 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(325522011).content)

				arg_44_1.text_.text = var_47_26

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_28 = 33 <= 0 and var_47_24 or var_47_24 * (utf8.len(var_47_26) / 33)

				if (33 <= 0 and var_47_24 or var_47_24 * (utf8.len(var_47_26) / 33)) > 0 and var_47_24 < var_47_28 then
					arg_44_1.talkMaxDuration = var_47_28
					var_47_23 = var_47_23 + 0.3

					if var_47_28 + var_47_23 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_28 + var_47_23
					end
				end

				arg_44_1.text_.text = var_47_26
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_29 = var_47_23 + 0.3
			local var_47_30 = math.max(var_47_24, arg_44_1.talkMaxDuration)

			if var_47_23 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_29 + var_47_30 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_29) / var_47_30

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_29 + var_47_30 and arg_44_1.time_ < var_47_29 + var_47_30 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play325522012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325522012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325522013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 1.825

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(325522012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 73 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 73)

				if (73 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 73)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325522013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325522013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325522014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.525

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(325522013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 21 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 21)

				if (21 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 21)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325522014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325522014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325522015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.875

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

				local var_61_1 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(325522014).content)

				arg_58_1.text_.text = var_61_1

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_3 = 35 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 35)

				if (35 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 35)) > 0 and var_61_0 < var_61_3 then
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
	Play325522015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325522015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325522016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.775

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(325522015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 71 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 71)

				if (71 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 71)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325522016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325522016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325522017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.1

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(325522016).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 4 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 4)

				if (4 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 4)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325522017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325522017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play325522018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0.2 < arg_70_1.time_ and arg_70_1.time_ <= 0.2 + arg_73_0 then
				arg_70_1:AudioAction("play", "effect", "se_story_side_1085", "se_story_side_1085_run_sand", "")
			end

			local var_73_1 = 0
			local var_73_2 = 1.05

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(325522017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 42 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 42)

				if (42 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 42)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325522018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325522018
		arg_74_1.duration_ = 7.73

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325522019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_9000

			if 1.2 < arg_74_1.time_ and arg_74_1.time_ <= 1.2 + arg_77_0 then
				local var_77_0 = arg_74_1.bgs_.J21h

				arg_74_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_77_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_1 = var_77_0:GetComponent("SpriteRenderer")

				if var_77_1 and var_77_1.sprite then
					local var_77_2 = 2 * (var_77_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_77_0.transform.localScale = Vector3.New(var_77_2 / var_77_1.sprite.bounds.size.y < var_77_2 * manager.ui.mainCameraCom_.aspect / var_77_1.sprite.bounds.size.x and var_77_2 * manager.ui.mainCameraCom_.aspect / var_77_1.sprite.bounds.size.x or var_77_2 / var_77_1.sprite.bounds.size.y, var_77_2 / var_77_1.sprite.bounds.size.y < var_77_2 * manager.ui.mainCameraCom_.aspect / var_77_1.sprite.bounds.size.x and var_77_2 * manager.ui.mainCameraCom_.aspect / var_77_1.sprite.bounds.size.x or var_77_2 / var_77_1.sprite.bounds.size.y, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "J21h" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_77_3 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_3 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			if arg_74_1.time_ >= var_77_3 + 0.3 and arg_74_1.time_ < var_77_3 + 0.3 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end

			local var_77_4 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_5 = 1.2

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_5 then
				local var_77_6 = Color.New(0, 0, 0)

				var_77_6.a = Mathf.Lerp(0, 1, (arg_74_1.time_ - var_77_4) / var_77_5)
				arg_74_1.mask_.color = var_77_6
			end

			if arg_74_1.time_ >= var_77_4 + var_77_5 and arg_74_1.time_ < var_77_4 + var_77_5 + arg_77_0 then
				local var_77_7 = Color.New(0, 0, 0)

				var_77_7.a = 1
				arg_74_1.mask_.color = var_77_7
			end

			local var_77_8 = 1.2

			if 1.2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_9 = 1.53333333333333

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_9 then
				local var_77_10 = Color.New(0, 0, 0)

				var_77_10.a = Mathf.Lerp(1, 0, (arg_74_1.time_ - var_77_8) / var_77_9)
				arg_74_1.mask_.color = var_77_10
			end

			if arg_74_1.time_ >= var_77_8 + var_77_9 and arg_74_1.time_ < var_77_8 + var_77_9 + arg_77_0 then
				local var_77_11 = Color.New(0, 0, 0)

				arg_74_1.mask_.enabled = false
				var_77_11.a = 0
				arg_74_1.mask_.color = var_77_11
			end

			if 1.2 < arg_74_1.time_ and arg_74_1.time_ <= 1.2 + arg_77_0 then
				local var_77_12 = arg_74_1.var_.effect323132

				if not arg_74_1.var_.effect323132 then
					var_77_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_77_12.name = "323132"
					arg_74_1.var_.effect323132 = var_77_12
				else
					var_77_12.transform:SetParent(var_77_9000)
				end

				var_77_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_77_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_77_12.transform.localScale = Vector3.New(var_77_12.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_77_12.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_77_12.transform.localScale.z)
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_14 = 2.73333333333333
			local var_77_15 = 1.575

			if 2.73333333333333 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_16 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_16:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_17 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(325522018).content)

				arg_74_1.text_.text = var_77_17

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_19 = 63 <= 0 and var_77_15 or var_77_15 * (utf8.len(var_77_17) / 63)

				if (63 <= 0 and var_77_15 or var_77_15 * (utf8.len(var_77_17) / 63)) > 0 and var_77_15 < var_77_19 then
					arg_74_1.talkMaxDuration = var_77_19
					var_77_14 = var_77_14 + 0.3

					if var_77_19 + var_77_14 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_14
					end
				end

				arg_74_1.text_.text = var_77_17
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_20 = var_77_14 + 0.3
			local var_77_21 = math.max(var_77_15, arg_74_1.talkMaxDuration)

			if var_77_14 + 0.3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_20 + var_77_21 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_20) / var_77_21

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_20 + var_77_21 and arg_74_1.time_ < var_77_20 + var_77_21 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325522019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325522019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325522020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.7

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(325522019).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 28 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 28)

				if (28 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 28)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325522020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325522020
		arg_84_1.duration_ = 3.23

		local var_84_0 = {
			zh = 3.233,
			ja = 2.5
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325522021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if arg_84_1.actors_["10180ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10180ui_story"))) then
				local var_87_0 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_84_1.stage_.transform)

				var_87_0.name = "10180ui_story"
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["10180ui_story"] = var_87_0

				local var_87_1 = var_87_0:GetComponentInChildren(typeof(CharacterEffect))

				var_87_1.enabled = true

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end

				arg_84_1:ShowWeapon(var_87_1.transform, false)

				arg_84_1.var_["10180ui_story" .. "Animator"] = var_87_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_84_1.var_["10180ui_story" .. "Animator"].applyRootMotion = true
				arg_84_1.var_["10180ui_story" .. "LipSync"] = var_87_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_87_3 = arg_84_1.actors_["10180ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10180ui_story = var_87_3.localPosition

				local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_3.gameObject, typeof(DynamicBoneHelper))

				if var_87_4 then
					var_87_4:EnableDynamicBone(false)
				end
			end

			local var_87_5 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_5 then
				var_87_3.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_84_1.time_ - 0) / var_87_5)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_5 and arg_84_1.time_ < 0 + var_87_5 + arg_87_0 then
				var_87_3.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles

				local var_87_6 = GameObjectTools.GetOrAddComponent(var_87_3.gameObject, typeof(DynamicBoneHelper))

				if var_87_6 then
					var_87_6:EnableDynamicBone(true)
				end
			end

			local var_87_7 = arg_84_1.actors_["10180ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_7) and arg_84_1.var_.characterEffect10180ui_story == nil then
				arg_84_1.var_.characterEffect10180ui_story = var_87_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_8 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_8 and not isNil(var_87_7) then
				if arg_84_1.var_.characterEffect10180ui_story and not isNil(var_87_7) then
					arg_84_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_8 and arg_84_1.time_ < 0 + var_87_8 + arg_87_0 and not isNil(var_87_7) and arg_84_1.var_.characterEffect10180ui_story then
				arg_84_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_87_10 = 0
			local var_87_11 = 0.225

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_12 = arg_84_1:GetWordFromCfg(325522020)
				local var_87_13 = arg_84_1:FormatText(var_87_12.content)

				arg_84_1.text_.text = var_87_13

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 9 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_13) / 9)

				if (9 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_13) / 9)) > 0 and var_87_11 < var_87_15 then
					arg_84_1.talkMaxDuration = var_87_15

					if var_87_15 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_15 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_13
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522020", "story_v_out_325522.awb") ~= 0 then
					local var_87_16 = manager.audio:GetVoiceLength("story_v_out_325522", "325522020", "story_v_out_325522.awb") / 1000

					if var_87_16 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_16 + var_87_10
					end

					if var_87_12.prefab_name ~= "" and arg_84_1.actors_[var_87_12.prefab_name] ~= nil then
						local var_87_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_12.prefab_name].transform, "story_v_out_325522", "325522020", "story_v_out_325522.awb")

						arg_84_1:RecordAudio("325522020", var_87_17)
						arg_84_1:RecordAudio("325522020", var_87_17)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325522", "325522020", "story_v_out_325522.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325522", "325522020", "story_v_out_325522.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_18 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_18 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_18

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_18 and arg_84_1.time_ < var_87_10 + var_87_18 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play325522021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325522021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325522022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10180ui_story"]) and arg_88_1.var_.characterEffect10180ui_story == nil then
				arg_88_1.var_.characterEffect10180ui_story = arg_88_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10180ui_story"]) then
				if arg_88_1.var_.characterEffect10180ui_story and not isNil(arg_88_1.actors_["10180ui_story"]) then
					arg_88_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10180ui_story"]) and arg_88_1.var_.characterEffect10180ui_story then
				arg_88_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.1

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(325522021).content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 4 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 4)

				if (4 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 4)) > 0 and var_91_2 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_6 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_6 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_6

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_6 and arg_88_1.time_ < var_91_1 + var_91_6 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325522022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325522022
		arg_92_1.duration_ = 4.7

		local var_92_0 = {
			zh = 3.266,
			ja = 4.7
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325522023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10180ui_story"]) and arg_92_1.var_.characterEffect10180ui_story == nil then
				arg_92_1.var_.characterEffect10180ui_story = arg_92_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10180ui_story"]) then
				if arg_92_1.var_.characterEffect10180ui_story and not isNil(arg_92_1.actors_["10180ui_story"]) then
					arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10180ui_story"]) and arg_92_1.var_.characterEffect10180ui_story then
				arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_95_2 = 0
			local var_95_3 = 0.25

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(325522022)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 10 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 10)

				if (10 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 10)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522022", "story_v_out_325522.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_325522", "325522022", "story_v_out_325522.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_325522", "325522022", "story_v_out_325522.awb")

						arg_92_1:RecordAudio("325522022", var_95_9)
						arg_92_1:RecordAudio("325522022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325522", "325522022", "story_v_out_325522.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325522", "325522022", "story_v_out_325522.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_10 and arg_92_1.time_ < var_95_2 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325522023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325522023
		arg_96_1.duration_ = 6.67

		local var_96_0 = {
			zh = 3.966,
			ja = 6.666
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325522024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10180ui_story = arg_96_1.actors_["10180ui_story"].transform.localPosition

				local var_99_0 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_0 then
					var_99_0:EnableDynamicBone(false)
				end
			end

			local var_99_1 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10180ui_story, Vector3.New(-0.8, -1.09, -6.14), (arg_96_1.time_ - 0) / var_99_1)
				arg_96_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10180ui_story"].transform.position).z)
				arg_96_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10180ui_story"].transform.localEulerAngles = arg_96_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.8, -1.09, -6.14)
				arg_96_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10180ui_story"].transform.position).z)
				arg_96_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10180ui_story"].transform.localEulerAngles = arg_96_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_99_2 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(true)
				end
			end

			local var_99_3 = arg_96_1.actors_["1170ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1170ui_story = var_99_3.localPosition

				local var_99_4 = GameObjectTools.GetOrAddComponent(var_99_3.gameObject, typeof(DynamicBoneHelper))

				if var_99_4 then
					var_99_4:EnableDynamicBone(false)
				end
			end

			local var_99_5 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_5 then
				var_99_3.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1170ui_story, Vector3.New(0.74, -0.95, -6.08), (arg_96_1.time_ - 0) / var_99_5)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_5 and arg_96_1.time_ < 0 + var_99_5 + arg_99_0 then
				var_99_3.localPosition = Vector3.New(0.74, -0.95, -6.08)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles

				local var_99_6 = GameObjectTools.GetOrAddComponent(var_99_3.gameObject, typeof(DynamicBoneHelper))

				if var_99_6 then
					var_99_6:EnableDynamicBone(true)
				end
			end

			local var_99_7 = arg_96_1.actors_["1170ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_7) and arg_96_1.var_.characterEffect1170ui_story == nil then
				arg_96_1.var_.characterEffect1170ui_story = var_99_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_8 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_8 and not isNil(var_99_7) then
				if arg_96_1.var_.characterEffect1170ui_story and not isNil(var_99_7) then
					arg_96_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_8 and arg_96_1.time_ < 0 + var_99_8 + arg_99_0 and not isNil(var_99_7) and arg_96_1.var_.characterEffect1170ui_story then
				arg_96_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_99_10 = arg_96_1.actors_["10180ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_10) and arg_96_1.var_.characterEffect10180ui_story == nil then
				arg_96_1.var_.characterEffect10180ui_story = var_99_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_11 and not isNil(var_99_10) then
				if arg_96_1.var_.characterEffect10180ui_story and not isNil(var_99_10) then
					arg_96_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_11)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_11 and arg_96_1.time_ < 0 + var_99_11 + arg_99_0 and not isNil(var_99_10) and arg_96_1.var_.characterEffect10180ui_story then
				arg_96_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action4_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiD_xiaoshengqi", "EmotionTimelineAnimator")
			end

			local var_99_12 = 0
			local var_99_13 = 0.45

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_14 = arg_96_1:GetWordFromCfg(325522023)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 18 <= 0 and var_99_13 or var_99_13 * (utf8.len(var_99_15) / 18)

				if (18 <= 0 and var_99_13 or var_99_13 * (utf8.len(var_99_15) / 18)) > 0 and var_99_13 < var_99_17 then
					arg_96_1.talkMaxDuration = var_99_17

					if var_99_17 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_15
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522023", "story_v_out_325522.awb") ~= 0 then
					local var_99_18 = manager.audio:GetVoiceLength("story_v_out_325522", "325522023", "story_v_out_325522.awb") / 1000

					if var_99_18 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_12
					end

					if var_99_14.prefab_name ~= "" and arg_96_1.actors_[var_99_14.prefab_name] ~= nil then
						local var_99_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_14.prefab_name].transform, "story_v_out_325522", "325522023", "story_v_out_325522.awb")

						arg_96_1:RecordAudio("325522023", var_99_19)
						arg_96_1:RecordAudio("325522023", var_99_19)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325522", "325522023", "story_v_out_325522.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325522", "325522023", "story_v_out_325522.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_20 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_20 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_20

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_20 and arg_96_1.time_ < var_99_12 + var_99_20 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play325522024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325522024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325522025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1170ui_story"]) and arg_100_1.var_.characterEffect1170ui_story == nil then
				arg_100_1.var_.characterEffect1170ui_story = arg_100_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1170ui_story"]) then
				if arg_100_1.var_.characterEffect1170ui_story and not isNil(arg_100_1.actors_["1170ui_story"]) then
					arg_100_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1170ui_story"]) and arg_100_1.var_.characterEffect1170ui_story then
				arg_100_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 1.05

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(325522024).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 42 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 42)

				if (42 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 42)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325522025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325522025
		arg_104_1.duration_ = 14.33

		local var_104_0 = {
			zh = 5.333,
			ja = 14.333
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325522026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) and arg_104_1.var_.characterEffect10180ui_story == nil then
				arg_104_1.var_.characterEffect10180ui_story = arg_104_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) then
				if arg_104_1.var_.characterEffect10180ui_story and not isNil(arg_104_1.actors_["10180ui_story"]) then
					arg_104_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) and arg_104_1.var_.characterEffect10180ui_story then
				arg_104_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_2")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_107_2 = 0
			local var_107_3 = 0.5

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(325522025)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 20 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 20)

				if (20 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 20)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522025", "story_v_out_325522.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_325522", "325522025", "story_v_out_325522.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_325522", "325522025", "story_v_out_325522.awb")

						arg_104_1:RecordAudio("325522025", var_107_9)
						arg_104_1:RecordAudio("325522025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325522", "325522025", "story_v_out_325522.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325522", "325522025", "story_v_out_325522.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325522026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325522026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325522027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10180ui_story = arg_108_1.actors_["10180ui_story"].transform.localPosition

				local var_111_0 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_0 then
					var_111_0:EnableDynamicBone(false)
				end
			end

			local var_111_1 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 then
				arg_108_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_1)
				arg_108_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10180ui_story"].transform.position).z)
				arg_108_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10180ui_story"].transform.localEulerAngles = arg_108_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 then
				arg_108_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10180ui_story"].transform.position).z)
				arg_108_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10180ui_story"].transform.localEulerAngles = arg_108_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_111_2 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(true)
				end
			end

			local var_111_3 = arg_108_1.actors_["1170ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1170ui_story = var_111_3.localPosition

				local var_111_4 = GameObjectTools.GetOrAddComponent(var_111_3.gameObject, typeof(DynamicBoneHelper))

				if var_111_4 then
					var_111_4:EnableDynamicBone(false)
				end
			end

			local var_111_5 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 then
				var_111_3.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_5)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 then
				var_111_3.localPosition = Vector3.New(0, 100, 0)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles

				local var_111_6 = GameObjectTools.GetOrAddComponent(var_111_3.gameObject, typeof(DynamicBoneHelper))

				if var_111_6 then
					var_111_6:EnableDynamicBone(true)
				end
			end

			local var_111_7 = arg_108_1.actors_["10180ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_7) and arg_108_1.var_.characterEffect10180ui_story == nil then
				arg_108_1.var_.characterEffect10180ui_story = var_111_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_8 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_8 and not isNil(var_111_7) then
				if arg_108_1.var_.characterEffect10180ui_story and not isNil(var_111_7) then
					arg_108_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_8)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_8 and arg_108_1.time_ < 0 + var_111_8 + arg_111_0 and not isNil(var_111_7) and arg_108_1.var_.characterEffect10180ui_story then
				arg_108_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_111_9 = 0
			local var_111_10 = 1.4

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_11 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(325522026).content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 56 <= 0 and var_111_10 or var_111_10 * (utf8.len(var_111_11) / 56)

				if (56 <= 0 and var_111_10 or var_111_10 * (utf8.len(var_111_11) / 56)) > 0 and var_111_10 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_9 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_9
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_10, arg_108_1.talkMaxDuration)

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_9) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_9 + var_111_14 and arg_108_1.time_ < var_111_9 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play325522027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325522027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325522028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.725

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(325522027).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 29 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 29)

				if (29 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 29)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325522028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325522028
		arg_116_1.duration_ = 4.97

		local var_116_0 = {
			zh = 4.066,
			ja = 4.966
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325522029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10180ui_story = arg_116_1.actors_["10180ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).z)
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles = arg_116_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_116_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).z)
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles = arg_116_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			local var_119_3 = arg_116_1.actors_["10180ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect10180ui_story == nil then
				arg_116_1.var_.characterEffect10180ui_story = var_119_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.characterEffect10180ui_story and not isNil(var_119_3) then
					arg_116_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect10180ui_story then
				arg_116_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_119_6 = 0
			local var_119_7 = 0.275

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:GetWordFromCfg(325522028)
				local var_119_9 = arg_116_1:FormatText(var_119_8.content)

				arg_116_1.text_.text = var_119_9

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 11 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_9) / 11)

				if (11 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_9) / 11)) > 0 and var_119_7 < var_119_11 then
					arg_116_1.talkMaxDuration = var_119_11

					if var_119_11 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_9
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522028", "story_v_out_325522.awb") ~= 0 then
					local var_119_12 = manager.audio:GetVoiceLength("story_v_out_325522", "325522028", "story_v_out_325522.awb") / 1000

					if var_119_12 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_6
					end

					if var_119_8.prefab_name ~= "" and arg_116_1.actors_[var_119_8.prefab_name] ~= nil then
						local var_119_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_8.prefab_name].transform, "story_v_out_325522", "325522028", "story_v_out_325522.awb")

						arg_116_1:RecordAudio("325522028", var_119_13)
						arg_116_1:RecordAudio("325522028", var_119_13)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_325522", "325522028", "story_v_out_325522.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_325522", "325522028", "story_v_out_325522.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_14 and arg_116_1.time_ < var_119_6 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325522029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325522029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325522030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10180ui_story"]) and arg_120_1.var_.characterEffect10180ui_story == nil then
				arg_120_1.var_.characterEffect10180ui_story = arg_120_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10180ui_story"]) then
				if arg_120_1.var_.characterEffect10180ui_story and not isNil(arg_120_1.actors_["10180ui_story"]) then
					arg_120_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10180ui_story"]) and arg_120_1.var_.characterEffect10180ui_story then
				arg_120_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.6

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(325522029).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 24 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 24)

				if (24 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 24)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_6 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_6 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_6

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_6 and arg_120_1.time_ < var_123_1 + var_123_6 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play325522030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325522030
		arg_124_1.duration_ = 9.73

		local var_124_0 = {
			zh = 6.6,
			ja = 9.733
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
				arg_124_0:Play325522031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10180ui_story"]) and arg_124_1.var_.characterEffect10180ui_story == nil then
				arg_124_1.var_.characterEffect10180ui_story = arg_124_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10180ui_story"]) then
				if arg_124_1.var_.characterEffect10180ui_story and not isNil(arg_124_1.actors_["10180ui_story"]) then
					arg_124_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10180ui_story"]) and arg_124_1.var_.characterEffect10180ui_story then
				arg_124_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action4_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_127_2 = 0
			local var_127_3 = 0.525

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(325522030)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 21 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 21)

				if (21 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 21)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522030", "story_v_out_325522.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_325522", "325522030", "story_v_out_325522.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_325522", "325522030", "story_v_out_325522.awb")

						arg_124_1:RecordAudio("325522030", var_127_9)
						arg_124_1:RecordAudio("325522030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325522", "325522030", "story_v_out_325522.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325522", "325522030", "story_v_out_325522.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325522031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325522031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325522032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10180ui_story = arg_128_1.actors_["10180ui_story"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10180ui_story"].transform.position).z)
				arg_128_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10180ui_story"].transform.localEulerAngles = arg_128_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10180ui_story"].transform.position).z)
				arg_128_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10180ui_story"].transform.localEulerAngles = arg_128_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["10180ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect10180ui_story == nil then
				arg_128_1.var_.characterEffect10180ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect10180ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_4)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect10180ui_story then
				arg_128_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 1 < arg_128_1.time_ and arg_128_1.time_ <= 1 + arg_131_0 then
				arg_128_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_whoosh05", "")
			end

			local var_131_6 = 0
			local var_131_7 = 1.075

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(325522031).content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 43 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_8) / 43)

				if (43 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_8) / 43)) > 0 and var_131_7 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_11 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_11 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_11

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_11 and arg_128_1.time_ < var_131_6 + var_131_11 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play325522032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325522032
		arg_132_1.duration_ = 5.9

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325522033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_9002
			local var_135_9001
			local var_135_9000

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				if arg_132_1.var_.effect323132 then
					Object.Destroy(arg_132_1.var_.effect323132)

					arg_132_1.var_.effect323132 = nil
				end
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				local var_135_1 = arg_132_1.var_.effectgdfg

				if not arg_132_1.var_.effectgdfg then
					var_135_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_135_1.name = "gdfg"
					arg_132_1.var_.effectgdfg = var_135_1
				else
					var_135_1.transform:SetParent(var_135_9002)
				end

				var_135_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_135_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_135_1.transform.localScale = Vector3.New(var_135_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_135_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_135_1.transform.localScale.z)
			end

			if 0.9 < arg_132_1.time_ and arg_132_1.time_ <= 0.9 + arg_135_0 then
				if arg_132_1.var_.effectgdfg then
					Object.Destroy(arg_132_1.var_.effectgdfg)

					arg_132_1.var_.effectgdfg = nil
				end
			end

			local var_135_4 = 0

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			if arg_132_1.time_ >= var_135_4 + 1.76666666666667 and arg_132_1.time_ < var_135_4 + 1.76666666666667 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_132_1.time_ and arg_132_1.time_ <= 0.166666666666667 + arg_135_0 then
				local var_135_5 = arg_132_1.var_.effectgdfg1

				if not arg_132_1.var_.effectgdfg1 then
					var_135_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_135_5.name = "gdfg1"
					arg_132_1.var_.effectgdfg1 = var_135_5
				else
					var_135_5.transform:SetParent(var_135_9001)
				end

				var_135_5.transform.localPosition = Vector3.New(-1.52, 0, -1.2)
				var_135_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_135_5.transform.localScale = Vector3.New(var_135_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_135_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_135_5.transform.localScale.z)
			end

			if 1.06666666666667 < arg_132_1.time_ and arg_132_1.time_ <= 1.06666666666667 + arg_135_0 then
				if arg_132_1.var_.effectgdfg1 then
					Object.Destroy(arg_132_1.var_.effectgdfg1)

					arg_132_1.var_.effectgdfg1 = nil
				end
			end

			if 0.333333333333333 < arg_132_1.time_ and arg_132_1.time_ <= 0.333333333333333 + arg_135_0 then
				local var_135_8 = arg_132_1.var_.effectgdfg2

				if not arg_132_1.var_.effectgdfg2 then
					var_135_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_135_8.name = "gdfg2"
					arg_132_1.var_.effectgdfg2 = var_135_8
				else
					var_135_8.transform:SetParent(var_135_9000)
				end

				var_135_8.transform.localPosition = Vector3.New(1.53, -0.33, -2.55)
				var_135_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_135_8.transform.localScale = Vector3.New(var_135_8.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_135_8.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_135_8.transform.localScale.z)
			end

			if 1.23333333333333 < arg_132_1.time_ and arg_132_1.time_ <= 1.23333333333333 + arg_135_0 then
				if arg_132_1.var_.effectgdfg2 then
					Object.Destroy(arg_132_1.var_.effectgdfg2)

					arg_132_1.var_.effectgdfg2 = nil
				end
			end

			local var_135_11 = 0

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			if arg_132_1.time_ >= var_135_11 + 1.76666666666667 and arg_132_1.time_ < var_135_11 + 1.76666666666667 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			if 0.1 < arg_132_1.time_ and arg_132_1.time_ <= 0.1 + arg_135_0 then
				arg_132_1:AudioAction("play", "effect", "se_story_15", "se_story_15_blast03", "")
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_13 = 0.9
			local var_135_14 = 1.45

			if 0.9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_15 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_15:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_132_1.dialogCg_.alpha = arg_136_0
				end))
				var_135_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_16 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(325522032).content)

				arg_132_1.text_.text = var_135_16

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_18 = 58 <= 0 and var_135_14 or var_135_14 * (utf8.len(var_135_16) / 58)

				if (58 <= 0 and var_135_14 or var_135_14 * (utf8.len(var_135_16) / 58)) > 0 and var_135_14 < var_135_18 then
					arg_132_1.talkMaxDuration = var_135_18
					var_135_13 = var_135_13 + 0.3

					if var_135_18 + var_135_13 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_13
					end
				end

				arg_132_1.text_.text = var_135_16
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_19 = var_135_13 + 0.3
			local var_135_20 = math.max(var_135_14, arg_132_1.talkMaxDuration)

			if var_135_13 + 0.3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_19 + var_135_20 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_19) / var_135_20

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_19 + var_135_20 and arg_132_1.time_ < var_135_19 + var_135_20 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325522033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325522033
		arg_138_1.duration_ = 13.53

		local var_138_0 = {
			zh = 9.933,
			ja = 13.533
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
				arg_138_0:Play325522034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10180ui_story = arg_138_1.actors_["10180ui_story"].transform.localPosition

				local var_141_0 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_0 then
					var_141_0:EnableDynamicBone(false)
				end
			end

			local var_141_1 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 then
				arg_138_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_138_1.time_ - 0) / var_141_1)
				arg_138_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).z)
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles = arg_138_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 then
				arg_138_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_138_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).z)
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles = arg_138_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_141_2 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(true)
				end
			end

			local var_141_3 = arg_138_1.actors_["10180ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10180ui_story == nil then
				arg_138_1.var_.characterEffect10180ui_story = var_141_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 and not isNil(var_141_3) then
				if arg_138_1.var_.characterEffect10180ui_story and not isNil(var_141_3) then
					arg_138_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10180ui_story then
				arg_138_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180actionlink/10180action449")
			end

			local var_141_6 = 0
			local var_141_7 = 0.9

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(325522033)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 36 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 36)

				if (36 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 36)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522033", "story_v_out_325522.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_325522", "325522033", "story_v_out_325522.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_325522", "325522033", "story_v_out_325522.awb")

						arg_138_1:RecordAudio("325522033", var_141_13)
						arg_138_1:RecordAudio("325522033", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325522", "325522033", "story_v_out_325522.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325522", "325522033", "story_v_out_325522.awb")
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
				actorName = "10180ui_story",
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
	Play325522034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325522034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325522035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10180ui_story = arg_142_1.actors_["10180ui_story"].transform.localPosition

				local var_145_0 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_0 then
					var_145_0:EnableDynamicBone(false)
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_1)
				arg_142_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).z)
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles = arg_142_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_142_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).z)
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles = arg_142_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_145_2 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(true)
				end
			end

			local var_145_3 = arg_142_1.actors_["10180ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10180ui_story == nil then
				arg_142_1.var_.characterEffect10180ui_story = var_145_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_4 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 and not isNil(var_145_3) then
				if arg_142_1.var_.characterEffect10180ui_story and not isNil(var_145_3) then
					arg_142_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_4)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10180ui_story then
				arg_142_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_145_5 = 0
			local var_145_6 = 1.55

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_7 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(325522034).content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 62 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_7) / 62)

				if (62 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_7) / 62)) > 0 and var_145_6 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_10 and arg_142_1.time_ < var_145_5 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325522035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325522035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325522036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.9

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(325522035).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 36 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 36)

				if (36 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 36)) > 0 and var_149_0 < var_149_3 then
					arg_146_1.talkMaxDuration = var_149_3

					if var_149_3 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_3 + 0
					end
				end

				arg_146_1.text_.text = var_149_1
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_4 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_4

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play325522036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325522036
		arg_150_1.duration_ = 4.03

		local var_150_0 = {
			zh = 3.2,
			ja = 4.033
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
				arg_150_0:Play325522037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_153_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_150_1.stage_.transform)

				var_153_0.name = "1071ui_story"
				var_153_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1071ui_story"] = var_153_0

				local var_153_1 = var_153_0:GetComponentInChildren(typeof(CharacterEffect))

				var_153_1.enabled = true

				local var_153_2 = GameObjectTools.GetOrAddComponent(var_153_0, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(false)
				end

				arg_150_1:ShowWeapon(var_153_1.transform, false)

				arg_150_1.var_["1071ui_story" .. "Animator"] = var_153_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_150_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_150_1.var_["1071ui_story" .. "LipSync"] = var_153_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_153_3 = arg_150_1.actors_["1071ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1071ui_story = var_153_3.localPosition
			end

			local var_153_4 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				var_153_3.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_150_1.time_ - 0) / var_153_4)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				var_153_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			local var_153_5 = arg_150_1.actors_["1071ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1071ui_story == nil then
				arg_150_1.var_.characterEffect1071ui_story = var_153_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_6 and not isNil(var_153_5) then
				if arg_150_1.var_.characterEffect1071ui_story and not isNil(var_153_5) then
					arg_150_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_6 and arg_150_1.time_ < 0 + var_153_6 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1071ui_story then
				arg_150_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_153_8 = 0
			local var_153_9 = 0.3

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:GetWordFromCfg(325522036)
				local var_153_11 = arg_150_1:FormatText(var_153_10.content)

				arg_150_1.text_.text = var_153_11

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 12 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 12)

				if (12 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 12)) > 0 and var_153_9 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_11
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522036", "story_v_out_325522.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_out_325522", "325522036", "story_v_out_325522.awb") / 1000

					if var_153_14 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_8
					end

					if var_153_10.prefab_name ~= "" and arg_150_1.actors_[var_153_10.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_10.prefab_name].transform, "story_v_out_325522", "325522036", "story_v_out_325522.awb")

						arg_150_1:RecordAudio("325522036", var_153_15)
						arg_150_1:RecordAudio("325522036", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325522", "325522036", "story_v_out_325522.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325522", "325522036", "story_v_out_325522.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_9, arg_150_1.talkMaxDuration)

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_8) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_8 + var_153_16 and arg_150_1.time_ < var_153_8 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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

		arg_150_1:InitPlayNodeList()
	end,
	Play325522037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325522037
		arg_154_1.duration_ = 7.17

		local var_154_0 = {
			zh = 4.066,
			ja = 7.166
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
				arg_154_0:Play325522038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1071ui_story = arg_154_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).z)
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles = arg_154_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_154_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).z)
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles = arg_154_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_157_1 = arg_154_1.actors_["10180ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10180ui_story = var_157_1.localPosition

				local var_157_2 = GameObjectTools.GetOrAddComponent(var_157_1.gameObject, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(false)
				end
			end

			local var_157_3 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 then
				var_157_1.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10180ui_story, Vector3.New(0.8, -1.09, -6.14), (arg_154_1.time_ - 0) / var_157_3)
				var_157_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_1.position).x, (manager.ui.mainCamera.transform.position - var_157_1.position).y, (manager.ui.mainCamera.transform.position - var_157_1.position).z)
				var_157_1.localEulerAngles.z = 0
				var_157_1.localEulerAngles.x = 0
				var_157_1.localEulerAngles = var_157_1.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 then
				var_157_1.localPosition = Vector3.New(0.8, -1.09, -6.14)
				var_157_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_1.position).x, (manager.ui.mainCamera.transform.position - var_157_1.position).y, (manager.ui.mainCamera.transform.position - var_157_1.position).z)
				var_157_1.localEulerAngles.z = 0
				var_157_1.localEulerAngles.x = 0
				var_157_1.localEulerAngles = var_157_1.localEulerAngles

				local var_157_4 = GameObjectTools.GetOrAddComponent(var_157_1.gameObject, typeof(DynamicBoneHelper))

				if var_157_4 then
					var_157_4:EnableDynamicBone(true)
				end
			end

			local var_157_5 = arg_154_1.actors_["10180ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.characterEffect10180ui_story == nil then
				arg_154_1.var_.characterEffect10180ui_story = var_157_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_6 and not isNil(var_157_5) then
				if arg_154_1.var_.characterEffect10180ui_story and not isNil(var_157_5) then
					arg_154_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_6 and arg_154_1.time_ < 0 + var_157_6 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.characterEffect10180ui_story then
				arg_154_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_157_8 = arg_154_1.actors_["1071ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.characterEffect1071ui_story == nil then
				arg_154_1.var_.characterEffect1071ui_story = var_157_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_9 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_9 and not isNil(var_157_8) then
				if arg_154_1.var_.characterEffect1071ui_story and not isNil(var_157_8) then
					arg_154_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_9)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_9 and arg_154_1.time_ < 0 + var_157_9 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.characterEffect1071ui_story then
				arg_154_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action9_2")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_157_10 = 0
			local var_157_11 = 0.425

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_12 = arg_154_1:GetWordFromCfg(325522037)
				local var_157_13 = arg_154_1:FormatText(var_157_12.content)

				arg_154_1.text_.text = var_157_13

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_15 = 17 <= 0 and var_157_11 or var_157_11 * (utf8.len(var_157_13) / 17)

				if (17 <= 0 and var_157_11 or var_157_11 * (utf8.len(var_157_13) / 17)) > 0 and var_157_11 < var_157_15 then
					arg_154_1.talkMaxDuration = var_157_15

					if var_157_15 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_15 + var_157_10
					end
				end

				arg_154_1.text_.text = var_157_13
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522037", "story_v_out_325522.awb") ~= 0 then
					local var_157_16 = manager.audio:GetVoiceLength("story_v_out_325522", "325522037", "story_v_out_325522.awb") / 1000

					if var_157_16 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_16 + var_157_10
					end

					if var_157_12.prefab_name ~= "" and arg_154_1.actors_[var_157_12.prefab_name] ~= nil then
						local var_157_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_12.prefab_name].transform, "story_v_out_325522", "325522037", "story_v_out_325522.awb")

						arg_154_1:RecordAudio("325522037", var_157_17)
						arg_154_1:RecordAudio("325522037", var_157_17)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325522", "325522037", "story_v_out_325522.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325522", "325522037", "story_v_out_325522.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_18 = math.max(var_157_11, arg_154_1.talkMaxDuration)

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_18 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_10) / var_157_18

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_10 + var_157_18 and arg_154_1.time_ < var_157_10 + var_157_18 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play325522038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325522038
		arg_158_1.duration_ = 14.4

		local var_158_0 = {
			zh = 8.366,
			ja = 14.4
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
				arg_158_0:Play325522039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.775

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:GetWordFromCfg(325522038)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 31 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 31)

				if (31 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 31)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522038", "story_v_out_325522.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522038", "story_v_out_325522.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_325522", "325522038", "story_v_out_325522.awb")

						arg_158_1:RecordAudio("325522038", var_161_6)
						arg_158_1:RecordAudio("325522038", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325522", "325522038", "story_v_out_325522.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325522", "325522038", "story_v_out_325522.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play325522039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325522039
		arg_162_1.duration_ = 14.83

		local var_162_0 = {
			zh = 11.533,
			ja = 14.833
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play325522040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action3_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_165_0 = 0
			local var_165_1 = 0.975

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(325522039)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 39 <= 0 and var_165_1 or var_165_1 * (utf8.len(var_165_3) / 39)

				if (39 <= 0 and var_165_1 or var_165_1 * (utf8.len(var_165_3) / 39)) > 0 and var_165_1 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522039", "story_v_out_325522.awb") ~= 0 then
					local var_165_6 = manager.audio:GetVoiceLength("story_v_out_325522", "325522039", "story_v_out_325522.awb") / 1000

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end

					if var_165_2.prefab_name ~= "" and arg_162_1.actors_[var_165_2.prefab_name] ~= nil then
						local var_165_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_2.prefab_name].transform, "story_v_out_325522", "325522039", "story_v_out_325522.awb")

						arg_162_1:RecordAudio("325522039", var_165_7)
						arg_162_1:RecordAudio("325522039", var_165_7)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_325522", "325522039", "story_v_out_325522.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_325522", "325522039", "story_v_out_325522.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_8 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_8 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_8

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_8 and arg_162_1.time_ < var_165_0 + var_165_8 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play325522040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325522040
		arg_166_1.duration_ = 3.9

		local var_166_0 = {
			zh = 3.566,
			ja = 3.9
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325522041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1071ui_story"]) and arg_166_1.var_.characterEffect1071ui_story == nil then
				arg_166_1.var_.characterEffect1071ui_story = arg_166_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1071ui_story"]) then
				if arg_166_1.var_.characterEffect1071ui_story and not isNil(arg_166_1.actors_["1071ui_story"]) then
					arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1071ui_story"]) and arg_166_1.var_.characterEffect1071ui_story then
				arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_169_2 = arg_166_1.actors_["10180ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.characterEffect10180ui_story == nil then
				arg_166_1.var_.characterEffect10180ui_story = var_169_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_3 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.characterEffect10180ui_story and not isNil(var_169_2) then
					arg_166_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_3)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.characterEffect10180ui_story then
				arg_166_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_169_4 = 0
			local var_169_5 = 0.45

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(325522040)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 18 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 18)

				if (18 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 18)) > 0 and var_169_5 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522040", "story_v_out_325522.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522040", "story_v_out_325522.awb") / 1000

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end

					if var_169_6.prefab_name ~= "" and arg_166_1.actors_[var_169_6.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_6.prefab_name].transform, "story_v_out_325522", "325522040", "story_v_out_325522.awb")

						arg_166_1:RecordAudio("325522040", var_169_11)
						arg_166_1:RecordAudio("325522040", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_325522", "325522040", "story_v_out_325522.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_325522", "325522040", "story_v_out_325522.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_12 and arg_166_1.time_ < var_169_4 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325522041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325522041
		arg_170_1.duration_ = 7.07

		local var_170_0 = {
			zh = 5.966,
			ja = 7.066
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play325522042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10180ui_story"]) and arg_170_1.var_.characterEffect10180ui_story == nil then
				arg_170_1.var_.characterEffect10180ui_story = arg_170_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10180ui_story"]) then
				if arg_170_1.var_.characterEffect10180ui_story and not isNil(arg_170_1.actors_["10180ui_story"]) then
					arg_170_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10180ui_story"]) and arg_170_1.var_.characterEffect10180ui_story then
				arg_170_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_173_2 = arg_170_1.actors_["1071ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1071ui_story == nil then
				arg_170_1.var_.characterEffect1071ui_story = var_173_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_3 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.characterEffect1071ui_story and not isNil(var_173_2) then
					arg_170_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_3)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1071ui_story then
				arg_170_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_173_4 = 0
			local var_173_5 = 0.5

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(325522041)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 20 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 20)

				if (20 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 20)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522041", "story_v_out_325522.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522041", "story_v_out_325522.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_325522", "325522041", "story_v_out_325522.awb")

						arg_170_1:RecordAudio("325522041", var_173_11)
						arg_170_1:RecordAudio("325522041", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_325522", "325522041", "story_v_out_325522.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_325522", "325522041", "story_v_out_325522.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_12 and arg_170_1.time_ < var_173_4 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play325522042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325522042
		arg_174_1.duration_ = 6.67

		local var_174_0 = {
			zh = 6.666,
			ja = 5.333
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
				arg_174_0:Play325522043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1071ui_story"]) and arg_174_1.var_.characterEffect1071ui_story == nil then
				arg_174_1.var_.characterEffect1071ui_story = arg_174_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1071ui_story"]) then
				if arg_174_1.var_.characterEffect1071ui_story and not isNil(arg_174_1.actors_["1071ui_story"]) then
					arg_174_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1071ui_story"]) and arg_174_1.var_.characterEffect1071ui_story then
				arg_174_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_177_2 = arg_174_1.actors_["10180ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect10180ui_story == nil then
				arg_174_1.var_.characterEffect10180ui_story = var_177_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_3 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.characterEffect10180ui_story and not isNil(var_177_2) then
					arg_174_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_3)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect10180ui_story then
				arg_174_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_177_4 = 0
			local var_177_5 = 0.725

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_6 = arg_174_1:GetWordFromCfg(325522042)
				local var_177_7 = arg_174_1:FormatText(var_177_6.content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 29 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 29)

				if (29 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 29)) > 0 and var_177_5 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_4
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522042", "story_v_out_325522.awb") ~= 0 then
					local var_177_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522042", "story_v_out_325522.awb") / 1000

					if var_177_10 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_4
					end

					if var_177_6.prefab_name ~= "" and arg_174_1.actors_[var_177_6.prefab_name] ~= nil then
						local var_177_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_6.prefab_name].transform, "story_v_out_325522", "325522042", "story_v_out_325522.awb")

						arg_174_1:RecordAudio("325522042", var_177_11)
						arg_174_1:RecordAudio("325522042", var_177_11)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_325522", "325522042", "story_v_out_325522.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_325522", "325522042", "story_v_out_325522.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_12 = math.max(var_177_5, arg_174_1.talkMaxDuration)

			if var_177_4 <= arg_174_1.time_ and arg_174_1.time_ < var_177_4 + var_177_12 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_4) / var_177_12

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_4 + var_177_12 and arg_174_1.time_ < var_177_4 + var_177_12 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play325522043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325522043
		arg_178_1.duration_ = 10.97

		local var_178_0 = {
			zh = 7.5,
			ja = 10.966
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
				arg_178_0:Play325522044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10180ui_story"]) and arg_178_1.var_.characterEffect10180ui_story == nil then
				arg_178_1.var_.characterEffect10180ui_story = arg_178_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10180ui_story"]) then
				if arg_178_1.var_.characterEffect10180ui_story and not isNil(arg_178_1.actors_["10180ui_story"]) then
					arg_178_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10180ui_story"]) and arg_178_1.var_.characterEffect10180ui_story then
				arg_178_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_181_2 = arg_178_1.actors_["1071ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.characterEffect1071ui_story == nil then
				arg_178_1.var_.characterEffect1071ui_story = var_181_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_3 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 and not isNil(var_181_2) then
				if arg_178_1.var_.characterEffect1071ui_story and not isNil(var_181_2) then
					arg_178_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_3)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.characterEffect1071ui_story then
				arg_178_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action3_2")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_181_4 = 0
			local var_181_5 = 0.575

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(325522043)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 23 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 23)

				if (23 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 23)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522043", "story_v_out_325522.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522043", "story_v_out_325522.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_out_325522", "325522043", "story_v_out_325522.awb")

						arg_178_1:RecordAudio("325522043", var_181_11)
						arg_178_1:RecordAudio("325522043", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_325522", "325522043", "story_v_out_325522.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_325522", "325522043", "story_v_out_325522.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play325522044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325522044
		arg_182_1.duration_ = 22.3

		local var_182_0 = {
			zh = 14.6,
			ja = 22.3
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
				arg_182_0:Play325522045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 1.225

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(325522044)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 49 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 49)

				if (49 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 49)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522044", "story_v_out_325522.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522044", "story_v_out_325522.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_325522", "325522044", "story_v_out_325522.awb")

						arg_182_1:RecordAudio("325522044", var_185_6)
						arg_182_1:RecordAudio("325522044", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_325522", "325522044", "story_v_out_325522.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_325522", "325522044", "story_v_out_325522.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play325522045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325522045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play325522046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10180ui_story = arg_186_1.actors_["10180ui_story"].transform.localPosition

				local var_189_0 = GameObjectTools.GetOrAddComponent(arg_186_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_189_0 then
					var_189_0:EnableDynamicBone(false)
				end
			end

			local var_189_1 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_1 then
				arg_186_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_1)
				arg_186_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10180ui_story"].transform.position).z)
				arg_186_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10180ui_story"].transform.localEulerAngles = arg_186_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_1 and arg_186_1.time_ < 0 + var_189_1 + arg_189_0 then
				arg_186_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10180ui_story"].transform.position).z)
				arg_186_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10180ui_story"].transform.localEulerAngles = arg_186_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_189_2 = GameObjectTools.GetOrAddComponent(arg_186_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_189_2 then
					var_189_2:EnableDynamicBone(true)
				end
			end

			local var_189_3 = arg_186_1.actors_["1071ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1071ui_story = var_189_3.localPosition
			end

			local var_189_4 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				var_189_3.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_4)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				var_189_3.localPosition = Vector3.New(0, 100, 0)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			local var_189_5 = arg_186_1.actors_["10180ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect10180ui_story == nil then
				arg_186_1.var_.characterEffect10180ui_story = var_189_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_6 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_6 and not isNil(var_189_5) then
				if arg_186_1.var_.characterEffect10180ui_story and not isNil(var_189_5) then
					arg_186_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_6)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_6 and arg_186_1.time_ < 0 + var_189_6 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect10180ui_story then
				arg_186_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_189_7 = 0
			local var_189_8 = 1.275

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_7 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_9 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(325522045).content)

				arg_186_1.text_.text = var_189_9

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 51 <= 0 and var_189_8 or var_189_8 * (utf8.len(var_189_9) / 51)

				if (51 <= 0 and var_189_8 or var_189_8 * (utf8.len(var_189_9) / 51)) > 0 and var_189_8 < var_189_11 then
					arg_186_1.talkMaxDuration = var_189_11

					if var_189_11 + var_189_7 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_7
					end
				end

				arg_186_1.text_.text = var_189_9
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_8, arg_186_1.talkMaxDuration)

			if var_189_7 <= arg_186_1.time_ and arg_186_1.time_ < var_189_7 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_7) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_7 + var_189_12 and arg_186_1.time_ < var_189_7 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_186_1:InitPlayNodeList()
	end,
	Play325522046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 325522046
		arg_190_1.duration_ = 3.13

		local var_190_0 = {
			zh = 2.733,
			ja = 3.133
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
				arg_190_0:Play325522047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1071ui_story = arg_190_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1071ui_story"].transform.position).z)
				arg_190_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1071ui_story"].transform.localEulerAngles = arg_190_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_190_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1071ui_story"].transform.position).z)
				arg_190_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1071ui_story"].transform.localEulerAngles = arg_190_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1071ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1071ui_story == nil then
				arg_190_1.var_.characterEffect1071ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1071ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1071ui_story then
				arg_190_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action453")
			end

			local var_193_4 = 0
			local var_193_5 = 0.325

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(325522046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 13 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 13)

				if (13 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 13)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522046", "story_v_out_325522.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522046", "story_v_out_325522.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_325522", "325522046", "story_v_out_325522.awb")

						arg_190_1:RecordAudio("325522046", var_193_11)
						arg_190_1:RecordAudio("325522046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_325522", "325522046", "story_v_out_325522.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_325522", "325522046", "story_v_out_325522.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
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

		arg_190_1:InitPlayNodeList()
	end,
	Play325522047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 325522047
		arg_194_1.duration_ = 7.07

		local var_194_0 = {
			zh = 7.066,
			ja = 7.033
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
				arg_194_0:Play325522048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.65

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:GetWordFromCfg(325522047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 26 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 26)

				if (26 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 26)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522047", "story_v_out_325522.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522047", "story_v_out_325522.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_325522", "325522047", "story_v_out_325522.awb")

						arg_194_1:RecordAudio("325522047", var_197_6)
						arg_194_1:RecordAudio("325522047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_325522", "325522047", "story_v_out_325522.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_325522", "325522047", "story_v_out_325522.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play325522048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325522048
		arg_198_1.duration_ = 5.9

		local var_198_0 = {
			zh = 2,
			ja = 5.9
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
				arg_198_0:Play325522049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1071ui_story = arg_198_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1071ui_story"].transform.position).z)
				arg_198_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1071ui_story"].transform.localEulerAngles = arg_198_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_198_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1071ui_story"].transform.position).z)
				arg_198_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1071ui_story"].transform.localEulerAngles = arg_198_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["10180ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10180ui_story = var_201_1.localPosition

				local var_201_2 = GameObjectTools.GetOrAddComponent(var_201_1.gameObject, typeof(DynamicBoneHelper))

				if var_201_2 then
					var_201_2:EnableDynamicBone(false)
				end
			end

			local var_201_3 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 then
				var_201_1.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10180ui_story, Vector3.New(0.8, -1.09, -6.14), (arg_198_1.time_ - 0) / var_201_3)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 then
				var_201_1.localPosition = Vector3.New(0.8, -1.09, -6.14)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles

				local var_201_4 = GameObjectTools.GetOrAddComponent(var_201_1.gameObject, typeof(DynamicBoneHelper))

				if var_201_4 then
					var_201_4:EnableDynamicBone(true)
				end
			end

			local var_201_5 = arg_198_1.actors_["10180ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_5) and arg_198_1.var_.characterEffect10180ui_story == nil then
				arg_198_1.var_.characterEffect10180ui_story = var_201_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_6 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_6 and not isNil(var_201_5) then
				if arg_198_1.var_.characterEffect10180ui_story and not isNil(var_201_5) then
					arg_198_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_6 and arg_198_1.time_ < 0 + var_201_6 + arg_201_0 and not isNil(var_201_5) and arg_198_1.var_.characterEffect10180ui_story then
				arg_198_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_201_8 = arg_198_1.actors_["1071ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.characterEffect1071ui_story == nil then
				arg_198_1.var_.characterEffect1071ui_story = var_201_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_9 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_9 and not isNil(var_201_8) then
				if arg_198_1.var_.characterEffect1071ui_story and not isNil(var_201_8) then
					arg_198_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_9)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_9 and arg_198_1.time_ < 0 + var_201_9 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.characterEffect1071ui_story then
				arg_198_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_201_10 = 0
			local var_201_11 = 0.125

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_12 = arg_198_1:GetWordFromCfg(325522048)
				local var_201_13 = arg_198_1:FormatText(var_201_12.content)

				arg_198_1.text_.text = var_201_13

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_15 = 5 <= 0 and var_201_11 or var_201_11 * (utf8.len(var_201_13) / 5)

				if (5 <= 0 and var_201_11 or var_201_11 * (utf8.len(var_201_13) / 5)) > 0 and var_201_11 < var_201_15 then
					arg_198_1.talkMaxDuration = var_201_15

					if var_201_15 + var_201_10 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_15 + var_201_10
					end
				end

				arg_198_1.text_.text = var_201_13
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522048", "story_v_out_325522.awb") ~= 0 then
					local var_201_16 = manager.audio:GetVoiceLength("story_v_out_325522", "325522048", "story_v_out_325522.awb") / 1000

					if var_201_16 + var_201_10 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_16 + var_201_10
					end

					if var_201_12.prefab_name ~= "" and arg_198_1.actors_[var_201_12.prefab_name] ~= nil then
						local var_201_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_12.prefab_name].transform, "story_v_out_325522", "325522048", "story_v_out_325522.awb")

						arg_198_1:RecordAudio("325522048", var_201_17)
						arg_198_1:RecordAudio("325522048", var_201_17)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_325522", "325522048", "story_v_out_325522.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_325522", "325522048", "story_v_out_325522.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_18 = math.max(var_201_11, arg_198_1.talkMaxDuration)

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_18 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_10) / var_201_18

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_10 + var_201_18 and arg_198_1.time_ < var_201_10 + var_201_18 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play325522049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325522049
		arg_202_1.duration_ = 11.07

		local var_202_0 = {
			zh = 10.3,
			ja = 11.066
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
				arg_202_0:Play325522050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) and arg_202_1.var_.characterEffect1071ui_story == nil then
				arg_202_1.var_.characterEffect1071ui_story = arg_202_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) then
				if arg_202_1.var_.characterEffect1071ui_story and not isNil(arg_202_1.actors_["1071ui_story"]) then
					arg_202_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) and arg_202_1.var_.characterEffect1071ui_story then
				arg_202_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_205_2 = arg_202_1.actors_["10180ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect10180ui_story == nil then
				arg_202_1.var_.characterEffect10180ui_story = var_205_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_3 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_3 and not isNil(var_205_2) then
				if arg_202_1.var_.characterEffect10180ui_story and not isNil(var_205_2) then
					arg_202_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_3)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_3 and arg_202_1.time_ < 0 + var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect10180ui_story then
				arg_202_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_205_4 = 0
			local var_205_5 = 1.125

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(325522049)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 45 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 45)

				if (45 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 45)) > 0 and var_205_5 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522049", "story_v_out_325522.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522049", "story_v_out_325522.awb") / 1000

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_325522", "325522049", "story_v_out_325522.awb")

						arg_202_1:RecordAudio("325522049", var_205_11)
						arg_202_1:RecordAudio("325522049", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_325522", "325522049", "story_v_out_325522.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_325522", "325522049", "story_v_out_325522.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_12 and arg_202_1.time_ < var_205_4 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play325522050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325522050
		arg_206_1.duration_ = 13.2

		local var_206_0 = {
			zh = 7.6,
			ja = 13.2
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
				arg_206_0:Play325522051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.9

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:GetWordFromCfg(325522050)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 35 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 35)

				if (35 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 35)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522050", "story_v_out_325522.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522050", "story_v_out_325522.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_325522", "325522050", "story_v_out_325522.awb")

						arg_206_1:RecordAudio("325522050", var_209_6)
						arg_206_1:RecordAudio("325522050", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325522", "325522050", "story_v_out_325522.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325522", "325522050", "story_v_out_325522.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play325522051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325522051
		arg_210_1.duration_ = 10.2

		local var_210_0 = {
			zh = 10.1,
			ja = 10.2
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
				arg_210_0:Play325522052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 1.05

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:GetWordFromCfg(325522051)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 42 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 42)

				if (42 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 42)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522051", "story_v_out_325522.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522051", "story_v_out_325522.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_325522", "325522051", "story_v_out_325522.awb")

						arg_210_1:RecordAudio("325522051", var_213_6)
						arg_210_1:RecordAudio("325522051", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_325522", "325522051", "story_v_out_325522.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_325522", "325522051", "story_v_out_325522.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play325522052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325522052
		arg_214_1.duration_ = 6.03

		local var_214_0 = {
			zh = 4.9,
			ja = 6.033
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
				arg_214_0:Play325522053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_217_0 = 0
			local var_217_1 = 0.475

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_2 = arg_214_1:GetWordFromCfg(325522052)
				local var_217_3 = arg_214_1:FormatText(var_217_2.content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 19 <= 0 and var_217_1 or var_217_1 * (utf8.len(var_217_3) / 19)

				if (19 <= 0 and var_217_1 or var_217_1 * (utf8.len(var_217_3) / 19)) > 0 and var_217_1 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522052", "story_v_out_325522.awb") ~= 0 then
					local var_217_6 = manager.audio:GetVoiceLength("story_v_out_325522", "325522052", "story_v_out_325522.awb") / 1000

					if var_217_6 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_0
					end

					if var_217_2.prefab_name ~= "" and arg_214_1.actors_[var_217_2.prefab_name] ~= nil then
						local var_217_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_2.prefab_name].transform, "story_v_out_325522", "325522052", "story_v_out_325522.awb")

						arg_214_1:RecordAudio("325522052", var_217_7)
						arg_214_1:RecordAudio("325522052", var_217_7)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325522", "325522052", "story_v_out_325522.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325522", "325522052", "story_v_out_325522.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_8 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_8 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_8

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_8 and arg_214_1.time_ < var_217_0 + var_217_8 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play325522053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325522053
		arg_218_1.duration_ = 9.67

		local var_218_0 = {
			zh = 9.666,
			ja = 8.7
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
				arg_218_0:Play325522054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10180ui_story"]) and arg_218_1.var_.characterEffect10180ui_story == nil then
				arg_218_1.var_.characterEffect10180ui_story = arg_218_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10180ui_story"]) then
				if arg_218_1.var_.characterEffect10180ui_story and not isNil(arg_218_1.actors_["10180ui_story"]) then
					arg_218_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10180ui_story"]) and arg_218_1.var_.characterEffect10180ui_story then
				arg_218_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_221_2 = arg_218_1.actors_["1071ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1071ui_story == nil then
				arg_218_1.var_.characterEffect1071ui_story = var_221_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_3 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.characterEffect1071ui_story and not isNil(var_221_2) then
					arg_218_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_3)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1071ui_story then
				arg_218_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_221_4 = 0
			local var_221_5 = 0.775

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(325522053)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 31 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 31)

				if (31 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 31)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522053", "story_v_out_325522.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522053", "story_v_out_325522.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_325522", "325522053", "story_v_out_325522.awb")

						arg_218_1:RecordAudio("325522053", var_221_11)
						arg_218_1:RecordAudio("325522053", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_325522", "325522053", "story_v_out_325522.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_325522", "325522053", "story_v_out_325522.awb")
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
	Play325522054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325522054
		arg_222_1.duration_ = 9.63

		local var_222_0 = {
			zh = 9.633,
			ja = 9.333
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
				arg_222_0:Play325522055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_225_0 = 0
			local var_225_1 = 0.875

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(325522054)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 35 <= 0 and var_225_1 or var_225_1 * (utf8.len(var_225_3) / 35)

				if (35 <= 0 and var_225_1 or var_225_1 * (utf8.len(var_225_3) / 35)) > 0 and var_225_1 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522054", "story_v_out_325522.awb") ~= 0 then
					local var_225_6 = manager.audio:GetVoiceLength("story_v_out_325522", "325522054", "story_v_out_325522.awb") / 1000

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end

					if var_225_2.prefab_name ~= "" and arg_222_1.actors_[var_225_2.prefab_name] ~= nil then
						local var_225_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_2.prefab_name].transform, "story_v_out_325522", "325522054", "story_v_out_325522.awb")

						arg_222_1:RecordAudio("325522054", var_225_7)
						arg_222_1:RecordAudio("325522054", var_225_7)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_325522", "325522054", "story_v_out_325522.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_325522", "325522054", "story_v_out_325522.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_8 and arg_222_1.time_ < var_225_0 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play325522055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325522055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325522056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10180ui_story = arg_226_1.actors_["10180ui_story"].transform.localPosition

				local var_229_0 = GameObjectTools.GetOrAddComponent(arg_226_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_229_0 then
					var_229_0:EnableDynamicBone(false)
				end
			end

			local var_229_1 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 then
				arg_226_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_1)
				arg_226_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).z)
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles = arg_226_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 then
				arg_226_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).z)
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles = arg_226_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_229_2 = GameObjectTools.GetOrAddComponent(arg_226_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(true)
				end
			end

			local var_229_3 = arg_226_1.actors_["1071ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1071ui_story = var_229_3.localPosition
			end

			local var_229_4 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				var_229_3.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_4)
				var_229_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_3.position).x, (manager.ui.mainCamera.transform.position - var_229_3.position).y, (manager.ui.mainCamera.transform.position - var_229_3.position).z)
				var_229_3.localEulerAngles.z = 0
				var_229_3.localEulerAngles.x = 0
				var_229_3.localEulerAngles = var_229_3.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				var_229_3.localPosition = Vector3.New(0, 100, 0)
				var_229_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_3.position).x, (manager.ui.mainCamera.transform.position - var_229_3.position).y, (manager.ui.mainCamera.transform.position - var_229_3.position).z)
				var_229_3.localEulerAngles.z = 0
				var_229_3.localEulerAngles.x = 0
				var_229_3.localEulerAngles = var_229_3.localEulerAngles
			end

			local var_229_5 = arg_226_1.actors_["10180ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect10180ui_story == nil then
				arg_226_1.var_.characterEffect10180ui_story = var_229_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_6 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_6 and not isNil(var_229_5) then
				if arg_226_1.var_.characterEffect10180ui_story and not isNil(var_229_5) then
					arg_226_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_6)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_6 and arg_226_1.time_ < 0 + var_229_6 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect10180ui_story then
				arg_226_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_229_7 = 0
			local var_229_8 = 0.4

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_7 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_9 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(325522055).content)

				arg_226_1.text_.text = var_229_9

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 16 <= 0 and var_229_8 or var_229_8 * (utf8.len(var_229_9) / 16)

				if (16 <= 0 and var_229_8 or var_229_8 * (utf8.len(var_229_9) / 16)) > 0 and var_229_8 < var_229_11 then
					arg_226_1.talkMaxDuration = var_229_11

					if var_229_11 + var_229_7 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_7
					end
				end

				arg_226_1.text_.text = var_229_9
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_8, arg_226_1.talkMaxDuration)

			if var_229_7 <= arg_226_1.time_ and arg_226_1.time_ < var_229_7 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_7) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_7 + var_229_12 and arg_226_1.time_ < var_229_7 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_226_1:InitPlayNodeList()
	end,
	Play325522056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325522056
		arg_230_1.duration_ = 9.9

		local var_230_0 = {
			zh = 8.1,
			ja = 9.9
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
				arg_230_0:Play325522057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1071ui_story = arg_230_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1071ui_story"].transform.position).z)
				arg_230_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1071ui_story"].transform.localEulerAngles = arg_230_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_230_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1071ui_story"].transform.position).z)
				arg_230_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1071ui_story"].transform.localEulerAngles = arg_230_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1071ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1071ui_story == nil then
				arg_230_1.var_.characterEffect1071ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect1071ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1071ui_story then
				arg_230_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_233_4 = 0
			local var_233_5 = 0.9

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(325522056)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 37 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 37)

				if (37 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 37)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522056", "story_v_out_325522.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522056", "story_v_out_325522.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_out_325522", "325522056", "story_v_out_325522.awb")

						arg_230_1:RecordAudio("325522056", var_233_11)
						arg_230_1:RecordAudio("325522056", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_325522", "325522056", "story_v_out_325522.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_325522", "325522056", "story_v_out_325522.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_12 and arg_230_1.time_ < var_233_4 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play325522057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325522057
		arg_234_1.duration_ = 12.53

		local var_234_0 = {
			zh = 7.933,
			ja = 12.533
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
				arg_234_0:Play325522058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.875

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:GetWordFromCfg(325522057)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 35 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 35)

				if (35 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 35)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522057", "story_v_out_325522.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522057", "story_v_out_325522.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_out_325522", "325522057", "story_v_out_325522.awb")

						arg_234_1:RecordAudio("325522057", var_237_6)
						arg_234_1:RecordAudio("325522057", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325522", "325522057", "story_v_out_325522.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325522", "325522057", "story_v_out_325522.awb")
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
	Play325522058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325522058
		arg_238_1.duration_ = 5.8

		local var_238_0 = {
			zh = 5.333,
			ja = 5.8
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325522059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1071ui_story = arg_238_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1071ui_story"].transform.position).z)
				arg_238_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1071ui_story"].transform.localEulerAngles = arg_238_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_238_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1071ui_story"].transform.position).z)
				arg_238_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1071ui_story"].transform.localEulerAngles = arg_238_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["10180ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10180ui_story = var_241_1.localPosition

				local var_241_2 = GameObjectTools.GetOrAddComponent(var_241_1.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(false)
				end
			end

			local var_241_3 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 then
				var_241_1.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10180ui_story, Vector3.New(0.8, -1.09, -6.14), (arg_238_1.time_ - 0) / var_241_3)
				var_241_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_1.position).x, (manager.ui.mainCamera.transform.position - var_241_1.position).y, (manager.ui.mainCamera.transform.position - var_241_1.position).z)
				var_241_1.localEulerAngles.z = 0
				var_241_1.localEulerAngles.x = 0
				var_241_1.localEulerAngles = var_241_1.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 then
				var_241_1.localPosition = Vector3.New(0.8, -1.09, -6.14)
				var_241_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_1.position).x, (manager.ui.mainCamera.transform.position - var_241_1.position).y, (manager.ui.mainCamera.transform.position - var_241_1.position).z)
				var_241_1.localEulerAngles.z = 0
				var_241_1.localEulerAngles.x = 0
				var_241_1.localEulerAngles = var_241_1.localEulerAngles

				local var_241_4 = GameObjectTools.GetOrAddComponent(var_241_1.gameObject, typeof(DynamicBoneHelper))

				if var_241_4 then
					var_241_4:EnableDynamicBone(true)
				end
			end

			local var_241_5 = arg_238_1.actors_["10180ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect10180ui_story == nil then
				arg_238_1.var_.characterEffect10180ui_story = var_241_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_6 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_6 and not isNil(var_241_5) then
				if arg_238_1.var_.characterEffect10180ui_story and not isNil(var_241_5) then
					arg_238_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_6 and arg_238_1.time_ < 0 + var_241_6 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect10180ui_story then
				arg_238_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_241_8 = arg_238_1.actors_["1071ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.characterEffect1071ui_story == nil then
				arg_238_1.var_.characterEffect1071ui_story = var_241_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_9 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_9 and not isNil(var_241_8) then
				if arg_238_1.var_.characterEffect1071ui_story and not isNil(var_241_8) then
					arg_238_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_9)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_9 and arg_238_1.time_ < 0 + var_241_9 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.characterEffect1071ui_story then
				arg_238_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_241_10 = 0
			local var_241_11 = 0.425

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_12 = arg_238_1:GetWordFromCfg(325522058)
				local var_241_13 = arg_238_1:FormatText(var_241_12.content)

				arg_238_1.text_.text = var_241_13

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_15 = 17 <= 0 and var_241_11 or var_241_11 * (utf8.len(var_241_13) / 17)

				if (17 <= 0 and var_241_11 or var_241_11 * (utf8.len(var_241_13) / 17)) > 0 and var_241_11 < var_241_15 then
					arg_238_1.talkMaxDuration = var_241_15

					if var_241_15 + var_241_10 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_15 + var_241_10
					end
				end

				arg_238_1.text_.text = var_241_13
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522058", "story_v_out_325522.awb") ~= 0 then
					local var_241_16 = manager.audio:GetVoiceLength("story_v_out_325522", "325522058", "story_v_out_325522.awb") / 1000

					if var_241_16 + var_241_10 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_16 + var_241_10
					end

					if var_241_12.prefab_name ~= "" and arg_238_1.actors_[var_241_12.prefab_name] ~= nil then
						local var_241_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_12.prefab_name].transform, "story_v_out_325522", "325522058", "story_v_out_325522.awb")

						arg_238_1:RecordAudio("325522058", var_241_17)
						arg_238_1:RecordAudio("325522058", var_241_17)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_325522", "325522058", "story_v_out_325522.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_325522", "325522058", "story_v_out_325522.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_18 = math.max(var_241_11, arg_238_1.talkMaxDuration)

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_18 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_10) / var_241_18

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_10 + var_241_18 and arg_238_1.time_ < var_241_10 + var_241_18 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325522059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325522059
		arg_242_1.duration_ = 5.83

		local var_242_0 = {
			zh = 3.166,
			ja = 5.833
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
				arg_242_0:Play325522060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1071ui_story"]) and arg_242_1.var_.characterEffect1071ui_story == nil then
				arg_242_1.var_.characterEffect1071ui_story = arg_242_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1071ui_story"]) then
				if arg_242_1.var_.characterEffect1071ui_story and not isNil(arg_242_1.actors_["1071ui_story"]) then
					arg_242_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1071ui_story"]) and arg_242_1.var_.characterEffect1071ui_story then
				arg_242_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_245_2 = arg_242_1.actors_["10180ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.characterEffect10180ui_story == nil then
				arg_242_1.var_.characterEffect10180ui_story = var_245_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_3 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.characterEffect10180ui_story and not isNil(var_245_2) then
					arg_242_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_3)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.characterEffect10180ui_story then
				arg_242_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_245_4 = 0
			local var_245_5 = 0.35

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(325522059)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 14 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 14)

				if (14 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 14)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522059", "story_v_out_325522.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522059", "story_v_out_325522.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_out_325522", "325522059", "story_v_out_325522.awb")

						arg_242_1:RecordAudio("325522059", var_245_11)
						arg_242_1:RecordAudio("325522059", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325522", "325522059", "story_v_out_325522.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325522", "325522059", "story_v_out_325522.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play325522060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325522060
		arg_246_1.duration_ = 5.1

		local var_246_0 = {
			zh = 5.1,
			ja = 3.266
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
				arg_246_0:Play325522061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["10180ui_story"]) and arg_246_1.var_.characterEffect10180ui_story == nil then
				arg_246_1.var_.characterEffect10180ui_story = arg_246_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["10180ui_story"]) then
				if arg_246_1.var_.characterEffect10180ui_story and not isNil(arg_246_1.actors_["10180ui_story"]) then
					arg_246_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["10180ui_story"]) and arg_246_1.var_.characterEffect10180ui_story then
				arg_246_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_249_2 = arg_246_1.actors_["1071ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.characterEffect1071ui_story == nil then
				arg_246_1.var_.characterEffect1071ui_story = var_249_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_3 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.characterEffect1071ui_story and not isNil(var_249_2) then
					arg_246_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_3)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.characterEffect1071ui_story then
				arg_246_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180actionlink/10180action4822")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_249_4 = 0
			local var_249_5 = 0.125

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_6 = arg_246_1:GetWordFromCfg(325522060)
				local var_249_7 = arg_246_1:FormatText(var_249_6.content)

				arg_246_1.text_.text = var_249_7

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_9 = 5 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 5)

				if (5 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 5)) > 0 and var_249_5 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_4
					end
				end

				arg_246_1.text_.text = var_249_7
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522060", "story_v_out_325522.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_325522", "325522060", "story_v_out_325522.awb") / 1000

					if var_249_10 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_4
					end

					if var_249_6.prefab_name ~= "" and arg_246_1.actors_[var_249_6.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_6.prefab_name].transform, "story_v_out_325522", "325522060", "story_v_out_325522.awb")

						arg_246_1:RecordAudio("325522060", var_249_11)
						arg_246_1:RecordAudio("325522060", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325522", "325522060", "story_v_out_325522.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325522", "325522060", "story_v_out_325522.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_5, arg_246_1.talkMaxDuration)

			if var_249_4 <= arg_246_1.time_ and arg_246_1.time_ < var_249_4 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_4) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_4 + var_249_12 and arg_246_1.time_ < var_249_4 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325522061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325522061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325522062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["10180ui_story"]) and arg_250_1.var_.characterEffect10180ui_story == nil then
				arg_250_1.var_.characterEffect10180ui_story = arg_250_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["10180ui_story"]) then
				if arg_250_1.var_.characterEffect10180ui_story and not isNil(arg_250_1.actors_["10180ui_story"]) then
					arg_250_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["10180ui_story"]) and arg_250_1.var_.characterEffect10180ui_story then
				arg_250_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_253_1 = arg_250_1.actors_["1071ui_story"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1071ui_story = var_253_1.localPosition
			end

			local var_253_2 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 then
				var_253_1.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_2)
				var_253_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_1.position).x, (manager.ui.mainCamera.transform.position - var_253_1.position).y, (manager.ui.mainCamera.transform.position - var_253_1.position).z)
				var_253_1.localEulerAngles.z = 0
				var_253_1.localEulerAngles.x = 0
				var_253_1.localEulerAngles = var_253_1.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 then
				var_253_1.localPosition = Vector3.New(0, 100, 0)
				var_253_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_1.position).x, (manager.ui.mainCamera.transform.position - var_253_1.position).y, (manager.ui.mainCamera.transform.position - var_253_1.position).z)
				var_253_1.localEulerAngles.z = 0
				var_253_1.localEulerAngles.x = 0
				var_253_1.localEulerAngles = var_253_1.localEulerAngles
			end

			local var_253_3 = arg_250_1.actors_["10180ui_story"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10180ui_story = var_253_3.localPosition

				local var_253_4 = GameObjectTools.GetOrAddComponent(var_253_3.gameObject, typeof(DynamicBoneHelper))

				if var_253_4 then
					var_253_4:EnableDynamicBone(false)
				end
			end

			local var_253_5 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_5 then
				var_253_3.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_5)
				var_253_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_3.position).x, (manager.ui.mainCamera.transform.position - var_253_3.position).y, (manager.ui.mainCamera.transform.position - var_253_3.position).z)
				var_253_3.localEulerAngles.z = 0
				var_253_3.localEulerAngles.x = 0
				var_253_3.localEulerAngles = var_253_3.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_5 and arg_250_1.time_ < 0 + var_253_5 + arg_253_0 then
				var_253_3.localPosition = Vector3.New(0, 100, 0)
				var_253_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_3.position).x, (manager.ui.mainCamera.transform.position - var_253_3.position).y, (manager.ui.mainCamera.transform.position - var_253_3.position).z)
				var_253_3.localEulerAngles.z = 0
				var_253_3.localEulerAngles.x = 0
				var_253_3.localEulerAngles = var_253_3.localEulerAngles

				local var_253_6 = GameObjectTools.GetOrAddComponent(var_253_3.gameObject, typeof(DynamicBoneHelper))

				if var_253_6 then
					var_253_6:EnableDynamicBone(true)
				end
			end

			local var_253_7 = 0
			local var_253_8 = 1.625

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(325522061).content)

				arg_250_1.text_.text = var_253_9

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 65 <= 0 and var_253_8 or var_253_8 * (utf8.len(var_253_9) / 65)

				if (65 <= 0 and var_253_8 or var_253_8 * (utf8.len(var_253_9) / 65)) > 0 and var_253_8 < var_253_11 then
					arg_250_1.talkMaxDuration = var_253_11

					if var_253_11 + var_253_7 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_11 + var_253_7
					end
				end

				arg_250_1.text_.text = var_253_9
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_8, arg_250_1.talkMaxDuration)

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_7) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_7 + var_253_12 and arg_250_1.time_ < var_253_7 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play325522062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325522062
		arg_254_1.duration_ = 9.87

		local var_254_0 = {
			zh = 6.766,
			ja = 9.866
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325522063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["10180ui_story"]) and arg_254_1.var_.characterEffect10180ui_story == nil then
				arg_254_1.var_.characterEffect10180ui_story = arg_254_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["10180ui_story"]) then
				if arg_254_1.var_.characterEffect10180ui_story and not isNil(arg_254_1.actors_["10180ui_story"]) then
					arg_254_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["10180ui_story"]) and arg_254_1.var_.characterEffect10180ui_story then
				arg_254_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_257_2 = arg_254_1.actors_["10180ui_story"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos10180ui_story = var_257_2.localPosition

				local var_257_3 = GameObjectTools.GetOrAddComponent(var_257_2.gameObject, typeof(DynamicBoneHelper))

				if var_257_3 then
					var_257_3:EnableDynamicBone(false)
				end
			end

			local var_257_4 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				var_257_2.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_254_1.time_ - 0) / var_257_4)
				var_257_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_2.position).x, (manager.ui.mainCamera.transform.position - var_257_2.position).y, (manager.ui.mainCamera.transform.position - var_257_2.position).z)
				var_257_2.localEulerAngles.z = 0
				var_257_2.localEulerAngles.x = 0
				var_257_2.localEulerAngles = var_257_2.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				var_257_2.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				var_257_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_2.position).x, (manager.ui.mainCamera.transform.position - var_257_2.position).y, (manager.ui.mainCamera.transform.position - var_257_2.position).z)
				var_257_2.localEulerAngles.z = 0
				var_257_2.localEulerAngles.x = 0
				var_257_2.localEulerAngles = var_257_2.localEulerAngles

				local var_257_5 = GameObjectTools.GetOrAddComponent(var_257_2.gameObject, typeof(DynamicBoneHelper))

				if var_257_5 then
					var_257_5:EnableDynamicBone(true)
				end
			end

			local var_257_6 = 0
			local var_257_7 = 0.625

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_8 = arg_254_1:GetWordFromCfg(325522062)
				local var_257_9 = arg_254_1:FormatText(var_257_8.content)

				arg_254_1.text_.text = var_257_9

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 25 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 25)

				if (25 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 25)) > 0 and var_257_7 < var_257_11 then
					arg_254_1.talkMaxDuration = var_257_11

					if var_257_11 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_11 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_9
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522062", "story_v_out_325522.awb") ~= 0 then
					local var_257_12 = manager.audio:GetVoiceLength("story_v_out_325522", "325522062", "story_v_out_325522.awb") / 1000

					if var_257_12 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_6
					end

					if var_257_8.prefab_name ~= "" and arg_254_1.actors_[var_257_8.prefab_name] ~= nil then
						local var_257_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_8.prefab_name].transform, "story_v_out_325522", "325522062", "story_v_out_325522.awb")

						arg_254_1:RecordAudio("325522062", var_257_13)
						arg_254_1:RecordAudio("325522062", var_257_13)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_325522", "325522062", "story_v_out_325522.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_325522", "325522062", "story_v_out_325522.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325522063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325522063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325522064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["10180ui_story"]) and arg_258_1.var_.characterEffect10180ui_story == nil then
				arg_258_1.var_.characterEffect10180ui_story = arg_258_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["10180ui_story"]) then
				if arg_258_1.var_.characterEffect10180ui_story and not isNil(arg_258_1.actors_["10180ui_story"]) then
					arg_258_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["10180ui_story"]) and arg_258_1.var_.characterEffect10180ui_story then
				arg_258_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_261_1 = 0
			local var_261_2 = 0.175

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(325522063).content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 7 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 7)

				if (7 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 7)) > 0 and var_261_2 < var_261_5 then
					arg_258_1.talkMaxDuration = var_261_5

					if var_261_5 + var_261_1 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + var_261_1
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_6 = math.max(var_261_2, arg_258_1.talkMaxDuration)

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_6 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_1) / var_261_6

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_1 + var_261_6 and arg_258_1.time_ < var_261_1 + var_261_6 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play325522064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325522064
		arg_262_1.duration_ = 10.6

		local var_262_0 = {
			zh = 9,
			ja = 10.6
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
				arg_262_0:Play325522065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["10180ui_story"]) and arg_262_1.var_.characterEffect10180ui_story == nil then
				arg_262_1.var_.characterEffect10180ui_story = arg_262_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["10180ui_story"]) then
				if arg_262_1.var_.characterEffect10180ui_story and not isNil(arg_262_1.actors_["10180ui_story"]) then
					arg_262_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["10180ui_story"]) and arg_262_1.var_.characterEffect10180ui_story then
				arg_262_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180actionlink/10180action42240")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_265_2 = 0
			local var_265_3 = 0.65

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_4 = arg_262_1:GetWordFromCfg(325522064)
				local var_265_5 = arg_262_1:FormatText(var_265_4.content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 26 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 26)

				if (26 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 26)) > 0 and var_265_3 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522064", "story_v_out_325522.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_out_325522", "325522064", "story_v_out_325522.awb") / 1000

					if var_265_8 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_2
					end

					if var_265_4.prefab_name ~= "" and arg_262_1.actors_[var_265_4.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_4.prefab_name].transform, "story_v_out_325522", "325522064", "story_v_out_325522.awb")

						arg_262_1:RecordAudio("325522064", var_265_9)
						arg_262_1:RecordAudio("325522064", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_325522", "325522064", "story_v_out_325522.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_325522", "325522064", "story_v_out_325522.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_3, arg_262_1.talkMaxDuration)

			if var_265_2 <= arg_262_1.time_ and arg_262_1.time_ < var_265_2 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_2) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_2 + var_265_10 and arg_262_1.time_ < var_265_2 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play325522065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325522065
		arg_266_1.duration_ = 7.9

		local var_266_0 = {
			zh = 7.9,
			ja = 7.266
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325522066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.65

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_1 = arg_266_1:GetWordFromCfg(325522065)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 26 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 26)

				if (26 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 26)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522065", "story_v_out_325522.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_325522", "325522065", "story_v_out_325522.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_325522", "325522065", "story_v_out_325522.awb")

						arg_266_1:RecordAudio("325522065", var_269_6)
						arg_266_1:RecordAudio("325522065", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_325522", "325522065", "story_v_out_325522.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_325522", "325522065", "story_v_out_325522.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play325522066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325522066
		arg_270_1.duration_ = 7.43

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325522067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if arg_270_1.bgs_.MS2503 == nil then
				local var_273_0 = Object.Instantiate(arg_270_1.paintGo_)

				var_273_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2503")
				var_273_0.name = "MS2503"
				var_273_0.transform.parent = arg_270_1.stage_.transform
				var_273_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.bgs_.MS2503 = var_273_0
			end

			if 0.433333333333333 < arg_270_1.time_ and arg_270_1.time_ <= 0.433333333333333 + arg_273_0 then
				local var_273_1 = arg_270_1.bgs_.MS2503

				arg_270_1.bgs_.MS2503.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_273_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_2 = var_273_1:GetComponent("SpriteRenderer")

				if var_273_2 and var_273_2.sprite then
					local var_273_3 = 2 * (var_273_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_273_1.transform.localScale = Vector3.New(var_273_3 / var_273_2.sprite.bounds.size.y < var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x and var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x or var_273_3 / var_273_2.sprite.bounds.size.y, var_273_3 / var_273_2.sprite.bounds.size.y < var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x and var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x or var_273_3 / var_273_2.sprite.bounds.size.y, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "MS2503" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_4 = 0.433333333333333

			if 0.433333333333333 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_4 + 0.3 and arg_270_1.time_ < var_273_4 + 0.3 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_5 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_6 = 0.467333335181077

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 then
				local var_273_7 = Color.New(1, 1, 1)

				var_273_7.a = Mathf.Lerp(0, 1, (arg_270_1.time_ - var_273_5) / var_273_6)
				arg_270_1.mask_.color = var_273_7
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 then
				local var_273_8 = Color.New(1, 1, 1)

				var_273_8.a = 1
				arg_270_1.mask_.color = var_273_8
			end

			local var_273_9 = 0.467333335181077

			if 0.467333335181077 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_10 = 0.632666664818923

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_10 then
				local var_273_11 = Color.New(1, 1, 1)

				var_273_11.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_9) / var_273_10)
				arg_270_1.mask_.color = var_273_11
			end

			if arg_270_1.time_ >= var_273_9 + var_273_10 and arg_270_1.time_ < var_273_9 + var_273_10 + arg_273_0 then
				local var_273_12 = Color.New(1, 1, 1)

				arg_270_1.mask_.enabled = false
				var_273_12.a = 0
				arg_270_1.mask_.color = var_273_12
			end

			local var_273_13 = arg_270_1.actors_["10180ui_story"].transform

			if 0.433333333333333 < arg_270_1.time_ and arg_270_1.time_ <= 0.433333333333333 + arg_273_0 then
				arg_270_1.var_.moveOldPos10180ui_story = var_273_13.localPosition

				local var_273_14 = GameObjectTools.GetOrAddComponent(var_273_13.gameObject, typeof(DynamicBoneHelper))

				if var_273_14 then
					var_273_14:EnableDynamicBone(false)
				end
			end

			local var_273_15 = 0.001

			if 0.433333333333333 <= arg_270_1.time_ and arg_270_1.time_ < 0.433333333333333 + var_273_15 then
				var_273_13.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0.433333333333333) / var_273_15)
				var_273_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_13.position).x, (manager.ui.mainCamera.transform.position - var_273_13.position).y, (manager.ui.mainCamera.transform.position - var_273_13.position).z)
				var_273_13.localEulerAngles.z = 0
				var_273_13.localEulerAngles.x = 0
				var_273_13.localEulerAngles = var_273_13.localEulerAngles
			end

			if arg_270_1.time_ >= 0.433333333333333 + var_273_15 and arg_270_1.time_ < 0.433333333333333 + var_273_15 + arg_273_0 then
				var_273_13.localPosition = Vector3.New(0, 100, 0)
				var_273_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_13.position).x, (manager.ui.mainCamera.transform.position - var_273_13.position).y, (manager.ui.mainCamera.transform.position - var_273_13.position).z)
				var_273_13.localEulerAngles.z = 0
				var_273_13.localEulerAngles.x = 0
				var_273_13.localEulerAngles = var_273_13.localEulerAngles

				local var_273_16 = GameObjectTools.GetOrAddComponent(var_273_13.gameObject, typeof(DynamicBoneHelper))

				if var_273_16 then
					var_273_16:EnableDynamicBone(true)
				end
			end

			local var_273_17 = arg_270_1.actors_["1071ui_story"].transform

			if 0.433333333333333 < arg_270_1.time_ and arg_270_1.time_ <= 0.433333333333333 + arg_273_0 then
				arg_270_1.var_.moveOldPos1071ui_story = var_273_17.localPosition
			end

			local var_273_18 = 0.001

			if 0.433333333333333 <= arg_270_1.time_ and arg_270_1.time_ < 0.433333333333333 + var_273_18 then
				var_273_17.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0.433333333333333) / var_273_18)
				var_273_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_17.position).x, (manager.ui.mainCamera.transform.position - var_273_17.position).y, (manager.ui.mainCamera.transform.position - var_273_17.position).z)
				var_273_17.localEulerAngles.z = 0
				var_273_17.localEulerAngles.x = 0
				var_273_17.localEulerAngles = var_273_17.localEulerAngles
			end

			if arg_270_1.time_ >= 0.433333333333333 + var_273_18 and arg_270_1.time_ < 0.433333333333333 + var_273_18 + arg_273_0 then
				var_273_17.localPosition = Vector3.New(0, 100, 0)
				var_273_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_17.position).x, (manager.ui.mainCamera.transform.position - var_273_17.position).y, (manager.ui.mainCamera.transform.position - var_273_17.position).z)
				var_273_17.localEulerAngles.z = 0
				var_273_17.localEulerAngles.x = 0
				var_273_17.localEulerAngles = var_273_17.localEulerAngles
			end

			local var_273_19 = arg_270_1.actors_["10180ui_story"]

			if 0.433333333333333 < arg_270_1.time_ and arg_270_1.time_ <= 0.433333333333333 + arg_273_0 and not isNil(var_273_19) and arg_270_1.var_.characterEffect10180ui_story == nil then
				arg_270_1.var_.characterEffect10180ui_story = var_273_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_20 = 0.200000002980232

			if 0.433333333333333 <= arg_270_1.time_ and arg_270_1.time_ < 0.433333333333333 + var_273_20 and not isNil(var_273_19) then
				if arg_270_1.var_.characterEffect10180ui_story and not isNil(var_273_19) then
					arg_270_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0.433333333333333) / var_273_20)
				end
			end

			if arg_270_1.time_ >= 0.433333333333333 + var_273_20 and arg_270_1.time_ < 0.433333333333333 + var_273_20 + arg_273_0 and not isNil(var_273_19) and arg_270_1.var_.characterEffect10180ui_story then
				arg_270_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_273_21 = arg_270_1.bgs_.MS2503.transform

			if 0.433333333333333 < arg_270_1.time_ and arg_270_1.time_ <= 0.433333333333333 + arg_273_0 then
				arg_270_1.var_.moveOldPosMS2503 = var_273_21.localPosition
			end

			local var_273_22 = 1.26666666666667

			if 0.433333333333333 <= arg_270_1.time_ and arg_270_1.time_ < 0.433333333333333 + var_273_22 then
				var_273_21.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPosMS2503, Vector3.New(0, 1, 5), (arg_270_1.time_ - 0.433333333333333) / var_273_22)
			end

			if arg_270_1.time_ >= 0.433333333333333 + var_273_22 and arg_270_1.time_ < 0.433333333333333 + var_273_22 + arg_273_0 then
				var_273_21.localPosition = Vector3.New(0, 1, 5)
			end

			local var_273_23 = arg_270_1.bgs_.MS2503.transform

			if 1.7 < arg_270_1.time_ and arg_270_1.time_ <= 1.7 + arg_273_0 then
				arg_270_1.var_.moveOldPosMS2503 = var_273_23.localPosition
			end

			local var_273_24 = 1.26666666666667

			if 1.7 <= arg_270_1.time_ and arg_270_1.time_ < 1.7 + var_273_24 then
				var_273_23.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPosMS2503, Vector3.New(0, 1, 4), (arg_270_1.time_ - 1.7) / var_273_24)
			end

			if arg_270_1.time_ >= 1.7 + var_273_24 and arg_270_1.time_ < 1.7 + var_273_24 + arg_273_0 then
				var_273_23.localPosition = Vector3.New(0, 1, 4)
			end

			local var_273_25 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_25 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_25 + 2.53333333333333 and arg_270_1.time_ < var_273_25 + 2.53333333333333 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			if 0.1 < arg_270_1.time_ and arg_270_1.time_ <= 0.1 + arg_273_0 then
				arg_270_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0.1 < arg_270_1.time_ and arg_270_1.time_ <= 0.1 + arg_273_0 then
				arg_270_1:AudioAction("play", "effect", "se_story_121_00", "se_story_121_00_dooropen_loop", "")
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_28 = 2.43333333333333
			local var_273_29 = 0.9

			if 2.43333333333333 < arg_270_1.time_ and arg_270_1.time_ <= var_273_28 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_30 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_30:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_31 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(325522066).content)

				arg_270_1.text_.text = var_273_31

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_33 = 36 <= 0 and var_273_29 or var_273_29 * (utf8.len(var_273_31) / 36)

				if (36 <= 0 and var_273_29 or var_273_29 * (utf8.len(var_273_31) / 36)) > 0 and var_273_29 < var_273_33 then
					arg_270_1.talkMaxDuration = var_273_33
					var_273_28 = var_273_28 + 0.3

					if var_273_33 + var_273_28 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_33 + var_273_28
					end
				end

				arg_270_1.text_.text = var_273_31
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_34 = var_273_28 + 0.3
			local var_273_35 = math.max(var_273_29, arg_270_1.talkMaxDuration)

			if var_273_28 + 0.3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_34 + var_273_35 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_34) / var_273_35

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_34 + var_273_35 and arg_270_1.time_ < var_273_34 + var_273_35 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.433333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.433333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2503",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.26666666666667,
				startTime = 0.433333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 5),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2503",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.26666666666667,
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 5),
					endPos = Vector3.New(0, 1, 4),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play325522067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325522067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play325522068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0.1 < arg_276_1.time_ and arg_276_1.time_ <= 0.1 + arg_279_0 then
				arg_276_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword02", "")
			end

			local var_279_1 = 0
			local var_279_2 = 1.125

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(325522067).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 45 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 45)

				if (45 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 45)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play325522068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325522068
		arg_280_1.duration_ = 6.97

		local var_280_0 = {
			zh = 6.966,
			ja = 4.666
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
				arg_280_0:Play325522069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10180ui_story = arg_280_1.actors_["10180ui_story"].transform.localPosition

				local var_283_0 = GameObjectTools.GetOrAddComponent(arg_280_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_283_0 then
					var_283_0:EnableDynamicBone(false)
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_280_1.time_ - 0) / var_283_1)
				arg_280_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10180ui_story"].transform.position).z)
				arg_280_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10180ui_story"].transform.localEulerAngles = arg_280_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_280_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10180ui_story"].transform.position).z)
				arg_280_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10180ui_story"].transform.localEulerAngles = arg_280_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_283_2 = GameObjectTools.GetOrAddComponent(arg_280_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_283_2 then
					var_283_2:EnableDynamicBone(true)
				end
			end

			local var_283_3 = arg_280_1.actors_["10180ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect10180ui_story == nil then
				arg_280_1.var_.characterEffect10180ui_story = var_283_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_4 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 and not isNil(var_283_3) then
				if arg_280_1.var_.characterEffect10180ui_story and not isNil(var_283_3) then
					arg_280_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect10180ui_story then
				arg_280_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_283_6 = 0
			local var_283_7 = 0.4

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_8 = arg_280_1:GetWordFromCfg(325522068)
				local var_283_9 = arg_280_1:FormatText(var_283_8.content)

				arg_280_1.text_.text = var_283_9

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 16 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 16)

				if (16 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 16)) > 0 and var_283_7 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11

					if var_283_11 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_9
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522068", "story_v_out_325522.awb") ~= 0 then
					local var_283_12 = manager.audio:GetVoiceLength("story_v_out_325522", "325522068", "story_v_out_325522.awb") / 1000

					if var_283_12 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_6
					end

					if var_283_8.prefab_name ~= "" and arg_280_1.actors_[var_283_8.prefab_name] ~= nil then
						local var_283_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_8.prefab_name].transform, "story_v_out_325522", "325522068", "story_v_out_325522.awb")

						arg_280_1:RecordAudio("325522068", var_283_13)
						arg_280_1:RecordAudio("325522068", var_283_13)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325522", "325522068", "story_v_out_325522.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325522", "325522068", "story_v_out_325522.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_14 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_14 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_14

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_14 and arg_280_1.time_ < var_283_6 + var_283_14 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play325522069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325522069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play325522070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos10180ui_story = arg_284_1.actors_["10180ui_story"].transform.localPosition

				local var_287_0 = GameObjectTools.GetOrAddComponent(arg_284_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_287_0 then
					var_287_0:EnableDynamicBone(false)
				end
			end

			local var_287_1 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_1 then
				arg_284_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_284_1.time_ - 0) / var_287_1)
				arg_284_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10180ui_story"].transform.position).z)
				arg_284_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["10180ui_story"].transform.localEulerAngles = arg_284_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_1 and arg_284_1.time_ < 0 + var_287_1 + arg_287_0 then
				arg_284_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_284_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10180ui_story"].transform.position).z)
				arg_284_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["10180ui_story"].transform.localEulerAngles = arg_284_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_287_2 = GameObjectTools.GetOrAddComponent(arg_284_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_287_2 then
					var_287_2:EnableDynamicBone(true)
				end
			end

			local var_287_3 = arg_284_1.actors_["10180ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_3) and arg_284_1.var_.characterEffect10180ui_story == nil then
				arg_284_1.var_.characterEffect10180ui_story = var_287_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_4 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 and not isNil(var_287_3) then
				if arg_284_1.var_.characterEffect10180ui_story and not isNil(var_287_3) then
					arg_284_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_284_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_4)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 and not isNil(var_287_3) and arg_284_1.var_.characterEffect10180ui_story then
				arg_284_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_284_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_287_5 = 0
			local var_287_6 = 1.125

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_7 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(325522069).content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 45 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_7) / 45)

				if (45 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_7) / 45)) > 0 and var_287_6 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_5
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_6, arg_284_1.talkMaxDuration)

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_5) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_5 + var_287_10 and arg_284_1.time_ < var_287_5 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play325522070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 325522070
		arg_288_1.duration_ = 5.73

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play325522071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_9000

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPosMS2503 = arg_288_1.bgs_.MS2503.transform.localPosition
			end

			local var_291_0 = 0.733333333333333

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.bgs_.MS2503.transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPosMS2503, Vector3.New(0, 1, 10), (arg_288_1.time_ - 0) / var_291_0)
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.bgs_.MS2503.transform.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				local var_291_1 = arg_288_1.var_.effect324

				if not arg_288_1.var_.effect324 then
					var_291_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_291_1.name = "324"
					arg_288_1.var_.effect324 = var_291_1
				else
					var_291_1.transform:SetParent(var_291_9000)
				end

				var_291_1.transform.localPosition = Vector3.New(0, 0, -1.05)
				var_291_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_291_3 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_291_1.transform.localScale = Vector3.New(var_291_1.transform.localScale.x * var_291_3, var_291_1.transform.localScale.y * var_291_3, var_291_1.transform.localScale.z * var_291_3)
			end

			local var_291_4 = 0

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.allBtn_.enabled = false
			end

			if arg_288_1.time_ >= var_291_4 + 1 and arg_288_1.time_ < var_291_4 + 1 + arg_291_0 then
				arg_288_1.allBtn_.enabled = true
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_5 = 0.733333333333333
			local var_291_6 = 1.125

			if 0.733333333333333 < arg_288_1.time_ and arg_288_1.time_ <= var_291_5 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_7 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_7:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_8 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(325522070).content)

				arg_288_1.text_.text = var_291_8

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_10 = 45 <= 0 and var_291_6 or var_291_6 * (utf8.len(var_291_8) / 45)

				if (45 <= 0 and var_291_6 or var_291_6 * (utf8.len(var_291_8) / 45)) > 0 and var_291_6 < var_291_10 then
					arg_288_1.talkMaxDuration = var_291_10
					var_291_5 = var_291_5 + 0.3

					if var_291_10 + var_291_5 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_5
					end
				end

				arg_288_1.text_.text = var_291_8
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_11 = var_291_5 + 0.3
			local var_291_12 = math.max(var_291_6, arg_288_1.talkMaxDuration)

			if var_291_5 + 0.3 <= arg_288_1.time_ and arg_288_1.time_ < var_291_11 + var_291_12 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_11) / var_291_12

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_11 + var_291_12 and arg_288_1.time_ < var_291_11 + var_291_12 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2503",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.733333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 4),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeOutBounce
				}
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play325522071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 325522071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play325522072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.475

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(325522071).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 19 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 19)

				if (19 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 19)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play325522072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 325522072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play325522073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.75

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(325522072).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 30 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 30)

				if (30 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 30)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play325522073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 325522073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play325522074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 1.1

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(325522073).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 44 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 44)

				if (44 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 44)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play325522074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 325522074
		arg_306_1.duration_ = 4.03

		local var_306_0 = {
			zh = 4.033,
			ja = 3.5
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play325522075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos10180ui_story = arg_306_1.actors_["10180ui_story"].transform.localPosition

				local var_309_0 = GameObjectTools.GetOrAddComponent(arg_306_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_309_0 then
					var_309_0:EnableDynamicBone(false)
				end
			end

			local var_309_1 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_1 then
				arg_306_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_306_1.time_ - 0) / var_309_1)
				arg_306_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10180ui_story"].transform.position).z)
				arg_306_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["10180ui_story"].transform.localEulerAngles = arg_306_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_1 and arg_306_1.time_ < 0 + var_309_1 + arg_309_0 then
				arg_306_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10180ui_story"].transform.position).z)
				arg_306_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["10180ui_story"].transform.localEulerAngles = arg_306_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_309_2 = GameObjectTools.GetOrAddComponent(arg_306_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_309_2 then
					var_309_2:EnableDynamicBone(true)
				end
			end

			local var_309_3 = arg_306_1.actors_["10180ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_3) and arg_306_1.var_.characterEffect10180ui_story == nil then
				arg_306_1.var_.characterEffect10180ui_story = var_309_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_4 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 and not isNil(var_309_3) then
				if arg_306_1.var_.characterEffect10180ui_story and not isNil(var_309_3) then
					arg_306_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 and not isNil(var_309_3) and arg_306_1.var_.characterEffect10180ui_story then
				arg_306_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_309_6 = 0
			local var_309_7 = 0.275

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_8 = arg_306_1:GetWordFromCfg(325522074)
				local var_309_9 = arg_306_1:FormatText(var_309_8.content)

				arg_306_1.text_.text = var_309_9

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 11 <= 0 and var_309_7 or var_309_7 * (utf8.len(var_309_9) / 11)

				if (11 <= 0 and var_309_7 or var_309_7 * (utf8.len(var_309_9) / 11)) > 0 and var_309_7 < var_309_11 then
					arg_306_1.talkMaxDuration = var_309_11

					if var_309_11 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_9
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522074", "story_v_out_325522.awb") ~= 0 then
					local var_309_12 = manager.audio:GetVoiceLength("story_v_out_325522", "325522074", "story_v_out_325522.awb") / 1000

					if var_309_12 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_12 + var_309_6
					end

					if var_309_8.prefab_name ~= "" and arg_306_1.actors_[var_309_8.prefab_name] ~= nil then
						local var_309_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_8.prefab_name].transform, "story_v_out_325522", "325522074", "story_v_out_325522.awb")

						arg_306_1:RecordAudio("325522074", var_309_13)
						arg_306_1:RecordAudio("325522074", var_309_13)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_325522", "325522074", "story_v_out_325522.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_325522", "325522074", "story_v_out_325522.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_14 and arg_306_1.time_ < var_309_6 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play325522075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 325522075
		arg_310_1.duration_ = 7.63

		local var_310_0 = {
			zh = 6,
			ja = 7.633
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play325522076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_313_0 = 0
			local var_313_1 = 0.4

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_2 = arg_310_1:GetWordFromCfg(325522075)
				local var_313_3 = arg_310_1:FormatText(var_313_2.content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 16 <= 0 and var_313_1 or var_313_1 * (utf8.len(var_313_3) / 16)

				if (16 <= 0 and var_313_1 or var_313_1 * (utf8.len(var_313_3) / 16)) > 0 and var_313_1 < var_313_5 then
					arg_310_1.talkMaxDuration = var_313_5

					if var_313_5 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325522", "325522075", "story_v_out_325522.awb") ~= 0 then
					local var_313_6 = manager.audio:GetVoiceLength("story_v_out_325522", "325522075", "story_v_out_325522.awb") / 1000

					if var_313_6 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_0
					end

					if var_313_2.prefab_name ~= "" and arg_310_1.actors_[var_313_2.prefab_name] ~= nil then
						local var_313_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_2.prefab_name].transform, "story_v_out_325522", "325522075", "story_v_out_325522.awb")

						arg_310_1:RecordAudio("325522075", var_313_7)
						arg_310_1:RecordAudio("325522075", var_313_7)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_325522", "325522075", "story_v_out_325522.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_325522", "325522075", "story_v_out_325522.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_8 and arg_310_1.time_ < var_313_0 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play325522076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 325522076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
			arg_314_1.auto_ = false
		end

		function arg_314_1.playNext_(arg_316_0)
			arg_314_1.onStoryFinished_()
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10180ui_story = arg_314_1.actors_["10180ui_story"].transform.localPosition

				local var_317_0 = GameObjectTools.GetOrAddComponent(arg_314_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_317_0 then
					var_317_0:EnableDynamicBone(false)
				end
			end

			local var_317_1 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_1 then
				arg_314_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_314_1.time_ - 0) / var_317_1)
				arg_314_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10180ui_story"].transform.position).z)
				arg_314_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10180ui_story"].transform.localEulerAngles = arg_314_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_1 and arg_314_1.time_ < 0 + var_317_1 + arg_317_0 then
				arg_314_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_314_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10180ui_story"].transform.position).z)
				arg_314_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10180ui_story"].transform.localEulerAngles = arg_314_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_317_2 = GameObjectTools.GetOrAddComponent(arg_314_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_317_2 then
					var_317_2:EnableDynamicBone(true)
				end
			end

			local var_317_3 = arg_314_1.actors_["10180ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_3) and arg_314_1.var_.characterEffect10180ui_story == nil then
				arg_314_1.var_.characterEffect10180ui_story = var_317_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_4 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 and not isNil(var_317_3) then
				if arg_314_1.var_.characterEffect10180ui_story and not isNil(var_317_3) then
					arg_314_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_314_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_4)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 and not isNil(var_317_3) and arg_314_1.var_.characterEffect10180ui_story then
				arg_314_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_314_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_blast02", "")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_317_7 = 0
			local var_317_8 = 0.925

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_7 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_9 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(325522076).content)

				arg_314_1.text_.text = var_317_9

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_11 = 37 <= 0 and var_317_8 or var_317_8 * (utf8.len(var_317_9) / 37)

				if (37 <= 0 and var_317_8 or var_317_8 * (utf8.len(var_317_9) / 37)) > 0 and var_317_8 < var_317_11 then
					arg_314_1.talkMaxDuration = var_317_11

					if var_317_11 + var_317_7 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_11 + var_317_7
					end
				end

				arg_314_1.text_.text = var_317_9
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_8, arg_314_1.talkMaxDuration)

			if var_317_7 <= arg_314_1.time_ and arg_314_1.time_ < var_317_7 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_7) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_7 + var_317_12 and arg_314_1.time_ < var_317_7 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21f",
		"TextureConfig/Background/J21h",
		"TextureConfig/Background/MS2503"
	},
	voices = {
		"story_v_out_325522.awb"
	}
}
