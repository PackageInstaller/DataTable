return {
	Play325591001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325591001
		arg_1_1.duration_ = 7.7

		local var_1_0 = {
			zh = 6.466,
			ja = 7.7
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
				arg_1_0:Play325591002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J28f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J28f")
				var_4_0.name = "J28f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J28f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J28f

				arg_1_1.bgs_.J28f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J28f" then
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

			local var_4_9 = "1054ui_story"

			if arg_1_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1054ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1054ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_1_1.time_ - 2) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 then
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

			local var_4_17 = arg_1_1.actors_["1054ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1054ui_story == nil then
				arg_1_1.var_.characterEffect1054ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect1054ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_18 and arg_1_1.time_ < 2 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1054ui_story then
				arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan")

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
			local var_4_25 = 0.425

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(325591001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 17 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 17)

				if (17 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 17)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591001", "story_v_out_325591.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_325591", "325591001", "story_v_out_325591.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_325591", "325591001", "story_v_out_325591.awb")

						arg_1_1:RecordAudio("325591001", var_4_32)
						arg_1_1:RecordAudio("325591001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325591", "325591001", "story_v_out_325591.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325591", "325591001", "story_v_out_325591.awb")
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
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325591002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325591002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325591003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1054ui_story = arg_8_1.actors_["1054ui_story"].transform.localPosition

				local var_11_0 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_0 then
					var_11_0:EnableDynamicBone(false)
				end
			end

			local var_11_1 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_1 then
				arg_8_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_1)
				arg_8_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1054ui_story"].transform.position).z)
				arg_8_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1054ui_story"].transform.localEulerAngles = arg_8_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1054ui_story"].transform.position).z)
				arg_8_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1054ui_story"].transform.localEulerAngles = arg_8_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_11_2 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(true)
				end
			end

			local var_11_3 = arg_8_1.actors_["1054ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1054ui_story == nil then
				arg_8_1.var_.characterEffect1054ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1054ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1054ui_story then
				arg_8_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_11_5 = 0
			local var_11_6 = 1.75

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

				local var_11_7 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325591002).content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 70 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 70)

				if (70 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 70)) > 0 and var_11_6 < var_11_9 then
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
	Play325591003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325591003
		arg_12_1.duration_ = 10.23

		local var_12_0 = {
			zh = 6.9,
			ja = 10.233
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
				arg_12_0:Play325591004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "6148ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["6148ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["6148ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["6148ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["6148ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos6148ui_story = var_15_3.localPosition

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(false)
				end
			end

			local var_15_5 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_12_1.time_ - 0) / var_15_5)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -0.985, -6)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles

				local var_15_6 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_6 then
					var_15_6:EnableDynamicBone(true)
				end
			end

			local var_15_7 = arg_12_1.actors_["6148ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect6148ui_story == nil then
				arg_12_1.var_.characterEffect6148ui_story = var_15_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_8 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 and not isNil(var_15_7) then
				if arg_12_1.var_.characterEffect6148ui_story and not isNil(var_15_7) then
					arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect6148ui_story then
				arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_15_10 = 0
			local var_15_11 = 0.925

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
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

				local var_15_12 = arg_12_1:GetWordFromCfg(325591003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 37 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 37)

				if (37 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 37)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591003", "story_v_out_325591.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_325591", "325591003", "story_v_out_325591.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_325591", "325591003", "story_v_out_325591.awb")

						arg_12_1:RecordAudio("325591003", var_15_17)
						arg_12_1:RecordAudio("325591003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325591", "325591003", "story_v_out_325591.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325591", "325591003", "story_v_out_325591.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play325591004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325591004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			zh = 3.866,
			ja = 4.6
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
				arg_16_0:Play325591005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = arg_16_1.actors_["6148ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["6148ui_story"].transform.position).z)
				arg_16_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["6148ui_story"].transform.localEulerAngles = arg_16_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_16_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["6148ui_story"].transform.position).z)
				arg_16_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["6148ui_story"].transform.localEulerAngles = arg_16_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["1054ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1054ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["1054ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect1054ui_story == nil then
				arg_16_1.var_.characterEffect1054ui_story = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect1054ui_story and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect1054ui_story then
				arg_16_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_19_10 = arg_16_1.actors_["6148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_10) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_11 and not isNil(var_19_10) then
				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_10) then
					arg_16_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_16_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_11)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_11 and arg_16_1.time_ < 0 + var_19_11 + arg_19_0 and not isNil(var_19_10) and arg_16_1.var_.characterEffect6148ui_story then
				arg_16_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_16_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_19_12 = 0
			local var_19_13 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
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

				local var_19_14 = arg_16_1:GetWordFromCfg(325591004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 13 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 13)

				if (13 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 13)) > 0 and var_19_13 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591004", "story_v_out_325591.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591004", "story_v_out_325591.awb") / 1000

					if var_19_18 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_12
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_325591", "325591004", "story_v_out_325591.awb")

						arg_16_1:RecordAudio("325591004", var_19_19)
						arg_16_1:RecordAudio("325591004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325591", "325591004", "story_v_out_325591.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325591", "325591004", "story_v_out_325591.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_20 and arg_16_1.time_ < var_19_12 + var_19_20 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_16_1:InitPlayNodeList()
	end,
	Play325591005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325591005
		arg_20_1.duration_ = 6.53

		local var_20_0 = {
			zh = 5.433,
			ja = 6.533
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
				arg_20_0:Play325591006(arg_20_1)
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

			local var_23_4 = 0
			local var_23_5 = 0.7

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

				local var_23_6 = arg_20_1:GetWordFromCfg(325591005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 28 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 28)

				if (28 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 28)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591005", "story_v_out_325591.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591005", "story_v_out_325591.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_325591", "325591005", "story_v_out_325591.awb")

						arg_20_1:RecordAudio("325591005", var_23_11)
						arg_20_1:RecordAudio("325591005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325591", "325591005", "story_v_out_325591.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325591", "325591005", "story_v_out_325591.awb")
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
	Play325591006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325591006
		arg_24_1.duration_ = 5.5

		local var_24_0 = {
			zh = 4.966,
			ja = 5.5
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
				arg_24_0:Play325591007(arg_24_1)
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
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_27_4 = 0
			local var_27_5 = 0.4

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

				local var_27_6 = arg_24_1:GetWordFromCfg(325591006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 16 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 16)

				if (16 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 16)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591006", "story_v_out_325591.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591006", "story_v_out_325591.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_325591", "325591006", "story_v_out_325591.awb")

						arg_24_1:RecordAudio("325591006", var_27_11)
						arg_24_1:RecordAudio("325591006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325591", "325591006", "story_v_out_325591.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325591", "325591006", "story_v_out_325591.awb")
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
	Play325591007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325591007
		arg_28_1.duration_ = 8.57

		local var_28_0 = {
			zh = 4,
			ja = 8.566
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
				arg_28_0:Play325591008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = arg_28_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) then
				if arg_28_1.var_.characterEffect6148ui_story and not isNil(arg_28_1.actors_["6148ui_story"]) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1054ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1054ui_story == nil then
				arg_28_1.var_.characterEffect1054ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1054ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1054ui_story then
				arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_31_4 = 0
			local var_31_5 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(325591007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 16 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 16)

				if (16 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 16)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591007", "story_v_out_325591.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591007", "story_v_out_325591.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_325591", "325591007", "story_v_out_325591.awb")

						arg_28_1:RecordAudio("325591007", var_31_11)
						arg_28_1:RecordAudio("325591007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325591", "325591007", "story_v_out_325591.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325591", "325591007", "story_v_out_325591.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325591008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325591008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325591009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos6148ui_story = arg_32_1.actors_["6148ui_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).z)
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles = arg_32_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).z)
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles = arg_32_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["1054ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1054ui_story = var_35_3.localPosition

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(false)
				end
			end

			local var_35_5 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_5)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0, 100, 0)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(true)
				end
			end

			local var_35_7 = arg_32_1.actors_["6148ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_8 and not isNil(var_35_7) then
				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_7) then
					arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_8)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_8 and arg_32_1.time_ < 0 + var_35_8 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect6148ui_story then
				arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_35_9 = 0
			local var_35_10 = 1.375

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_11 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(325591008).content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 55 <= 0 and var_35_10 or var_35_10 * (utf8.len(var_35_11) / 55)

				if (55 <= 0 and var_35_10 or var_35_10 * (utf8.len(var_35_11) / 55)) > 0 and var_35_10 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_9 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_9
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_10, arg_32_1.talkMaxDuration)

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_9) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_9 + var_35_14 and arg_32_1.time_ < var_35_9 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_32_1:InitPlayNodeList()
	end,
	Play325591009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325591009
		arg_36_1.duration_ = 5.97

		local var_36_0 = {
			zh = 3.966,
			ja = 5.966
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
				arg_36_0:Play325591010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = arg_36_1.actors_["1054ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).z)
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles = arg_36_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_36_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).z)
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles = arg_36_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["1054ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect1054ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_39_6 = 0
			local var_39_7 = 0.3

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
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

				local var_39_8 = arg_36_1:GetWordFromCfg(325591009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 12 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 12)

				if (12 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 12)) > 0 and var_39_7 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591009", "story_v_out_325591.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_325591", "325591009", "story_v_out_325591.awb") / 1000

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_325591", "325591009", "story_v_out_325591.awb")

						arg_36_1:RecordAudio("325591009", var_39_13)
						arg_36_1:RecordAudio("325591009", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325591", "325591009", "story_v_out_325591.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325591", "325591009", "story_v_out_325591.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
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
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325591010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325591010
		arg_40_1.duration_ = 5.77

		local var_40_0 = {
			zh = 4.733,
			ja = 5.766
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
				arg_40_0:Play325591011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_43_0 = 0
			local var_43_1 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(325591010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 16 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 16)

				if (16 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 16)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591010", "story_v_out_325591.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_out_325591", "325591010", "story_v_out_325591.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_out_325591", "325591010", "story_v_out_325591.awb")

						arg_40_1:RecordAudio("325591010", var_43_7)
						arg_40_1:RecordAudio("325591010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325591", "325591010", "story_v_out_325591.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325591", "325591010", "story_v_out_325591.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325591011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325591011
		arg_44_1.duration_ = 7.77

		local var_44_0 = {
			zh = 6.733,
			ja = 7.766
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325591012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1054ui_story = arg_44_1.actors_["1054ui_story"].transform.localPosition

				local var_47_0 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_0 then
					var_47_0:EnableDynamicBone(false)
				end
			end

			local var_47_1 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 then
				arg_44_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_44_1.time_ - 0) / var_47_1)
				arg_44_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).z)
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles = arg_44_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 then
				arg_44_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_44_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).z)
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles = arg_44_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_47_2 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(true)
				end
			end

			local var_47_3 = arg_44_1.actors_["6148ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos6148ui_story = var_47_3.localPosition

				local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_4 then
					var_47_4:EnableDynamicBone(false)
				end
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_3.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_44_1.time_ - 0) / var_47_5)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles

				local var_47_6 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_6 then
					var_47_6:EnableDynamicBone(true)
				end
			end

			local var_47_7 = arg_44_1.actors_["6148ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.characterEffect6148ui_story == nil then
				arg_44_1.var_.characterEffect6148ui_story = var_47_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_8 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_8 and not isNil(var_47_7) then
				if arg_44_1.var_.characterEffect6148ui_story and not isNil(var_47_7) then
					arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_8 and arg_44_1.time_ < 0 + var_47_8 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.characterEffect6148ui_story then
				arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_47_10 = arg_44_1.actors_["1054ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_11 and not isNil(var_47_10) then
				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_10) then
					arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_11)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_11 and arg_44_1.time_ < 0 + var_47_11 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect1054ui_story then
				arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_47_12 = 0
			local var_47_13 = 0.8

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(325591011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 32 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 32)

				if (32 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 32)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591011", "story_v_out_325591.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591011", "story_v_out_325591.awb") / 1000

					if var_47_18 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_12
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_325591", "325591011", "story_v_out_325591.awb")

						arg_44_1:RecordAudio("325591011", var_47_19)
						arg_44_1:RecordAudio("325591011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325591", "325591011", "story_v_out_325591.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325591", "325591011", "story_v_out_325591.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_20 and arg_44_1.time_ < var_47_12 + var_47_20 + arg_47_0 then
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

		arg_44_1:InitPlayNodeList()
	end,
	Play325591012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325591012
		arg_48_1.duration_ = 8.57

		local var_48_0 = {
			zh = 8.566,
			ja = 7.833
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
				arg_48_0:Play325591013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_51_0 = 0
			local var_51_1 = 0.95

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
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

				local var_51_2 = arg_48_1:GetWordFromCfg(325591012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 38 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 38)

				if (38 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 38)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591012", "story_v_out_325591.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_325591", "325591012", "story_v_out_325591.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_325591", "325591012", "story_v_out_325591.awb")

						arg_48_1:RecordAudio("325591012", var_51_7)
						arg_48_1:RecordAudio("325591012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325591", "325591012", "story_v_out_325591.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325591", "325591012", "story_v_out_325591.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325591013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325591013
		arg_52_1.duration_ = 5.4

		local var_52_0 = {
			zh = 5.4,
			ja = 4.9
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
				arg_52_0:Play325591014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1054ui_story"]) and arg_52_1.var_.characterEffect1054ui_story == nil then
				arg_52_1.var_.characterEffect1054ui_story = arg_52_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1054ui_story"]) then
				if arg_52_1.var_.characterEffect1054ui_story and not isNil(arg_52_1.actors_["1054ui_story"]) then
					arg_52_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1054ui_story"]) and arg_52_1.var_.characterEffect1054ui_story then
				arg_52_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["6148ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect6148ui_story == nil then
				arg_52_1.var_.characterEffect6148ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect6148ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_52_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect6148ui_story then
				arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_52_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.475

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
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

				local var_55_6 = arg_52_1:GetWordFromCfg(325591013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 19)

				if (19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 19)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591013", "story_v_out_325591.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591013", "story_v_out_325591.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_325591", "325591013", "story_v_out_325591.awb")

						arg_52_1:RecordAudio("325591013", var_55_11)
						arg_52_1:RecordAudio("325591013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325591", "325591013", "story_v_out_325591.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325591", "325591013", "story_v_out_325591.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325591014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325591014
		arg_56_1.duration_ = 4

		local var_56_0 = {
			zh = 3.066,
			ja = 4
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325591015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.2

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:GetWordFromCfg(325591014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 8 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 8)

				if (8 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 8)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591014", "story_v_out_325591.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591014", "story_v_out_325591.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_325591", "325591014", "story_v_out_325591.awb")

						arg_56_1:RecordAudio("325591014", var_59_6)
						arg_56_1:RecordAudio("325591014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325591", "325591014", "story_v_out_325591.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325591", "325591014", "story_v_out_325591.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325591015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325591015
		arg_60_1.duration_ = 5.67

		local var_60_0 = {
			zh = 5.633,
			ja = 5.666
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
				arg_60_0:Play325591016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["6148ui_story"]) and arg_60_1.var_.characterEffect6148ui_story == nil then
				arg_60_1.var_.characterEffect6148ui_story = arg_60_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["6148ui_story"]) then
				if arg_60_1.var_.characterEffect6148ui_story and not isNil(arg_60_1.actors_["6148ui_story"]) then
					arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["6148ui_story"]) and arg_60_1.var_.characterEffect6148ui_story then
				arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1054ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.675

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(325591015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 27 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 27)

				if (27 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 27)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591015", "story_v_out_325591.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591015", "story_v_out_325591.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_325591", "325591015", "story_v_out_325591.awb")

						arg_60_1:RecordAudio("325591015", var_63_11)
						arg_60_1:RecordAudio("325591015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325591", "325591015", "story_v_out_325591.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325591", "325591015", "story_v_out_325591.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325591016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325591016
		arg_64_1.duration_ = 9

		local var_64_0 = {
			zh = 9,
			ja = 8.833
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
				arg_64_0:Play325591017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if arg_64_1.bgs_.J28h == nil then
				local var_67_0 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J28h")
				var_67_0.name = "J28h"
				var_67_0.transform.parent = arg_64_1.stage_.transform
				var_67_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_.J28h = var_67_0
			end

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				local var_67_1 = arg_64_1.bgs_.J28h

				arg_64_1.bgs_.J28h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_67_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_2 = var_67_1:GetComponent("SpriteRenderer")

				if var_67_2 and var_67_2.sprite then
					local var_67_3 = 2 * (var_67_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_67_1.transform.localScale = Vector3.New(var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "J28h" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_4 = 4

			if 4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			if arg_64_1.time_ >= var_67_4 + 0.3 and arg_64_1.time_ < var_67_4 + 0.3 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_5 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_6 = 2

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 then
				local var_67_7 = Color.New(0, 0, 0)

				var_67_7.a = Mathf.Lerp(0, 1, (arg_64_1.time_ - var_67_5) / var_67_6)
				arg_64_1.mask_.color = var_67_7
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 then
				local var_67_8 = Color.New(0, 0, 0)

				var_67_8.a = 1
				arg_64_1.mask_.color = var_67_8
			end

			local var_67_9 = 2

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_10 = 2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 then
				local var_67_11 = Color.New(0, 0, 0)

				var_67_11.a = Mathf.Lerp(1, 0, (arg_64_1.time_ - var_67_9) / var_67_10)
				arg_64_1.mask_.color = var_67_11
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 then
				local var_67_12 = Color.New(0, 0, 0)

				arg_64_1.mask_.enabled = false
				var_67_12.a = 0
				arg_64_1.mask_.color = var_67_12
			end

			local var_67_13 = arg_64_1.actors_["6148ui_story"].transform

			if 1.96599999815226 < arg_64_1.time_ and arg_64_1.time_ <= 1.96599999815226 + arg_67_0 then
				arg_64_1.var_.moveOldPos6148ui_story = var_67_13.localPosition

				local var_67_14 = GameObjectTools.GetOrAddComponent(var_67_13.gameObject, typeof(DynamicBoneHelper))

				if var_67_14 then
					var_67_14:EnableDynamicBone(false)
				end
			end

			local var_67_15 = 0.001

			if 1.96599999815226 <= arg_64_1.time_ and arg_64_1.time_ < 1.96599999815226 + var_67_15 then
				var_67_13.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 1.96599999815226) / var_67_15)
				var_67_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_13.position).x, (manager.ui.mainCamera.transform.position - var_67_13.position).y, (manager.ui.mainCamera.transform.position - var_67_13.position).z)
				var_67_13.localEulerAngles.z = 0
				var_67_13.localEulerAngles.x = 0
				var_67_13.localEulerAngles = var_67_13.localEulerAngles
			end

			if arg_64_1.time_ >= 1.96599999815226 + var_67_15 and arg_64_1.time_ < 1.96599999815226 + var_67_15 + arg_67_0 then
				var_67_13.localPosition = Vector3.New(0, 100, 0)
				var_67_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_13.position).x, (manager.ui.mainCamera.transform.position - var_67_13.position).y, (manager.ui.mainCamera.transform.position - var_67_13.position).z)
				var_67_13.localEulerAngles.z = 0
				var_67_13.localEulerAngles.x = 0
				var_67_13.localEulerAngles = var_67_13.localEulerAngles

				local var_67_16 = GameObjectTools.GetOrAddComponent(var_67_13.gameObject, typeof(DynamicBoneHelper))

				if var_67_16 then
					var_67_16:EnableDynamicBone(true)
				end
			end

			local var_67_17 = arg_64_1.actors_["1054ui_story"].transform

			if 1.96599999815226 < arg_64_1.time_ and arg_64_1.time_ <= 1.96599999815226 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = var_67_17.localPosition

				local var_67_18 = GameObjectTools.GetOrAddComponent(var_67_17.gameObject, typeof(DynamicBoneHelper))

				if var_67_18 then
					var_67_18:EnableDynamicBone(false)
				end
			end

			local var_67_19 = 0.001

			if 1.96599999815226 <= arg_64_1.time_ and arg_64_1.time_ < 1.96599999815226 + var_67_19 then
				var_67_17.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 1.96599999815226) / var_67_19)
				var_67_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_17.position).x, (manager.ui.mainCamera.transform.position - var_67_17.position).y, (manager.ui.mainCamera.transform.position - var_67_17.position).z)
				var_67_17.localEulerAngles.z = 0
				var_67_17.localEulerAngles.x = 0
				var_67_17.localEulerAngles = var_67_17.localEulerAngles
			end

			if arg_64_1.time_ >= 1.96599999815226 + var_67_19 and arg_64_1.time_ < 1.96599999815226 + var_67_19 + arg_67_0 then
				var_67_17.localPosition = Vector3.New(0, 100, 0)
				var_67_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_17.position).x, (manager.ui.mainCamera.transform.position - var_67_17.position).y, (manager.ui.mainCamera.transform.position - var_67_17.position).z)
				var_67_17.localEulerAngles.z = 0
				var_67_17.localEulerAngles.x = 0
				var_67_17.localEulerAngles = var_67_17.localEulerAngles

				local var_67_20 = GameObjectTools.GetOrAddComponent(var_67_17.gameObject, typeof(DynamicBoneHelper))

				if var_67_20 then
					var_67_20:EnableDynamicBone(true)
				end
			end

			local var_67_21 = arg_64_1.actors_["1054ui_story"]

			if 1.96599999815226 < arg_64_1.time_ and arg_64_1.time_ <= 1.96599999815226 + arg_67_0 and not isNil(var_67_21) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_22 = 0.034000001847744

			if 1.96599999815226 <= arg_64_1.time_ and arg_64_1.time_ < 1.96599999815226 + var_67_22 and not isNil(var_67_21) then
				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_21) then
					arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 1.96599999815226 + var_67_22 and arg_64_1.time_ < 1.96599999815226 + var_67_22 + arg_67_0 and not isNil(var_67_21) and arg_64_1.var_.characterEffect1054ui_story then
				arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_67_24 = arg_64_1.actors_["6148ui_story"]

			if 1.96599999815226 < arg_64_1.time_ and arg_64_1.time_ <= 1.96599999815226 + arg_67_0 and not isNil(var_67_24) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_25 = 0.034000001847744

			if 1.96599999815226 <= arg_64_1.time_ and arg_64_1.time_ < 1.96599999815226 + var_67_25 and not isNil(var_67_24) then
				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_24) then
					arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 1.96599999815226) / var_67_25)
				end
			end

			if arg_64_1.time_ >= 1.96599999815226 + var_67_25 and arg_64_1.time_ < 1.96599999815226 + var_67_25 + arg_67_0 and not isNil(var_67_24) and arg_64_1.var_.characterEffect6148ui_story then
				arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_67_26 = arg_64_1.actors_["1054ui_story"].transform

			if 3.8 < arg_64_1.time_ and arg_64_1.time_ <= 3.8 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = var_67_26.localPosition

				local var_67_27 = GameObjectTools.GetOrAddComponent(var_67_26.gameObject, typeof(DynamicBoneHelper))

				if var_67_27 then
					var_67_27:EnableDynamicBone(false)
				end
			end

			local var_67_28 = 0.001

			if 3.8 <= arg_64_1.time_ and arg_64_1.time_ < 3.8 + var_67_28 then
				var_67_26.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_64_1.time_ - 3.8) / var_67_28)
				var_67_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_26.position).x, (manager.ui.mainCamera.transform.position - var_67_26.position).y, (manager.ui.mainCamera.transform.position - var_67_26.position).z)
				var_67_26.localEulerAngles.z = 0
				var_67_26.localEulerAngles.x = 0
				var_67_26.localEulerAngles = var_67_26.localEulerAngles
			end

			if arg_64_1.time_ >= 3.8 + var_67_28 and arg_64_1.time_ < 3.8 + var_67_28 + arg_67_0 then
				var_67_26.localPosition = Vector3.New(0, -0.985, -6)
				var_67_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_26.position).x, (manager.ui.mainCamera.transform.position - var_67_26.position).y, (manager.ui.mainCamera.transform.position - var_67_26.position).z)
				var_67_26.localEulerAngles.z = 0
				var_67_26.localEulerAngles.x = 0
				var_67_26.localEulerAngles = var_67_26.localEulerAngles

				local var_67_29 = GameObjectTools.GetOrAddComponent(var_67_26.gameObject, typeof(DynamicBoneHelper))

				if var_67_29 then
					var_67_29:EnableDynamicBone(true)
				end
			end

			local var_67_30 = arg_64_1.actors_["1054ui_story"]

			if 3.8 < arg_64_1.time_ and arg_64_1.time_ <= 3.8 + arg_67_0 and not isNil(var_67_30) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_31 = 0.200000002980232

			if 3.8 <= arg_64_1.time_ and arg_64_1.time_ < 3.8 + var_67_31 and not isNil(var_67_30) then
				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_30) then
					arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 3.8 + var_67_31 and arg_64_1.time_ < 3.8 + var_67_31 + arg_67_0 and not isNil(var_67_30) and arg_64_1.var_.characterEffect1054ui_story then
				arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 3.8 < arg_64_1.time_ and arg_64_1.time_ <= 3.8 + arg_67_0 then
				arg_64_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 3.8 < arg_64_1.time_ and arg_64_1.time_ <= 3.8 + arg_67_0 then
				arg_64_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_33 = 4
			local var_67_34 = 0.325

			if 4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_35 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_35:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_36 = arg_64_1:GetWordFromCfg(325591016)
				local var_67_37 = arg_64_1:FormatText(var_67_36.content)

				arg_64_1.text_.text = var_67_37

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_39 = 13 <= 0 and var_67_34 or var_67_34 * (utf8.len(var_67_37) / 13)

				if (13 <= 0 and var_67_34 or var_67_34 * (utf8.len(var_67_37) / 13)) > 0 and var_67_34 < var_67_39 then
					arg_64_1.talkMaxDuration = var_67_39
					var_67_33 = var_67_33 + 0.3

					if var_67_39 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_39 + var_67_33
					end
				end

				arg_64_1.text_.text = var_67_37
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591016", "story_v_out_325591.awb") ~= 0 then
					local var_67_40 = manager.audio:GetVoiceLength("story_v_out_325591", "325591016", "story_v_out_325591.awb") / 1000

					if var_67_40 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_40 + var_67_33
					end

					if var_67_36.prefab_name ~= "" and arg_64_1.actors_[var_67_36.prefab_name] ~= nil then
						local var_67_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_36.prefab_name].transform, "story_v_out_325591", "325591016", "story_v_out_325591.awb")

						arg_64_1:RecordAudio("325591016", var_67_41)
						arg_64_1:RecordAudio("325591016", var_67_41)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325591", "325591016", "story_v_out_325591.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325591", "325591016", "story_v_out_325591.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_42 = var_67_33 + 0.3
			local var_67_43 = math.max(var_67_34, arg_64_1.talkMaxDuration)

			if var_67_33 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_42 + var_67_43 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_42) / var_67_43

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_42 + var_67_43 and arg_64_1.time_ < var_67_42 + var_67_43 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325591017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325591017
		arg_70_1.duration_ = 4.23

		local var_70_0 = {
			zh = 4.233,
			ja = 3.3
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
				arg_70_0:Play325591018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1054ui_story = arg_70_1.actors_["1054ui_story"].transform.localPosition

				local var_73_0 = GameObjectTools.GetOrAddComponent(arg_70_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_73_0 then
					var_73_0:EnableDynamicBone(false)
				end
			end

			local var_73_1 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_1 then
				arg_70_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_70_1.time_ - 0) / var_73_1)
				arg_70_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).z)
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles = arg_70_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_1 and arg_70_1.time_ < 0 + var_73_1 + arg_73_0 then
				arg_70_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_70_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).z)
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles = arg_70_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_73_2 = GameObjectTools.GetOrAddComponent(arg_70_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(true)
				end
			end

			local var_73_3 = arg_70_1.actors_["6148ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos6148ui_story = var_73_3.localPosition

				local var_73_4 = GameObjectTools.GetOrAddComponent(var_73_3.gameObject, typeof(DynamicBoneHelper))

				if var_73_4 then
					var_73_4:EnableDynamicBone(false)
				end
			end

			local var_73_5 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_5 then
				var_73_3.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_70_1.time_ - 0) / var_73_5)
				var_73_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_3.position).x, (manager.ui.mainCamera.transform.position - var_73_3.position).y, (manager.ui.mainCamera.transform.position - var_73_3.position).z)
				var_73_3.localEulerAngles.z = 0
				var_73_3.localEulerAngles.x = 0
				var_73_3.localEulerAngles = var_73_3.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_5 and arg_70_1.time_ < 0 + var_73_5 + arg_73_0 then
				var_73_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_73_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_3.position).x, (manager.ui.mainCamera.transform.position - var_73_3.position).y, (manager.ui.mainCamera.transform.position - var_73_3.position).z)
				var_73_3.localEulerAngles.z = 0
				var_73_3.localEulerAngles.x = 0
				var_73_3.localEulerAngles = var_73_3.localEulerAngles

				local var_73_6 = GameObjectTools.GetOrAddComponent(var_73_3.gameObject, typeof(DynamicBoneHelper))

				if var_73_6 then
					var_73_6:EnableDynamicBone(true)
				end
			end

			local var_73_7 = arg_70_1.actors_["6148ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_7) and arg_70_1.var_.characterEffect6148ui_story == nil then
				arg_70_1.var_.characterEffect6148ui_story = var_73_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_8 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_8 and not isNil(var_73_7) then
				if arg_70_1.var_.characterEffect6148ui_story and not isNil(var_73_7) then
					arg_70_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_8 and arg_70_1.time_ < 0 + var_73_8 + arg_73_0 and not isNil(var_73_7) and arg_70_1.var_.characterEffect6148ui_story then
				arg_70_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_73_10 = arg_70_1.actors_["1054ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_10) and arg_70_1.var_.characterEffect1054ui_story == nil then
				arg_70_1.var_.characterEffect1054ui_story = var_73_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_11 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_11 and not isNil(var_73_10) then
				if arg_70_1.var_.characterEffect1054ui_story and not isNil(var_73_10) then
					arg_70_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_11)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_11 and arg_70_1.time_ < 0 + var_73_11 + arg_73_0 and not isNil(var_73_10) and arg_70_1.var_.characterEffect1054ui_story then
				arg_70_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_73_12 = 0
			local var_73_13 = 0.45

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_14 = arg_70_1:GetWordFromCfg(325591017)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 18 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 18)

				if (18 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 18)) > 0 and var_73_13 < var_73_17 then
					arg_70_1.talkMaxDuration = var_73_17

					if var_73_17 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_17 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591017", "story_v_out_325591.awb") ~= 0 then
					local var_73_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591017", "story_v_out_325591.awb") / 1000

					if var_73_18 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_12
					end

					if var_73_14.prefab_name ~= "" and arg_70_1.actors_[var_73_14.prefab_name] ~= nil then
						local var_73_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_14.prefab_name].transform, "story_v_out_325591", "325591017", "story_v_out_325591.awb")

						arg_70_1:RecordAudio("325591017", var_73_19)
						arg_70_1:RecordAudio("325591017", var_73_19)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325591", "325591017", "story_v_out_325591.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325591", "325591017", "story_v_out_325591.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_20 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_20 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_20

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_20 and arg_70_1.time_ < var_73_12 + var_73_20 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play325591018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325591018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325591019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos6148ui_story = arg_74_1.actors_["6148ui_story"].transform.localPosition

				local var_77_0 = GameObjectTools.GetOrAddComponent(arg_74_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_77_0 then
					var_77_0:EnableDynamicBone(false)
				end
			end

			local var_77_1 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_1 then
				arg_74_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_1)
				arg_74_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["6148ui_story"].transform.position).z)
				arg_74_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["6148ui_story"].transform.localEulerAngles = arg_74_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_1 and arg_74_1.time_ < 0 + var_77_1 + arg_77_0 then
				arg_74_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["6148ui_story"].transform.position).z)
				arg_74_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["6148ui_story"].transform.localEulerAngles = arg_74_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_77_2 = GameObjectTools.GetOrAddComponent(arg_74_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(true)
				end
			end

			local var_77_3 = arg_74_1.actors_["1054ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1054ui_story = var_77_3.localPosition

				local var_77_4 = GameObjectTools.GetOrAddComponent(var_77_3.gameObject, typeof(DynamicBoneHelper))

				if var_77_4 then
					var_77_4:EnableDynamicBone(false)
				end
			end

			local var_77_5 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_5 then
				var_77_3.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_5)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_5 and arg_74_1.time_ < 0 + var_77_5 + arg_77_0 then
				var_77_3.localPosition = Vector3.New(0, 100, 0)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles

				local var_77_6 = GameObjectTools.GetOrAddComponent(var_77_3.gameObject, typeof(DynamicBoneHelper))

				if var_77_6 then
					var_77_6:EnableDynamicBone(true)
				end
			end

			local var_77_7 = arg_74_1.actors_["6148ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_7) and arg_74_1.var_.characterEffect6148ui_story == nil then
				arg_74_1.var_.characterEffect6148ui_story = var_77_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_8 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_8 and not isNil(var_77_7) then
				if arg_74_1.var_.characterEffect6148ui_story and not isNil(var_77_7) then
					arg_74_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_74_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_8)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_8 and arg_74_1.time_ < 0 + var_77_8 + arg_77_0 and not isNil(var_77_7) and arg_74_1.var_.characterEffect6148ui_story then
				arg_74_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_74_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_77_9 = 0
			local var_77_10 = 1.325

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_11 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(325591018).content)

				arg_74_1.text_.text = var_77_11

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 53 <= 0 and var_77_10 or var_77_10 * (utf8.len(var_77_11) / 53)

				if (53 <= 0 and var_77_10 or var_77_10 * (utf8.len(var_77_11) / 53)) > 0 and var_77_10 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_9 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_9
					end
				end

				arg_74_1.text_.text = var_77_11
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_10, arg_74_1.talkMaxDuration)

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_9) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_9 + var_77_14 and arg_74_1.time_ < var_77_9 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_74_1:InitPlayNodeList()
	end,
	Play325591019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325591019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325591020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.95

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(325591019).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 38 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 38)

				if (38 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 38)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325591020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325591020
		arg_82_1.duration_ = 6.8

		local var_82_0 = {
			zh = 6.8,
			ja = 6
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
				arg_82_0:Play325591021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1054ui_story = arg_82_1.actors_["1054ui_story"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).z)
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles = arg_82_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_82_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).z)
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles = arg_82_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = arg_82_1.actors_["1054ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1054ui_story == nil then
				arg_82_1.var_.characterEffect1054ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect1054ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1054ui_story then
				arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_85_6 = 0
			local var_85_7 = 0.5

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(325591020)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 20 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 20)

				if (20 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 20)) > 0 and var_85_7 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591020", "story_v_out_325591.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_325591", "325591020", "story_v_out_325591.awb") / 1000

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_out_325591", "325591020", "story_v_out_325591.awb")

						arg_82_1:RecordAudio("325591020", var_85_13)
						arg_82_1:RecordAudio("325591020", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325591", "325591020", "story_v_out_325591.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325591", "325591020", "story_v_out_325591.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play325591021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325591021
		arg_86_1.duration_ = 9.63

		local var_86_0 = {
			zh = 5.6,
			ja = 9.633
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
				arg_86_0:Play325591022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = arg_86_1.actors_["1054ui_story"].transform.localPosition

				local var_89_0 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_0 then
					var_89_0:EnableDynamicBone(false)
				end
			end

			local var_89_1 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_1 then
				arg_86_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_86_1.time_ - 0) / var_89_1)
				arg_86_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).z)
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles = arg_86_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_1 and arg_86_1.time_ < 0 + var_89_1 + arg_89_0 then
				arg_86_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_86_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).z)
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles = arg_86_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_89_2 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(true)
				end
			end

			local var_89_3 = arg_86_1.actors_["6148ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos6148ui_story = var_89_3.localPosition

				local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_3.gameObject, typeof(DynamicBoneHelper))

				if var_89_4 then
					var_89_4:EnableDynamicBone(false)
				end
			end

			local var_89_5 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 then
				var_89_3.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_86_1.time_ - 0) / var_89_5)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 then
				var_89_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles

				local var_89_6 = GameObjectTools.GetOrAddComponent(var_89_3.gameObject, typeof(DynamicBoneHelper))

				if var_89_6 then
					var_89_6:EnableDynamicBone(true)
				end
			end

			local var_89_7 = arg_86_1.actors_["6148ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_7) and arg_86_1.var_.characterEffect6148ui_story == nil then
				arg_86_1.var_.characterEffect6148ui_story = var_89_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_8 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_8 and not isNil(var_89_7) then
				if arg_86_1.var_.characterEffect6148ui_story and not isNil(var_89_7) then
					arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_8 and arg_86_1.time_ < 0 + var_89_8 + arg_89_0 and not isNil(var_89_7) and arg_86_1.var_.characterEffect6148ui_story then
				arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_89_10 = arg_86_1.actors_["1054ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_10) and arg_86_1.var_.characterEffect1054ui_story == nil then
				arg_86_1.var_.characterEffect1054ui_story = var_89_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_11 and not isNil(var_89_10) then
				if arg_86_1.var_.characterEffect1054ui_story and not isNil(var_89_10) then
					arg_86_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_11)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_11 and arg_86_1.time_ < 0 + var_89_11 + arg_89_0 and not isNil(var_89_10) and arg_86_1.var_.characterEffect1054ui_story then
				arg_86_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_89_12 = 0
			local var_89_13 = 0.675

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_14 = arg_86_1:GetWordFromCfg(325591021)
				local var_89_15 = arg_86_1:FormatText(var_89_14.content)

				arg_86_1.text_.text = var_89_15

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 27 <= 0 and var_89_13 or var_89_13 * (utf8.len(var_89_15) / 27)

				if (27 <= 0 and var_89_13 or var_89_13 * (utf8.len(var_89_15) / 27)) > 0 and var_89_13 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17

					if var_89_17 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_15
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591021", "story_v_out_325591.awb") ~= 0 then
					local var_89_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591021", "story_v_out_325591.awb") / 1000

					if var_89_18 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_12
					end

					if var_89_14.prefab_name ~= "" and arg_86_1.actors_[var_89_14.prefab_name] ~= nil then
						local var_89_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_14.prefab_name].transform, "story_v_out_325591", "325591021", "story_v_out_325591.awb")

						arg_86_1:RecordAudio("325591021", var_89_19)
						arg_86_1:RecordAudio("325591021", var_89_19)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325591", "325591021", "story_v_out_325591.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325591", "325591021", "story_v_out_325591.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_20 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_20 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_12) / var_89_20

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_12 + var_89_20 and arg_86_1.time_ < var_89_12 + var_89_20 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play325591022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325591022
		arg_90_1.duration_ = 8.7

		local var_90_0 = {
			zh = 8.7,
			ja = 8.066
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
				arg_90_0:Play325591023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action445")
			end

			local var_93_0 = 0
			local var_93_1 = 1.025

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(325591022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 41 <= 0 and var_93_1 or var_93_1 * (utf8.len(var_93_3) / 41)

				if (41 <= 0 and var_93_1 or var_93_1 * (utf8.len(var_93_3) / 41)) > 0 and var_93_1 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591022", "story_v_out_325591.awb") ~= 0 then
					local var_93_6 = manager.audio:GetVoiceLength("story_v_out_325591", "325591022", "story_v_out_325591.awb") / 1000

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end

					if var_93_2.prefab_name ~= "" and arg_90_1.actors_[var_93_2.prefab_name] ~= nil then
						local var_93_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_2.prefab_name].transform, "story_v_out_325591", "325591022", "story_v_out_325591.awb")

						arg_90_1:RecordAudio("325591022", var_93_7)
						arg_90_1:RecordAudio("325591022", var_93_7)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325591", "325591022", "story_v_out_325591.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325591", "325591022", "story_v_out_325591.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_8 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_8 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_8

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_8 and arg_90_1.time_ < var_93_0 + var_93_8 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325591023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325591023
		arg_94_1.duration_ = 9.73

		local var_94_0 = {
			zh = 6.3,
			ja = 9.733
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
				arg_94_0:Play325591024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1054ui_story"]) and arg_94_1.var_.characterEffect1054ui_story == nil then
				arg_94_1.var_.characterEffect1054ui_story = arg_94_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1054ui_story"]) then
				if arg_94_1.var_.characterEffect1054ui_story and not isNil(arg_94_1.actors_["1054ui_story"]) then
					arg_94_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1054ui_story"]) and arg_94_1.var_.characterEffect1054ui_story then
				arg_94_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["6148ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect6148ui_story == nil then
				arg_94_1.var_.characterEffect6148ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect6148ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_94_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect6148ui_story then
				arg_94_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_94_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_97_4 = 0
			local var_97_5 = 0.6

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(325591023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 24 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 24)

				if (24 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 24)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591023", "story_v_out_325591.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591023", "story_v_out_325591.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_325591", "325591023", "story_v_out_325591.awb")

						arg_94_1:RecordAudio("325591023", var_97_11)
						arg_94_1:RecordAudio("325591023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325591", "325591023", "story_v_out_325591.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325591", "325591023", "story_v_out_325591.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325591024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325591024
		arg_98_1.duration_ = 7

		local var_98_0 = {
			zh = 6.166,
			ja = 7
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
				arg_98_0:Play325591025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["6148ui_story"]) and arg_98_1.var_.characterEffect6148ui_story == nil then
				arg_98_1.var_.characterEffect6148ui_story = arg_98_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["6148ui_story"]) then
				if arg_98_1.var_.characterEffect6148ui_story and not isNil(arg_98_1.actors_["6148ui_story"]) then
					arg_98_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["6148ui_story"]) and arg_98_1.var_.characterEffect6148ui_story then
				arg_98_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["1054ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1054ui_story == nil then
				arg_98_1.var_.characterEffect1054ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect1054ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1054ui_story then
				arg_98_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_101_4 = 0
			local var_101_5 = 0.675

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(325591024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 27 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 27)

				if (27 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 27)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591024", "story_v_out_325591.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591024", "story_v_out_325591.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_325591", "325591024", "story_v_out_325591.awb")

						arg_98_1:RecordAudio("325591024", var_101_11)
						arg_98_1:RecordAudio("325591024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325591", "325591024", "story_v_out_325591.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325591", "325591024", "story_v_out_325591.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325591025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325591025
		arg_102_1.duration_ = 4.3

		local var_102_0 = {
			zh = 4.3,
			ja = 3.933
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
				arg_102_0:Play325591026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1054ui_story"]) and arg_102_1.var_.characterEffect1054ui_story == nil then
				arg_102_1.var_.characterEffect1054ui_story = arg_102_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1054ui_story"]) then
				if arg_102_1.var_.characterEffect1054ui_story and not isNil(arg_102_1.actors_["1054ui_story"]) then
					arg_102_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1054ui_story"]) and arg_102_1.var_.characterEffect1054ui_story then
				arg_102_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["6148ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect6148ui_story == nil then
				arg_102_1.var_.characterEffect6148ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect6148ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_102_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect6148ui_story then
				arg_102_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_102_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_102_1.time_ and arg_102_1.time_ <= 0.1 + arg_105_0 then
				arg_102_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_blast", "")
			end

			local var_105_5 = 0
			local var_105_6 = 0.35

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:GetWordFromCfg(325591025)
				local var_105_8 = arg_102_1:FormatText(var_105_7.content)

				arg_102_1.text_.text = var_105_8

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_10 = 14 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 14)

				if (14 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 14)) > 0 and var_105_6 < var_105_10 then
					arg_102_1.talkMaxDuration = var_105_10

					if var_105_10 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_8
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591025", "story_v_out_325591.awb") ~= 0 then
					local var_105_11 = manager.audio:GetVoiceLength("story_v_out_325591", "325591025", "story_v_out_325591.awb") / 1000

					if var_105_11 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_5
					end

					if var_105_7.prefab_name ~= "" and arg_102_1.actors_[var_105_7.prefab_name] ~= nil then
						local var_105_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_7.prefab_name].transform, "story_v_out_325591", "325591025", "story_v_out_325591.awb")

						arg_102_1:RecordAudio("325591025", var_105_12)
						arg_102_1:RecordAudio("325591025", var_105_12)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325591", "325591025", "story_v_out_325591.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325591", "325591025", "story_v_out_325591.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_13 = math.max(var_105_6, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_13 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_5) / var_105_13

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_13 and arg_102_1.time_ < var_105_5 + var_105_13 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325591026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325591026
		arg_106_1.duration_ = 4.9

		local var_106_0 = {
			zh = 4.9,
			ja = 4.733
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
				arg_106_0:Play325591027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_109_0 = 0
			local var_109_1 = 0.475

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(325591026)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 19 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 19)

				if (19 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 19)) > 0 and var_109_1 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591026", "story_v_out_325591.awb") ~= 0 then
					local var_109_6 = manager.audio:GetVoiceLength("story_v_out_325591", "325591026", "story_v_out_325591.awb") / 1000

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end

					if var_109_2.prefab_name ~= "" and arg_106_1.actors_[var_109_2.prefab_name] ~= nil then
						local var_109_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_2.prefab_name].transform, "story_v_out_325591", "325591026", "story_v_out_325591.awb")

						arg_106_1:RecordAudio("325591026", var_109_7)
						arg_106_1:RecordAudio("325591026", var_109_7)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325591", "325591026", "story_v_out_325591.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325591", "325591026", "story_v_out_325591.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325591027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325591027
		arg_110_1.duration_ = 7.85

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325591028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_9000

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos6148ui_story = arg_110_1.actors_["6148ui_story"].transform.localPosition

				local var_113_0 = GameObjectTools.GetOrAddComponent(arg_110_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_113_0 then
					var_113_0:EnableDynamicBone(false)
				end
			end

			local var_113_1 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_1 then
				arg_110_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_1)
				arg_110_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["6148ui_story"].transform.position).z)
				arg_110_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["6148ui_story"].transform.localEulerAngles = arg_110_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_1 and arg_110_1.time_ < 0 + var_113_1 + arg_113_0 then
				arg_110_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["6148ui_story"].transform.position).z)
				arg_110_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["6148ui_story"].transform.localEulerAngles = arg_110_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_113_2 = GameObjectTools.GetOrAddComponent(arg_110_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(true)
				end
			end

			local var_113_3 = arg_110_1.actors_["1054ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1054ui_story = var_113_3.localPosition

				local var_113_4 = GameObjectTools.GetOrAddComponent(var_113_3.gameObject, typeof(DynamicBoneHelper))

				if var_113_4 then
					var_113_4:EnableDynamicBone(false)
				end
			end

			local var_113_5 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_5 then
				var_113_3.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_5)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_5 and arg_110_1.time_ < 0 + var_113_5 + arg_113_0 then
				var_113_3.localPosition = Vector3.New(0, 100, 0)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles

				local var_113_6 = GameObjectTools.GetOrAddComponent(var_113_3.gameObject, typeof(DynamicBoneHelper))

				if var_113_6 then
					var_113_6:EnableDynamicBone(true)
				end
			end

			local var_113_7 = arg_110_1.actors_["1054ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_7) and arg_110_1.var_.characterEffect1054ui_story == nil then
				arg_110_1.var_.characterEffect1054ui_story = var_113_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_8 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_8 and not isNil(var_113_7) then
				if arg_110_1.var_.characterEffect1054ui_story and not isNil(var_113_7) then
					arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_8)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_8 and arg_110_1.time_ < 0 + var_113_8 + arg_113_0 and not isNil(var_113_7) and arg_110_1.var_.characterEffect1054ui_story then
				arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_113_9 = manager.ui.mainCamera.transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.shakeOldPos = var_113_9.localPosition
			end

			local var_113_10 = 2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_10 then
				local var_113_11, var_113_12 = math.modf((arg_110_1.time_ - 0) / 0.066)

				var_113_9.localPosition = Vector3.New(var_113_12 * 0.13, var_113_12 * 0.13, var_113_12 * 0.13) + arg_110_1.var_.shakeOldPos
			end

			if arg_110_1.time_ >= 0 + var_113_10 and arg_110_1.time_ < 0 + var_113_10 + arg_113_0 then
				var_113_9.localPosition = arg_110_1.var_.shakeOldPos
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				local var_113_13 = arg_110_1.var_.effectdidongshanyao1

				if not arg_110_1.var_.effectdidongshanyao1 then
					var_113_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), manager.ui.mainCamera.transform)
					var_113_13.name = "didongshanyao1"
					arg_110_1.var_.effectdidongshanyao1 = var_113_13
				else
					var_113_13.transform:SetParent(var_113_9000)
				end

				var_113_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_113_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.83333333333333 < arg_110_1.time_ and arg_110_1.time_ <= 3.83333333333333 + arg_113_0 then
				if arg_110_1.var_.effectdidongshanyao1 then
					Object.Destroy(arg_110_1.var_.effectdidongshanyao1)

					arg_110_1.var_.effectdidongshanyao1 = nil
				end
			end

			local var_113_16 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_16 + 4.299999999999 and arg_110_1.time_ < var_113_16 + 4.299999999999 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_17 = 2.849999999999
			local var_113_18 = 1.45

			if 2.849999999999 < arg_110_1.time_ and arg_110_1.time_ <= var_113_17 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_19 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_19:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_20 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(325591027).content)

				arg_110_1.text_.text = var_113_20

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_22 = 58 <= 0 and var_113_18 or var_113_18 * (utf8.len(var_113_20) / 58)

				if (58 <= 0 and var_113_18 or var_113_18 * (utf8.len(var_113_20) / 58)) > 0 and var_113_18 < var_113_22 then
					arg_110_1.talkMaxDuration = var_113_22
					var_113_17 = var_113_17 + 0.3

					if var_113_22 + var_113_17 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_17
					end
				end

				arg_110_1.text_.text = var_113_20
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_23 = var_113_17 + 0.3
			local var_113_24 = math.max(var_113_18, arg_110_1.talkMaxDuration)

			if var_113_17 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_24 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_23) / var_113_24

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_110_1:InitPlayNodeList()
	end,
	Play325591028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325591028
		arg_116_1.duration_ = 7.5

		local var_116_0 = {
			zh = 5.3,
			ja = 7.5
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
				arg_116_0:Play325591029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos6148ui_story = arg_116_1.actors_["6148ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["6148ui_story"].transform.position).z)
				arg_116_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["6148ui_story"].transform.localEulerAngles = arg_116_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_116_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["6148ui_story"].transform.position).z)
				arg_116_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["6148ui_story"].transform.localEulerAngles = arg_116_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			local var_119_3 = arg_116_1.actors_["6148ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect6148ui_story == nil then
				arg_116_1.var_.characterEffect6148ui_story = var_119_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.characterEffect6148ui_story and not isNil(var_119_3) then
					arg_116_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect6148ui_story then
				arg_116_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_119_6 = 0
			local var_119_7 = 0.55

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:GetWordFromCfg(325591028)
				local var_119_9 = arg_116_1:FormatText(var_119_8.content)

				arg_116_1.text_.text = var_119_9

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 22 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_9) / 22)

				if (22 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_9) / 22)) > 0 and var_119_7 < var_119_11 then
					arg_116_1.talkMaxDuration = var_119_11

					if var_119_11 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_9
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591028", "story_v_out_325591.awb") ~= 0 then
					local var_119_12 = manager.audio:GetVoiceLength("story_v_out_325591", "325591028", "story_v_out_325591.awb") / 1000

					if var_119_12 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_6
					end

					if var_119_8.prefab_name ~= "" and arg_116_1.actors_[var_119_8.prefab_name] ~= nil then
						local var_119_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_8.prefab_name].transform, "story_v_out_325591", "325591028", "story_v_out_325591.awb")

						arg_116_1:RecordAudio("325591028", var_119_13)
						arg_116_1:RecordAudio("325591028", var_119_13)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_325591", "325591028", "story_v_out_325591.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_325591", "325591028", "story_v_out_325591.awb")
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
				actorName = "6148ui_story",
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
	Play325591029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325591029
		arg_120_1.duration_ = 4.93

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325591030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos6148ui_story = arg_120_1.actors_["6148ui_story"].transform.localPosition

				local var_123_0 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_0 then
					var_123_0:EnableDynamicBone(false)
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_120_1.time_ - 0) / var_123_1)
				arg_120_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["6148ui_story"].transform.position).z)
				arg_120_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["6148ui_story"].transform.localEulerAngles = arg_120_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_120_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["6148ui_story"].transform.position).z)
				arg_120_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["6148ui_story"].transform.localEulerAngles = arg_120_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_123_2 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(true)
				end
			end

			local var_123_3 = arg_120_1.actors_["1054ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1054ui_story = var_123_3.localPosition

				local var_123_4 = GameObjectTools.GetOrAddComponent(var_123_3.gameObject, typeof(DynamicBoneHelper))

				if var_123_4 then
					var_123_4:EnableDynamicBone(false)
				end
			end

			local var_123_5 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_5 then
				var_123_3.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_120_1.time_ - 0) / var_123_5)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_5 and arg_120_1.time_ < 0 + var_123_5 + arg_123_0 then
				var_123_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles

				local var_123_6 = GameObjectTools.GetOrAddComponent(var_123_3.gameObject, typeof(DynamicBoneHelper))

				if var_123_6 then
					var_123_6:EnableDynamicBone(true)
				end
			end

			local var_123_7 = arg_120_1.actors_["1054ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.characterEffect1054ui_story == nil then
				arg_120_1.var_.characterEffect1054ui_story = var_123_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_8 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_8 and not isNil(var_123_7) then
				if arg_120_1.var_.characterEffect1054ui_story and not isNil(var_123_7) then
					arg_120_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_8 and arg_120_1.time_ < 0 + var_123_8 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.characterEffect1054ui_story then
				arg_120_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_123_10 = arg_120_1.actors_["6148ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_10) and arg_120_1.var_.characterEffect6148ui_story == nil then
				arg_120_1.var_.characterEffect6148ui_story = var_123_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_11 and not isNil(var_123_10) then
				if arg_120_1.var_.characterEffect6148ui_story and not isNil(var_123_10) then
					arg_120_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_120_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_11)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_11 and arg_120_1.time_ < 0 + var_123_11 + arg_123_0 and not isNil(var_123_10) and arg_120_1.var_.characterEffect6148ui_story then
				arg_120_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_120_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_123_12 = 0
			local var_123_13 = 0.525

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_14 = arg_120_1:GetWordFromCfg(325591029)
				local var_123_15 = arg_120_1:FormatText(var_123_14.content)

				arg_120_1.text_.text = var_123_15

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_17 = 21 <= 0 and var_123_13 or var_123_13 * (utf8.len(var_123_15) / 21)

				if (21 <= 0 and var_123_13 or var_123_13 * (utf8.len(var_123_15) / 21)) > 0 and var_123_13 < var_123_17 then
					arg_120_1.talkMaxDuration = var_123_17

					if var_123_17 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_17 + var_123_12
					end
				end

				arg_120_1.text_.text = var_123_15
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591029", "story_v_out_325591.awb") ~= 0 then
					local var_123_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591029", "story_v_out_325591.awb") / 1000

					if var_123_18 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_18 + var_123_12
					end

					if var_123_14.prefab_name ~= "" and arg_120_1.actors_[var_123_14.prefab_name] ~= nil then
						local var_123_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_14.prefab_name].transform, "story_v_out_325591", "325591029", "story_v_out_325591.awb")

						arg_120_1:RecordAudio("325591029", var_123_19)
						arg_120_1:RecordAudio("325591029", var_123_19)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_325591", "325591029", "story_v_out_325591.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_325591", "325591029", "story_v_out_325591.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_20 = math.max(var_123_13, arg_120_1.talkMaxDuration)

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_20 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_12) / var_123_20

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_12 + var_123_20 and arg_120_1.time_ < var_123_12 + var_123_20 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_120_1:InitPlayNodeList()
	end,
	Play325591030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325591030
		arg_124_1.duration_ = 2.97

		local var_124_0 = {
			zh = 2.866,
			ja = 2.966
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
				arg_124_0:Play325591031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.2

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(325591030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 8 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 8)

				if (8 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 8)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591030", "story_v_out_325591.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591030", "story_v_out_325591.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_325591", "325591030", "story_v_out_325591.awb")

						arg_124_1:RecordAudio("325591030", var_127_6)
						arg_124_1:RecordAudio("325591030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325591", "325591030", "story_v_out_325591.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325591", "325591030", "story_v_out_325591.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325591031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325591031
		arg_128_1.duration_ = 6.77

		local var_128_0 = {
			zh = 5.1,
			ja = 6.766
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
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325591032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["6148ui_story"]) and arg_128_1.var_.characterEffect6148ui_story == nil then
				arg_128_1.var_.characterEffect6148ui_story = arg_128_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["6148ui_story"]) then
				if arg_128_1.var_.characterEffect6148ui_story and not isNil(arg_128_1.actors_["6148ui_story"]) then
					arg_128_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["6148ui_story"]) and arg_128_1.var_.characterEffect6148ui_story then
				arg_128_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1054ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1054ui_story == nil then
				arg_128_1.var_.characterEffect1054ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1054ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1054ui_story then
				arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_131_4 = 0
			local var_131_5 = 0.525

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(325591031)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 21 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 21)

				if (21 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 21)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591031", "story_v_out_325591.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591031", "story_v_out_325591.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_325591", "325591031", "story_v_out_325591.awb")

						arg_128_1:RecordAudio("325591031", var_131_11)
						arg_128_1:RecordAudio("325591031", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325591", "325591031", "story_v_out_325591.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325591", "325591031", "story_v_out_325591.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325591032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325591032
		arg_132_1.duration_ = 2.47

		local var_132_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325591033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["6148ui_story"]) and arg_132_1.var_.characterEffect6148ui_story == nil then
				arg_132_1.var_.characterEffect6148ui_story = arg_132_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["6148ui_story"]) then
				if arg_132_1.var_.characterEffect6148ui_story and not isNil(arg_132_1.actors_["6148ui_story"]) then
					arg_132_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["6148ui_story"]) and arg_132_1.var_.characterEffect6148ui_story then
				arg_132_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_135_2 = arg_132_1.actors_["1054ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1054ui_story == nil then
				arg_132_1.var_.characterEffect1054ui_story = var_135_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_3 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.characterEffect1054ui_story and not isNil(var_135_2) then
					arg_132_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1054ui_story then
				arg_132_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_135_5 = 0
			local var_135_6 = 0.15

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:GetWordFromCfg(325591032)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 6 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 6)

				if (6 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 6)) > 0 and var_135_6 < var_135_10 then
					arg_132_1.talkMaxDuration = var_135_10

					if var_135_10 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591032", "story_v_out_325591.awb") ~= 0 then
					local var_135_11 = manager.audio:GetVoiceLength("story_v_out_325591", "325591032", "story_v_out_325591.awb") / 1000

					if var_135_11 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_5
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_325591", "325591032", "story_v_out_325591.awb")

						arg_132_1:RecordAudio("325591032", var_135_12)
						arg_132_1:RecordAudio("325591032", var_135_12)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325591", "325591032", "story_v_out_325591.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325591", "325591032", "story_v_out_325591.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_13 = math.max(var_135_6, arg_132_1.talkMaxDuration)

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_13 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_5) / var_135_13

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_5 + var_135_13 and arg_132_1.time_ < var_135_5 + var_135_13 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325591033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325591033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325591034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos6148ui_story = arg_136_1.actors_["6148ui_story"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).z)
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles = arg_136_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).z)
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles = arg_136_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["1054ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1054ui_story = var_139_3.localPosition

				local var_139_4 = GameObjectTools.GetOrAddComponent(var_139_3.gameObject, typeof(DynamicBoneHelper))

				if var_139_4 then
					var_139_4:EnableDynamicBone(false)
				end
			end

			local var_139_5 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_5)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(0, 100, 0)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles

				local var_139_6 = GameObjectTools.GetOrAddComponent(var_139_3.gameObject, typeof(DynamicBoneHelper))

				if var_139_6 then
					var_139_6:EnableDynamicBone(true)
				end
			end

			local var_139_7 = 0
			local var_139_8 = 0.875

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_7 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_9 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(325591033).content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 35 <= 0 and var_139_8 or var_139_8 * (utf8.len(var_139_9) / 35)

				if (35 <= 0 and var_139_8 or var_139_8 * (utf8.len(var_139_9) / 35)) > 0 and var_139_8 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_7 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_7
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_8, arg_136_1.talkMaxDuration)

			if var_139_7 <= arg_136_1.time_ and arg_136_1.time_ < var_139_7 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_7) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_7 + var_139_12 and arg_136_1.time_ < var_139_7 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_136_1:InitPlayNodeList()
	end,
	Play325591034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325591034
		arg_140_1.duration_ = 9

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325591035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 1.999999999999 < arg_140_1.time_ and arg_140_1.time_ <= 1.999999999999 + arg_143_0 then
				local var_143_0 = arg_140_1.bgs_.J28h

				arg_140_1.bgs_.J28h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_143_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_1 = var_143_0:GetComponent("SpriteRenderer")

				if var_143_1 and var_143_1.sprite then
					local var_143_2 = 2 * (var_143_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_143_0.transform.localScale = Vector3.New(var_143_2 / var_143_1.sprite.bounds.size.y < var_143_2 * manager.ui.mainCameraCom_.aspect / var_143_1.sprite.bounds.size.x and var_143_2 * manager.ui.mainCameraCom_.aspect / var_143_1.sprite.bounds.size.x or var_143_2 / var_143_1.sprite.bounds.size.y, var_143_2 / var_143_1.sprite.bounds.size.y < var_143_2 * manager.ui.mainCameraCom_.aspect / var_143_1.sprite.bounds.size.x and var_143_2 * manager.ui.mainCameraCom_.aspect / var_143_1.sprite.bounds.size.x or var_143_2 / var_143_1.sprite.bounds.size.y, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "J28h" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_3 = 3.999999999999

			if 3.999999999999 < arg_140_1.time_ and arg_140_1.time_ <= var_143_3 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			if arg_140_1.time_ >= var_143_3 + 0.3 and arg_140_1.time_ < var_143_3 + 0.3 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_4 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_5 = 2

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_5 then
				local var_143_6 = Color.New(0, 0, 0)

				var_143_6.a = Mathf.Lerp(0, 1, (arg_140_1.time_ - var_143_4) / var_143_5)
				arg_140_1.mask_.color = var_143_6
			end

			if arg_140_1.time_ >= var_143_4 + var_143_5 and arg_140_1.time_ < var_143_4 + var_143_5 + arg_143_0 then
				local var_143_7 = Color.New(0, 0, 0)

				var_143_7.a = 1
				arg_140_1.mask_.color = var_143_7
			end

			local var_143_8 = 2

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_9 = 2

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_9 then
				local var_143_10 = Color.New(0, 0, 0)

				var_143_10.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_8) / var_143_9)
				arg_140_1.mask_.color = var_143_10
			end

			if arg_140_1.time_ >= var_143_8 + var_143_9 and arg_140_1.time_ < var_143_8 + var_143_9 + arg_143_0 then
				local var_143_11 = Color.New(0, 0, 0)

				arg_140_1.mask_.enabled = false
				var_143_11.a = 0
				arg_140_1.mask_.color = var_143_11
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_12 = 3.999999999999
			local var_143_13 = 1.5

			if 3.999999999999 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_14 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_14:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_140_1.dialogCg_.alpha = arg_144_0
				end))
				var_143_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_15 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(325591034).content)

				arg_140_1.text_.text = var_143_15

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 60 <= 0 and var_143_13 or var_143_13 * (utf8.len(var_143_15) / 60)

				if (60 <= 0 and var_143_13 or var_143_13 * (utf8.len(var_143_15) / 60)) > 0 and var_143_13 < var_143_17 then
					arg_140_1.talkMaxDuration = var_143_17
					var_143_12 = var_143_12 + 0.3

					if var_143_17 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_17 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_15
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_18 = var_143_12 + 0.3
			local var_143_19 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 + 0.3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_18 + var_143_19 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_18) / var_143_19

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_18 + var_143_19 and arg_140_1.time_ < var_143_18 + var_143_19 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325591035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325591035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325591036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1.65

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

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(325591035).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 66 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 66)

				if (66 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 66)) > 0 and var_149_0 < var_149_3 then
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
	Play325591036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325591036
		arg_150_1.duration_ = 5.3

		local var_150_0 = {
			zh = 5.1,
			ja = 5.3
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
				arg_150_0:Play325591037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.actors_["10176ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10176ui_story"))) then
				local var_153_0 = Object.Instantiate(Asset.Load("Char/" .. "10176ui_story"), arg_150_1.stage_.transform)

				var_153_0.name = "10176ui_story"
				var_153_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["10176ui_story"] = var_153_0

				local var_153_1 = var_153_0:GetComponentInChildren(typeof(CharacterEffect))

				var_153_1.enabled = true

				local var_153_2 = GameObjectTools.GetOrAddComponent(var_153_0, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(false)
				end

				arg_150_1:ShowWeapon(var_153_1.transform, false)

				arg_150_1.var_["10176ui_story" .. "Animator"] = var_153_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_150_1.var_["10176ui_story" .. "Animator"].applyRootMotion = true
				arg_150_1.var_["10176ui_story" .. "LipSync"] = var_153_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_153_3 = arg_150_1.actors_["10176ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10176ui_story = var_153_3.localPosition

				local var_153_4 = GameObjectTools.GetOrAddComponent(var_153_3.gameObject, typeof(DynamicBoneHelper))

				if var_153_4 then
					var_153_4:EnableDynamicBone(false)
				end
			end

			local var_153_5 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_5 then
				var_153_3.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_150_1.time_ - 0) / var_153_5)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_5 and arg_150_1.time_ < 0 + var_153_5 + arg_153_0 then
				var_153_3.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles

				local var_153_6 = GameObjectTools.GetOrAddComponent(var_153_3.gameObject, typeof(DynamicBoneHelper))

				if var_153_6 then
					var_153_6:EnableDynamicBone(true)
				end
			end

			local var_153_7 = arg_150_1.actors_["10176ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_7) and arg_150_1.var_.characterEffect10176ui_story == nil then
				arg_150_1.var_.characterEffect10176ui_story = var_153_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_8 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_8 and not isNil(var_153_7) then
				if arg_150_1.var_.characterEffect10176ui_story and not isNil(var_153_7) then
					arg_150_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_8 and arg_150_1.time_ < 0 + var_153_8 + arg_153_0 and not isNil(var_153_7) and arg_150_1.var_.characterEffect10176ui_story then
				arg_150_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action2_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_153_10 = 0
			local var_153_11 = 0.5

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_12 = arg_150_1:GetWordFromCfg(325591036)
				local var_153_13 = arg_150_1:FormatText(var_153_12.content)

				arg_150_1.text_.text = var_153_13

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_15 = 20 <= 0 and var_153_11 or var_153_11 * (utf8.len(var_153_13) / 20)

				if (20 <= 0 and var_153_11 or var_153_11 * (utf8.len(var_153_13) / 20)) > 0 and var_153_11 < var_153_15 then
					arg_150_1.talkMaxDuration = var_153_15

					if var_153_15 + var_153_10 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_15 + var_153_10
					end
				end

				arg_150_1.text_.text = var_153_13
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591036", "story_v_out_325591.awb") ~= 0 then
					local var_153_16 = manager.audio:GetVoiceLength("story_v_out_325591", "325591036", "story_v_out_325591.awb") / 1000

					if var_153_16 + var_153_10 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_16 + var_153_10
					end

					if var_153_12.prefab_name ~= "" and arg_150_1.actors_[var_153_12.prefab_name] ~= nil then
						local var_153_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_12.prefab_name].transform, "story_v_out_325591", "325591036", "story_v_out_325591.awb")

						arg_150_1:RecordAudio("325591036", var_153_17)
						arg_150_1:RecordAudio("325591036", var_153_17)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325591", "325591036", "story_v_out_325591.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325591", "325591036", "story_v_out_325591.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_18 = math.max(var_153_11, arg_150_1.talkMaxDuration)

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_18 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_10) / var_153_18

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_10 + var_153_18 and arg_150_1.time_ < var_153_10 + var_153_18 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
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
	Play325591037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325591037
		arg_154_1.duration_ = 5.97

		local var_154_0 = {
			zh = 3.566,
			ja = 5.966
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
				arg_154_0:Play325591038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10176ui_story"]) and arg_154_1.var_.characterEffect10176ui_story == nil then
				arg_154_1.var_.characterEffect10176ui_story = arg_154_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10176ui_story"]) then
				if arg_154_1.var_.characterEffect10176ui_story and not isNil(arg_154_1.actors_["10176ui_story"]) then
					arg_154_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_0)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10176ui_story"]) and arg_154_1.var_.characterEffect10176ui_story then
				arg_154_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_157_1 = 0
			local var_157_2 = 0.4

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:GetWordFromCfg(325591037)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_6 = 16 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_4) / 16)

				if (16 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_4) / 16)) > 0 and var_157_2 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591037", "story_v_out_325591.awb") ~= 0 then
					local var_157_7 = manager.audio:GetVoiceLength("story_v_out_325591", "325591037", "story_v_out_325591.awb") / 1000

					if var_157_7 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_1
					end

					if var_157_3.prefab_name ~= "" and arg_154_1.actors_[var_157_3.prefab_name] ~= nil then
						local var_157_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_3.prefab_name].transform, "story_v_out_325591", "325591037", "story_v_out_325591.awb")

						arg_154_1:RecordAudio("325591037", var_157_8)
						arg_154_1:RecordAudio("325591037", var_157_8)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325591", "325591037", "story_v_out_325591.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325591", "325591037", "story_v_out_325591.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_9 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_9 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_9

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_9 and arg_154_1.time_ < var_157_1 + var_157_9 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play325591038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325591038
		arg_158_1.duration_ = 4.43

		local var_158_0 = {
			zh = 4.166,
			ja = 4.433
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
				arg_158_0:Play325591039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10176ui_story"]) and arg_158_1.var_.characterEffect10176ui_story == nil then
				arg_158_1.var_.characterEffect10176ui_story = arg_158_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10176ui_story"]) then
				if arg_158_1.var_.characterEffect10176ui_story and not isNil(arg_158_1.actors_["10176ui_story"]) then
					arg_158_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10176ui_story"]) and arg_158_1.var_.characterEffect10176ui_story then
				arg_158_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action2_2")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_161_2 = 0
			local var_161_3 = 0.275

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(325591038)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_7 = 11 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 11)

				if (11 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 11)) > 0 and var_161_3 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591038", "story_v_out_325591.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591038", "story_v_out_325591.awb") / 1000

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_out_325591", "325591038", "story_v_out_325591.awb")

						arg_158_1:RecordAudio("325591038", var_161_9)
						arg_158_1:RecordAudio("325591038", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325591", "325591038", "story_v_out_325591.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325591", "325591038", "story_v_out_325591.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_10 and arg_158_1.time_ < var_161_2 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play325591039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325591039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play325591040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos10176ui_story = arg_162_1.actors_["10176ui_story"].transform.localPosition

				local var_165_0 = GameObjectTools.GetOrAddComponent(arg_162_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_165_0 then
					var_165_0:EnableDynamicBone(false)
				end
			end

			local var_165_1 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_1 then
				arg_162_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_1)
				arg_162_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10176ui_story"].transform.position).z)
				arg_162_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["10176ui_story"].transform.localEulerAngles = arg_162_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_1 and arg_162_1.time_ < 0 + var_165_1 + arg_165_0 then
				arg_162_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_162_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10176ui_story"].transform.position).z)
				arg_162_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["10176ui_story"].transform.localEulerAngles = arg_162_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_165_2 = GameObjectTools.GetOrAddComponent(arg_162_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(true)
				end
			end

			local var_165_3 = arg_162_1.actors_["10176ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_3) and arg_162_1.var_.characterEffect10176ui_story == nil then
				arg_162_1.var_.characterEffect10176ui_story = var_165_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_4 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 and not isNil(var_165_3) then
				if arg_162_1.var_.characterEffect10176ui_story and not isNil(var_165_3) then
					arg_162_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_4)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 and not isNil(var_165_3) and arg_162_1.var_.characterEffect10176ui_story then
				arg_162_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_165_5 = manager.ui.mainCamera.transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.shakeOldPos = var_165_5.localPosition
			end

			local var_165_6 = 0.3

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_6 then
				local var_165_7, var_165_8 = math.modf((arg_162_1.time_ - 0) / 0.066)

				var_165_5.localPosition = Vector3.New(var_165_8 * 0.13, var_165_8 * 0.13, var_165_8 * 0.13) + arg_162_1.var_.shakeOldPos
			end

			if arg_162_1.time_ >= 0 + var_165_6 and arg_162_1.time_ < 0 + var_165_6 + arg_165_0 then
				var_165_5.localPosition = arg_162_1.var_.shakeOldPos
			end

			local var_165_9 = 0

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_9 + arg_165_0 then
				arg_162_1.allBtn_.enabled = false
			end

			if arg_162_1.time_ >= var_165_9 + 0.6 and arg_162_1.time_ < var_165_9 + 0.6 + arg_165_0 then
				arg_162_1.allBtn_.enabled = true
			end

			local var_165_10 = 0
			local var_165_11 = 1.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_12 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_12:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_162_1.dialogCg_.alpha = arg_166_0
				end))
				var_165_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_13 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(325591039).content)

				arg_162_1.text_.text = var_165_13

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_15 = 47 <= 0 and var_165_11 or var_165_11 * (utf8.len(var_165_13) / 47)

				if (47 <= 0 and var_165_11 or var_165_11 * (utf8.len(var_165_13) / 47)) > 0 and var_165_11 < var_165_15 then
					arg_162_1.talkMaxDuration = var_165_15
					var_165_10 = var_165_10 + 0.3

					if var_165_15 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_15 + var_165_10
					end
				end

				arg_162_1.text_.text = var_165_13
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = var_165_10 + 0.3
			local var_165_17 = math.max(var_165_11, arg_162_1.talkMaxDuration)

			if var_165_10 + 0.3 <= arg_162_1.time_ and arg_162_1.time_ < var_165_16 + var_165_17 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_16) / var_165_17

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_16 + var_165_17 and arg_162_1.time_ < var_165_16 + var_165_17 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play325591040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325591040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325591041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 1.65

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(325591040).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 66 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 66)

				if (66 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 66)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play325591041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325591041
		arg_172_1.duration_ = 5.9

		local var_172_0 = {
			zh = 5.9,
			ja = 4.2
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325591042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos10176ui_story = arg_172_1.actors_["10176ui_story"].transform.localPosition

				local var_175_0 = GameObjectTools.GetOrAddComponent(arg_172_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_175_0 then
					var_175_0:EnableDynamicBone(false)
				end
			end

			local var_175_1 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_1 then
				arg_172_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_172_1.time_ - 0) / var_175_1)
				arg_172_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["10176ui_story"].transform.position).z)
				arg_172_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["10176ui_story"].transform.localEulerAngles = arg_172_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_1 and arg_172_1.time_ < 0 + var_175_1 + arg_175_0 then
				arg_172_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				arg_172_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["10176ui_story"].transform.position).z)
				arg_172_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["10176ui_story"].transform.localEulerAngles = arg_172_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_175_2 = GameObjectTools.GetOrAddComponent(arg_172_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(true)
				end
			end

			local var_175_3 = arg_172_1.actors_["10176ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_3) and arg_172_1.var_.characterEffect10176ui_story == nil then
				arg_172_1.var_.characterEffect10176ui_story = var_175_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_4 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 and not isNil(var_175_3) then
				if arg_172_1.var_.characterEffect10176ui_story and not isNil(var_175_3) then
					arg_172_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 and not isNil(var_175_3) and arg_172_1.var_.characterEffect10176ui_story then
				arg_172_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_175_6 = 0
			local var_175_7 = 0.525

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_8 = arg_172_1:GetWordFromCfg(325591041)
				local var_175_9 = arg_172_1:FormatText(var_175_8.content)

				arg_172_1.text_.text = var_175_9

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 21 <= 0 and var_175_7 or var_175_7 * (utf8.len(var_175_9) / 21)

				if (21 <= 0 and var_175_7 or var_175_7 * (utf8.len(var_175_9) / 21)) > 0 and var_175_7 < var_175_11 then
					arg_172_1.talkMaxDuration = var_175_11

					if var_175_11 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_9
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591041", "story_v_out_325591.awb") ~= 0 then
					local var_175_12 = manager.audio:GetVoiceLength("story_v_out_325591", "325591041", "story_v_out_325591.awb") / 1000

					if var_175_12 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_6
					end

					if var_175_8.prefab_name ~= "" and arg_172_1.actors_[var_175_8.prefab_name] ~= nil then
						local var_175_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_8.prefab_name].transform, "story_v_out_325591", "325591041", "story_v_out_325591.awb")

						arg_172_1:RecordAudio("325591041", var_175_13)
						arg_172_1:RecordAudio("325591041", var_175_13)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_325591", "325591041", "story_v_out_325591.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_325591", "325591041", "story_v_out_325591.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play325591042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325591042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325591043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10176ui_story = arg_176_1.actors_["10176ui_story"].transform.localPosition

				local var_179_0 = GameObjectTools.GetOrAddComponent(arg_176_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_179_0 then
					var_179_0:EnableDynamicBone(false)
				end
			end

			local var_179_1 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 then
				arg_176_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_176_1.time_ - 0) / var_179_1)
				arg_176_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10176ui_story"].transform.position).z)
				arg_176_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10176ui_story"].transform.localEulerAngles = arg_176_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 then
				arg_176_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_176_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10176ui_story"].transform.position).z)
				arg_176_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10176ui_story"].transform.localEulerAngles = arg_176_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_179_2 = GameObjectTools.GetOrAddComponent(arg_176_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_179_2 then
					var_179_2:EnableDynamicBone(true)
				end
			end

			local var_179_3 = arg_176_1.actors_["10176ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_3) and arg_176_1.var_.characterEffect10176ui_story == nil then
				arg_176_1.var_.characterEffect10176ui_story = var_179_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_4 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 and not isNil(var_179_3) then
				if arg_176_1.var_.characterEffect10176ui_story and not isNil(var_179_3) then
					arg_176_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_4)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 and not isNil(var_179_3) and arg_176_1.var_.characterEffect10176ui_story then
				arg_176_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_179_5 = 0
			local var_179_6 = 1.4

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(325591042).content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 56 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_7) / 56)

				if (56 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_7) / 56)) > 0 and var_179_6 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_6, arg_176_1.talkMaxDuration)

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_5) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_5 + var_179_10 and arg_176_1.time_ < var_179_5 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
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
	Play325591043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325591043
		arg_180_1.duration_ = 4.63

		local var_180_0 = {
			zh = 3.533,
			ja = 4.633
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
				arg_180_0:Play325591044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10176ui_story = arg_180_1.actors_["10176ui_story"].transform.localPosition

				local var_183_0 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_0 then
					var_183_0:EnableDynamicBone(false)
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_180_1.time_ - 0) / var_183_1)
				arg_180_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10176ui_story"].transform.position).z)
				arg_180_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10176ui_story"].transform.localEulerAngles = arg_180_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				arg_180_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10176ui_story"].transform.position).z)
				arg_180_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10176ui_story"].transform.localEulerAngles = arg_180_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_183_2 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(true)
				end
			end

			local var_183_3 = arg_180_1.actors_["10176ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect10176ui_story == nil then
				arg_180_1.var_.characterEffect10176ui_story = var_183_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_4 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 and not isNil(var_183_3) then
				if arg_180_1.var_.characterEffect10176ui_story and not isNil(var_183_3) then
					arg_180_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect10176ui_story then
				arg_180_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_2")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_183_6 = 0
			local var_183_7 = 0.275

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_8 = arg_180_1:GetWordFromCfg(325591043)
				local var_183_9 = arg_180_1:FormatText(var_183_8.content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 11 <= 0 and var_183_7 or var_183_7 * (utf8.len(var_183_9) / 11)

				if (11 <= 0 and var_183_7 or var_183_7 * (utf8.len(var_183_9) / 11)) > 0 and var_183_7 < var_183_11 then
					arg_180_1.talkMaxDuration = var_183_11

					if var_183_11 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591043", "story_v_out_325591.awb") ~= 0 then
					local var_183_12 = manager.audio:GetVoiceLength("story_v_out_325591", "325591043", "story_v_out_325591.awb") / 1000

					if var_183_12 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_6
					end

					if var_183_8.prefab_name ~= "" and arg_180_1.actors_[var_183_8.prefab_name] ~= nil then
						local var_183_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_8.prefab_name].transform, "story_v_out_325591", "325591043", "story_v_out_325591.awb")

						arg_180_1:RecordAudio("325591043", var_183_13)
						arg_180_1:RecordAudio("325591043", var_183_13)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325591", "325591043", "story_v_out_325591.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325591", "325591043", "story_v_out_325591.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play325591044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325591044
		arg_184_1.duration_ = 7.17

		local var_184_0 = {
			zh = 5.4,
			ja = 7.166
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
				arg_184_0:Play325591045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10176ui_story = arg_184_1.actors_["10176ui_story"].transform.localPosition

				local var_187_0 = GameObjectTools.GetOrAddComponent(arg_184_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_187_0 then
					var_187_0:EnableDynamicBone(false)
				end
			end

			local var_187_1 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 then
				arg_184_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10176ui_story, Vector3.New(-0.7, -1.09, -6.12), (arg_184_1.time_ - 0) / var_187_1)
				arg_184_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10176ui_story"].transform.position).z)
				arg_184_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10176ui_story"].transform.localEulerAngles = arg_184_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 then
				arg_184_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -6.12)
				arg_184_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10176ui_story"].transform.position).z)
				arg_184_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10176ui_story"].transform.localEulerAngles = arg_184_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_187_2 = GameObjectTools.GetOrAddComponent(arg_184_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(true)
				end
			end

			local var_187_3 = arg_184_1.actors_["6148ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos6148ui_story = var_187_3.localPosition

				local var_187_4 = GameObjectTools.GetOrAddComponent(var_187_3.gameObject, typeof(DynamicBoneHelper))

				if var_187_4 then
					var_187_4:EnableDynamicBone(false)
				end
			end

			local var_187_5 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_5 then
				var_187_3.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_184_1.time_ - 0) / var_187_5)
				var_187_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_3.position).x, (manager.ui.mainCamera.transform.position - var_187_3.position).y, (manager.ui.mainCamera.transform.position - var_187_3.position).z)
				var_187_3.localEulerAngles.z = 0
				var_187_3.localEulerAngles.x = 0
				var_187_3.localEulerAngles = var_187_3.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_5 and arg_184_1.time_ < 0 + var_187_5 + arg_187_0 then
				var_187_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_187_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_3.position).x, (manager.ui.mainCamera.transform.position - var_187_3.position).y, (manager.ui.mainCamera.transform.position - var_187_3.position).z)
				var_187_3.localEulerAngles.z = 0
				var_187_3.localEulerAngles.x = 0
				var_187_3.localEulerAngles = var_187_3.localEulerAngles

				local var_187_6 = GameObjectTools.GetOrAddComponent(var_187_3.gameObject, typeof(DynamicBoneHelper))

				if var_187_6 then
					var_187_6:EnableDynamicBone(true)
				end
			end

			local var_187_7 = arg_184_1.actors_["6148ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_7) and arg_184_1.var_.characterEffect6148ui_story == nil then
				arg_184_1.var_.characterEffect6148ui_story = var_187_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_8 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_8 and not isNil(var_187_7) then
				if arg_184_1.var_.characterEffect6148ui_story and not isNil(var_187_7) then
					arg_184_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_8 and arg_184_1.time_ < 0 + var_187_8 + arg_187_0 and not isNil(var_187_7) and arg_184_1.var_.characterEffect6148ui_story then
				arg_184_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_187_10 = arg_184_1.actors_["10176ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_10) and arg_184_1.var_.characterEffect10176ui_story == nil then
				arg_184_1.var_.characterEffect10176ui_story = var_187_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_11 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_11 and not isNil(var_187_10) then
				if arg_184_1.var_.characterEffect10176ui_story and not isNil(var_187_10) then
					arg_184_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_184_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_11)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_11 and arg_184_1.time_ < 0 + var_187_11 + arg_187_0 and not isNil(var_187_10) and arg_184_1.var_.characterEffect10176ui_story then
				arg_184_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_184_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_187_12 = 0
			local var_187_13 = 0.625

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_14 = arg_184_1:GetWordFromCfg(325591044)
				local var_187_15 = arg_184_1:FormatText(var_187_14.content)

				arg_184_1.text_.text = var_187_15

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_17 = 25 <= 0 and var_187_13 or var_187_13 * (utf8.len(var_187_15) / 25)

				if (25 <= 0 and var_187_13 or var_187_13 * (utf8.len(var_187_15) / 25)) > 0 and var_187_13 < var_187_17 then
					arg_184_1.talkMaxDuration = var_187_17

					if var_187_17 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_17 + var_187_12
					end
				end

				arg_184_1.text_.text = var_187_15
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591044", "story_v_out_325591.awb") ~= 0 then
					local var_187_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591044", "story_v_out_325591.awb") / 1000

					if var_187_18 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_18 + var_187_12
					end

					if var_187_14.prefab_name ~= "" and arg_184_1.actors_[var_187_14.prefab_name] ~= nil then
						local var_187_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_14.prefab_name].transform, "story_v_out_325591", "325591044", "story_v_out_325591.awb")

						arg_184_1:RecordAudio("325591044", var_187_19)
						arg_184_1:RecordAudio("325591044", var_187_19)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325591", "325591044", "story_v_out_325591.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325591", "325591044", "story_v_out_325591.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_20 = math.max(var_187_13, arg_184_1.talkMaxDuration)

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_20 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_12) / var_187_20

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_12 + var_187_20 and arg_184_1.time_ < var_187_12 + var_187_20 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
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

		arg_184_1:InitPlayNodeList()
	end,
	Play325591045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325591045
		arg_188_1.duration_ = 6.07

		local var_188_0 = {
			zh = 5.966,
			ja = 6.066
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
				arg_188_0:Play325591046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.6

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:GetWordFromCfg(325591045)
				local var_191_2 = arg_188_1:FormatText(var_191_1.content)

				arg_188_1.text_.text = var_191_2

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 24 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 24)

				if (24 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 24)) > 0 and var_191_0 < var_191_4 then
					arg_188_1.talkMaxDuration = var_191_4

					if var_191_4 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_4 + 0
					end
				end

				arg_188_1.text_.text = var_191_2
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591045", "story_v_out_325591.awb") ~= 0 then
					local var_191_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591045", "story_v_out_325591.awb") / 1000

					if var_191_5 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + 0
					end

					if var_191_1.prefab_name ~= "" and arg_188_1.actors_[var_191_1.prefab_name] ~= nil then
						local var_191_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_1.prefab_name].transform, "story_v_out_325591", "325591045", "story_v_out_325591.awb")

						arg_188_1:RecordAudio("325591045", var_191_6)
						arg_188_1:RecordAudio("325591045", var_191_6)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325591", "325591045", "story_v_out_325591.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325591", "325591045", "story_v_out_325591.awb")
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
	Play325591046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325591046
		arg_192_1.duration_ = 5.43

		local var_192_0 = {
			zh = 5.433,
			ja = 4.6
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
				arg_192_0:Play325591047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["10176ui_story"]) and arg_192_1.var_.characterEffect10176ui_story == nil then
				arg_192_1.var_.characterEffect10176ui_story = arg_192_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["10176ui_story"]) then
				if arg_192_1.var_.characterEffect10176ui_story and not isNil(arg_192_1.actors_["10176ui_story"]) then
					arg_192_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["10176ui_story"]) and arg_192_1.var_.characterEffect10176ui_story then
				arg_192_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_195_2 = arg_192_1.actors_["6148ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect6148ui_story == nil then
				arg_192_1.var_.characterEffect6148ui_story = var_195_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_3 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.characterEffect6148ui_story and not isNil(var_195_2) then
					arg_192_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_192_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_3)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect6148ui_story then
				arg_192_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_192_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action7_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_195_4 = 0
			local var_195_5 = 0.475

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(325591046)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 19 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 19)

				if (19 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 19)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591046", "story_v_out_325591.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591046", "story_v_out_325591.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_325591", "325591046", "story_v_out_325591.awb")

						arg_192_1:RecordAudio("325591046", var_195_11)
						arg_192_1:RecordAudio("325591046", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325591", "325591046", "story_v_out_325591.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325591", "325591046", "story_v_out_325591.awb")
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
	Play325591047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325591047
		arg_196_1.duration_ = 5.53

		local var_196_0 = {
			zh = 5.533,
			ja = 5.033
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
				arg_196_0:Play325591048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10176ui_story = arg_196_1.actors_["10176ui_story"].transform.localPosition

				local var_199_0 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_0 then
					var_199_0:EnableDynamicBone(false)
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_196_1.time_ - 0) / var_199_1)
				arg_196_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10176ui_story"].transform.position).z)
				arg_196_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["10176ui_story"].transform.localEulerAngles = arg_196_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10176ui_story"].transform.position).z)
				arg_196_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["10176ui_story"].transform.localEulerAngles = arg_196_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_199_2 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(true)
				end
			end

			local var_199_3 = arg_196_1.actors_["1054ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1054ui_story = var_199_3.localPosition

				local var_199_4 = GameObjectTools.GetOrAddComponent(var_199_3.gameObject, typeof(DynamicBoneHelper))

				if var_199_4 then
					var_199_4:EnableDynamicBone(false)
				end
			end

			local var_199_5 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_5 then
				var_199_3.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_196_1.time_ - 0) / var_199_5)
				var_199_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_3.position).x, (manager.ui.mainCamera.transform.position - var_199_3.position).y, (manager.ui.mainCamera.transform.position - var_199_3.position).z)
				var_199_3.localEulerAngles.z = 0
				var_199_3.localEulerAngles.x = 0
				var_199_3.localEulerAngles = var_199_3.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_5 and arg_196_1.time_ < 0 + var_199_5 + arg_199_0 then
				var_199_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_199_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_3.position).x, (manager.ui.mainCamera.transform.position - var_199_3.position).y, (manager.ui.mainCamera.transform.position - var_199_3.position).z)
				var_199_3.localEulerAngles.z = 0
				var_199_3.localEulerAngles.x = 0
				var_199_3.localEulerAngles = var_199_3.localEulerAngles

				local var_199_6 = GameObjectTools.GetOrAddComponent(var_199_3.gameObject, typeof(DynamicBoneHelper))

				if var_199_6 then
					var_199_6:EnableDynamicBone(true)
				end
			end

			local var_199_7 = arg_196_1.actors_["1054ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.characterEffect1054ui_story == nil then
				arg_196_1.var_.characterEffect1054ui_story = var_199_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_8 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_8 and not isNil(var_199_7) then
				if arg_196_1.var_.characterEffect1054ui_story and not isNil(var_199_7) then
					arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_8 and arg_196_1.time_ < 0 + var_199_8 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.characterEffect1054ui_story then
				arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_199_10 = arg_196_1.actors_["10176ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_10) and arg_196_1.var_.characterEffect10176ui_story == nil then
				arg_196_1.var_.characterEffect10176ui_story = var_199_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_11 and not isNil(var_199_10) then
				if arg_196_1.var_.characterEffect10176ui_story and not isNil(var_199_10) then
					arg_196_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_196_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_11)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_11 and arg_196_1.time_ < 0 + var_199_11 + arg_199_0 and not isNil(var_199_10) and arg_196_1.var_.characterEffect10176ui_story then
				arg_196_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_196_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_199_12 = 0
			local var_199_13 = 0.55

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_14 = arg_196_1:GetWordFromCfg(325591047)
				local var_199_15 = arg_196_1:FormatText(var_199_14.content)

				arg_196_1.text_.text = var_199_15

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_17 = 22 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_15) / 22)

				if (22 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_15) / 22)) > 0 and var_199_13 < var_199_17 then
					arg_196_1.talkMaxDuration = var_199_17

					if var_199_17 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_17 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_15
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591047", "story_v_out_325591.awb") ~= 0 then
					local var_199_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591047", "story_v_out_325591.awb") / 1000

					if var_199_18 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_12
					end

					if var_199_14.prefab_name ~= "" and arg_196_1.actors_[var_199_14.prefab_name] ~= nil then
						local var_199_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_14.prefab_name].transform, "story_v_out_325591", "325591047", "story_v_out_325591.awb")

						arg_196_1:RecordAudio("325591047", var_199_19)
						arg_196_1:RecordAudio("325591047", var_199_19)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325591", "325591047", "story_v_out_325591.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325591", "325591047", "story_v_out_325591.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_20 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_20 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_12) / var_199_20

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_12 + var_199_20 and arg_196_1.time_ < var_199_12 + var_199_20 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_196_1:InitPlayNodeList()
	end,
	Play325591048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325591048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325591049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) and arg_200_1.var_.characterEffect1054ui_story == nil then
				arg_200_1.var_.characterEffect1054ui_story = arg_200_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) then
				if arg_200_1.var_.characterEffect1054ui_story and not isNil(arg_200_1.actors_["1054ui_story"]) then
					arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) and arg_200_1.var_.characterEffect1054ui_story then
				arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_203_1 = 0
			local var_203_2 = 0.85

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_3 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(325591048).content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 34 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 34)

				if (34 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 34)) > 0 and var_203_2 < var_203_5 then
					arg_200_1.talkMaxDuration = var_203_5

					if var_203_5 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + var_203_1
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_6 = math.max(var_203_2, arg_200_1.talkMaxDuration)

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_6 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_1) / var_203_6

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_1 + var_203_6 and arg_200_1.time_ < var_203_1 + var_203_6 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play325591049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325591049
		arg_204_1.duration_ = 12.8

		local var_204_0 = {
			zh = 9.433,
			ja = 12.8
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
				arg_204_0:Play325591050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10176ui_story = arg_204_1.actors_["10176ui_story"].transform.localPosition

				local var_207_0 = GameObjectTools.GetOrAddComponent(arg_204_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_207_0 then
					var_207_0:EnableDynamicBone(false)
				end
			end

			local var_207_1 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_1 then
				arg_204_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_204_1.time_ - 0) / var_207_1)
				arg_204_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10176ui_story"].transform.position).z)
				arg_204_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["10176ui_story"].transform.localEulerAngles = arg_204_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_1 and arg_204_1.time_ < 0 + var_207_1 + arg_207_0 then
				arg_204_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				arg_204_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10176ui_story"].transform.position).z)
				arg_204_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["10176ui_story"].transform.localEulerAngles = arg_204_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_207_2 = GameObjectTools.GetOrAddComponent(arg_204_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_207_2 then
					var_207_2:EnableDynamicBone(true)
				end
			end

			local var_207_3 = arg_204_1.actors_["6148ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos6148ui_story = var_207_3.localPosition

				local var_207_4 = GameObjectTools.GetOrAddComponent(var_207_3.gameObject, typeof(DynamicBoneHelper))

				if var_207_4 then
					var_207_4:EnableDynamicBone(false)
				end
			end

			local var_207_5 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_5 then
				var_207_3.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_5)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_5 and arg_204_1.time_ < 0 + var_207_5 + arg_207_0 then
				var_207_3.localPosition = Vector3.New(0, 100, 0)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles

				local var_207_6 = GameObjectTools.GetOrAddComponent(var_207_3.gameObject, typeof(DynamicBoneHelper))

				if var_207_6 then
					var_207_6:EnableDynamicBone(true)
				end
			end

			local var_207_7 = arg_204_1.actors_["1054ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1054ui_story = var_207_7.localPosition

				local var_207_8 = GameObjectTools.GetOrAddComponent(var_207_7.gameObject, typeof(DynamicBoneHelper))

				if var_207_8 then
					var_207_8:EnableDynamicBone(false)
				end
			end

			local var_207_9 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_9 then
				var_207_7.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_9)
				var_207_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_7.position).x, (manager.ui.mainCamera.transform.position - var_207_7.position).y, (manager.ui.mainCamera.transform.position - var_207_7.position).z)
				var_207_7.localEulerAngles.z = 0
				var_207_7.localEulerAngles.x = 0
				var_207_7.localEulerAngles = var_207_7.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_9 and arg_204_1.time_ < 0 + var_207_9 + arg_207_0 then
				var_207_7.localPosition = Vector3.New(0, 100, 0)
				var_207_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_7.position).x, (manager.ui.mainCamera.transform.position - var_207_7.position).y, (manager.ui.mainCamera.transform.position - var_207_7.position).z)
				var_207_7.localEulerAngles.z = 0
				var_207_7.localEulerAngles.x = 0
				var_207_7.localEulerAngles = var_207_7.localEulerAngles

				local var_207_10 = GameObjectTools.GetOrAddComponent(var_207_7.gameObject, typeof(DynamicBoneHelper))

				if var_207_10 then
					var_207_10:EnableDynamicBone(true)
				end
			end

			local var_207_11 = arg_204_1.actors_["10176ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_11) and arg_204_1.var_.characterEffect10176ui_story == nil then
				arg_204_1.var_.characterEffect10176ui_story = var_207_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_12 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_12 and not isNil(var_207_11) then
				if arg_204_1.var_.characterEffect10176ui_story and not isNil(var_207_11) then
					arg_204_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_12 and arg_204_1.time_ < 0 + var_207_12 + arg_207_0 and not isNil(var_207_11) and arg_204_1.var_.characterEffect10176ui_story then
				arg_204_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_1")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_207_14 = 0
			local var_207_15 = 0.975

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_14 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_16 = arg_204_1:GetWordFromCfg(325591049)
				local var_207_17 = arg_204_1:FormatText(var_207_16.content)

				arg_204_1.text_.text = var_207_17

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_19 = 39 <= 0 and var_207_15 or var_207_15 * (utf8.len(var_207_17) / 39)

				if (39 <= 0 and var_207_15 or var_207_15 * (utf8.len(var_207_17) / 39)) > 0 and var_207_15 < var_207_19 then
					arg_204_1.talkMaxDuration = var_207_19

					if var_207_19 + var_207_14 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_19 + var_207_14
					end
				end

				arg_204_1.text_.text = var_207_17
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591049", "story_v_out_325591.awb") ~= 0 then
					local var_207_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591049", "story_v_out_325591.awb") / 1000

					if var_207_20 + var_207_14 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_20 + var_207_14
					end

					if var_207_16.prefab_name ~= "" and arg_204_1.actors_[var_207_16.prefab_name] ~= nil then
						local var_207_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_16.prefab_name].transform, "story_v_out_325591", "325591049", "story_v_out_325591.awb")

						arg_204_1:RecordAudio("325591049", var_207_21)
						arg_204_1:RecordAudio("325591049", var_207_21)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325591", "325591049", "story_v_out_325591.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325591", "325591049", "story_v_out_325591.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_22 = math.max(var_207_15, arg_204_1.talkMaxDuration)

			if var_207_14 <= arg_204_1.time_ and arg_204_1.time_ < var_207_14 + var_207_22 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_14) / var_207_22

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_14 + var_207_22 and arg_204_1.time_ < var_207_14 + var_207_22 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
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
			},
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

		arg_204_1:InitPlayNodeList()
	end,
	Play325591050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325591050
		arg_208_1.duration_ = 7.47

		local var_208_0 = {
			zh = 6.9,
			ja = 7.466
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
				arg_208_0:Play325591051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.725

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(325591050)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 29 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 29)

				if (29 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 29)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591050", "story_v_out_325591.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591050", "story_v_out_325591.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_325591", "325591050", "story_v_out_325591.awb")

						arg_208_1:RecordAudio("325591050", var_211_6)
						arg_208_1:RecordAudio("325591050", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325591", "325591050", "story_v_out_325591.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325591", "325591050", "story_v_out_325591.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play325591051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325591051
		arg_212_1.duration_ = 8.37

		local var_212_0 = {
			zh = 6.333,
			ja = 8.366
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
				arg_212_0:Play325591052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.625

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(325591051)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 25 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 25)

				if (25 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 25)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591051", "story_v_out_325591.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591051", "story_v_out_325591.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_325591", "325591051", "story_v_out_325591.awb")

						arg_212_1:RecordAudio("325591051", var_215_6)
						arg_212_1:RecordAudio("325591051", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_325591", "325591051", "story_v_out_325591.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_325591", "325591051", "story_v_out_325591.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play325591052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325591052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325591053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10176ui_story = arg_216_1.actors_["10176ui_story"].transform.localPosition

				local var_219_0 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_0 then
					var_219_0:EnableDynamicBone(false)
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_1)
				arg_216_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10176ui_story"].transform.position).z)
				arg_216_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10176ui_story"].transform.localEulerAngles = arg_216_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10176ui_story"].transform.position).z)
				arg_216_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10176ui_story"].transform.localEulerAngles = arg_216_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_219_2 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(true)
				end
			end

			local var_219_3 = arg_216_1.actors_["10176ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10176ui_story == nil then
				arg_216_1.var_.characterEffect10176ui_story = var_219_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_4 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 and not isNil(var_219_3) then
				if arg_216_1.var_.characterEffect10176ui_story and not isNil(var_219_3) then
					arg_216_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_4)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10176ui_story then
				arg_216_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_219_5 = 0
			local var_219_6 = 0.725

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_7 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(325591052).content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 29 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 29)

				if (29 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 29)) > 0 and var_219_6 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_5
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_6, arg_216_1.talkMaxDuration)

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_5) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_5 + var_219_10 and arg_216_1.time_ < var_219_5 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
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
	Play325591053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325591053
		arg_220_1.duration_ = 7.8

		local var_220_0 = {
			zh = 7.8,
			ja = 7.7
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
				arg_220_0:Play325591054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos6148ui_story = arg_220_1.actors_["6148ui_story"].transform.localPosition

				local var_223_0 = GameObjectTools.GetOrAddComponent(arg_220_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_223_0 then
					var_223_0:EnableDynamicBone(false)
				end
			end

			local var_223_1 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_1 then
				arg_220_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_220_1.time_ - 0) / var_223_1)
				arg_220_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).z)
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles = arg_220_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_1 and arg_220_1.time_ < 0 + var_223_1 + arg_223_0 then
				arg_220_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_220_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).z)
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles = arg_220_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_223_2 = GameObjectTools.GetOrAddComponent(arg_220_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(true)
				end
			end

			local var_223_3 = arg_220_1.actors_["6148ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect6148ui_story == nil then
				arg_220_1.var_.characterEffect6148ui_story = var_223_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_4 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 and not isNil(var_223_3) then
				if arg_220_1.var_.characterEffect6148ui_story and not isNil(var_223_3) then
					arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect6148ui_story then
				arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_223_6 = 0
			local var_223_7 = 0.9

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_8 = arg_220_1:GetWordFromCfg(325591053)
				local var_223_9 = arg_220_1:FormatText(var_223_8.content)

				arg_220_1.text_.text = var_223_9

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 36 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 36)

				if (36 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 36)) > 0 and var_223_7 < var_223_11 then
					arg_220_1.talkMaxDuration = var_223_11

					if var_223_11 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_9
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591053", "story_v_out_325591.awb") ~= 0 then
					local var_223_12 = manager.audio:GetVoiceLength("story_v_out_325591", "325591053", "story_v_out_325591.awb") / 1000

					if var_223_12 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_12 + var_223_6
					end

					if var_223_8.prefab_name ~= "" and arg_220_1.actors_[var_223_8.prefab_name] ~= nil then
						local var_223_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_8.prefab_name].transform, "story_v_out_325591", "325591053", "story_v_out_325591.awb")

						arg_220_1:RecordAudio("325591053", var_223_13)
						arg_220_1:RecordAudio("325591053", var_223_13)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_325591", "325591053", "story_v_out_325591.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_325591", "325591053", "story_v_out_325591.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_14 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_14 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_14

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_14 and arg_220_1.time_ < var_223_6 + var_223_14 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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

		arg_220_1:InitPlayNodeList()
	end,
	Play325591054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325591054
		arg_224_1.duration_ = 5.73

		local var_224_0 = {
			zh = 5.733,
			ja = 4.833
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
				arg_224_0:Play325591055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos6148ui_story = arg_224_1.actors_["6148ui_story"].transform.localPosition

				local var_227_0 = GameObjectTools.GetOrAddComponent(arg_224_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_227_0 then
					var_227_0:EnableDynamicBone(false)
				end
			end

			local var_227_1 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_1 then
				arg_224_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_224_1.time_ - 0) / var_227_1)
				arg_224_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["6148ui_story"].transform.position).z)
				arg_224_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["6148ui_story"].transform.localEulerAngles = arg_224_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_1 and arg_224_1.time_ < 0 + var_227_1 + arg_227_0 then
				arg_224_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_224_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["6148ui_story"].transform.position).z)
				arg_224_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["6148ui_story"].transform.localEulerAngles = arg_224_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_227_2 = GameObjectTools.GetOrAddComponent(arg_224_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(true)
				end
			end

			local var_227_3 = arg_224_1.actors_["1054ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1054ui_story = var_227_3.localPosition

				local var_227_4 = GameObjectTools.GetOrAddComponent(var_227_3.gameObject, typeof(DynamicBoneHelper))

				if var_227_4 then
					var_227_4:EnableDynamicBone(false)
				end
			end

			local var_227_5 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_5 then
				var_227_3.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_224_1.time_ - 0) / var_227_5)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_5 and arg_224_1.time_ < 0 + var_227_5 + arg_227_0 then
				var_227_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles

				local var_227_6 = GameObjectTools.GetOrAddComponent(var_227_3.gameObject, typeof(DynamicBoneHelper))

				if var_227_6 then
					var_227_6:EnableDynamicBone(true)
				end
			end

			local var_227_7 = arg_224_1.actors_["1054ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.characterEffect1054ui_story == nil then
				arg_224_1.var_.characterEffect1054ui_story = var_227_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_8 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_8 and not isNil(var_227_7) then
				if arg_224_1.var_.characterEffect1054ui_story and not isNil(var_227_7) then
					arg_224_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_8 and arg_224_1.time_ < 0 + var_227_8 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.characterEffect1054ui_story then
				arg_224_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_227_10 = arg_224_1.actors_["6148ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_10) and arg_224_1.var_.characterEffect6148ui_story == nil then
				arg_224_1.var_.characterEffect6148ui_story = var_227_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_11 and not isNil(var_227_10) then
				if arg_224_1.var_.characterEffect6148ui_story and not isNil(var_227_10) then
					arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_224_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_11)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_11 and arg_224_1.time_ < 0 + var_227_11 + arg_227_0 and not isNil(var_227_10) and arg_224_1.var_.characterEffect6148ui_story then
				arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_224_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_227_12 = 0
			local var_227_13 = 0.6

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_14 = arg_224_1:GetWordFromCfg(325591054)
				local var_227_15 = arg_224_1:FormatText(var_227_14.content)

				arg_224_1.text_.text = var_227_15

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_17 = 24 <= 0 and var_227_13 or var_227_13 * (utf8.len(var_227_15) / 24)

				if (24 <= 0 and var_227_13 or var_227_13 * (utf8.len(var_227_15) / 24)) > 0 and var_227_13 < var_227_17 then
					arg_224_1.talkMaxDuration = var_227_17

					if var_227_17 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_17 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_15
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591054", "story_v_out_325591.awb") ~= 0 then
					local var_227_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591054", "story_v_out_325591.awb") / 1000

					if var_227_18 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_18 + var_227_12
					end

					if var_227_14.prefab_name ~= "" and arg_224_1.actors_[var_227_14.prefab_name] ~= nil then
						local var_227_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_14.prefab_name].transform, "story_v_out_325591", "325591054", "story_v_out_325591.awb")

						arg_224_1:RecordAudio("325591054", var_227_19)
						arg_224_1:RecordAudio("325591054", var_227_19)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_325591", "325591054", "story_v_out_325591.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_325591", "325591054", "story_v_out_325591.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_20 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_20 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_12) / var_227_20

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_12 + var_227_20 and arg_224_1.time_ < var_227_12 + var_227_20 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_224_1:InitPlayNodeList()
	end,
	Play325591055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325591055
		arg_228_1.duration_ = 8.47

		local var_228_0 = {
			zh = 6.5,
			ja = 8.466
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
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325591056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_231_0 = 0
			local var_231_1 = 0.6

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_2 = arg_228_1:GetWordFromCfg(325591055)
				local var_231_3 = arg_228_1:FormatText(var_231_2.content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 24 <= 0 and var_231_1 or var_231_1 * (utf8.len(var_231_3) / 24)

				if (24 <= 0 and var_231_1 or var_231_1 * (utf8.len(var_231_3) / 24)) > 0 and var_231_1 < var_231_5 then
					arg_228_1.talkMaxDuration = var_231_5

					if var_231_5 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591055", "story_v_out_325591.awb") ~= 0 then
					local var_231_6 = manager.audio:GetVoiceLength("story_v_out_325591", "325591055", "story_v_out_325591.awb") / 1000

					if var_231_6 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_6 + var_231_0
					end

					if var_231_2.prefab_name ~= "" and arg_228_1.actors_[var_231_2.prefab_name] ~= nil then
						local var_231_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_2.prefab_name].transform, "story_v_out_325591", "325591055", "story_v_out_325591.awb")

						arg_228_1:RecordAudio("325591055", var_231_7)
						arg_228_1:RecordAudio("325591055", var_231_7)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325591", "325591055", "story_v_out_325591.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325591", "325591055", "story_v_out_325591.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_8 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_8 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_8

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_8 and arg_228_1.time_ < var_231_0 + var_231_8 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play325591056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325591056
		arg_232_1.duration_ = 6.4

		local var_232_0 = {
			zh = 6,
			ja = 6.4
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325591057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1054ui_story = arg_232_1.actors_["1054ui_story"].transform.localPosition

				local var_235_0 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_0 then
					var_235_0:EnableDynamicBone(false)
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_1)
				arg_232_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1054ui_story"].transform.position).z)
				arg_232_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1054ui_story"].transform.localEulerAngles = arg_232_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1054ui_story"].transform.position).z)
				arg_232_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1054ui_story"].transform.localEulerAngles = arg_232_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_235_2 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(true)
				end
			end

			local var_235_3 = arg_232_1.actors_["10176ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10176ui_story = var_235_3.localPosition

				local var_235_4 = GameObjectTools.GetOrAddComponent(var_235_3.gameObject, typeof(DynamicBoneHelper))

				if var_235_4 then
					var_235_4:EnableDynamicBone(false)
				end
			end

			local var_235_5 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_5 then
				var_235_3.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_232_1.time_ - 0) / var_235_5)
				var_235_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_3.position).x, (manager.ui.mainCamera.transform.position - var_235_3.position).y, (manager.ui.mainCamera.transform.position - var_235_3.position).z)
				var_235_3.localEulerAngles.z = 0
				var_235_3.localEulerAngles.x = 0
				var_235_3.localEulerAngles = var_235_3.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_5 and arg_232_1.time_ < 0 + var_235_5 + arg_235_0 then
				var_235_3.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				var_235_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_3.position).x, (manager.ui.mainCamera.transform.position - var_235_3.position).y, (manager.ui.mainCamera.transform.position - var_235_3.position).z)
				var_235_3.localEulerAngles.z = 0
				var_235_3.localEulerAngles.x = 0
				var_235_3.localEulerAngles = var_235_3.localEulerAngles

				local var_235_6 = GameObjectTools.GetOrAddComponent(var_235_3.gameObject, typeof(DynamicBoneHelper))

				if var_235_6 then
					var_235_6:EnableDynamicBone(true)
				end
			end

			local var_235_7 = arg_232_1.actors_["6148ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos6148ui_story = var_235_7.localPosition

				local var_235_8 = GameObjectTools.GetOrAddComponent(var_235_7.gameObject, typeof(DynamicBoneHelper))

				if var_235_8 then
					var_235_8:EnableDynamicBone(false)
				end
			end

			local var_235_9 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_9 then
				var_235_7.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_9)
				var_235_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_7.position).x, (manager.ui.mainCamera.transform.position - var_235_7.position).y, (manager.ui.mainCamera.transform.position - var_235_7.position).z)
				var_235_7.localEulerAngles.z = 0
				var_235_7.localEulerAngles.x = 0
				var_235_7.localEulerAngles = var_235_7.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_9 and arg_232_1.time_ < 0 + var_235_9 + arg_235_0 then
				var_235_7.localPosition = Vector3.New(0, 100, 0)
				var_235_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_7.position).x, (manager.ui.mainCamera.transform.position - var_235_7.position).y, (manager.ui.mainCamera.transform.position - var_235_7.position).z)
				var_235_7.localEulerAngles.z = 0
				var_235_7.localEulerAngles.x = 0
				var_235_7.localEulerAngles = var_235_7.localEulerAngles

				local var_235_10 = GameObjectTools.GetOrAddComponent(var_235_7.gameObject, typeof(DynamicBoneHelper))

				if var_235_10 then
					var_235_10:EnableDynamicBone(true)
				end
			end

			local var_235_11 = arg_232_1.actors_["10176ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_11) and arg_232_1.var_.characterEffect10176ui_story == nil then
				arg_232_1.var_.characterEffect10176ui_story = var_235_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_12 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_12 and not isNil(var_235_11) then
				if arg_232_1.var_.characterEffect10176ui_story and not isNil(var_235_11) then
					arg_232_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_12 and arg_232_1.time_ < 0 + var_235_12 + arg_235_0 and not isNil(var_235_11) and arg_232_1.var_.characterEffect10176ui_story then
				arg_232_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_235_14 = arg_232_1.actors_["1054ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.characterEffect1054ui_story == nil then
				arg_232_1.var_.characterEffect1054ui_story = var_235_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_15 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_15 and not isNil(var_235_14) then
				if arg_232_1.var_.characterEffect1054ui_story and not isNil(var_235_14) then
					arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_15)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_15 and arg_232_1.time_ < 0 + var_235_15 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.characterEffect1054ui_story then
				arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_1")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_235_16 = 0
			local var_235_17 = 0.575

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_18 = arg_232_1:GetWordFromCfg(325591056)
				local var_235_19 = arg_232_1:FormatText(var_235_18.content)

				arg_232_1.text_.text = var_235_19

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_21 = 23 <= 0 and var_235_17 or var_235_17 * (utf8.len(var_235_19) / 23)

				if (23 <= 0 and var_235_17 or var_235_17 * (utf8.len(var_235_19) / 23)) > 0 and var_235_17 < var_235_21 then
					arg_232_1.talkMaxDuration = var_235_21

					if var_235_21 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_21 + var_235_16
					end
				end

				arg_232_1.text_.text = var_235_19
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591056", "story_v_out_325591.awb") ~= 0 then
					local var_235_22 = manager.audio:GetVoiceLength("story_v_out_325591", "325591056", "story_v_out_325591.awb") / 1000

					if var_235_22 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_22 + var_235_16
					end

					if var_235_18.prefab_name ~= "" and arg_232_1.actors_[var_235_18.prefab_name] ~= nil then
						local var_235_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_18.prefab_name].transform, "story_v_out_325591", "325591056", "story_v_out_325591.awb")

						arg_232_1:RecordAudio("325591056", var_235_23)
						arg_232_1:RecordAudio("325591056", var_235_23)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_325591", "325591056", "story_v_out_325591.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_325591", "325591056", "story_v_out_325591.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_24 = math.max(var_235_17, arg_232_1.talkMaxDuration)

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_24 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_16) / var_235_24

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_16 + var_235_24 and arg_232_1.time_ < var_235_16 + var_235_24 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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
				actorName = "10176ui_story",
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

		arg_232_1:InitPlayNodeList()
	end,
	Play325591057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 325591057
		arg_236_1.duration_ = 9.67

		local var_236_0 = {
			zh = 9.166,
			ja = 9.666
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play325591058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.825

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:GetWordFromCfg(325591057)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 33 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 33)

				if (33 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 33)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591057", "story_v_out_325591.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591057", "story_v_out_325591.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_325591", "325591057", "story_v_out_325591.awb")

						arg_236_1:RecordAudio("325591057", var_239_6)
						arg_236_1:RecordAudio("325591057", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_325591", "325591057", "story_v_out_325591.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_325591", "325591057", "story_v_out_325591.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play325591058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 325591058
		arg_240_1.duration_ = 6.4

		local var_240_0 = {
			zh = 5.033,
			ja = 6.4
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play325591059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10176ui_story = arg_240_1.actors_["10176ui_story"].transform.localPosition

				local var_243_0 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_0 then
					var_243_0:EnableDynamicBone(false)
				end
			end

			local var_243_1 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_1 then
				arg_240_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10176ui_story, Vector3.New(-0.7, -1.09, -6.12), (arg_240_1.time_ - 0) / var_243_1)
				arg_240_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10176ui_story"].transform.position).z)
				arg_240_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10176ui_story"].transform.localEulerAngles = arg_240_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_1 and arg_240_1.time_ < 0 + var_243_1 + arg_243_0 then
				arg_240_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -6.12)
				arg_240_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10176ui_story"].transform.position).z)
				arg_240_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10176ui_story"].transform.localEulerAngles = arg_240_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_243_2 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(true)
				end
			end

			local var_243_3 = arg_240_1.actors_["1054ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1054ui_story = var_243_3.localPosition

				local var_243_4 = GameObjectTools.GetOrAddComponent(var_243_3.gameObject, typeof(DynamicBoneHelper))

				if var_243_4 then
					var_243_4:EnableDynamicBone(false)
				end
			end

			local var_243_5 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_5 then
				var_243_3.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_240_1.time_ - 0) / var_243_5)
				var_243_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_3.position).x, (manager.ui.mainCamera.transform.position - var_243_3.position).y, (manager.ui.mainCamera.transform.position - var_243_3.position).z)
				var_243_3.localEulerAngles.z = 0
				var_243_3.localEulerAngles.x = 0
				var_243_3.localEulerAngles = var_243_3.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_5 and arg_240_1.time_ < 0 + var_243_5 + arg_243_0 then
				var_243_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_243_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_3.position).x, (manager.ui.mainCamera.transform.position - var_243_3.position).y, (manager.ui.mainCamera.transform.position - var_243_3.position).z)
				var_243_3.localEulerAngles.z = 0
				var_243_3.localEulerAngles.x = 0
				var_243_3.localEulerAngles = var_243_3.localEulerAngles

				local var_243_6 = GameObjectTools.GetOrAddComponent(var_243_3.gameObject, typeof(DynamicBoneHelper))

				if var_243_6 then
					var_243_6:EnableDynamicBone(true)
				end
			end

			local var_243_7 = arg_240_1.actors_["1054ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_7) and arg_240_1.var_.characterEffect1054ui_story == nil then
				arg_240_1.var_.characterEffect1054ui_story = var_243_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_8 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_8 and not isNil(var_243_7) then
				if arg_240_1.var_.characterEffect1054ui_story and not isNil(var_243_7) then
					arg_240_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_8 and arg_240_1.time_ < 0 + var_243_8 + arg_243_0 and not isNil(var_243_7) and arg_240_1.var_.characterEffect1054ui_story then
				arg_240_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_243_10 = arg_240_1.actors_["10176ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_10) and arg_240_1.var_.characterEffect10176ui_story == nil then
				arg_240_1.var_.characterEffect10176ui_story = var_243_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_11 and not isNil(var_243_10) then
				if arg_240_1.var_.characterEffect10176ui_story and not isNil(var_243_10) then
					arg_240_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_11)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_11 and arg_240_1.time_ < 0 + var_243_11 + arg_243_0 and not isNil(var_243_10) and arg_240_1.var_.characterEffect10176ui_story then
				arg_240_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_243_12 = 0
			local var_243_13 = 0.525

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_12 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_14 = arg_240_1:GetWordFromCfg(325591058)
				local var_243_15 = arg_240_1:FormatText(var_243_14.content)

				arg_240_1.text_.text = var_243_15

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_17 = 21 <= 0 and var_243_13 or var_243_13 * (utf8.len(var_243_15) / 21)

				if (21 <= 0 and var_243_13 or var_243_13 * (utf8.len(var_243_15) / 21)) > 0 and var_243_13 < var_243_17 then
					arg_240_1.talkMaxDuration = var_243_17

					if var_243_17 + var_243_12 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_17 + var_243_12
					end
				end

				arg_240_1.text_.text = var_243_15
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591058", "story_v_out_325591.awb") ~= 0 then
					local var_243_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591058", "story_v_out_325591.awb") / 1000

					if var_243_18 + var_243_12 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_18 + var_243_12
					end

					if var_243_14.prefab_name ~= "" and arg_240_1.actors_[var_243_14.prefab_name] ~= nil then
						local var_243_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_14.prefab_name].transform, "story_v_out_325591", "325591058", "story_v_out_325591.awb")

						arg_240_1:RecordAudio("325591058", var_243_19)
						arg_240_1:RecordAudio("325591058", var_243_19)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_325591", "325591058", "story_v_out_325591.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_325591", "325591058", "story_v_out_325591.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_20 = math.max(var_243_13, arg_240_1.talkMaxDuration)

			if var_243_12 <= arg_240_1.time_ and arg_240_1.time_ < var_243_12 + var_243_20 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_12) / var_243_20

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_12 + var_243_20 and arg_240_1.time_ < var_243_12 + var_243_20 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_240_1:InitPlayNodeList()
	end,
	Play325591059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 325591059
		arg_244_1.duration_ = 9.23

		local var_244_0 = {
			zh = 8.633,
			ja = 9.233
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play325591060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10176ui_story"]) and arg_244_1.var_.characterEffect10176ui_story == nil then
				arg_244_1.var_.characterEffect10176ui_story = arg_244_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10176ui_story"]) then
				if arg_244_1.var_.characterEffect10176ui_story and not isNil(arg_244_1.actors_["10176ui_story"]) then
					arg_244_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10176ui_story"]) and arg_244_1.var_.characterEffect10176ui_story then
				arg_244_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_247_2 = arg_244_1.actors_["1054ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect1054ui_story == nil then
				arg_244_1.var_.characterEffect1054ui_story = var_247_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_3 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.characterEffect1054ui_story and not isNil(var_247_2) then
					arg_244_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_3)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect1054ui_story then
				arg_244_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_2")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_247_4 = 0
			local var_247_5 = 0.725

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(325591059)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 29 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 29)

				if (29 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 29)) > 0 and var_247_5 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591059", "story_v_out_325591.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591059", "story_v_out_325591.awb") / 1000

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_out_325591", "325591059", "story_v_out_325591.awb")

						arg_244_1:RecordAudio("325591059", var_247_11)
						arg_244_1:RecordAudio("325591059", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_325591", "325591059", "story_v_out_325591.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_325591", "325591059", "story_v_out_325591.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_12 and arg_244_1.time_ < var_247_4 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play325591060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 325591060
		arg_248_1.duration_ = 3.87

		local var_248_0 = {
			zh = 3.466,
			ja = 3.866
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play325591061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.375

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(325591060)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 15 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 15)

				if (15 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 15)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591060", "story_v_out_325591.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591060", "story_v_out_325591.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_325591", "325591060", "story_v_out_325591.awb")

						arg_248_1:RecordAudio("325591060", var_251_6)
						arg_248_1:RecordAudio("325591060", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_325591", "325591060", "story_v_out_325591.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_325591", "325591060", "story_v_out_325591.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play325591061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 325591061
		arg_252_1.duration_ = 3.77

		local var_252_0 = {
			zh = 3,
			ja = 3.766
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play325591062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1054ui_story = arg_252_1.actors_["1054ui_story"].transform.localPosition

				local var_255_0 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_0 then
					var_255_0:EnableDynamicBone(false)
				end
			end

			local var_255_1 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				arg_252_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_1)
				arg_252_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).z)
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles = arg_252_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				arg_252_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).z)
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles = arg_252_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_255_2 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(true)
				end
			end

			local var_255_3 = arg_252_1.actors_["6148ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos6148ui_story = var_255_3.localPosition

				local var_255_4 = GameObjectTools.GetOrAddComponent(var_255_3.gameObject, typeof(DynamicBoneHelper))

				if var_255_4 then
					var_255_4:EnableDynamicBone(false)
				end
			end

			local var_255_5 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_5 then
				var_255_3.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_252_1.time_ - 0) / var_255_5)
				var_255_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_3.position).x, (manager.ui.mainCamera.transform.position - var_255_3.position).y, (manager.ui.mainCamera.transform.position - var_255_3.position).z)
				var_255_3.localEulerAngles.z = 0
				var_255_3.localEulerAngles.x = 0
				var_255_3.localEulerAngles = var_255_3.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_5 and arg_252_1.time_ < 0 + var_255_5 + arg_255_0 then
				var_255_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_255_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_3.position).x, (manager.ui.mainCamera.transform.position - var_255_3.position).y, (manager.ui.mainCamera.transform.position - var_255_3.position).z)
				var_255_3.localEulerAngles.z = 0
				var_255_3.localEulerAngles.x = 0
				var_255_3.localEulerAngles = var_255_3.localEulerAngles

				local var_255_6 = GameObjectTools.GetOrAddComponent(var_255_3.gameObject, typeof(DynamicBoneHelper))

				if var_255_6 then
					var_255_6:EnableDynamicBone(true)
				end
			end

			local var_255_7 = arg_252_1.actors_["6148ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_7) and arg_252_1.var_.characterEffect6148ui_story == nil then
				arg_252_1.var_.characterEffect6148ui_story = var_255_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_8 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_8 and not isNil(var_255_7) then
				if arg_252_1.var_.characterEffect6148ui_story and not isNil(var_255_7) then
					arg_252_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_8 and arg_252_1.time_ < 0 + var_255_8 + arg_255_0 and not isNil(var_255_7) and arg_252_1.var_.characterEffect6148ui_story then
				arg_252_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_255_10 = arg_252_1.actors_["10176ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_10) and arg_252_1.var_.characterEffect10176ui_story == nil then
				arg_252_1.var_.characterEffect10176ui_story = var_255_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_11 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_11 and not isNil(var_255_10) then
				if arg_252_1.var_.characterEffect10176ui_story and not isNil(var_255_10) then
					arg_252_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_252_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_11)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_11 and arg_252_1.time_ < 0 + var_255_11 + arg_255_0 and not isNil(var_255_10) and arg_252_1.var_.characterEffect10176ui_story then
				arg_252_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_252_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_255_12 = 0
			local var_255_13 = 0.225

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_14 = arg_252_1:GetWordFromCfg(325591061)
				local var_255_15 = arg_252_1:FormatText(var_255_14.content)

				arg_252_1.text_.text = var_255_15

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_17 = 9 <= 0 and var_255_13 or var_255_13 * (utf8.len(var_255_15) / 9)

				if (9 <= 0 and var_255_13 or var_255_13 * (utf8.len(var_255_15) / 9)) > 0 and var_255_13 < var_255_17 then
					arg_252_1.talkMaxDuration = var_255_17

					if var_255_17 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_17 + var_255_12
					end
				end

				arg_252_1.text_.text = var_255_15
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591061", "story_v_out_325591.awb") ~= 0 then
					local var_255_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591061", "story_v_out_325591.awb") / 1000

					if var_255_18 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_18 + var_255_12
					end

					if var_255_14.prefab_name ~= "" and arg_252_1.actors_[var_255_14.prefab_name] ~= nil then
						local var_255_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_14.prefab_name].transform, "story_v_out_325591", "325591061", "story_v_out_325591.awb")

						arg_252_1:RecordAudio("325591061", var_255_19)
						arg_252_1:RecordAudio("325591061", var_255_19)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_325591", "325591061", "story_v_out_325591.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_325591", "325591061", "story_v_out_325591.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_20 = math.max(var_255_13, arg_252_1.talkMaxDuration)

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_20 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_12) / var_255_20

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_12 + var_255_20 and arg_252_1.time_ < var_255_12 + var_255_20 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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

		arg_252_1:InitPlayNodeList()
	end,
	Play325591062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 325591062
		arg_256_1.duration_ = 8.27

		local var_256_0 = {
			zh = 7.2,
			ja = 8.266
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play325591063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["10176ui_story"]) and arg_256_1.var_.characterEffect10176ui_story == nil then
				arg_256_1.var_.characterEffect10176ui_story = arg_256_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["10176ui_story"]) then
				if arg_256_1.var_.characterEffect10176ui_story and not isNil(arg_256_1.actors_["10176ui_story"]) then
					arg_256_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["10176ui_story"]) and arg_256_1.var_.characterEffect10176ui_story then
				arg_256_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_259_2 = arg_256_1.actors_["6148ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.characterEffect6148ui_story == nil then
				arg_256_1.var_.characterEffect6148ui_story = var_259_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_3 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 and not isNil(var_259_2) then
				if arg_256_1.var_.characterEffect6148ui_story and not isNil(var_259_2) then
					arg_256_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_256_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_3)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.characterEffect6148ui_story then
				arg_256_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_256_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			local var_259_4 = 0
			local var_259_5 = 0.775

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(325591062)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 31 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 31)

				if (31 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 31)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591062", "story_v_out_325591.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591062", "story_v_out_325591.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_out_325591", "325591062", "story_v_out_325591.awb")

						arg_256_1:RecordAudio("325591062", var_259_11)
						arg_256_1:RecordAudio("325591062", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_325591", "325591062", "story_v_out_325591.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_325591", "325591062", "story_v_out_325591.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play325591063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 325591063
		arg_260_1.duration_ = 5.13

		local var_260_0 = {
			zh = 3.9,
			ja = 5.133
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play325591064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.35

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(325591063)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 14 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 14)

				if (14 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 14)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591063", "story_v_out_325591.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591063", "story_v_out_325591.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_325591", "325591063", "story_v_out_325591.awb")

						arg_260_1:RecordAudio("325591063", var_263_6)
						arg_260_1:RecordAudio("325591063", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_325591", "325591063", "story_v_out_325591.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_325591", "325591063", "story_v_out_325591.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play325591064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 325591064
		arg_264_1.duration_ = 8

		local var_264_0 = {
			zh = 5.866,
			ja = 8
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play325591065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["6148ui_story"]) and arg_264_1.var_.characterEffect6148ui_story == nil then
				arg_264_1.var_.characterEffect6148ui_story = arg_264_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["6148ui_story"]) then
				if arg_264_1.var_.characterEffect6148ui_story and not isNil(arg_264_1.actors_["6148ui_story"]) then
					arg_264_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["6148ui_story"]) and arg_264_1.var_.characterEffect6148ui_story then
				arg_264_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_267_2 = arg_264_1.actors_["10176ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.characterEffect10176ui_story == nil then
				arg_264_1.var_.characterEffect10176ui_story = var_267_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_3 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_3 and not isNil(var_267_2) then
				if arg_264_1.var_.characterEffect10176ui_story and not isNil(var_267_2) then
					arg_264_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_264_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_3)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_3 and arg_264_1.time_ < 0 + var_267_3 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.characterEffect10176ui_story then
				arg_264_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_264_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_267_4 = 0
			local var_267_5 = 0.675

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_6 = arg_264_1:GetWordFromCfg(325591064)
				local var_267_7 = arg_264_1:FormatText(var_267_6.content)

				arg_264_1.text_.text = var_267_7

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 27 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 27)

				if (27 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 27)) > 0 and var_267_5 < var_267_9 then
					arg_264_1.talkMaxDuration = var_267_9

					if var_267_9 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_9 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_7
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591064", "story_v_out_325591.awb") ~= 0 then
					local var_267_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591064", "story_v_out_325591.awb") / 1000

					if var_267_10 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_4
					end

					if var_267_6.prefab_name ~= "" and arg_264_1.actors_[var_267_6.prefab_name] ~= nil then
						local var_267_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_6.prefab_name].transform, "story_v_out_325591", "325591064", "story_v_out_325591.awb")

						arg_264_1:RecordAudio("325591064", var_267_11)
						arg_264_1:RecordAudio("325591064", var_267_11)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_325591", "325591064", "story_v_out_325591.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_325591", "325591064", "story_v_out_325591.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_12 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_12 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_12

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_12 and arg_264_1.time_ < var_267_4 + var_267_12 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play325591065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 325591065
		arg_268_1.duration_ = 2.6

		local var_268_0 = {
			zh = 2.533,
			ja = 2.6
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play325591066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_271_0 = 0
			local var_271_1 = 0.25

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_2 = arg_268_1:GetWordFromCfg(325591065)
				local var_271_3 = arg_268_1:FormatText(var_271_2.content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 10 <= 0 and var_271_1 or var_271_1 * (utf8.len(var_271_3) / 10)

				if (10 <= 0 and var_271_1 or var_271_1 * (utf8.len(var_271_3) / 10)) > 0 and var_271_1 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591065", "story_v_out_325591.awb") ~= 0 then
					local var_271_6 = manager.audio:GetVoiceLength("story_v_out_325591", "325591065", "story_v_out_325591.awb") / 1000

					if var_271_6 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_0
					end

					if var_271_2.prefab_name ~= "" and arg_268_1.actors_[var_271_2.prefab_name] ~= nil then
						local var_271_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_2.prefab_name].transform, "story_v_out_325591", "325591065", "story_v_out_325591.awb")

						arg_268_1:RecordAudio("325591065", var_271_7)
						arg_268_1:RecordAudio("325591065", var_271_7)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_325591", "325591065", "story_v_out_325591.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_325591", "325591065", "story_v_out_325591.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_8 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_8 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_8

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_8 and arg_268_1.time_ < var_271_0 + var_271_8 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play325591066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 325591066
		arg_272_1.duration_ = 12.83

		local var_272_0 = {
			zh = 10.633,
			ja = 12.833
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play325591067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos6148ui_story = arg_272_1.actors_["6148ui_story"].transform.localPosition

				local var_275_0 = GameObjectTools.GetOrAddComponent(arg_272_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_275_0 then
					var_275_0:EnableDynamicBone(false)
				end
			end

			local var_275_1 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_1 then
				arg_272_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_272_1.time_ - 0) / var_275_1)
				arg_272_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["6148ui_story"].transform.position).z)
				arg_272_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["6148ui_story"].transform.localEulerAngles = arg_272_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_1 and arg_272_1.time_ < 0 + var_275_1 + arg_275_0 then
				arg_272_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_272_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["6148ui_story"].transform.position).z)
				arg_272_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["6148ui_story"].transform.localEulerAngles = arg_272_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_275_2 = GameObjectTools.GetOrAddComponent(arg_272_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_275_2 then
					var_275_2:EnableDynamicBone(true)
				end
			end

			local var_275_3 = arg_272_1.actors_["1054ui_story"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1054ui_story = var_275_3.localPosition

				local var_275_4 = GameObjectTools.GetOrAddComponent(var_275_3.gameObject, typeof(DynamicBoneHelper))

				if var_275_4 then
					var_275_4:EnableDynamicBone(false)
				end
			end

			local var_275_5 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_5 then
				var_275_3.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_272_1.time_ - 0) / var_275_5)
				var_275_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_3.position).x, (manager.ui.mainCamera.transform.position - var_275_3.position).y, (manager.ui.mainCamera.transform.position - var_275_3.position).z)
				var_275_3.localEulerAngles.z = 0
				var_275_3.localEulerAngles.x = 0
				var_275_3.localEulerAngles = var_275_3.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_5 and arg_272_1.time_ < 0 + var_275_5 + arg_275_0 then
				var_275_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_275_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_3.position).x, (manager.ui.mainCamera.transform.position - var_275_3.position).y, (manager.ui.mainCamera.transform.position - var_275_3.position).z)
				var_275_3.localEulerAngles.z = 0
				var_275_3.localEulerAngles.x = 0
				var_275_3.localEulerAngles = var_275_3.localEulerAngles

				local var_275_6 = GameObjectTools.GetOrAddComponent(var_275_3.gameObject, typeof(DynamicBoneHelper))

				if var_275_6 then
					var_275_6:EnableDynamicBone(true)
				end
			end

			local var_275_7 = arg_272_1.actors_["1054ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_7) and arg_272_1.var_.characterEffect1054ui_story == nil then
				arg_272_1.var_.characterEffect1054ui_story = var_275_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_8 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_8 and not isNil(var_275_7) then
				if arg_272_1.var_.characterEffect1054ui_story and not isNil(var_275_7) then
					arg_272_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_8 and arg_272_1.time_ < 0 + var_275_8 + arg_275_0 and not isNil(var_275_7) and arg_272_1.var_.characterEffect1054ui_story then
				arg_272_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_275_10 = arg_272_1.actors_["6148ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_10) and arg_272_1.var_.characterEffect6148ui_story == nil then
				arg_272_1.var_.characterEffect6148ui_story = var_275_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_11 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_11 and not isNil(var_275_10) then
				if arg_272_1.var_.characterEffect6148ui_story and not isNil(var_275_10) then
					arg_272_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_272_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_11)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_11 and arg_272_1.time_ < 0 + var_275_11 + arg_275_0 and not isNil(var_275_10) and arg_272_1.var_.characterEffect6148ui_story then
				arg_272_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_272_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_275_12 = 0
			local var_275_13 = 0.9

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_12 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_14 = arg_272_1:GetWordFromCfg(325591066)
				local var_275_15 = arg_272_1:FormatText(var_275_14.content)

				arg_272_1.text_.text = var_275_15

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_17 = 36 <= 0 and var_275_13 or var_275_13 * (utf8.len(var_275_15) / 36)

				if (36 <= 0 and var_275_13 or var_275_13 * (utf8.len(var_275_15) / 36)) > 0 and var_275_13 < var_275_17 then
					arg_272_1.talkMaxDuration = var_275_17

					if var_275_17 + var_275_12 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_17 + var_275_12
					end
				end

				arg_272_1.text_.text = var_275_15
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591066", "story_v_out_325591.awb") ~= 0 then
					local var_275_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591066", "story_v_out_325591.awb") / 1000

					if var_275_18 + var_275_12 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_18 + var_275_12
					end

					if var_275_14.prefab_name ~= "" and arg_272_1.actors_[var_275_14.prefab_name] ~= nil then
						local var_275_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_14.prefab_name].transform, "story_v_out_325591", "325591066", "story_v_out_325591.awb")

						arg_272_1:RecordAudio("325591066", var_275_19)
						arg_272_1:RecordAudio("325591066", var_275_19)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_325591", "325591066", "story_v_out_325591.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_325591", "325591066", "story_v_out_325591.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_20 = math.max(var_275_13, arg_272_1.talkMaxDuration)

			if var_275_12 <= arg_272_1.time_ and arg_272_1.time_ < var_275_12 + var_275_20 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_12) / var_275_20

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_12 + var_275_20 and arg_272_1.time_ < var_275_12 + var_275_20 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_272_1:InitPlayNodeList()
	end,
	Play325591067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325591067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play325591068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1054ui_story = arg_276_1.actors_["1054ui_story"].transform.localPosition

				local var_279_0 = GameObjectTools.GetOrAddComponent(arg_276_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_279_0 then
					var_279_0:EnableDynamicBone(false)
				end
			end

			local var_279_1 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_1 then
				arg_276_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_276_1.time_ - 0) / var_279_1)
				arg_276_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1054ui_story"].transform.position).z)
				arg_276_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1054ui_story"].transform.localEulerAngles = arg_276_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_1 and arg_276_1.time_ < 0 + var_279_1 + arg_279_0 then
				arg_276_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_276_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1054ui_story"].transform.position).z)
				arg_276_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1054ui_story"].transform.localEulerAngles = arg_276_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_279_2 = GameObjectTools.GetOrAddComponent(arg_276_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_279_2 then
					var_279_2:EnableDynamicBone(true)
				end
			end

			local var_279_3 = arg_276_1.actors_["10176ui_story"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10176ui_story = var_279_3.localPosition

				local var_279_4 = GameObjectTools.GetOrAddComponent(var_279_3.gameObject, typeof(DynamicBoneHelper))

				if var_279_4 then
					var_279_4:EnableDynamicBone(false)
				end
			end

			local var_279_5 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_5 then
				var_279_3.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_276_1.time_ - 0) / var_279_5)
				var_279_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_279_3.position).x, (manager.ui.mainCamera.transform.position - var_279_3.position).y, (manager.ui.mainCamera.transform.position - var_279_3.position).z)
				var_279_3.localEulerAngles.z = 0
				var_279_3.localEulerAngles.x = 0
				var_279_3.localEulerAngles = var_279_3.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_5 and arg_276_1.time_ < 0 + var_279_5 + arg_279_0 then
				var_279_3.localPosition = Vector3.New(0, 100, 0)
				var_279_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_279_3.position).x, (manager.ui.mainCamera.transform.position - var_279_3.position).y, (manager.ui.mainCamera.transform.position - var_279_3.position).z)
				var_279_3.localEulerAngles.z = 0
				var_279_3.localEulerAngles.x = 0
				var_279_3.localEulerAngles = var_279_3.localEulerAngles

				local var_279_6 = GameObjectTools.GetOrAddComponent(var_279_3.gameObject, typeof(DynamicBoneHelper))

				if var_279_6 then
					var_279_6:EnableDynamicBone(true)
				end
			end

			local var_279_7 = arg_276_1.actors_["1054ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_7) and arg_276_1.var_.characterEffect1054ui_story == nil then
				arg_276_1.var_.characterEffect1054ui_story = var_279_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_8 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_8 and not isNil(var_279_7) then
				if arg_276_1.var_.characterEffect1054ui_story and not isNil(var_279_7) then
					arg_276_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_8)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_8 and arg_276_1.time_ < 0 + var_279_8 + arg_279_0 and not isNil(var_279_7) and arg_276_1.var_.characterEffect1054ui_story then
				arg_276_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_279_9 = 0
			local var_279_10 = 0.925

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_9 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_11 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(325591067).content)

				arg_276_1.text_.text = var_279_11

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_13 = 37 <= 0 and var_279_10 or var_279_10 * (utf8.len(var_279_11) / 37)

				if (37 <= 0 and var_279_10 or var_279_10 * (utf8.len(var_279_11) / 37)) > 0 and var_279_10 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_9 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_9
					end
				end

				arg_276_1.text_.text = var_279_11
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_10, arg_276_1.talkMaxDuration)

			if var_279_9 <= arg_276_1.time_ and arg_276_1.time_ < var_279_9 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_9) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_9 + var_279_14 and arg_276_1.time_ < var_279_9 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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
				actorName = "10176ui_story",
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
	Play325591068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325591068
		arg_280_1.duration_ = 11.5

		local var_280_0 = {
			zh = 10.1,
			ja = 11.5
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
				arg_280_0:Play325591069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10176ui_story = arg_280_1.actors_["10176ui_story"].transform.localPosition

				local var_283_0 = GameObjectTools.GetOrAddComponent(arg_280_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_283_0 then
					var_283_0:EnableDynamicBone(false)
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_280_1.time_ - 0) / var_283_1)
				arg_280_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10176ui_story"].transform.position).z)
				arg_280_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10176ui_story"].transform.localEulerAngles = arg_280_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				arg_280_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10176ui_story"].transform.position).z)
				arg_280_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10176ui_story"].transform.localEulerAngles = arg_280_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_283_2 = GameObjectTools.GetOrAddComponent(arg_280_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_283_2 then
					var_283_2:EnableDynamicBone(true)
				end
			end

			local var_283_3 = arg_280_1.actors_["10176ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect10176ui_story == nil then
				arg_280_1.var_.characterEffect10176ui_story = var_283_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_4 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 and not isNil(var_283_3) then
				if arg_280_1.var_.characterEffect10176ui_story and not isNil(var_283_3) then
					arg_280_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect10176ui_story then
				arg_280_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_283_6 = 0
			local var_283_7 = 0.925

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_8 = arg_280_1:GetWordFromCfg(325591068)
				local var_283_9 = arg_280_1:FormatText(var_283_8.content)

				arg_280_1.text_.text = var_283_9

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 37 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 37)

				if (37 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 37)) > 0 and var_283_7 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11

					if var_283_11 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_9
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591068", "story_v_out_325591.awb") ~= 0 then
					local var_283_12 = manager.audio:GetVoiceLength("story_v_out_325591", "325591068", "story_v_out_325591.awb") / 1000

					if var_283_12 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_6
					end

					if var_283_8.prefab_name ~= "" and arg_280_1.actors_[var_283_8.prefab_name] ~= nil then
						local var_283_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_8.prefab_name].transform, "story_v_out_325591", "325591068", "story_v_out_325591.awb")

						arg_280_1:RecordAudio("325591068", var_283_13)
						arg_280_1:RecordAudio("325591068", var_283_13)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325591", "325591068", "story_v_out_325591.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325591", "325591068", "story_v_out_325591.awb")
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
				actorName = "10176ui_story",
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
	Play325591069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325591069
		arg_284_1.duration_ = 6.33

		local var_284_0 = {
			zh = 6.266,
			ja = 6.333
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
				arg_284_0:Play325591070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.5

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:GetWordFromCfg(325591069)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 20 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 20)

				if (20 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 20)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591069", "story_v_out_325591.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591069", "story_v_out_325591.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_325591", "325591069", "story_v_out_325591.awb")

						arg_284_1:RecordAudio("325591069", var_287_6)
						arg_284_1:RecordAudio("325591069", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_325591", "325591069", "story_v_out_325591.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_325591", "325591069", "story_v_out_325591.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play325591070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 325591070
		arg_288_1.duration_ = 2.27

		local var_288_0 = {
			zh = 2.266,
			ja = 1.066
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
				arg_288_0:Play325591071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10176ui_story = arg_288_1.actors_["10176ui_story"].transform.localPosition

				local var_291_0 = GameObjectTools.GetOrAddComponent(arg_288_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_291_0 then
					var_291_0:EnableDynamicBone(false)
				end
			end

			local var_291_1 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_1 then
				arg_288_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_288_1.time_ - 0) / var_291_1)
				arg_288_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["10176ui_story"].transform.position).z)
				arg_288_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["10176ui_story"].transform.localEulerAngles = arg_288_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_1 and arg_288_1.time_ < 0 + var_291_1 + arg_291_0 then
				arg_288_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_288_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["10176ui_story"].transform.position).z)
				arg_288_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["10176ui_story"].transform.localEulerAngles = arg_288_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_291_2 = GameObjectTools.GetOrAddComponent(arg_288_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_291_2 then
					var_291_2:EnableDynamicBone(true)
				end
			end

			local var_291_3 = arg_288_1.actors_["1054ui_story"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1054ui_story = var_291_3.localPosition

				local var_291_4 = GameObjectTools.GetOrAddComponent(var_291_3.gameObject, typeof(DynamicBoneHelper))

				if var_291_4 then
					var_291_4:EnableDynamicBone(false)
				end
			end

			local var_291_5 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_5 then
				var_291_3.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_288_1.time_ - 0) / var_291_5)
				var_291_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_3.position).x, (manager.ui.mainCamera.transform.position - var_291_3.position).y, (manager.ui.mainCamera.transform.position - var_291_3.position).z)
				var_291_3.localEulerAngles.z = 0
				var_291_3.localEulerAngles.x = 0
				var_291_3.localEulerAngles = var_291_3.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_5 and arg_288_1.time_ < 0 + var_291_5 + arg_291_0 then
				var_291_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_291_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_3.position).x, (manager.ui.mainCamera.transform.position - var_291_3.position).y, (manager.ui.mainCamera.transform.position - var_291_3.position).z)
				var_291_3.localEulerAngles.z = 0
				var_291_3.localEulerAngles.x = 0
				var_291_3.localEulerAngles = var_291_3.localEulerAngles

				local var_291_6 = GameObjectTools.GetOrAddComponent(var_291_3.gameObject, typeof(DynamicBoneHelper))

				if var_291_6 then
					var_291_6:EnableDynamicBone(true)
				end
			end

			local var_291_7 = arg_288_1.actors_["6148ui_story"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos6148ui_story = var_291_7.localPosition

				local var_291_8 = GameObjectTools.GetOrAddComponent(var_291_7.gameObject, typeof(DynamicBoneHelper))

				if var_291_8 then
					var_291_8:EnableDynamicBone(false)
				end
			end

			local var_291_9 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_9 then
				var_291_7.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_288_1.time_ - 0) / var_291_9)
				var_291_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_7.position).x, (manager.ui.mainCamera.transform.position - var_291_7.position).y, (manager.ui.mainCamera.transform.position - var_291_7.position).z)
				var_291_7.localEulerAngles.z = 0
				var_291_7.localEulerAngles.x = 0
				var_291_7.localEulerAngles = var_291_7.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_9 and arg_288_1.time_ < 0 + var_291_9 + arg_291_0 then
				var_291_7.localPosition = Vector3.New(0.7, -0.985, -6)
				var_291_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_7.position).x, (manager.ui.mainCamera.transform.position - var_291_7.position).y, (manager.ui.mainCamera.transform.position - var_291_7.position).z)
				var_291_7.localEulerAngles.z = 0
				var_291_7.localEulerAngles.x = 0
				var_291_7.localEulerAngles = var_291_7.localEulerAngles

				local var_291_10 = GameObjectTools.GetOrAddComponent(var_291_7.gameObject, typeof(DynamicBoneHelper))

				if var_291_10 then
					var_291_10:EnableDynamicBone(true)
				end
			end

			local var_291_11 = arg_288_1.actors_["1054ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_11) and arg_288_1.var_.characterEffect1054ui_story == nil then
				arg_288_1.var_.characterEffect1054ui_story = var_291_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_12 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_12 and not isNil(var_291_11) then
				if arg_288_1.var_.characterEffect1054ui_story and not isNil(var_291_11) then
					arg_288_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_12 and arg_288_1.time_ < 0 + var_291_12 + arg_291_0 and not isNil(var_291_11) and arg_288_1.var_.characterEffect1054ui_story then
				arg_288_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_291_14 = arg_288_1.actors_["6148ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_14) and arg_288_1.var_.characterEffect6148ui_story == nil then
				arg_288_1.var_.characterEffect6148ui_story = var_291_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_15 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_15 and not isNil(var_291_14) then
				if arg_288_1.var_.characterEffect6148ui_story and not isNil(var_291_14) then
					arg_288_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_15 and arg_288_1.time_ < 0 + var_291_15 + arg_291_0 and not isNil(var_291_14) and arg_288_1.var_.characterEffect6148ui_story then
				arg_288_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_291_17 = 0
			local var_291_18 = 0.2

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_17 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_19 = arg_288_1:GetWordFromCfg(325591070)
				local var_291_20 = arg_288_1:FormatText(var_291_19.content)

				arg_288_1.text_.text = var_291_20

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_22 = 8 <= 0 and var_291_18 or var_291_18 * (utf8.len(var_291_20) / 8)

				if (8 <= 0 and var_291_18 or var_291_18 * (utf8.len(var_291_20) / 8)) > 0 and var_291_18 < var_291_22 then
					arg_288_1.talkMaxDuration = var_291_22

					if var_291_22 + var_291_17 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_22 + var_291_17
					end
				end

				arg_288_1.text_.text = var_291_20
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591070", "story_v_out_325591.awb") ~= 0 then
					local var_291_23 = manager.audio:GetVoiceLength("story_v_out_325591", "325591070", "story_v_out_325591.awb") / 1000

					if var_291_23 + var_291_17 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_23 + var_291_17
					end

					if var_291_19.prefab_name ~= "" and arg_288_1.actors_[var_291_19.prefab_name] ~= nil then
						local var_291_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_19.prefab_name].transform, "story_v_out_325591", "325591070", "story_v_out_325591.awb")

						arg_288_1:RecordAudio("325591070", var_291_24)
						arg_288_1:RecordAudio("325591070", var_291_24)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_325591", "325591070", "story_v_out_325591.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_325591", "325591070", "story_v_out_325591.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_25 = math.max(var_291_18, arg_288_1.talkMaxDuration)

			if var_291_17 <= arg_288_1.time_ and arg_288_1.time_ < var_291_17 + var_291_25 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_17) / var_291_25

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_17 + var_291_25 and arg_288_1.time_ < var_291_17 + var_291_25 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_288_1:InitPlayNodeList()
	end,
	Play325591071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 325591071
		arg_292_1.duration_ = 7.03

		local var_292_0 = {
			zh = 5.833,
			ja = 7.033
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
				arg_292_0:Play325591072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["10176ui_story"]) and arg_292_1.var_.characterEffect10176ui_story == nil then
				arg_292_1.var_.characterEffect10176ui_story = arg_292_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["10176ui_story"]) then
				if arg_292_1.var_.characterEffect10176ui_story and not isNil(arg_292_1.actors_["10176ui_story"]) then
					arg_292_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["10176ui_story"]) and arg_292_1.var_.characterEffect10176ui_story then
				arg_292_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_295_2 = arg_292_1.actors_["10176ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10176ui_story = var_295_2.localPosition

				local var_295_3 = GameObjectTools.GetOrAddComponent(var_295_2.gameObject, typeof(DynamicBoneHelper))

				if var_295_3 then
					var_295_3:EnableDynamicBone(false)
				end
			end

			local var_295_4 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				var_295_2.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_292_1.time_ - 0) / var_295_4)
				var_295_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_2.position).x, (manager.ui.mainCamera.transform.position - var_295_2.position).y, (manager.ui.mainCamera.transform.position - var_295_2.position).z)
				var_295_2.localEulerAngles.z = 0
				var_295_2.localEulerAngles.x = 0
				var_295_2.localEulerAngles = var_295_2.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				var_295_2.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				var_295_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_2.position).x, (manager.ui.mainCamera.transform.position - var_295_2.position).y, (manager.ui.mainCamera.transform.position - var_295_2.position).z)
				var_295_2.localEulerAngles.z = 0
				var_295_2.localEulerAngles.x = 0
				var_295_2.localEulerAngles = var_295_2.localEulerAngles

				local var_295_5 = GameObjectTools.GetOrAddComponent(var_295_2.gameObject, typeof(DynamicBoneHelper))

				if var_295_5 then
					var_295_5:EnableDynamicBone(true)
				end
			end

			local var_295_6 = arg_292_1.actors_["1054ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1054ui_story = var_295_6.localPosition

				local var_295_7 = GameObjectTools.GetOrAddComponent(var_295_6.gameObject, typeof(DynamicBoneHelper))

				if var_295_7 then
					var_295_7:EnableDynamicBone(false)
				end
			end

			local var_295_8 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_8 then
				var_295_6.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_8)
				var_295_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_6.position).x, (manager.ui.mainCamera.transform.position - var_295_6.position).y, (manager.ui.mainCamera.transform.position - var_295_6.position).z)
				var_295_6.localEulerAngles.z = 0
				var_295_6.localEulerAngles.x = 0
				var_295_6.localEulerAngles = var_295_6.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_8 and arg_292_1.time_ < 0 + var_295_8 + arg_295_0 then
				var_295_6.localPosition = Vector3.New(0, 100, 0)
				var_295_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_6.position).x, (manager.ui.mainCamera.transform.position - var_295_6.position).y, (manager.ui.mainCamera.transform.position - var_295_6.position).z)
				var_295_6.localEulerAngles.z = 0
				var_295_6.localEulerAngles.x = 0
				var_295_6.localEulerAngles = var_295_6.localEulerAngles

				local var_295_9 = GameObjectTools.GetOrAddComponent(var_295_6.gameObject, typeof(DynamicBoneHelper))

				if var_295_9 then
					var_295_9:EnableDynamicBone(true)
				end
			end

			local var_295_10 = arg_292_1.actors_["6148ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos6148ui_story = var_295_10.localPosition

				local var_295_11 = GameObjectTools.GetOrAddComponent(var_295_10.gameObject, typeof(DynamicBoneHelper))

				if var_295_11 then
					var_295_11:EnableDynamicBone(false)
				end
			end

			local var_295_12 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_12 then
				var_295_10.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_12)
				var_295_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_10.position).x, (manager.ui.mainCamera.transform.position - var_295_10.position).y, (manager.ui.mainCamera.transform.position - var_295_10.position).z)
				var_295_10.localEulerAngles.z = 0
				var_295_10.localEulerAngles.x = 0
				var_295_10.localEulerAngles = var_295_10.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_12 and arg_292_1.time_ < 0 + var_295_12 + arg_295_0 then
				var_295_10.localPosition = Vector3.New(0, 100, 0)
				var_295_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_10.position).x, (manager.ui.mainCamera.transform.position - var_295_10.position).y, (manager.ui.mainCamera.transform.position - var_295_10.position).z)
				var_295_10.localEulerAngles.z = 0
				var_295_10.localEulerAngles.x = 0
				var_295_10.localEulerAngles = var_295_10.localEulerAngles

				local var_295_13 = GameObjectTools.GetOrAddComponent(var_295_10.gameObject, typeof(DynamicBoneHelper))

				if var_295_13 then
					var_295_13:EnableDynamicBone(true)
				end
			end

			local var_295_14 = 0
			local var_295_15 = 0.425

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_14 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_16 = arg_292_1:GetWordFromCfg(325591071)
				local var_295_17 = arg_292_1:FormatText(var_295_16.content)

				arg_292_1.text_.text = var_295_17

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_19 = 17 <= 0 and var_295_15 or var_295_15 * (utf8.len(var_295_17) / 17)

				if (17 <= 0 and var_295_15 or var_295_15 * (utf8.len(var_295_17) / 17)) > 0 and var_295_15 < var_295_19 then
					arg_292_1.talkMaxDuration = var_295_19

					if var_295_19 + var_295_14 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_19 + var_295_14
					end
				end

				arg_292_1.text_.text = var_295_17
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591071", "story_v_out_325591.awb") ~= 0 then
					local var_295_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591071", "story_v_out_325591.awb") / 1000

					if var_295_20 + var_295_14 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_20 + var_295_14
					end

					if var_295_16.prefab_name ~= "" and arg_292_1.actors_[var_295_16.prefab_name] ~= nil then
						local var_295_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_16.prefab_name].transform, "story_v_out_325591", "325591071", "story_v_out_325591.awb")

						arg_292_1:RecordAudio("325591071", var_295_21)
						arg_292_1:RecordAudio("325591071", var_295_21)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_325591", "325591071", "story_v_out_325591.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_325591", "325591071", "story_v_out_325591.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_22 = math.max(var_295_15, arg_292_1.talkMaxDuration)

			if var_295_14 <= arg_292_1.time_ and arg_292_1.time_ < var_295_14 + var_295_22 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_14) / var_295_22

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_14 + var_295_22 and arg_292_1.time_ < var_295_14 + var_295_22 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_292_1:InitPlayNodeList()
	end,
	Play325591072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 325591072
		arg_296_1.duration_ = 3.73

		local var_296_0 = {
			zh = 3.733,
			ja = 2.7
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play325591073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_2")
			end

			local var_299_0 = 0
			local var_299_1 = 0.3

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_2 = arg_296_1:GetWordFromCfg(325591072)
				local var_299_3 = arg_296_1:FormatText(var_299_2.content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 12 <= 0 and var_299_1 or var_299_1 * (utf8.len(var_299_3) / 12)

				if (12 <= 0 and var_299_1 or var_299_1 * (utf8.len(var_299_3) / 12)) > 0 and var_299_1 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591072", "story_v_out_325591.awb") ~= 0 then
					local var_299_6 = manager.audio:GetVoiceLength("story_v_out_325591", "325591072", "story_v_out_325591.awb") / 1000

					if var_299_6 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_6 + var_299_0
					end

					if var_299_2.prefab_name ~= "" and arg_296_1.actors_[var_299_2.prefab_name] ~= nil then
						local var_299_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_2.prefab_name].transform, "story_v_out_325591", "325591072", "story_v_out_325591.awb")

						arg_296_1:RecordAudio("325591072", var_299_7)
						arg_296_1:RecordAudio("325591072", var_299_7)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_325591", "325591072", "story_v_out_325591.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_325591", "325591072", "story_v_out_325591.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_8 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_8 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_8

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_8 and arg_296_1.time_ < var_299_0 + var_299_8 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play325591073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 325591073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play325591074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10176ui_story = arg_300_1.actors_["10176ui_story"].transform.localPosition

				local var_303_0 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_0 then
					var_303_0:EnableDynamicBone(false)
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_1)
				arg_300_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10176ui_story"].transform.position).z)
				arg_300_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["10176ui_story"].transform.localEulerAngles = arg_300_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_300_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10176ui_story"].transform.position).z)
				arg_300_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["10176ui_story"].transform.localEulerAngles = arg_300_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_303_2 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(true)
				end
			end

			local var_303_3 = arg_300_1.actors_["6148ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos6148ui_story = var_303_3.localPosition

				local var_303_4 = GameObjectTools.GetOrAddComponent(var_303_3.gameObject, typeof(DynamicBoneHelper))

				if var_303_4 then
					var_303_4:EnableDynamicBone(false)
				end
			end

			local var_303_5 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_5 then
				var_303_3.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_5)
				var_303_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_3.position).x, (manager.ui.mainCamera.transform.position - var_303_3.position).y, (manager.ui.mainCamera.transform.position - var_303_3.position).z)
				var_303_3.localEulerAngles.z = 0
				var_303_3.localEulerAngles.x = 0
				var_303_3.localEulerAngles = var_303_3.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_5 and arg_300_1.time_ < 0 + var_303_5 + arg_303_0 then
				var_303_3.localPosition = Vector3.New(0, 100, 0)
				var_303_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_3.position).x, (manager.ui.mainCamera.transform.position - var_303_3.position).y, (manager.ui.mainCamera.transform.position - var_303_3.position).z)
				var_303_3.localEulerAngles.z = 0
				var_303_3.localEulerAngles.x = 0
				var_303_3.localEulerAngles = var_303_3.localEulerAngles

				local var_303_6 = GameObjectTools.GetOrAddComponent(var_303_3.gameObject, typeof(DynamicBoneHelper))

				if var_303_6 then
					var_303_6:EnableDynamicBone(true)
				end
			end

			local var_303_7 = arg_300_1.actors_["1054ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1054ui_story = var_303_7.localPosition

				local var_303_8 = GameObjectTools.GetOrAddComponent(var_303_7.gameObject, typeof(DynamicBoneHelper))

				if var_303_8 then
					var_303_8:EnableDynamicBone(false)
				end
			end

			local var_303_9 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_9 then
				var_303_7.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_9)
				var_303_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_7.position).x, (manager.ui.mainCamera.transform.position - var_303_7.position).y, (manager.ui.mainCamera.transform.position - var_303_7.position).z)
				var_303_7.localEulerAngles.z = 0
				var_303_7.localEulerAngles.x = 0
				var_303_7.localEulerAngles = var_303_7.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_9 and arg_300_1.time_ < 0 + var_303_9 + arg_303_0 then
				var_303_7.localPosition = Vector3.New(0, 100, 0)
				var_303_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_7.position).x, (manager.ui.mainCamera.transform.position - var_303_7.position).y, (manager.ui.mainCamera.transform.position - var_303_7.position).z)
				var_303_7.localEulerAngles.z = 0
				var_303_7.localEulerAngles.x = 0
				var_303_7.localEulerAngles = var_303_7.localEulerAngles

				local var_303_10 = GameObjectTools.GetOrAddComponent(var_303_7.gameObject, typeof(DynamicBoneHelper))

				if var_303_10 then
					var_303_10:EnableDynamicBone(true)
				end
			end

			local var_303_11 = arg_300_1.actors_["10176ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10176ui_story == nil then
				arg_300_1.var_.characterEffect10176ui_story = var_303_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_12 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_12 and not isNil(var_303_11) then
				if arg_300_1.var_.characterEffect10176ui_story and not isNil(var_303_11) then
					arg_300_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_12)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_12 and arg_300_1.time_ < 0 + var_303_12 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10176ui_story then
				arg_300_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_303_14 = 0
			local var_303_15 = 1.175

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_16 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(325591073).content)

				arg_300_1.text_.text = var_303_16

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_18 = 47 <= 0 and var_303_15 or var_303_15 * (utf8.len(var_303_16) / 47)

				if (47 <= 0 and var_303_15 or var_303_15 * (utf8.len(var_303_16) / 47)) > 0 and var_303_15 < var_303_18 then
					arg_300_1.talkMaxDuration = var_303_18

					if var_303_18 + var_303_14 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_18 + var_303_14
					end
				end

				arg_300_1.text_.text = var_303_16
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_19 = math.max(var_303_15, arg_300_1.talkMaxDuration)

			if var_303_14 <= arg_300_1.time_ and arg_300_1.time_ < var_303_14 + var_303_19 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_14) / var_303_19

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_14 + var_303_19 and arg_300_1.time_ < var_303_14 + var_303_19 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
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
			},
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

		arg_300_1:InitPlayNodeList()
	end,
	Play325591074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 325591074
		arg_304_1.duration_ = 9.87

		local var_304_0 = {
			zh = 9.4,
			ja = 9.866
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
				arg_304_0:Play325591075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if arg_304_1.bgs_.J26h == nil then
				local var_307_0 = Object.Instantiate(arg_304_1.paintGo_)

				var_307_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J26h")
				var_307_0.name = "J26h"
				var_307_0.transform.parent = arg_304_1.stage_.transform
				var_307_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.bgs_.J26h = var_307_0
			end

			if 2 < arg_304_1.time_ and arg_304_1.time_ <= 2 + arg_307_0 then
				local var_307_1 = arg_304_1.bgs_.J26h

				arg_304_1.bgs_.J26h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_307_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_307_2 = var_307_1:GetComponent("SpriteRenderer")

				if var_307_2 and var_307_2.sprite then
					local var_307_3 = 2 * (var_307_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_307_1.transform.localScale = Vector3.New(var_307_3 / var_307_2.sprite.bounds.size.y < var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x and var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x or var_307_3 / var_307_2.sprite.bounds.size.y, var_307_3 / var_307_2.sprite.bounds.size.y < var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x and var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x or var_307_3 / var_307_2.sprite.bounds.size.y, 0)
				end

				for iter_307_0, iter_307_1 in pairs(arg_304_1.bgs_) do
					if iter_307_0 ~= "J26h" then
						iter_307_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_307_4 = 4

			if 4 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.allBtn_.enabled = false
			end

			if arg_304_1.time_ >= var_307_4 + 0.3 and arg_304_1.time_ < var_307_4 + 0.3 + arg_307_0 then
				arg_304_1.allBtn_.enabled = true
			end

			local var_307_5 = 0

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_6 = 2

			if var_307_5 <= arg_304_1.time_ and arg_304_1.time_ < var_307_5 + var_307_6 then
				local var_307_7 = Color.New(0, 0, 0)

				var_307_7.a = Mathf.Lerp(0, 1, (arg_304_1.time_ - var_307_5) / var_307_6)
				arg_304_1.mask_.color = var_307_7
			end

			if arg_304_1.time_ >= var_307_5 + var_307_6 and arg_304_1.time_ < var_307_5 + var_307_6 + arg_307_0 then
				local var_307_8 = Color.New(0, 0, 0)

				var_307_8.a = 1
				arg_304_1.mask_.color = var_307_8
			end

			local var_307_9 = 2

			if 2 < arg_304_1.time_ and arg_304_1.time_ <= var_307_9 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_10 = 2

			if var_307_9 <= arg_304_1.time_ and arg_304_1.time_ < var_307_9 + var_307_10 then
				local var_307_11 = Color.New(0, 0, 0)

				var_307_11.a = Mathf.Lerp(1, 0, (arg_304_1.time_ - var_307_9) / var_307_10)
				arg_304_1.mask_.color = var_307_11
			end

			if arg_304_1.time_ >= var_307_9 + var_307_10 and arg_304_1.time_ < var_307_9 + var_307_10 + arg_307_0 then
				local var_307_12 = Color.New(0, 0, 0)

				arg_304_1.mask_.enabled = false
				var_307_12.a = 0
				arg_304_1.mask_.color = var_307_12
			end

			local var_307_13 = "10175ui_story"

			if arg_304_1.actors_["10175ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10175ui_story"))) then
				local var_307_14 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_304_1.stage_.transform)

				var_307_14.name = var_307_13
				var_307_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.actors_[var_307_13] = var_307_14

				local var_307_15 = var_307_14:GetComponentInChildren(typeof(CharacterEffect))

				var_307_15.enabled = true

				local var_307_16 = GameObjectTools.GetOrAddComponent(var_307_14, typeof(DynamicBoneHelper))

				if var_307_16 then
					var_307_16:EnableDynamicBone(false)
				end

				arg_304_1:ShowWeapon(var_307_15.transform, false)

				arg_304_1.var_[var_307_13 .. "Animator"] = var_307_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_304_1.var_[var_307_13 .. "Animator"].applyRootMotion = true
				arg_304_1.var_[var_307_13 .. "LipSync"] = var_307_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_307_17 = arg_304_1.actors_["10175ui_story"].transform

			if 3.83333333333333 < arg_304_1.time_ and arg_304_1.time_ <= 3.83333333333333 + arg_307_0 then
				arg_304_1.var_.moveOldPos10175ui_story = var_307_17.localPosition

				local var_307_18 = GameObjectTools.GetOrAddComponent(var_307_17.gameObject, typeof(DynamicBoneHelper))

				if var_307_18 then
					var_307_18:EnableDynamicBone(false)
				end
			end

			local var_307_19 = 0.001

			if 3.83333333333333 <= arg_304_1.time_ and arg_304_1.time_ < 3.83333333333333 + var_307_19 then
				var_307_17.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_304_1.time_ - 3.83333333333333) / var_307_19)
				var_307_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_17.position).x, (manager.ui.mainCamera.transform.position - var_307_17.position).y, (manager.ui.mainCamera.transform.position - var_307_17.position).z)
				var_307_17.localEulerAngles.z = 0
				var_307_17.localEulerAngles.x = 0
				var_307_17.localEulerAngles = var_307_17.localEulerAngles
			end

			if arg_304_1.time_ >= 3.83333333333333 + var_307_19 and arg_304_1.time_ < 3.83333333333333 + var_307_19 + arg_307_0 then
				var_307_17.localPosition = Vector3.New(0, -1, -6.05)
				var_307_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_17.position).x, (manager.ui.mainCamera.transform.position - var_307_17.position).y, (manager.ui.mainCamera.transform.position - var_307_17.position).z)
				var_307_17.localEulerAngles.z = 0
				var_307_17.localEulerAngles.x = 0
				var_307_17.localEulerAngles = var_307_17.localEulerAngles

				local var_307_20 = GameObjectTools.GetOrAddComponent(var_307_17.gameObject, typeof(DynamicBoneHelper))

				if var_307_20 then
					var_307_20:EnableDynamicBone(true)
				end
			end

			local var_307_21 = arg_304_1.actors_["10175ui_story"]

			if 3.83333333333333 < arg_304_1.time_ and arg_304_1.time_ <= 3.83333333333333 + arg_307_0 and not isNil(var_307_21) and arg_304_1.var_.characterEffect10175ui_story == nil then
				arg_304_1.var_.characterEffect10175ui_story = var_307_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_22 = 0.200000002980232

			if 3.83333333333333 <= arg_304_1.time_ and arg_304_1.time_ < 3.83333333333333 + var_307_22 and not isNil(var_307_21) then
				if arg_304_1.var_.characterEffect10175ui_story and not isNil(var_307_21) then
					arg_304_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 3.83333333333333 + var_307_22 and arg_304_1.time_ < 3.83333333333333 + var_307_22 + arg_307_0 and not isNil(var_307_21) and arg_304_1.var_.characterEffect10175ui_story then
				arg_304_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_304_1.time_ and arg_304_1.time_ <= 3.83333333333333 + arg_307_0 then
				arg_304_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 3.83333333333333 < arg_304_1.time_ and arg_304_1.time_ <= 3.83333333333333 + arg_307_0 then
				arg_304_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_307_26 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_304_1.bgmTxt_.text ~= var_307_26 and arg_304_1.bgmTxt_.text ~= "" then
						if arg_304_1.bgmTxt2_.text ~= "" then
							arg_304_1.bgmTxt_.text = arg_304_1.bgmTxt2_.text
						end

						arg_304_1.bgmTxt2_.text = var_307_26

						arg_304_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_304_1.bgmTxt_.text = var_307_26
						arg_304_1.bgmTxt2_.text = var_307_26
					end

					if arg_304_1.bgmTimer then
						arg_304_1.bgmTimer:Stop()

						arg_304_1.bgmTimer = nil
					end

					if arg_304_1.settingData.show_music_name == 1 then
						arg_304_1.musicController:SetSelectedState("show")
						arg_304_1.musicAnimator_:Play("open", 0, 0)

						if arg_304_1.settingData.music_time ~= 0 then
							arg_304_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_304_1.settingData.music_time), function()
								if arg_304_1 == nil or isNil(arg_304_1.bgmTxt_) then
									return
								end

								arg_304_1.musicController:SetSelectedState("hide")
								arg_304_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_304_1.frameCnt_ <= 1 then
				arg_304_1.dialog_:SetActive(false)
			end

			local var_307_27 = 4
			local var_307_28 = 0.725

			if 4 < arg_304_1.time_ and arg_304_1.time_ <= var_307_27 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				arg_304_1.dialog_:SetActive(true)

				arg_304_1.dialogCg_.alpha = 0

				local var_307_29 = LeanTween.value(arg_304_1.dialog_, 0, 1, 0.3)

				var_307_29:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_304_1.dialogCg_.alpha = arg_309_0
				end))
				var_307_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_304_1.dialog_)
					var_307_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_304_1.duration_ = arg_304_1.duration_ + 0.3

				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_30 = arg_304_1:GetWordFromCfg(325591074)
				local var_307_31 = arg_304_1:FormatText(var_307_30.content)

				arg_304_1.text_.text = var_307_31

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_33 = 29 <= 0 and var_307_28 or var_307_28 * (utf8.len(var_307_31) / 29)

				if (29 <= 0 and var_307_28 or var_307_28 * (utf8.len(var_307_31) / 29)) > 0 and var_307_28 < var_307_33 then
					arg_304_1.talkMaxDuration = var_307_33
					var_307_27 = var_307_27 + 0.3

					if var_307_33 + var_307_27 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_33 + var_307_27
					end
				end

				arg_304_1.text_.text = var_307_31
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591074", "story_v_out_325591.awb") ~= 0 then
					local var_307_34 = manager.audio:GetVoiceLength("story_v_out_325591", "325591074", "story_v_out_325591.awb") / 1000

					if var_307_34 + var_307_27 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_34 + var_307_27
					end

					if var_307_30.prefab_name ~= "" and arg_304_1.actors_[var_307_30.prefab_name] ~= nil then
						local var_307_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_30.prefab_name].transform, "story_v_out_325591", "325591074", "story_v_out_325591.awb")

						arg_304_1:RecordAudio("325591074", var_307_35)
						arg_304_1:RecordAudio("325591074", var_307_35)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_325591", "325591074", "story_v_out_325591.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_325591", "325591074", "story_v_out_325591.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_36 = var_307_27 + 0.3
			local var_307_37 = math.max(var_307_28, arg_304_1.talkMaxDuration)

			if var_307_27 + 0.3 <= arg_304_1.time_ and arg_304_1.time_ < var_307_36 + var_307_37 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_36) / var_307_37

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_36 + var_307_37 and arg_304_1.time_ < var_307_36 + var_307_37 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play325591075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 325591075
		arg_311_1.duration_ = 6.3

		local var_311_0 = {
			zh = 5.933,
			ja = 6.3
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play325591076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.675

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(325591075)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 27)

				if (27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 27)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591075", "story_v_out_325591.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_325591", "325591075", "story_v_out_325591.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_325591", "325591075", "story_v_out_325591.awb")

						arg_311_1:RecordAudio("325591075", var_314_6)
						arg_311_1:RecordAudio("325591075", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_325591", "325591075", "story_v_out_325591.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_325591", "325591075", "story_v_out_325591.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play325591076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 325591076
		arg_315_1.duration_ = 6.5

		local var_315_0 = {
			zh = 5.566,
			ja = 6.5
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play325591077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10175ui_story = arg_315_1.actors_["10175ui_story"].transform.localPosition

				local var_318_0 = GameObjectTools.GetOrAddComponent(arg_315_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_318_0 then
					var_318_0:EnableDynamicBone(false)
				end
			end

			local var_318_1 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 then
				arg_315_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10175ui_story, Vector3.New(-0.7, -1, -6.05), (arg_315_1.time_ - 0) / var_318_1)
				arg_315_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10175ui_story"].transform.position).z)
				arg_315_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["10175ui_story"].transform.localEulerAngles = arg_315_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 then
				arg_315_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_315_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10175ui_story"].transform.position).z)
				arg_315_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["10175ui_story"].transform.localEulerAngles = arg_315_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_318_2 = GameObjectTools.GetOrAddComponent(arg_315_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_318_2 then
					var_318_2:EnableDynamicBone(true)
				end
			end

			local var_318_3 = arg_315_1.actors_["6148ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos6148ui_story = var_318_3.localPosition

				local var_318_4 = GameObjectTools.GetOrAddComponent(var_318_3.gameObject, typeof(DynamicBoneHelper))

				if var_318_4 then
					var_318_4:EnableDynamicBone(false)
				end
			end

			local var_318_5 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_5 then
				var_318_3.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_315_1.time_ - 0) / var_318_5)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_5 and arg_315_1.time_ < 0 + var_318_5 + arg_318_0 then
				var_318_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles

				local var_318_6 = GameObjectTools.GetOrAddComponent(var_318_3.gameObject, typeof(DynamicBoneHelper))

				if var_318_6 then
					var_318_6:EnableDynamicBone(true)
				end
			end

			local var_318_7 = arg_315_1.actors_["6148ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.characterEffect6148ui_story == nil then
				arg_315_1.var_.characterEffect6148ui_story = var_318_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_8 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_8 and not isNil(var_318_7) then
				if arg_315_1.var_.characterEffect6148ui_story and not isNil(var_318_7) then
					arg_315_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_8 and arg_315_1.time_ < 0 + var_318_8 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.characterEffect6148ui_story then
				arg_315_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_318_10 = arg_315_1.actors_["10175ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_10) and arg_315_1.var_.characterEffect10175ui_story == nil then
				arg_315_1.var_.characterEffect10175ui_story = var_318_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_11 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_11 and not isNil(var_318_10) then
				if arg_315_1.var_.characterEffect10175ui_story and not isNil(var_318_10) then
					arg_315_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_11)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_11 and arg_315_1.time_ < 0 + var_318_11 + arg_318_0 and not isNil(var_318_10) and arg_315_1.var_.characterEffect10175ui_story then
				arg_315_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_318_12 = 0
			local var_318_13 = 0.65

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_14 = arg_315_1:GetWordFromCfg(325591076)
				local var_318_15 = arg_315_1:FormatText(var_318_14.content)

				arg_315_1.text_.text = var_318_15

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_17 = 26 <= 0 and var_318_13 or var_318_13 * (utf8.len(var_318_15) / 26)

				if (26 <= 0 and var_318_13 or var_318_13 * (utf8.len(var_318_15) / 26)) > 0 and var_318_13 < var_318_17 then
					arg_315_1.talkMaxDuration = var_318_17

					if var_318_17 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_17 + var_318_12
					end
				end

				arg_315_1.text_.text = var_318_15
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591076", "story_v_out_325591.awb") ~= 0 then
					local var_318_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591076", "story_v_out_325591.awb") / 1000

					if var_318_18 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_18 + var_318_12
					end

					if var_318_14.prefab_name ~= "" and arg_315_1.actors_[var_318_14.prefab_name] ~= nil then
						local var_318_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_14.prefab_name].transform, "story_v_out_325591", "325591076", "story_v_out_325591.awb")

						arg_315_1:RecordAudio("325591076", var_318_19)
						arg_315_1:RecordAudio("325591076", var_318_19)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_325591", "325591076", "story_v_out_325591.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_325591", "325591076", "story_v_out_325591.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_20 = math.max(var_318_13, arg_315_1.talkMaxDuration)

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_20 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_12) / var_318_20

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_12 + var_318_20 and arg_315_1.time_ < var_318_12 + var_318_20 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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

		arg_315_1:InitPlayNodeList()
	end,
	Play325591077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 325591077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play325591078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos6148ui_story = arg_319_1.actors_["6148ui_story"].transform.localPosition

				local var_322_0 = GameObjectTools.GetOrAddComponent(arg_319_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_322_0 then
					var_322_0:EnableDynamicBone(false)
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_319_1.time_ - 0) / var_322_1)
				arg_319_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["6148ui_story"].transform.position).z)
				arg_319_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["6148ui_story"].transform.localEulerAngles = arg_319_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_319_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["6148ui_story"].transform.position).z)
				arg_319_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["6148ui_story"].transform.localEulerAngles = arg_319_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_322_2 = GameObjectTools.GetOrAddComponent(arg_319_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_322_2 then
					var_322_2:EnableDynamicBone(true)
				end
			end

			local var_322_3 = arg_319_1.actors_["10175ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10175ui_story = var_322_3.localPosition

				local var_322_4 = GameObjectTools.GetOrAddComponent(var_322_3.gameObject, typeof(DynamicBoneHelper))

				if var_322_4 then
					var_322_4:EnableDynamicBone(false)
				end
			end

			local var_322_5 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_5 then
				var_322_3.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_319_1.time_ - 0) / var_322_5)
				var_322_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_3.position).x, (manager.ui.mainCamera.transform.position - var_322_3.position).y, (manager.ui.mainCamera.transform.position - var_322_3.position).z)
				var_322_3.localEulerAngles.z = 0
				var_322_3.localEulerAngles.x = 0
				var_322_3.localEulerAngles = var_322_3.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_5 and arg_319_1.time_ < 0 + var_322_5 + arg_322_0 then
				var_322_3.localPosition = Vector3.New(0, 100, 0)
				var_322_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_3.position).x, (manager.ui.mainCamera.transform.position - var_322_3.position).y, (manager.ui.mainCamera.transform.position - var_322_3.position).z)
				var_322_3.localEulerAngles.z = 0
				var_322_3.localEulerAngles.x = 0
				var_322_3.localEulerAngles = var_322_3.localEulerAngles

				local var_322_6 = GameObjectTools.GetOrAddComponent(var_322_3.gameObject, typeof(DynamicBoneHelper))

				if var_322_6 then
					var_322_6:EnableDynamicBone(true)
				end
			end

			local var_322_7 = arg_319_1.actors_["6148ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_7) and arg_319_1.var_.characterEffect6148ui_story == nil then
				arg_319_1.var_.characterEffect6148ui_story = var_322_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_8 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_8 and not isNil(var_322_7) then
				if arg_319_1.var_.characterEffect6148ui_story and not isNil(var_322_7) then
					arg_319_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_319_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_8)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_8 and arg_319_1.time_ < 0 + var_322_8 + arg_322_0 and not isNil(var_322_7) and arg_319_1.var_.characterEffect6148ui_story then
				arg_319_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_319_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_322_9 = 0
			local var_322_10 = 1.3

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_11 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(325591077).content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 52 <= 0 and var_322_10 or var_322_10 * (utf8.len(var_322_11) / 52)

				if (52 <= 0 and var_322_10 or var_322_10 * (utf8.len(var_322_11) / 52)) > 0 and var_322_10 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_9 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_9
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_14 = math.max(var_322_10, arg_319_1.talkMaxDuration)

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_9) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_9 + var_322_14 and arg_319_1.time_ < var_322_9 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play325591078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 325591078
		arg_323_1.duration_ = 5.3

		local var_323_0 = {
			zh = 4.433,
			ja = 5.3
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
			arg_323_1.auto_ = false
		end

		function arg_323_1.playNext_(arg_325_0)
			arg_323_1.onStoryFinished_()
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10175ui_story = arg_323_1.actors_["10175ui_story"].transform.localPosition

				local var_326_0 = GameObjectTools.GetOrAddComponent(arg_323_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_326_0 then
					var_326_0:EnableDynamicBone(false)
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_323_1.time_ - 0) / var_326_1)
				arg_323_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10175ui_story"].transform.position).z)
				arg_323_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["10175ui_story"].transform.localEulerAngles = arg_323_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_323_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10175ui_story"].transform.position).z)
				arg_323_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["10175ui_story"].transform.localEulerAngles = arg_323_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_326_2 = GameObjectTools.GetOrAddComponent(arg_323_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(true)
				end
			end

			local var_326_3 = arg_323_1.actors_["10175ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_3) and arg_323_1.var_.characterEffect10175ui_story == nil then
				arg_323_1.var_.characterEffect10175ui_story = var_326_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_4 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 and not isNil(var_326_3) then
				if arg_323_1.var_.characterEffect10175ui_story and not isNil(var_326_3) then
					arg_323_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 and not isNil(var_326_3) and arg_323_1.var_.characterEffect10175ui_story then
				arg_323_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action38_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_326_7 = 0
			local var_326_8 = 0.325

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_9 = arg_323_1:GetWordFromCfg(325591078)
				local var_326_10 = arg_323_1:FormatText(var_326_9.content)

				arg_323_1.text_.text = var_326_10

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_12 = 13 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_10) / 13)

				if (13 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_10) / 13)) > 0 and var_326_8 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_7
					end
				end

				arg_323_1.text_.text = var_326_10
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591078", "story_v_out_325591.awb") ~= 0 then
					local var_326_13 = manager.audio:GetVoiceLength("story_v_out_325591", "325591078", "story_v_out_325591.awb") / 1000

					if var_326_13 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_7
					end

					if var_326_9.prefab_name ~= "" and arg_323_1.actors_[var_326_9.prefab_name] ~= nil then
						local var_326_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_9.prefab_name].transform, "story_v_out_325591", "325591078", "story_v_out_325591.awb")

						arg_323_1:RecordAudio("325591078", var_326_14)
						arg_323_1:RecordAudio("325591078", var_326_14)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_325591", "325591078", "story_v_out_325591.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_325591", "325591078", "story_v_out_325591.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_15 = math.max(var_326_8, arg_323_1.talkMaxDuration)

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_15 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_7) / var_326_15

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_7 + var_326_15 and arg_323_1.time_ < var_326_7 + var_326_15 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J28f",
		"TextureConfig/Background/J28h",
		"TextureConfig/Background/J26h"
	},
	voices = {
		"story_v_out_325591.awb"
	}
}
