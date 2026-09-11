return {
	Play325132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325132001
		arg_1_1.duration_ = 6.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J23g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23g")
				var_4_0.name = "J23g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J23g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J23g

				arg_1_1.bgs_.J23g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J23g" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_workshop", "")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlightbroken", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 1.66666666666667
			local var_4_15 = 0.7

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325132001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 28 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 28)

				if (28 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 28)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325132002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325132002
		arg_8_1.duration_ = 6.57

		local var_8_0 = {
			zh = 3.8,
			ja = 6.566
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
				arg_8_0:Play325132003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1053ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1053ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1053ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1053ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1053ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1053ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1053ui_story = var_11_3.localPosition

				local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_4 then
					var_11_4:EnableDynamicBone(false)
				end
			end

			local var_11_5 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_5 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_8_1.time_ - 0) / var_11_5)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_5 and arg_8_1.time_ < 0 + var_11_5 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -1.08, -6)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles

				local var_11_6 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_6 then
					var_11_6:EnableDynamicBone(true)
				end
			end

			local var_11_7 = arg_8_1.actors_["1053ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1053ui_story == nil then
				arg_8_1.var_.characterEffect1053ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect1053ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1053ui_story then
				arg_8_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action8_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_11_10 = 0
			local var_11_11 = 0.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(325132002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 14 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 14)

				if (14 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 14)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132002", "story_v_out_325132.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132002", "story_v_out_325132.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_325132", "325132002", "story_v_out_325132.awb")

						arg_8_1:RecordAudio("325132002", var_11_17)
						arg_8_1:RecordAudio("325132002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325132", "325132002", "story_v_out_325132.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325132", "325132002", "story_v_out_325132.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_18 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_18 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_18

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_18 and arg_8_1.time_ < var_11_10 + var_11_18 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play325132003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325132003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325132004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1053ui_story = arg_12_1.actors_["1053ui_story"].transform.localPosition

				local var_15_0 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_0 then
					var_15_0:EnableDynamicBone(false)
				end
			end

			local var_15_1 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_1 then
				arg_12_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_1)
				arg_12_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1053ui_story"].transform.position).z)
				arg_12_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1053ui_story"].transform.localEulerAngles = arg_12_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_1 and arg_12_1.time_ < 0 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1053ui_story"].transform.position).z)
				arg_12_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1053ui_story"].transform.localEulerAngles = arg_12_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_15_2 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(true)
				end
			end

			local var_15_3 = arg_12_1.actors_["1053ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1053ui_story == nil then
				arg_12_1.var_.characterEffect1053ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1053ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_4)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1053ui_story then
				arg_12_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_12_1.time_ and arg_12_1.time_ <= 0.3 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_148", "se_story_148_magic_fire02", "")
			end

			local var_15_6 = 0
			local var_15_7 = 0.975

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325132003).content)

				arg_12_1.text_.text = var_15_8

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 39 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_8) / 39)

				if (39 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_8) / 39)) > 0 and var_15_7 < var_15_10 then
					arg_12_1.talkMaxDuration = var_15_10

					if var_15_10 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_8
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_11 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_11 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_11

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_11 and arg_12_1.time_ < var_15_6 + var_15_11 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play325132004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325132004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325132005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.95

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

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(325132004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 38 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 38)

				if (38 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 38)) > 0 and var_19_0 < var_19_3 then
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
	Play325132005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325132005
		arg_20_1.duration_ = 4.1

		local var_20_0 = {
			zh = 3.8,
			ja = 4.1
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
				arg_20_0:Play325132006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1077ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1077ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1077ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1077ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1077ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1077ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1077ui_story = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = arg_20_1.actors_["1077ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1077ui_story then
				arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_10 = 0
			local var_23_11 = 0.375

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
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

				local var_23_12 = arg_20_1:GetWordFromCfg(325132005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 15 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 15)

				if (15 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 15)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132005", "story_v_out_325132.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132005", "story_v_out_325132.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_325132", "325132005", "story_v_out_325132.awb")

						arg_20_1:RecordAudio("325132005", var_23_17)
						arg_20_1:RecordAudio("325132005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325132", "325132005", "story_v_out_325132.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325132", "325132005", "story_v_out_325132.awb")
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
				actorName = "1077ui_story",
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
	Play325132006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325132006
		arg_24_1.duration_ = 2.77

		local var_24_0 = {
			zh = 2.166,
			ja = 2.766
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
				arg_24_0:Play325132007(arg_24_1)
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
				arg_24_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).z)
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles = arg_24_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).z)
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles = arg_24_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = 0
			local var_27_4 = 0.15

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_5 = arg_24_1:GetWordFromCfg(325132006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 6 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 6)

				if (6 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 6)) > 0 and var_27_4 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_3
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132006", "story_v_out_325132.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_325132", "325132006", "story_v_out_325132.awb") / 1000

					if var_27_9 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_3
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_325132", "325132006", "story_v_out_325132.awb")

						arg_24_1:RecordAudio("325132006", var_27_10)
						arg_24_1:RecordAudio("325132006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325132", "325132006", "story_v_out_325132.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325132", "325132006", "story_v_out_325132.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_4, arg_24_1.talkMaxDuration)

			if var_27_3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_3 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_3) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_3 + var_27_11 and arg_24_1.time_ < var_27_3 + var_27_11 + arg_27_0 then
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
	Play325132007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325132007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325132008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1059ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1059ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1059ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1059ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1059ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1059ui_story == nil then
				arg_28_1.var_.characterEffect1059ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect1059ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_4)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1059ui_story then
				arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_31_5 = 0
			local var_31_6 = 1.125

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(325132007).content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 45 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 45)

				if (45 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 45)) > 0 and var_31_6 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_10 and arg_28_1.time_ < var_31_5 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325132008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325132008
		arg_32_1.duration_ = 5.6

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325132009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= 0 + 1.43333333333333 and arg_32_1.time_ < 0 + 1.43333333333333 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			if 0.3 < arg_32_1.time_ and arg_32_1.time_ <= 0.3 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_8", "se_story_8_water03", "")
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_1 = 0.6
			local var_35_2 = 1.375

			if 0.6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_3 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_3:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(325132008).content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 55 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 55)

				if (55 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 55)) > 0 and var_35_2 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6
					var_35_1 = var_35_1 + 0.3

					if var_35_6 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = var_35_1 + 0.3
			local var_35_8 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_7) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play325132009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325132009
		arg_38_1.duration_ = 8.4

		local var_38_0 = {
			zh = 5.166,
			ja = 8.4
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
				arg_38_0:Play325132010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if arg_38_1.actors_["10180ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10180ui_story"))) then
				local var_41_0 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_38_1.stage_.transform)

				var_41_0.name = "10180ui_story"
				var_41_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["10180ui_story"] = var_41_0

				local var_41_1 = var_41_0:GetComponentInChildren(typeof(CharacterEffect))

				var_41_1.enabled = true

				local var_41_2 = GameObjectTools.GetOrAddComponent(var_41_0, typeof(DynamicBoneHelper))

				if var_41_2 then
					var_41_2:EnableDynamicBone(false)
				end

				arg_38_1:ShowWeapon(var_41_1.transform, false)

				arg_38_1.var_["10180ui_story" .. "Animator"] = var_41_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_38_1.var_["10180ui_story" .. "Animator"].applyRootMotion = true
				arg_38_1.var_["10180ui_story" .. "LipSync"] = var_41_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_41_3 = arg_38_1.actors_["10180ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10180ui_story = var_41_3.localPosition

				local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_3.gameObject, typeof(DynamicBoneHelper))

				if var_41_4 then
					var_41_4:EnableDynamicBone(false)
				end
			end

			local var_41_5 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_5 then
				var_41_3.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_38_1.time_ - 0) / var_41_5)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_5 and arg_38_1.time_ < 0 + var_41_5 + arg_41_0 then
				var_41_3.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles

				local var_41_6 = GameObjectTools.GetOrAddComponent(var_41_3.gameObject, typeof(DynamicBoneHelper))

				if var_41_6 then
					var_41_6:EnableDynamicBone(true)
				end
			end

			local var_41_7 = arg_38_1.actors_["10180ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect10180ui_story == nil then
				arg_38_1.var_.characterEffect10180ui_story = var_41_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_8 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_8 and not isNil(var_41_7) then
				if arg_38_1.var_.characterEffect10180ui_story and not isNil(var_41_7) then
					arg_38_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_8 and arg_38_1.time_ < 0 + var_41_8 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect10180ui_story then
				arg_38_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_41_10 = 0
			local var_41_11 = 0.45

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_12 = arg_38_1:GetWordFromCfg(325132009)
				local var_41_13 = arg_38_1:FormatText(var_41_12.content)

				arg_38_1.text_.text = var_41_13

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_15 = 18 <= 0 and var_41_11 or var_41_11 * (utf8.len(var_41_13) / 18)

				if (18 <= 0 and var_41_11 or var_41_11 * (utf8.len(var_41_13) / 18)) > 0 and var_41_11 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_10
					end
				end

				arg_38_1.text_.text = var_41_13
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132009", "story_v_out_325132.awb") ~= 0 then
					local var_41_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132009", "story_v_out_325132.awb") / 1000

					if var_41_16 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_10
					end

					if var_41_12.prefab_name ~= "" and arg_38_1.actors_[var_41_12.prefab_name] ~= nil then
						local var_41_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_12.prefab_name].transform, "story_v_out_325132", "325132009", "story_v_out_325132.awb")

						arg_38_1:RecordAudio("325132009", var_41_17)
						arg_38_1:RecordAudio("325132009", var_41_17)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_325132", "325132009", "story_v_out_325132.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_325132", "325132009", "story_v_out_325132.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = math.max(var_41_11, arg_38_1.talkMaxDuration)

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_18 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_10) / var_41_18

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_10 + var_41_18 and arg_38_1.time_ < var_41_10 + var_41_18 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
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

		arg_38_1:InitPlayNodeList()
	end,
	Play325132010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325132010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325132011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["10180ui_story"]) and arg_42_1.var_.characterEffect10180ui_story == nil then
				arg_42_1.var_.characterEffect10180ui_story = arg_42_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["10180ui_story"]) then
				if arg_42_1.var_.characterEffect10180ui_story and not isNil(arg_42_1.actors_["10180ui_story"]) then
					arg_42_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["10180ui_story"]) and arg_42_1.var_.characterEffect10180ui_story then
				arg_42_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 1.425

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_3 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(325132010).content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 57 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 57)

				if (57 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 57)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_6 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_6 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_6

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_6 and arg_42_1.time_ < var_45_1 + var_45_6 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325132011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325132011
		arg_46_1.duration_ = 7.87

		local var_46_0 = {
			zh = 5,
			ja = 7.866
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
				arg_46_0:Play325132012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if arg_46_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_49_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_46_1.stage_.transform)

				var_49_0.name = "1061ui_story"
				var_49_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1061ui_story"] = var_49_0

				local var_49_1 = var_49_0:GetComponentInChildren(typeof(CharacterEffect))

				var_49_1.enabled = true

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end

				arg_46_1:ShowWeapon(var_49_1.transform, false)

				arg_46_1.var_["1061ui_story" .. "Animator"] = var_49_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_46_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_46_1.var_["1061ui_story" .. "LipSync"] = var_49_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_49_3 = arg_46_1.actors_["1061ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1061ui_story == nil then
				arg_46_1.var_.characterEffect1061ui_story = var_49_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_4 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 and not isNil(var_49_3) then
				if arg_46_1.var_.characterEffect1061ui_story and not isNil(var_49_3) then
					arg_46_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1061ui_story then
				arg_46_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_49_6 = arg_46_1.actors_["10180ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos10180ui_story = var_49_6.localPosition

				local var_49_7 = GameObjectTools.GetOrAddComponent(var_49_6.gameObject, typeof(DynamicBoneHelper))

				if var_49_7 then
					var_49_7:EnableDynamicBone(false)
				end
			end

			local var_49_8 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_8 then
				var_49_6.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10180ui_story, Vector3.New(-0.8, -1.09, -6.14), (arg_46_1.time_ - 0) / var_49_8)
				var_49_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_6.position).x, (manager.ui.mainCamera.transform.position - var_49_6.position).y, (manager.ui.mainCamera.transform.position - var_49_6.position).z)
				var_49_6.localEulerAngles.z = 0
				var_49_6.localEulerAngles.x = 0
				var_49_6.localEulerAngles = var_49_6.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_8 and arg_46_1.time_ < 0 + var_49_8 + arg_49_0 then
				var_49_6.localPosition = Vector3.New(-0.8, -1.09, -6.14)
				var_49_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_6.position).x, (manager.ui.mainCamera.transform.position - var_49_6.position).y, (manager.ui.mainCamera.transform.position - var_49_6.position).z)
				var_49_6.localEulerAngles.z = 0
				var_49_6.localEulerAngles.x = 0
				var_49_6.localEulerAngles = var_49_6.localEulerAngles

				local var_49_9 = GameObjectTools.GetOrAddComponent(var_49_6.gameObject, typeof(DynamicBoneHelper))

				if var_49_9 then
					var_49_9:EnableDynamicBone(true)
				end
			end

			local var_49_10 = arg_46_1.actors_["1061ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1061ui_story = var_49_10.localPosition
			end

			local var_49_11 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_11 then
				var_49_10.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_46_1.time_ - 0) / var_49_11)
				var_49_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_10.position).x, (manager.ui.mainCamera.transform.position - var_49_10.position).y, (manager.ui.mainCamera.transform.position - var_49_10.position).z)
				var_49_10.localEulerAngles.z = 0
				var_49_10.localEulerAngles.x = 0
				var_49_10.localEulerAngles = var_49_10.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_11 and arg_46_1.time_ < 0 + var_49_11 + arg_49_0 then
				var_49_10.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_49_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_10.position).x, (manager.ui.mainCamera.transform.position - var_49_10.position).y, (manager.ui.mainCamera.transform.position - var_49_10.position).z)
				var_49_10.localEulerAngles.z = 0
				var_49_10.localEulerAngles.x = 0
				var_49_10.localEulerAngles = var_49_10.localEulerAngles
			end

			local var_49_12 = 0
			local var_49_13 = 0.55

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
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

				local var_49_14 = arg_46_1:GetWordFromCfg(325132011)
				local var_49_15 = arg_46_1:FormatText(var_49_14.content)

				arg_46_1.text_.text = var_49_15

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_17 = 22 <= 0 and var_49_13 or var_49_13 * (utf8.len(var_49_15) / 22)

				if (22 <= 0 and var_49_13 or var_49_13 * (utf8.len(var_49_15) / 22)) > 0 and var_49_13 < var_49_17 then
					arg_46_1.talkMaxDuration = var_49_17

					if var_49_17 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_17 + var_49_12
					end
				end

				arg_46_1.text_.text = var_49_15
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132011", "story_v_out_325132.awb") ~= 0 then
					local var_49_18 = manager.audio:GetVoiceLength("story_v_out_325132", "325132011", "story_v_out_325132.awb") / 1000

					if var_49_18 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_18 + var_49_12
					end

					if var_49_14.prefab_name ~= "" and arg_46_1.actors_[var_49_14.prefab_name] ~= nil then
						local var_49_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_14.prefab_name].transform, "story_v_out_325132", "325132011", "story_v_out_325132.awb")

						arg_46_1:RecordAudio("325132011", var_49_19)
						arg_46_1:RecordAudio("325132011", var_49_19)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325132", "325132011", "story_v_out_325132.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325132", "325132011", "story_v_out_325132.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_20 = math.max(var_49_13, arg_46_1.talkMaxDuration)

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_20 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_12) / var_49_20

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_12 + var_49_20 and arg_46_1.time_ < var_49_12 + var_49_20 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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
				actorName = "1061ui_story",
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
	Play325132012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325132012
		arg_50_1.duration_ = 9.4

		local var_50_0 = {
			zh = 6.8,
			ja = 9.4
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
				arg_50_0:Play325132013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10180ui_story"]) and arg_50_1.var_.characterEffect10180ui_story == nil then
				arg_50_1.var_.characterEffect10180ui_story = arg_50_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10180ui_story"]) then
				if arg_50_1.var_.characterEffect10180ui_story and not isNil(arg_50_1.actors_["10180ui_story"]) then
					arg_50_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10180ui_story"]) and arg_50_1.var_.characterEffect10180ui_story then
				arg_50_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_53_2 = arg_50_1.actors_["1061ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1061ui_story == nil then
				arg_50_1.var_.characterEffect1061ui_story = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_3 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.characterEffect1061ui_story and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_3)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1061ui_story then
				arg_50_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_2")
			end

			local var_53_4 = 0
			local var_53_5 = 0.55

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(325132012)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 22 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 22)

				if (22 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 22)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132012", "story_v_out_325132.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132012", "story_v_out_325132.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_out_325132", "325132012", "story_v_out_325132.awb")

						arg_50_1:RecordAudio("325132012", var_53_11)
						arg_50_1:RecordAudio("325132012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325132", "325132012", "story_v_out_325132.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325132", "325132012", "story_v_out_325132.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325132013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325132013
		arg_54_1.duration_ = 4.13

		local var_54_0 = {
			zh = 2.966,
			ja = 4.133
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
				arg_54_0:Play325132014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1061ui_story = arg_54_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).z)
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles = arg_54_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).z)
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles = arg_54_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["10180ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect10180ui_story == nil then
				arg_54_1.var_.characterEffect10180ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect10180ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_2)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect10180ui_story then
				arg_54_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_57_3 = arg_54_1.actors_["10180ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos10180ui_story = var_57_3.localPosition

				local var_57_4 = GameObjectTools.GetOrAddComponent(var_57_3.gameObject, typeof(DynamicBoneHelper))

				if var_57_4 then
					var_57_4:EnableDynamicBone(false)
				end
			end

			local var_57_5 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_5 then
				var_57_3.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_54_1.time_ - 0) / var_57_5)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_5 and arg_54_1.time_ < 0 + var_57_5 + arg_57_0 then
				var_57_3.localPosition = Vector3.New(0, 100, 0)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles

				local var_57_6 = GameObjectTools.GetOrAddComponent(var_57_3.gameObject, typeof(DynamicBoneHelper))

				if var_57_6 then
					var_57_6:EnableDynamicBone(true)
				end
			end

			local var_57_7 = 0
			local var_57_8 = 0.375

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_7 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(325132013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_12 = 15 <= 0 and var_57_8 or var_57_8 * (utf8.len(var_57_10) / 15)

				if (15 <= 0 and var_57_8 or var_57_8 * (utf8.len(var_57_10) / 15)) > 0 and var_57_8 < var_57_12 then
					arg_54_1.talkMaxDuration = var_57_12

					if var_57_12 + var_57_7 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_12 + var_57_7
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132013", "story_v_out_325132.awb") ~= 0 then
					local var_57_13 = manager.audio:GetVoiceLength("story_v_out_325132", "325132013", "story_v_out_325132.awb") / 1000

					if var_57_13 + var_57_7 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_7
					end

					if var_57_9.prefab_name ~= "" and arg_54_1.actors_[var_57_9.prefab_name] ~= nil then
						local var_57_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_9.prefab_name].transform, "story_v_out_325132", "325132013", "story_v_out_325132.awb")

						arg_54_1:RecordAudio("325132013", var_57_14)
						arg_54_1:RecordAudio("325132013", var_57_14)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325132", "325132013", "story_v_out_325132.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325132", "325132013", "story_v_out_325132.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_15 = math.max(var_57_8, arg_54_1.talkMaxDuration)

			if var_57_7 <= arg_54_1.time_ and arg_54_1.time_ < var_57_7 + var_57_15 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_7) / var_57_15

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_7 + var_57_15 and arg_54_1.time_ < var_57_7 + var_57_15 + arg_57_0 then
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
				actorName = "10180ui_story",
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
	Play325132014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325132014
		arg_58_1.duration_ = 5.33

		local var_58_0 = {
			zh = 3.5,
			ja = 5.333
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
				arg_58_0:Play325132015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10180ui_story"]) and arg_58_1.var_.characterEffect10180ui_story == nil then
				arg_58_1.var_.characterEffect10180ui_story = arg_58_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10180ui_story"]) then
				if arg_58_1.var_.characterEffect10180ui_story and not isNil(arg_58_1.actors_["10180ui_story"]) then
					arg_58_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10180ui_story"]) and arg_58_1.var_.characterEffect10180ui_story then
				arg_58_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_61_2 = arg_58_1.actors_["1059ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1059ui_story == nil then
				arg_58_1.var_.characterEffect1059ui_story = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.characterEffect1059ui_story and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_3)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1059ui_story then
				arg_58_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_61_4 = arg_58_1.actors_["10180ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10180ui_story = var_61_4.localPosition

				local var_61_5 = GameObjectTools.GetOrAddComponent(var_61_4.gameObject, typeof(DynamicBoneHelper))

				if var_61_5 then
					var_61_5:EnableDynamicBone(false)
				end
			end

			local var_61_6 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_6 then
				var_61_4.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_58_1.time_ - 0) / var_61_6)
				var_61_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_4.position).x, (manager.ui.mainCamera.transform.position - var_61_4.position).y, (manager.ui.mainCamera.transform.position - var_61_4.position).z)
				var_61_4.localEulerAngles.z = 0
				var_61_4.localEulerAngles.x = 0
				var_61_4.localEulerAngles = var_61_4.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_6 and arg_58_1.time_ < 0 + var_61_6 + arg_61_0 then
				var_61_4.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				var_61_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_4.position).x, (manager.ui.mainCamera.transform.position - var_61_4.position).y, (manager.ui.mainCamera.transform.position - var_61_4.position).z)
				var_61_4.localEulerAngles.z = 0
				var_61_4.localEulerAngles.x = 0
				var_61_4.localEulerAngles = var_61_4.localEulerAngles

				local var_61_7 = GameObjectTools.GetOrAddComponent(var_61_4.gameObject, typeof(DynamicBoneHelper))

				if var_61_7 then
					var_61_7:EnableDynamicBone(true)
				end
			end

			local var_61_8 = 0
			local var_61_9 = 0.275

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_10 = arg_58_1:GetWordFromCfg(325132014)
				local var_61_11 = arg_58_1:FormatText(var_61_10.content)

				arg_58_1.text_.text = var_61_11

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 11 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 11)

				if (11 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 11)) > 0 and var_61_9 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_11
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132014", "story_v_out_325132.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_325132", "325132014", "story_v_out_325132.awb") / 1000

					if var_61_14 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_8
					end

					if var_61_10.prefab_name ~= "" and arg_58_1.actors_[var_61_10.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_10.prefab_name].transform, "story_v_out_325132", "325132014", "story_v_out_325132.awb")

						arg_58_1:RecordAudio("325132014", var_61_15)
						arg_58_1:RecordAudio("325132014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325132", "325132014", "story_v_out_325132.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325132", "325132014", "story_v_out_325132.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_16 and arg_58_1.time_ < var_61_8 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play325132015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325132015
		arg_62_1.duration_ = 10.4

		local var_62_0 = {
			zh = 8.6,
			ja = 10.4
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
				arg_62_0:Play325132016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.8

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(325132015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 32 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 32)

				if (32 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 32)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132015", "story_v_out_325132.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132015", "story_v_out_325132.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_325132", "325132015", "story_v_out_325132.awb")

						arg_62_1:RecordAudio("325132015", var_65_6)
						arg_62_1:RecordAudio("325132015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325132", "325132015", "story_v_out_325132.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325132", "325132015", "story_v_out_325132.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325132016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325132016
		arg_66_1.duration_ = 6.27

		local var_66_0 = {
			zh = 4.066,
			ja = 6.266
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
				arg_66_0:Play325132017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10180ui_story"]) and arg_66_1.var_.characterEffect10180ui_story == nil then
				arg_66_1.var_.characterEffect10180ui_story = arg_66_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10180ui_story"]) then
				if arg_66_1.var_.characterEffect10180ui_story and not isNil(arg_66_1.actors_["10180ui_story"]) then
					arg_66_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_66_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10180ui_story"]) and arg_66_1.var_.characterEffect10180ui_story then
				arg_66_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_66_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_69_1 = 0
			local var_69_2 = 0.4

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(325132016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_6 = 16 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_4) / 16)

				if (16 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_4) / 16)) > 0 and var_69_2 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132016", "story_v_out_325132.awb") ~= 0 then
					local var_69_7 = manager.audio:GetVoiceLength("story_v_out_325132", "325132016", "story_v_out_325132.awb") / 1000

					if var_69_7 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_1
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_325132", "325132016", "story_v_out_325132.awb")

						arg_66_1:RecordAudio("325132016", var_69_8)
						arg_66_1:RecordAudio("325132016", var_69_8)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325132", "325132016", "story_v_out_325132.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325132", "325132016", "story_v_out_325132.awb")
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
	Play325132017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325132017
		arg_70_1.duration_ = 15.63

		local var_70_0 = {
			zh = 8.166,
			ja = 15.633
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
				arg_70_0:Play325132018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10180ui_story"]) and arg_70_1.var_.characterEffect10180ui_story == nil then
				arg_70_1.var_.characterEffect10180ui_story = arg_70_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10180ui_story"]) then
				if arg_70_1.var_.characterEffect10180ui_story and not isNil(arg_70_1.actors_["10180ui_story"]) then
					arg_70_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10180ui_story"]) and arg_70_1.var_.characterEffect10180ui_story then
				arg_70_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action22_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_73_2 = 0
			local var_73_3 = 0.725

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_4 = arg_70_1:GetWordFromCfg(325132017)
				local var_73_5 = arg_70_1:FormatText(var_73_4.content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 29 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 29)

				if (29 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 29)) > 0 and var_73_3 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_2
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132017", "story_v_out_325132.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_325132", "325132017", "story_v_out_325132.awb") / 1000

					if var_73_8 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_2
					end

					if var_73_4.prefab_name ~= "" and arg_70_1.actors_[var_73_4.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_4.prefab_name].transform, "story_v_out_325132", "325132017", "story_v_out_325132.awb")

						arg_70_1:RecordAudio("325132017", var_73_9)
						arg_70_1:RecordAudio("325132017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325132", "325132017", "story_v_out_325132.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325132", "325132017", "story_v_out_325132.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_3, arg_70_1.talkMaxDuration)

			if var_73_2 <= arg_70_1.time_ and arg_70_1.time_ < var_73_2 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_2) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_2 + var_73_10 and arg_70_1.time_ < var_73_2 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325132018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325132018
		arg_74_1.duration_ = 4.53

		local var_74_0 = {
			zh = 3.9,
			ja = 4.533
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
				arg_74_0:Play325132019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos10180ui_story = arg_74_1.actors_["10180ui_story"].transform.localPosition

				local var_77_0 = GameObjectTools.GetOrAddComponent(arg_74_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_77_0 then
					var_77_0:EnableDynamicBone(false)
				end
			end

			local var_77_1 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_1 then
				arg_74_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_1)
				arg_74_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10180ui_story"].transform.position).z)
				arg_74_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["10180ui_story"].transform.localEulerAngles = arg_74_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_1 and arg_74_1.time_ < 0 + var_77_1 + arg_77_0 then
				arg_74_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10180ui_story"].transform.position).z)
				arg_74_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["10180ui_story"].transform.localEulerAngles = arg_74_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_77_2 = GameObjectTools.GetOrAddComponent(arg_74_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(true)
				end
			end

			local var_77_3 = arg_74_1.actors_["1053ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1053ui_story = var_77_3.localPosition

				local var_77_4 = GameObjectTools.GetOrAddComponent(var_77_3.gameObject, typeof(DynamicBoneHelper))

				if var_77_4 then
					var_77_4:EnableDynamicBone(false)
				end
			end

			local var_77_5 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_5 then
				var_77_3.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_74_1.time_ - 0) / var_77_5)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_5 and arg_74_1.time_ < 0 + var_77_5 + arg_77_0 then
				var_77_3.localPosition = Vector3.New(0, -1.08, -6)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles

				local var_77_6 = GameObjectTools.GetOrAddComponent(var_77_3.gameObject, typeof(DynamicBoneHelper))

				if var_77_6 then
					var_77_6:EnableDynamicBone(true)
				end
			end

			local var_77_7 = arg_74_1.actors_["1059ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1059ui_story = var_77_7.localPosition
			end

			local var_77_8 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_8 then
				var_77_7.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_8)
				var_77_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_7.position).x, (manager.ui.mainCamera.transform.position - var_77_7.position).y, (manager.ui.mainCamera.transform.position - var_77_7.position).z)
				var_77_7.localEulerAngles.z = 0
				var_77_7.localEulerAngles.x = 0
				var_77_7.localEulerAngles = var_77_7.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_8 and arg_74_1.time_ < 0 + var_77_8 + arg_77_0 then
				var_77_7.localPosition = Vector3.New(0, 100, 0)
				var_77_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_7.position).x, (manager.ui.mainCamera.transform.position - var_77_7.position).y, (manager.ui.mainCamera.transform.position - var_77_7.position).z)
				var_77_7.localEulerAngles.z = 0
				var_77_7.localEulerAngles.x = 0
				var_77_7.localEulerAngles = var_77_7.localEulerAngles
			end

			local var_77_9 = arg_74_1.actors_["1053ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect1053ui_story == nil then
				arg_74_1.var_.characterEffect1053ui_story = var_77_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_10 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_10 and not isNil(var_77_9) then
				if arg_74_1.var_.characterEffect1053ui_story and not isNil(var_77_9) then
					arg_74_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_10 and arg_74_1.time_ < 0 + var_77_10 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect1053ui_story then
				arg_74_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_77_12 = arg_74_1.actors_["10180ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_12) and arg_74_1.var_.characterEffect10180ui_story == nil then
				arg_74_1.var_.characterEffect10180ui_story = var_77_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_13 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_13 and not isNil(var_77_12) then
				if arg_74_1.var_.characterEffect10180ui_story and not isNil(var_77_12) then
					arg_74_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_74_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_13)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_13 and arg_74_1.time_ < 0 + var_77_13 + arg_77_0 and not isNil(var_77_12) and arg_74_1.var_.characterEffect10180ui_story then
				arg_74_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_74_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_77_14 = 0
			local var_77_15 = 0.35

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_16 = arg_74_1:GetWordFromCfg(325132018)
				local var_77_17 = arg_74_1:FormatText(var_77_16.content)

				arg_74_1.text_.text = var_77_17

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_19 = 14 <= 0 and var_77_15 or var_77_15 * (utf8.len(var_77_17) / 14)

				if (14 <= 0 and var_77_15 or var_77_15 * (utf8.len(var_77_17) / 14)) > 0 and var_77_15 < var_77_19 then
					arg_74_1.talkMaxDuration = var_77_19

					if var_77_19 + var_77_14 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_14
					end
				end

				arg_74_1.text_.text = var_77_17
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132018", "story_v_out_325132.awb") ~= 0 then
					local var_77_20 = manager.audio:GetVoiceLength("story_v_out_325132", "325132018", "story_v_out_325132.awb") / 1000

					if var_77_20 + var_77_14 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_20 + var_77_14
					end

					if var_77_16.prefab_name ~= "" and arg_74_1.actors_[var_77_16.prefab_name] ~= nil then
						local var_77_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_16.prefab_name].transform, "story_v_out_325132", "325132018", "story_v_out_325132.awb")

						arg_74_1:RecordAudio("325132018", var_77_21)
						arg_74_1:RecordAudio("325132018", var_77_21)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325132", "325132018", "story_v_out_325132.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325132", "325132018", "story_v_out_325132.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_22 = math.max(var_77_15, arg_74_1.talkMaxDuration)

			if var_77_14 <= arg_74_1.time_ and arg_74_1.time_ < var_77_14 + var_77_22 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_14) / var_77_22

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_14 + var_77_22 and arg_74_1.time_ < var_77_14 + var_77_22 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
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
	Play325132019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325132019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325132020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1053ui_story = arg_78_1.actors_["1053ui_story"].transform.localPosition

				local var_81_0 = GameObjectTools.GetOrAddComponent(arg_78_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_81_0 then
					var_81_0:EnableDynamicBone(false)
				end
			end

			local var_81_1 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_1 then
				arg_78_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_1)
				arg_78_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1053ui_story"].transform.position).z)
				arg_78_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1053ui_story"].transform.localEulerAngles = arg_78_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_1 and arg_78_1.time_ < 0 + var_81_1 + arg_81_0 then
				arg_78_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1053ui_story"].transform.position).z)
				arg_78_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1053ui_story"].transform.localEulerAngles = arg_78_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_81_2 = GameObjectTools.GetOrAddComponent(arg_78_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(true)
				end
			end

			local var_81_3 = arg_78_1.actors_["1053ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1053ui_story == nil then
				arg_78_1.var_.characterEffect1053ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_4 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 and not isNil(var_81_3) then
				if arg_78_1.var_.characterEffect1053ui_story and not isNil(var_81_3) then
					arg_78_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_4)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1053ui_story then
				arg_78_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0.575 < arg_78_1.time_ and arg_78_1.time_ <= 0.575 + arg_81_0 then
				arg_78_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword_huge", "")
			end

			local var_81_6 = 0
			local var_81_7 = 1.575

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(325132019).content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 63 <= 0 and var_81_7 or var_81_7 * (utf8.len(var_81_8) / 63)

				if (63 <= 0 and var_81_7 or var_81_7 * (utf8.len(var_81_8) / 63)) > 0 and var_81_7 < var_81_10 then
					arg_78_1.talkMaxDuration = var_81_10

					if var_81_10 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_8
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_11 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_11 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_11

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_11 and arg_78_1.time_ < var_81_6 + var_81_11 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play325132020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325132020
		arg_82_1.duration_ = 6.27

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325132021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				local var_85_0 = arg_82_1.var_.effect32131444

				if not arg_82_1.var_.effect32131444 then
					var_85_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_85_0.name = "32131444"
					arg_82_1.var_.effect32131444 = var_85_0
				else
					var_85_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_85_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_85_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_85_0.transform.localScale = Vector3.New(var_85_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_85_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_85_0.transform.localScale.z)
			end

			local var_85_2 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_2 + 1.87863799650222 and arg_82_1.time_ < var_85_2 + 1.87863799650222 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			if 0.2 < arg_82_1.time_ and arg_82_1.time_ <= 0.2 + arg_85_0 then
				arg_82_1:AudioAction("play", "effect", "se_story_11", "se_story_11_sword", "")
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_4 = 1.26666666666667
			local var_85_5 = 1.675

			if 1.26666666666667 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_6 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_6:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(325132020).content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 67 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 67)

				if (67 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 67)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9
					var_85_4 = var_85_4 + 0.3

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = var_85_4 + 0.3
			local var_85_11 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_10) / var_85_11

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325132021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325132021
		arg_88_1.duration_ = 8.4

		local var_88_0 = {
			zh = 5.233,
			ja = 8.4
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325132022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10180ui_story = arg_88_1.actors_["10180ui_story"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10180ui_story"].transform.position).z)
				arg_88_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["10180ui_story"].transform.localEulerAngles = arg_88_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10180ui_story"].transform.position).z)
				arg_88_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["10180ui_story"].transform.localEulerAngles = arg_88_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = arg_88_1.actors_["10180ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect10180ui_story == nil then
				arg_88_1.var_.characterEffect10180ui_story = var_91_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_4 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 and not isNil(var_91_3) then
				if arg_88_1.var_.characterEffect10180ui_story and not isNil(var_91_3) then
					arg_88_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect10180ui_story then
				arg_88_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_91_6 = 0
			local var_91_7 = 0.475

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10180")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_8 = arg_88_1:GetWordFromCfg(325132021)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 19 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 19)

				if (19 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 19)) > 0 and var_91_7 < var_91_11 then
					arg_88_1.talkMaxDuration = var_91_11

					if var_91_11 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132021", "story_v_out_325132.awb") ~= 0 then
					local var_91_12 = manager.audio:GetVoiceLength("story_v_out_325132", "325132021", "story_v_out_325132.awb") / 1000

					if var_91_12 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_6
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_325132", "325132021", "story_v_out_325132.awb")

						arg_88_1:RecordAudio("325132021", var_91_13)
						arg_88_1:RecordAudio("325132021", var_91_13)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325132", "325132021", "story_v_out_325132.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325132", "325132021", "story_v_out_325132.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play325132022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325132022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325132023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10180ui_story = arg_92_1.actors_["10180ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).z)
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles = arg_92_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).z)
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles = arg_92_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["10180ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect10180ui_story == nil then
				arg_92_1.var_.characterEffect10180ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect10180ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_4)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect10180ui_story then
				arg_92_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_95_5 = 0
			local var_95_6 = 0.825

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(325132022).content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 33 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_7) / 33)

				if (33 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_7) / 33)) > 0 and var_95_6 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_10 and arg_92_1.time_ < var_95_5 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play325132023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325132023
		arg_96_1.duration_ = 8

		local var_96_0 = {
			zh = 7.999999999998,
			ja = 5.799999997017
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
				arg_96_0:Play325132024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 1.999999999999 < arg_96_1.time_ and arg_96_1.time_ <= 1.999999999999 + arg_99_0 then
				local var_99_0 = arg_96_1.bgs_.J23g

				arg_96_1.bgs_.J23g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_99_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_1 = var_99_0:GetComponent("SpriteRenderer")

				if var_99_1 and var_99_1.sprite then
					local var_99_2 = 2 * (var_99_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_99_0.transform.localScale = Vector3.New(var_99_2 / var_99_1.sprite.bounds.size.y < var_99_2 * manager.ui.mainCameraCom_.aspect / var_99_1.sprite.bounds.size.x and var_99_2 * manager.ui.mainCameraCom_.aspect / var_99_1.sprite.bounds.size.x or var_99_2 / var_99_1.sprite.bounds.size.y, var_99_2 / var_99_1.sprite.bounds.size.y < var_99_2 * manager.ui.mainCameraCom_.aspect / var_99_1.sprite.bounds.size.x and var_99_2 * manager.ui.mainCameraCom_.aspect / var_99_1.sprite.bounds.size.x or var_99_2 / var_99_1.sprite.bounds.size.y, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "J23g" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_3 = 1.999999999999

			if 1.999999999999 < arg_96_1.time_ and arg_96_1.time_ <= var_99_3 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			if arg_96_1.time_ >= var_99_3 + 0.3 and arg_96_1.time_ < var_99_3 + 0.3 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			local var_99_4 = 0

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_5 = 2

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_5 then
				local var_99_6 = Color.New(0, 0, 0)

				var_99_6.a = Mathf.Lerp(0, 1, (arg_96_1.time_ - var_99_4) / var_99_5)
				arg_96_1.mask_.color = var_99_6
			end

			if arg_96_1.time_ >= var_99_4 + var_99_5 and arg_96_1.time_ < var_99_4 + var_99_5 + arg_99_0 then
				local var_99_7 = Color.New(0, 0, 0)

				var_99_7.a = 1
				arg_96_1.mask_.color = var_99_7
			end

			local var_99_8 = 1.999999999999

			if 1.999999999999 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_9 = 2

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_9 then
				local var_99_10 = Color.New(0, 0, 0)

				var_99_10.a = Mathf.Lerp(1, 0, (arg_96_1.time_ - var_99_8) / var_99_9)
				arg_96_1.mask_.color = var_99_10
			end

			if arg_96_1.time_ >= var_99_8 + var_99_9 and arg_96_1.time_ < var_99_8 + var_99_9 + arg_99_0 then
				local var_99_11 = Color.New(0, 0, 0)

				arg_96_1.mask_.enabled = false
				var_99_11.a = 0
				arg_96_1.mask_.color = var_99_11
			end

			local var_99_12 = arg_96_1.actors_["1061ui_story"].transform

			if 3.79999999701777 < arg_96_1.time_ and arg_96_1.time_ <= 3.79999999701777 + arg_99_0 then
				arg_96_1.var_.moveOldPos1061ui_story = var_99_12.localPosition
			end

			local var_99_13 = 0.001

			if 3.79999999701777 <= arg_96_1.time_ and arg_96_1.time_ < 3.79999999701777 + var_99_13 then
				var_99_12.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_96_1.time_ - 3.79999999701777) / var_99_13)
				var_99_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_12.position).x, (manager.ui.mainCamera.transform.position - var_99_12.position).y, (manager.ui.mainCamera.transform.position - var_99_12.position).z)
				var_99_12.localEulerAngles.z = 0
				var_99_12.localEulerAngles.x = 0
				var_99_12.localEulerAngles = var_99_12.localEulerAngles
			end

			if arg_96_1.time_ >= 3.79999999701777 + var_99_13 and arg_96_1.time_ < 3.79999999701777 + var_99_13 + arg_99_0 then
				var_99_12.localPosition = Vector3.New(0, -1.18, -6.15)
				var_99_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_12.position).x, (manager.ui.mainCamera.transform.position - var_99_12.position).y, (manager.ui.mainCamera.transform.position - var_99_12.position).z)
				var_99_12.localEulerAngles.z = 0
				var_99_12.localEulerAngles.x = 0
				var_99_12.localEulerAngles = var_99_12.localEulerAngles
			end

			local var_99_14 = arg_96_1.actors_["1061ui_story"]

			if 3.79999999701777 < arg_96_1.time_ and arg_96_1.time_ <= 3.79999999701777 + arg_99_0 and not isNil(var_99_14) and arg_96_1.var_.characterEffect1061ui_story == nil then
				arg_96_1.var_.characterEffect1061ui_story = var_99_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_15 = 0.200000002980232

			if 3.79999999701777 <= arg_96_1.time_ and arg_96_1.time_ < 3.79999999701777 + var_99_15 and not isNil(var_99_14) then
				if arg_96_1.var_.characterEffect1061ui_story and not isNil(var_99_14) then
					arg_96_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 3.79999999701777 + var_99_15 and arg_96_1.time_ < 3.79999999701777 + var_99_15 + arg_99_0 and not isNil(var_99_14) and arg_96_1.var_.characterEffect1061ui_story then
				arg_96_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 1.999999999999 < arg_96_1.time_ and arg_96_1.time_ <= 1.999999999999 + arg_99_0 then
				if arg_96_1.var_.effect32131444 then
					Object.Destroy(arg_96_1.var_.effect32131444)

					arg_96_1.var_.effect32131444 = nil
				end
			end

			if 3.79999999701777 < arg_96_1.time_ and arg_96_1.time_ <= 3.79999999701777 + arg_99_0 then
				arg_96_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_18 = 3.999999999998
			local var_99_19 = 0.35

			if 3.999999999998 < arg_96_1.time_ and arg_96_1.time_ <= var_99_18 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_20 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_20:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_96_1.dialogCg_.alpha = arg_100_0
				end))
				var_99_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_21 = arg_96_1:GetWordFromCfg(325132023)
				local var_99_22 = arg_96_1:FormatText(var_99_21.content)

				arg_96_1.text_.text = var_99_22

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_24 = 14 <= 0 and var_99_19 or var_99_19 * (utf8.len(var_99_22) / 14)

				if (14 <= 0 and var_99_19 or var_99_19 * (utf8.len(var_99_22) / 14)) > 0 and var_99_19 < var_99_24 then
					arg_96_1.talkMaxDuration = var_99_24
					var_99_18 = var_99_18 + 0.3

					if var_99_24 + var_99_18 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_18
					end
				end

				arg_96_1.text_.text = var_99_22
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132023", "story_v_out_325132.awb") ~= 0 then
					local var_99_25 = manager.audio:GetVoiceLength("story_v_out_325132", "325132023", "story_v_out_325132.awb") / 1000

					if var_99_25 + var_99_18 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_25 + var_99_18
					end

					if var_99_21.prefab_name ~= "" and arg_96_1.actors_[var_99_21.prefab_name] ~= nil then
						local var_99_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_21.prefab_name].transform, "story_v_out_325132", "325132023", "story_v_out_325132.awb")

						arg_96_1:RecordAudio("325132023", var_99_26)
						arg_96_1:RecordAudio("325132023", var_99_26)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325132", "325132023", "story_v_out_325132.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325132", "325132023", "story_v_out_325132.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_27 = var_99_18 + 0.3
			local var_99_28 = math.max(var_99_19, arg_96_1.talkMaxDuration)

			if var_99_18 + 0.3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_27 + var_99_28 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_27) / var_99_28

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_27 + var_99_28 and arg_96_1.time_ < var_99_27 + var_99_28 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701777,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play325132024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325132024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325132025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1061ui_story = arg_102_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).z)
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles = arg_102_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).z)
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles = arg_102_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1061ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_2)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1061ui_story then
				arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_105_3 = 0
			local var_105_4 = 0.975

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_5 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(325132024).content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 39 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 39)

				if (39 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 39)) > 0 and var_105_4 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_3
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_8 = math.max(var_105_4, arg_102_1.talkMaxDuration)

			if var_105_3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_3 + var_105_8 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_3) / var_105_8

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_3 + var_105_8 and arg_102_1.time_ < var_105_3 + var_105_8 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play325132025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325132025
		arg_106_1.duration_ = 4.87

		local var_106_0 = {
			zh = 3.266,
			ja = 4.866
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
				arg_106_0:Play325132026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1053ui_story = arg_106_1.actors_["1053ui_story"].transform.localPosition

				local var_109_0 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_0 then
					var_109_0:EnableDynamicBone(false)
				end
			end

			local var_109_1 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_1 then
				arg_106_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_106_1.time_ - 0) / var_109_1)
				arg_106_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1053ui_story"].transform.position).z)
				arg_106_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1053ui_story"].transform.localEulerAngles = arg_106_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_1 and arg_106_1.time_ < 0 + var_109_1 + arg_109_0 then
				arg_106_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_106_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1053ui_story"].transform.position).z)
				arg_106_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1053ui_story"].transform.localEulerAngles = arg_106_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_109_2 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(true)
				end
			end

			local var_109_3 = arg_106_1.actors_["1053ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1053ui_story == nil then
				arg_106_1.var_.characterEffect1053ui_story = var_109_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_4 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 and not isNil(var_109_3) then
				if arg_106_1.var_.characterEffect1053ui_story and not isNil(var_109_3) then
					arg_106_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1053ui_story then
				arg_106_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_2")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_109_6 = 0
			local var_109_7 = 0.375

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(325132025)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 15 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 15)

				if (15 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 15)) > 0 and var_109_7 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132025", "story_v_out_325132.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_325132", "325132025", "story_v_out_325132.awb") / 1000

					if var_109_12 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_6
					end

					if var_109_8.prefab_name ~= "" and arg_106_1.actors_[var_109_8.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_8.prefab_name].transform, "story_v_out_325132", "325132025", "story_v_out_325132.awb")

						arg_106_1:RecordAudio("325132025", var_109_13)
						arg_106_1:RecordAudio("325132025", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325132", "325132025", "story_v_out_325132.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325132", "325132025", "story_v_out_325132.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play325132026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325132026
		arg_110_1.duration_ = 6.37

		local var_110_0 = {
			zh = 3.3,
			ja = 6.366
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
				arg_110_0:Play325132027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1053ui_story = arg_110_1.actors_["1053ui_story"].transform.localPosition

				local var_113_0 = GameObjectTools.GetOrAddComponent(arg_110_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_113_0 then
					var_113_0:EnableDynamicBone(false)
				end
			end

			local var_113_1 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_1 then
				arg_110_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1053ui_story, Vector3.New(-0.7, -1.08, -6), (arg_110_1.time_ - 0) / var_113_1)
				arg_110_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1053ui_story"].transform.position).z)
				arg_110_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1053ui_story"].transform.localEulerAngles = arg_110_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_1 and arg_110_1.time_ < 0 + var_113_1 + arg_113_0 then
				arg_110_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6)
				arg_110_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1053ui_story"].transform.position).z)
				arg_110_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1053ui_story"].transform.localEulerAngles = arg_110_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_113_2 = GameObjectTools.GetOrAddComponent(arg_110_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(true)
				end
			end

			local var_113_3 = arg_110_1.actors_["1061ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1061ui_story = var_113_3.localPosition
			end

			local var_113_4 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				var_113_3.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_110_1.time_ - 0) / var_113_4)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				var_113_3.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles
			end

			local var_113_5 = arg_110_1.actors_["1061ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect1061ui_story == nil then
				arg_110_1.var_.characterEffect1061ui_story = var_113_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_6 and not isNil(var_113_5) then
				if arg_110_1.var_.characterEffect1061ui_story and not isNil(var_113_5) then
					arg_110_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_6 and arg_110_1.time_ < 0 + var_113_6 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect1061ui_story then
				arg_110_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_113_8 = arg_110_1.actors_["1053ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.characterEffect1053ui_story == nil then
				arg_110_1.var_.characterEffect1053ui_story = var_113_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_9 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_9 and not isNil(var_113_8) then
				if arg_110_1.var_.characterEffect1053ui_story and not isNil(var_113_8) then
					arg_110_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_9)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_9 and arg_110_1.time_ < 0 + var_113_9 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.characterEffect1053ui_story then
				arg_110_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_113_10 = 0
			local var_113_11 = 0.4

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
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

				local var_113_12 = arg_110_1:GetWordFromCfg(325132026)
				local var_113_13 = arg_110_1:FormatText(var_113_12.content)

				arg_110_1.text_.text = var_113_13

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_15 = 15 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 15)

				if (15 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 15)) > 0 and var_113_11 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_10
					end
				end

				arg_110_1.text_.text = var_113_13
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132026", "story_v_out_325132.awb") ~= 0 then
					local var_113_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132026", "story_v_out_325132.awb") / 1000

					if var_113_16 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_16 + var_113_10
					end

					if var_113_12.prefab_name ~= "" and arg_110_1.actors_[var_113_12.prefab_name] ~= nil then
						local var_113_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_12.prefab_name].transform, "story_v_out_325132", "325132026", "story_v_out_325132.awb")

						arg_110_1:RecordAudio("325132026", var_113_17)
						arg_110_1:RecordAudio("325132026", var_113_17)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325132", "325132026", "story_v_out_325132.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325132", "325132026", "story_v_out_325132.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_18 = math.max(var_113_11, arg_110_1.talkMaxDuration)

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_10) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_10 + var_113_18 and arg_110_1.time_ < var_113_10 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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
				actorName = "1061ui_story",
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
	Play325132027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325132027
		arg_114_1.duration_ = 11.67

		local var_114_0 = {
			zh = 9.233,
			ja = 11.666
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
				arg_114_0:Play325132028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1053ui_story"]) and arg_114_1.var_.characterEffect1053ui_story == nil then
				arg_114_1.var_.characterEffect1053ui_story = arg_114_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1053ui_story"]) then
				if arg_114_1.var_.characterEffect1053ui_story and not isNil(arg_114_1.actors_["1053ui_story"]) then
					arg_114_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1053ui_story"]) and arg_114_1.var_.characterEffect1053ui_story then
				arg_114_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1061ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_117_4 = 0
			local var_117_5 = 0.975

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(325132027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 39 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 39)

				if (39 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 39)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132027", "story_v_out_325132.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132027", "story_v_out_325132.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_325132", "325132027", "story_v_out_325132.awb")

						arg_114_1:RecordAudio("325132027", var_117_11)
						arg_114_1:RecordAudio("325132027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325132", "325132027", "story_v_out_325132.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325132", "325132027", "story_v_out_325132.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325132028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325132028
		arg_118_1.duration_ = 10.23

		local var_118_0 = {
			zh = 10.233,
			ja = 5.733
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
				arg_118_0:Play325132029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1077ui_story = arg_118_1.actors_["1077ui_story"].transform.localPosition

				local var_121_0 = GameObjectTools.GetOrAddComponent(arg_118_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_121_0 then
					var_121_0:EnableDynamicBone(false)
				end
			end

			local var_121_1 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_1 then
				arg_118_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_118_1.time_ - 0) / var_121_1)
				arg_118_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).z)
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles = arg_118_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_1 and arg_118_1.time_ < 0 + var_121_1 + arg_121_0 then
				arg_118_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0.8, -1.02, -5.92)
				arg_118_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).z)
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles = arg_118_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_121_2 = GameObjectTools.GetOrAddComponent(arg_118_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_121_2 then
					var_121_2:EnableDynamicBone(true)
				end
			end

			local var_121_3 = arg_118_1.actors_["1077ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_3) and arg_118_1.var_.characterEffect1077ui_story == nil then
				arg_118_1.var_.characterEffect1077ui_story = var_121_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_4 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 and not isNil(var_121_3) then
				if arg_118_1.var_.characterEffect1077ui_story and not isNil(var_121_3) then
					arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 and not isNil(var_121_3) and arg_118_1.var_.characterEffect1077ui_story then
				arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_121_6 = arg_118_1.actors_["1053ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_6) and arg_118_1.var_.characterEffect1053ui_story == nil then
				arg_118_1.var_.characterEffect1053ui_story = var_121_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_7 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 and not isNil(var_121_6) then
				if arg_118_1.var_.characterEffect1053ui_story and not isNil(var_121_6) then
					arg_118_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_7)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 and not isNil(var_121_6) and arg_118_1.var_.characterEffect1053ui_story then
				arg_118_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_121_8 = arg_118_1.actors_["1061ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1061ui_story = var_121_8.localPosition
			end

			local var_121_9 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_9 then
				var_121_8.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_9)
				var_121_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_8.position).x, (manager.ui.mainCamera.transform.position - var_121_8.position).y, (manager.ui.mainCamera.transform.position - var_121_8.position).z)
				var_121_8.localEulerAngles.z = 0
				var_121_8.localEulerAngles.x = 0
				var_121_8.localEulerAngles = var_121_8.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_9 and arg_118_1.time_ < 0 + var_121_9 + arg_121_0 then
				var_121_8.localPosition = Vector3.New(0, 100, 0)
				var_121_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_8.position).x, (manager.ui.mainCamera.transform.position - var_121_8.position).y, (manager.ui.mainCamera.transform.position - var_121_8.position).z)
				var_121_8.localEulerAngles.z = 0
				var_121_8.localEulerAngles.x = 0
				var_121_8.localEulerAngles = var_121_8.localEulerAngles
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_121_10 = 0
			local var_121_11 = 1.125

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
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

				local var_121_12 = arg_118_1:GetWordFromCfg(325132028)
				local var_121_13 = arg_118_1:FormatText(var_121_12.content)

				arg_118_1.text_.text = var_121_13

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_15 = 45 <= 0 and var_121_11 or var_121_11 * (utf8.len(var_121_13) / 45)

				if (45 <= 0 and var_121_11 or var_121_11 * (utf8.len(var_121_13) / 45)) > 0 and var_121_11 < var_121_15 then
					arg_118_1.talkMaxDuration = var_121_15

					if var_121_15 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_15 + var_121_10
					end
				end

				arg_118_1.text_.text = var_121_13
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132028", "story_v_out_325132.awb") ~= 0 then
					local var_121_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132028", "story_v_out_325132.awb") / 1000

					if var_121_16 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_16 + var_121_10
					end

					if var_121_12.prefab_name ~= "" and arg_118_1.actors_[var_121_12.prefab_name] ~= nil then
						local var_121_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_12.prefab_name].transform, "story_v_out_325132", "325132028", "story_v_out_325132.awb")

						arg_118_1:RecordAudio("325132028", var_121_17)
						arg_118_1:RecordAudio("325132028", var_121_17)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325132", "325132028", "story_v_out_325132.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325132", "325132028", "story_v_out_325132.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_18 = math.max(var_121_11, arg_118_1.talkMaxDuration)

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_18 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_10) / var_121_18

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_10 + var_121_18 and arg_118_1.time_ < var_121_10 + var_121_18 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play325132029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325132029
		arg_122_1.duration_ = 6.53

		local var_122_0 = {
			zh = 4.066,
			ja = 6.533
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
				arg_122_0:Play325132030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1053ui_story"]) and arg_122_1.var_.characterEffect1053ui_story == nil then
				arg_122_1.var_.characterEffect1053ui_story = arg_122_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1053ui_story"]) then
				if arg_122_1.var_.characterEffect1053ui_story and not isNil(arg_122_1.actors_["1053ui_story"]) then
					arg_122_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1053ui_story"]) and arg_122_1.var_.characterEffect1053ui_story then
				arg_122_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["1077ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1077ui_story == nil then
				arg_122_1.var_.characterEffect1077ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect1077ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1077ui_story then
				arg_122_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_125_4 = 0
			local var_125_5 = 0.5

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(325132029)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 20 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 20)

				if (20 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 20)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132029", "story_v_out_325132.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132029", "story_v_out_325132.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_325132", "325132029", "story_v_out_325132.awb")

						arg_122_1:RecordAudio("325132029", var_125_11)
						arg_122_1:RecordAudio("325132029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325132", "325132029", "story_v_out_325132.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325132", "325132029", "story_v_out_325132.awb")
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
	Play325132030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325132030
		arg_126_1.duration_ = 14.37

		local var_126_0 = {
			zh = 14.366,
			ja = 13.4
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
				arg_126_0:Play325132031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.325

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(325132030)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 53 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 53)

				if (53 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 53)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132030", "story_v_out_325132.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132030", "story_v_out_325132.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_325132", "325132030", "story_v_out_325132.awb")

						arg_126_1:RecordAudio("325132030", var_129_6)
						arg_126_1:RecordAudio("325132030", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325132", "325132030", "story_v_out_325132.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325132", "325132030", "story_v_out_325132.awb")
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
	Play325132031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325132031
		arg_130_1.duration_ = 7.17

		local var_130_0 = {
			zh = 5.466,
			ja = 7.166
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
				arg_130_0:Play325132032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1061ui_story"]) and arg_130_1.var_.characterEffect1061ui_story == nil then
				arg_130_1.var_.characterEffect1061ui_story = arg_130_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1061ui_story"]) then
				if arg_130_1.var_.characterEffect1061ui_story and not isNil(arg_130_1.actors_["1061ui_story"]) then
					arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1061ui_story"]) and arg_130_1.var_.characterEffect1061ui_story then
				arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_133_2 = arg_130_1.actors_["1053ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1053ui_story == nil then
				arg_130_1.var_.characterEffect1053ui_story = var_133_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_3 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 and not isNil(var_133_2) then
				if arg_130_1.var_.characterEffect1053ui_story and not isNil(var_133_2) then
					arg_130_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_3)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1053ui_story then
				arg_130_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_133_4 = arg_130_1.actors_["1061ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1061ui_story = var_133_4.localPosition
			end

			local var_133_5 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_5 then
				var_133_4.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_130_1.time_ - 0) / var_133_5)
				var_133_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_4.position).x, (manager.ui.mainCamera.transform.position - var_133_4.position).y, (manager.ui.mainCamera.transform.position - var_133_4.position).z)
				var_133_4.localEulerAngles.z = 0
				var_133_4.localEulerAngles.x = 0
				var_133_4.localEulerAngles = var_133_4.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_5 and arg_130_1.time_ < 0 + var_133_5 + arg_133_0 then
				var_133_4.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_133_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_4.position).x, (manager.ui.mainCamera.transform.position - var_133_4.position).y, (manager.ui.mainCamera.transform.position - var_133_4.position).z)
				var_133_4.localEulerAngles.z = 0
				var_133_4.localEulerAngles.x = 0
				var_133_4.localEulerAngles = var_133_4.localEulerAngles
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_133_6 = arg_130_1.actors_["1077ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1077ui_story = var_133_6.localPosition

				local var_133_7 = GameObjectTools.GetOrAddComponent(var_133_6.gameObject, typeof(DynamicBoneHelper))

				if var_133_7 then
					var_133_7:EnableDynamicBone(false)
				end
			end

			local var_133_8 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_8 then
				var_133_6.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_8)
				var_133_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_6.position).x, (manager.ui.mainCamera.transform.position - var_133_6.position).y, (manager.ui.mainCamera.transform.position - var_133_6.position).z)
				var_133_6.localEulerAngles.z = 0
				var_133_6.localEulerAngles.x = 0
				var_133_6.localEulerAngles = var_133_6.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_8 and arg_130_1.time_ < 0 + var_133_8 + arg_133_0 then
				var_133_6.localPosition = Vector3.New(0, 100, 0)
				var_133_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_6.position).x, (manager.ui.mainCamera.transform.position - var_133_6.position).y, (manager.ui.mainCamera.transform.position - var_133_6.position).z)
				var_133_6.localEulerAngles.z = 0
				var_133_6.localEulerAngles.x = 0
				var_133_6.localEulerAngles = var_133_6.localEulerAngles

				local var_133_9 = GameObjectTools.GetOrAddComponent(var_133_6.gameObject, typeof(DynamicBoneHelper))

				if var_133_9 then
					var_133_9:EnableDynamicBone(true)
				end
			end

			local var_133_10 = 0
			local var_133_11 = 0.625

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
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

				local var_133_12 = arg_130_1:GetWordFromCfg(325132031)
				local var_133_13 = arg_130_1:FormatText(var_133_12.content)

				arg_130_1.text_.text = var_133_13

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_15 = 25 <= 0 and var_133_11 or var_133_11 * (utf8.len(var_133_13) / 25)

				if (25 <= 0 and var_133_11 or var_133_11 * (utf8.len(var_133_13) / 25)) > 0 and var_133_11 < var_133_15 then
					arg_130_1.talkMaxDuration = var_133_15

					if var_133_15 + var_133_10 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_15 + var_133_10
					end
				end

				arg_130_1.text_.text = var_133_13
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132031", "story_v_out_325132.awb") ~= 0 then
					local var_133_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132031", "story_v_out_325132.awb") / 1000

					if var_133_16 + var_133_10 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_16 + var_133_10
					end

					if var_133_12.prefab_name ~= "" and arg_130_1.actors_[var_133_12.prefab_name] ~= nil then
						local var_133_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_12.prefab_name].transform, "story_v_out_325132", "325132031", "story_v_out_325132.awb")

						arg_130_1:RecordAudio("325132031", var_133_17)
						arg_130_1:RecordAudio("325132031", var_133_17)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325132", "325132031", "story_v_out_325132.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325132", "325132031", "story_v_out_325132.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_18 = math.max(var_133_11, arg_130_1.talkMaxDuration)

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_18 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_10) / var_133_18

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_10 + var_133_18 and arg_130_1.time_ < var_133_10 + var_133_18 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play325132032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325132032
		arg_134_1.duration_ = 14.8

		local var_134_0 = {
			zh = 7.966,
			ja = 14.8
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
				arg_134_0:Play325132033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1053ui_story"]) and arg_134_1.var_.characterEffect1053ui_story == nil then
				arg_134_1.var_.characterEffect1053ui_story = arg_134_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1053ui_story"]) then
				if arg_134_1.var_.characterEffect1053ui_story and not isNil(arg_134_1.actors_["1053ui_story"]) then
					arg_134_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1053ui_story"]) and arg_134_1.var_.characterEffect1053ui_story then
				arg_134_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_137_2 = arg_134_1.actors_["1061ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_3 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_2) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_3)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action425")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_137_4 = 0
			local var_137_5 = 0.9

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(325132032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 36 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 36)

				if (36 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 36)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132032", "story_v_out_325132.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132032", "story_v_out_325132.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_325132", "325132032", "story_v_out_325132.awb")

						arg_134_1:RecordAudio("325132032", var_137_11)
						arg_134_1:RecordAudio("325132032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325132", "325132032", "story_v_out_325132.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325132", "325132032", "story_v_out_325132.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325132033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325132033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325132034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1053ui_story"]) and arg_138_1.var_.characterEffect1053ui_story == nil then
				arg_138_1.var_.characterEffect1053ui_story = arg_138_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1053ui_story"]) then
				if arg_138_1.var_.characterEffect1053ui_story and not isNil(arg_138_1.actors_["1053ui_story"]) then
					arg_138_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1053ui_story"]) and arg_138_1.var_.characterEffect1053ui_story then
				arg_138_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_141_1 = arg_138_1.actors_["1061ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1061ui_story = var_141_1.localPosition
			end

			local var_141_2 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 then
				var_141_1.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_2)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 then
				var_141_1.localPosition = Vector3.New(0, 100, 0)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			local var_141_3 = arg_138_1.actors_["1053ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1053ui_story = var_141_3.localPosition

				local var_141_4 = GameObjectTools.GetOrAddComponent(var_141_3.gameObject, typeof(DynamicBoneHelper))

				if var_141_4 then
					var_141_4:EnableDynamicBone(false)
				end
			end

			local var_141_5 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 then
				var_141_3.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_5)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 then
				var_141_3.localPosition = Vector3.New(0, 100, 0)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles

				local var_141_6 = GameObjectTools.GetOrAddComponent(var_141_3.gameObject, typeof(DynamicBoneHelper))

				if var_141_6 then
					var_141_6:EnableDynamicBone(true)
				end
			end

			local var_141_7 = 0
			local var_141_8 = 1

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_9 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(325132033).content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 40 <= 0 and var_141_8 or var_141_8 * (utf8.len(var_141_9) / 40)

				if (40 <= 0 and var_141_8 or var_141_8 * (utf8.len(var_141_9) / 40)) > 0 and var_141_8 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_7 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_7
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_12 = math.max(var_141_8, arg_138_1.talkMaxDuration)

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_12 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_7) / var_141_12

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_7 + var_141_12 and arg_138_1.time_ < var_141_7 + var_141_12 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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
				actorName = "1053ui_story",
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
	Play325132034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325132034
		arg_142_1.duration_ = 4.5

		local var_142_0 = {
			zh = 4.5,
			ja = 4.366
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
				arg_142_0:Play325132035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) and arg_142_1.var_.characterEffect1077ui_story == nil then
				arg_142_1.var_.characterEffect1077ui_story = arg_142_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) then
				if arg_142_1.var_.characterEffect1077ui_story and not isNil(arg_142_1.actors_["1077ui_story"]) then
					arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) and arg_142_1.var_.characterEffect1077ui_story then
				arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_145_2 = arg_142_1.actors_["1077ui_story"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1077ui_story = var_145_2.localPosition

				local var_145_3 = GameObjectTools.GetOrAddComponent(var_145_2.gameObject, typeof(DynamicBoneHelper))

				if var_145_3 then
					var_145_3:EnableDynamicBone(false)
				end
			end

			local var_145_4 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				var_145_2.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_142_1.time_ - 0) / var_145_4)
				var_145_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_2.position).x, (manager.ui.mainCamera.transform.position - var_145_2.position).y, (manager.ui.mainCamera.transform.position - var_145_2.position).z)
				var_145_2.localEulerAngles.z = 0
				var_145_2.localEulerAngles.x = 0
				var_145_2.localEulerAngles = var_145_2.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				var_145_2.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_145_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_2.position).x, (manager.ui.mainCamera.transform.position - var_145_2.position).y, (manager.ui.mainCamera.transform.position - var_145_2.position).z)
				var_145_2.localEulerAngles.z = 0
				var_145_2.localEulerAngles.x = 0
				var_145_2.localEulerAngles = var_145_2.localEulerAngles

				local var_145_5 = GameObjectTools.GetOrAddComponent(var_145_2.gameObject, typeof(DynamicBoneHelper))

				if var_145_5 then
					var_145_5:EnableDynamicBone(true)
				end
			end

			local var_145_6 = 0
			local var_145_7 = 0.45

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_8 = arg_142_1:GetWordFromCfg(325132034)
				local var_145_9 = arg_142_1:FormatText(var_145_8.content)

				arg_142_1.text_.text = var_145_9

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_11 = 18 <= 0 and var_145_7 or var_145_7 * (utf8.len(var_145_9) / 18)

				if (18 <= 0 and var_145_7 or var_145_7 * (utf8.len(var_145_9) / 18)) > 0 and var_145_7 < var_145_11 then
					arg_142_1.talkMaxDuration = var_145_11

					if var_145_11 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_9
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132034", "story_v_out_325132.awb") ~= 0 then
					local var_145_12 = manager.audio:GetVoiceLength("story_v_out_325132", "325132034", "story_v_out_325132.awb") / 1000

					if var_145_12 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_6
					end

					if var_145_8.prefab_name ~= "" and arg_142_1.actors_[var_145_8.prefab_name] ~= nil then
						local var_145_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_8.prefab_name].transform, "story_v_out_325132", "325132034", "story_v_out_325132.awb")

						arg_142_1:RecordAudio("325132034", var_145_13)
						arg_142_1:RecordAudio("325132034", var_145_13)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325132", "325132034", "story_v_out_325132.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325132", "325132034", "story_v_out_325132.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_14 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_14 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_14

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_14 and arg_142_1.time_ < var_145_6 + var_145_14 + arg_145_0 then
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
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play325132035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325132035
		arg_146_1.duration_ = 10.93

		local var_146_0 = {
			zh = 10.933,
			ja = 7.2
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
				arg_146_0:Play325132036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1.225

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
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

				local var_149_1 = arg_146_1:GetWordFromCfg(325132035)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 49 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 49)

				if (49 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 49)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132035", "story_v_out_325132.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132035", "story_v_out_325132.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_325132", "325132035", "story_v_out_325132.awb")

						arg_146_1:RecordAudio("325132035", var_149_6)
						arg_146_1:RecordAudio("325132035", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_325132", "325132035", "story_v_out_325132.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_325132", "325132035", "story_v_out_325132.awb")
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
	Play325132036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325132036
		arg_150_1.duration_ = 16.07

		local var_150_0 = {
			zh = 11.766,
			ja = 16.066
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
				arg_150_0:Play325132037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_153_0 = 0
			local var_153_1 = 1.35

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
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

				local var_153_2 = arg_150_1:GetWordFromCfg(325132036)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 54 <= 0 and var_153_1 or var_153_1 * (utf8.len(var_153_3) / 54)

				if (54 <= 0 and var_153_1 or var_153_1 * (utf8.len(var_153_3) / 54)) > 0 and var_153_1 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132036", "story_v_out_325132.awb") ~= 0 then
					local var_153_6 = manager.audio:GetVoiceLength("story_v_out_325132", "325132036", "story_v_out_325132.awb") / 1000

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end

					if var_153_2.prefab_name ~= "" and arg_150_1.actors_[var_153_2.prefab_name] ~= nil then
						local var_153_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_2.prefab_name].transform, "story_v_out_325132", "325132036", "story_v_out_325132.awb")

						arg_150_1:RecordAudio("325132036", var_153_7)
						arg_150_1:RecordAudio("325132036", var_153_7)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325132", "325132036", "story_v_out_325132.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325132", "325132036", "story_v_out_325132.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_8 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_8 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_8

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_8 and arg_150_1.time_ < var_153_0 + var_153_8 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play325132037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325132037
		arg_154_1.duration_ = 13.87

		local var_154_0 = {
			zh = 13.2,
			ja = 13.866
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
				arg_154_0:Play325132038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.45

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:GetWordFromCfg(325132037)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 58 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 58)

				if (58 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 58)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132037", "story_v_out_325132.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132037", "story_v_out_325132.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_325132", "325132037", "story_v_out_325132.awb")

						arg_154_1:RecordAudio("325132037", var_157_6)
						arg_154_1:RecordAudio("325132037", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325132", "325132037", "story_v_out_325132.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325132", "325132037", "story_v_out_325132.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play325132038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325132038
		arg_158_1.duration_ = 5.07

		local var_158_0 = {
			zh = 4.833,
			ja = 5.066
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
				arg_158_0:Play325132039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_161_0 = 0
			local var_161_1 = 0.5

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(325132038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 20 <= 0 and var_161_1 or var_161_1 * (utf8.len(var_161_3) / 20)

				if (20 <= 0 and var_161_1 or var_161_1 * (utf8.len(var_161_3) / 20)) > 0 and var_161_1 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132038", "story_v_out_325132.awb") ~= 0 then
					local var_161_6 = manager.audio:GetVoiceLength("story_v_out_325132", "325132038", "story_v_out_325132.awb") / 1000

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end

					if var_161_2.prefab_name ~= "" and arg_158_1.actors_[var_161_2.prefab_name] ~= nil then
						local var_161_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_2.prefab_name].transform, "story_v_out_325132", "325132038", "story_v_out_325132.awb")

						arg_158_1:RecordAudio("325132038", var_161_7)
						arg_158_1:RecordAudio("325132038", var_161_7)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325132", "325132038", "story_v_out_325132.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325132", "325132038", "story_v_out_325132.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_8 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_8 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_8

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_8 and arg_158_1.time_ < var_161_0 + var_161_8 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play325132039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325132039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play325132040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1077ui_story"]) and arg_162_1.var_.characterEffect1077ui_story == nil then
				arg_162_1.var_.characterEffect1077ui_story = arg_162_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1077ui_story"]) then
				if arg_162_1.var_.characterEffect1077ui_story and not isNil(arg_162_1.actors_["1077ui_story"]) then
					arg_162_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1077ui_story"]) and arg_162_1.var_.characterEffect1077ui_story then
				arg_162_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.925

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(325132039).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 37 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 37)

				if (37 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 37)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play325132040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325132040
		arg_166_1.duration_ = 13.5

		local var_166_0 = {
			zh = 12,
			ja = 13.5
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
				arg_166_0:Play325132041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1077ui_story"]) and arg_166_1.var_.characterEffect1077ui_story == nil then
				arg_166_1.var_.characterEffect1077ui_story = arg_166_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1077ui_story"]) then
				if arg_166_1.var_.characterEffect1077ui_story and not isNil(arg_166_1.actors_["1077ui_story"]) then
					arg_166_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1077ui_story"]) and arg_166_1.var_.characterEffect1077ui_story then
				arg_166_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_169_2 = 0
			local var_169_3 = 1.2

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_4 = arg_166_1:GetWordFromCfg(325132040)
				local var_169_5 = arg_166_1:FormatText(var_169_4.content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 48 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 48)

				if (48 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 48)) > 0 and var_169_3 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132040", "story_v_out_325132.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_325132", "325132040", "story_v_out_325132.awb") / 1000

					if var_169_8 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_2
					end

					if var_169_4.prefab_name ~= "" and arg_166_1.actors_[var_169_4.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_4.prefab_name].transform, "story_v_out_325132", "325132040", "story_v_out_325132.awb")

						arg_166_1:RecordAudio("325132040", var_169_9)
						arg_166_1:RecordAudio("325132040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_325132", "325132040", "story_v_out_325132.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_325132", "325132040", "story_v_out_325132.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_10 and arg_166_1.time_ < var_169_2 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325132041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325132041
		arg_170_1.duration_ = 3.9

		local var_170_0 = {
			zh = 3.433,
			ja = 3.9
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
				arg_170_0:Play325132042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1061ui_story"]) and arg_170_1.var_.characterEffect1061ui_story == nil then
				arg_170_1.var_.characterEffect1061ui_story = arg_170_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1061ui_story"]) then
				if arg_170_1.var_.characterEffect1061ui_story and not isNil(arg_170_1.actors_["1061ui_story"]) then
					arg_170_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1061ui_story"]) and arg_170_1.var_.characterEffect1061ui_story then
				arg_170_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_173_2 = arg_170_1.actors_["1077ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1077ui_story == nil then
				arg_170_1.var_.characterEffect1077ui_story = var_173_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_3 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.characterEffect1077ui_story and not isNil(var_173_2) then
					arg_170_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_3)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1077ui_story then
				arg_170_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_173_4 = arg_170_1.actors_["1077ui_story"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1077ui_story = var_173_4.localPosition

				local var_173_5 = GameObjectTools.GetOrAddComponent(var_173_4.gameObject, typeof(DynamicBoneHelper))

				if var_173_5 then
					var_173_5:EnableDynamicBone(false)
				end
			end

			local var_173_6 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_6 then
				var_173_4.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_170_1.time_ - 0) / var_173_6)
				var_173_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_4.position).x, (manager.ui.mainCamera.transform.position - var_173_4.position).y, (manager.ui.mainCamera.transform.position - var_173_4.position).z)
				var_173_4.localEulerAngles.z = 0
				var_173_4.localEulerAngles.x = 0
				var_173_4.localEulerAngles = var_173_4.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_6 and arg_170_1.time_ < 0 + var_173_6 + arg_173_0 then
				var_173_4.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_173_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_4.position).x, (manager.ui.mainCamera.transform.position - var_173_4.position).y, (manager.ui.mainCamera.transform.position - var_173_4.position).z)
				var_173_4.localEulerAngles.z = 0
				var_173_4.localEulerAngles.x = 0
				var_173_4.localEulerAngles = var_173_4.localEulerAngles

				local var_173_7 = GameObjectTools.GetOrAddComponent(var_173_4.gameObject, typeof(DynamicBoneHelper))

				if var_173_7 then
					var_173_7:EnableDynamicBone(true)
				end
			end

			local var_173_8 = arg_170_1.actors_["1061ui_story"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1061ui_story = var_173_8.localPosition
			end

			local var_173_9 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_9 then
				var_173_8.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_170_1.time_ - 0) / var_173_9)
				var_173_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_8.position).x, (manager.ui.mainCamera.transform.position - var_173_8.position).y, (manager.ui.mainCamera.transform.position - var_173_8.position).z)
				var_173_8.localEulerAngles.z = 0
				var_173_8.localEulerAngles.x = 0
				var_173_8.localEulerAngles = var_173_8.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_9 and arg_170_1.time_ < 0 + var_173_9 + arg_173_0 then
				var_173_8.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_173_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_8.position).x, (manager.ui.mainCamera.transform.position - var_173_8.position).y, (manager.ui.mainCamera.transform.position - var_173_8.position).z)
				var_173_8.localEulerAngles.z = 0
				var_173_8.localEulerAngles.x = 0
				var_173_8.localEulerAngles = var_173_8.localEulerAngles
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_173_10 = 0
			local var_173_11 = 0.4

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_12 = arg_170_1:GetWordFromCfg(325132041)
				local var_173_13 = arg_170_1:FormatText(var_173_12.content)

				arg_170_1.text_.text = var_173_13

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_15 = 16 <= 0 and var_173_11 or var_173_11 * (utf8.len(var_173_13) / 16)

				if (16 <= 0 and var_173_11 or var_173_11 * (utf8.len(var_173_13) / 16)) > 0 and var_173_11 < var_173_15 then
					arg_170_1.talkMaxDuration = var_173_15

					if var_173_15 + var_173_10 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_15 + var_173_10
					end
				end

				arg_170_1.text_.text = var_173_13
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132041", "story_v_out_325132.awb") ~= 0 then
					local var_173_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132041", "story_v_out_325132.awb") / 1000

					if var_173_16 + var_173_10 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_16 + var_173_10
					end

					if var_173_12.prefab_name ~= "" and arg_170_1.actors_[var_173_12.prefab_name] ~= nil then
						local var_173_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_12.prefab_name].transform, "story_v_out_325132", "325132041", "story_v_out_325132.awb")

						arg_170_1:RecordAudio("325132041", var_173_17)
						arg_170_1:RecordAudio("325132041", var_173_17)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_325132", "325132041", "story_v_out_325132.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_325132", "325132041", "story_v_out_325132.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_18 = math.max(var_173_11, arg_170_1.talkMaxDuration)

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_18 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_10) / var_173_18

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_10 + var_173_18 and arg_170_1.time_ < var_173_10 + var_173_18 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play325132042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325132042
		arg_174_1.duration_ = 7.97

		local var_174_0 = {
			zh = 4.9,
			ja = 7.966
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
				arg_174_0:Play325132043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1077ui_story"]) and arg_174_1.var_.characterEffect1077ui_story == nil then
				arg_174_1.var_.characterEffect1077ui_story = arg_174_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1077ui_story"]) then
				if arg_174_1.var_.characterEffect1077ui_story and not isNil(arg_174_1.actors_["1077ui_story"]) then
					arg_174_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1077ui_story"]) and arg_174_1.var_.characterEffect1077ui_story then
				arg_174_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_177_2 = arg_174_1.actors_["1061ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect1061ui_story == nil then
				arg_174_1.var_.characterEffect1061ui_story = var_177_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_3 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.characterEffect1061ui_story and not isNil(var_177_2) then
					arg_174_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_3)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect1061ui_story then
				arg_174_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_2")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_177_4 = 0
			local var_177_5 = 0.55

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_6 = arg_174_1:GetWordFromCfg(325132042)
				local var_177_7 = arg_174_1:FormatText(var_177_6.content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 22 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 22)

				if (22 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 22)) > 0 and var_177_5 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_4
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132042", "story_v_out_325132.awb") ~= 0 then
					local var_177_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132042", "story_v_out_325132.awb") / 1000

					if var_177_10 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_4
					end

					if var_177_6.prefab_name ~= "" and arg_174_1.actors_[var_177_6.prefab_name] ~= nil then
						local var_177_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_6.prefab_name].transform, "story_v_out_325132", "325132042", "story_v_out_325132.awb")

						arg_174_1:RecordAudio("325132042", var_177_11)
						arg_174_1:RecordAudio("325132042", var_177_11)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_325132", "325132042", "story_v_out_325132.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_325132", "325132042", "story_v_out_325132.awb")
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
	Play325132043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325132043
		arg_178_1.duration_ = 23

		local var_178_0 = {
			zh = 11.2,
			ja = 23
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
				arg_178_0:Play325132044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 1.2

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
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

				local var_181_1 = arg_178_1:GetWordFromCfg(325132043)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 48 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 48)

				if (48 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 48)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132043", "story_v_out_325132.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132043", "story_v_out_325132.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_325132", "325132043", "story_v_out_325132.awb")

						arg_178_1:RecordAudio("325132043", var_181_6)
						arg_178_1:RecordAudio("325132043", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_325132", "325132043", "story_v_out_325132.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_325132", "325132043", "story_v_out_325132.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play325132044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325132044
		arg_182_1.duration_ = 11.6

		local var_182_0 = {
			zh = 11.6,
			ja = 11.133
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
				arg_182_0:Play325132045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 1.125

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(325132044)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 45 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 45)

				if (45 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 45)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132044", "story_v_out_325132.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132044", "story_v_out_325132.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_325132", "325132044", "story_v_out_325132.awb")

						arg_182_1:RecordAudio("325132044", var_185_6)
						arg_182_1:RecordAudio("325132044", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_325132", "325132044", "story_v_out_325132.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_325132", "325132044", "story_v_out_325132.awb")
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
	Play325132045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325132045
		arg_186_1.duration_ = 9.7

		local var_186_0 = {
			zh = 6.766,
			ja = 9.7
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
				arg_186_0:Play325132046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if arg_186_1.bgs_.ST2005 == nil then
				local var_189_0 = Object.Instantiate(arg_186_1.paintGo_)

				var_189_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2005")
				var_189_0.name = "ST2005"
				var_189_0.transform.parent = arg_186_1.stage_.transform
				var_189_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.bgs_.ST2005 = var_189_0
			end

			if 1.7 < arg_186_1.time_ and arg_186_1.time_ <= 1.7 + arg_189_0 then
				local var_189_1 = arg_186_1.bgs_.ST2005

				arg_186_1.bgs_.ST2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_189_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_189_2 = var_189_1:GetComponent("SpriteRenderer")

				if var_189_2 and var_189_2.sprite then
					local var_189_3 = 2 * (var_189_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_189_1.transform.localScale = Vector3.New(var_189_3 / var_189_2.sprite.bounds.size.y < var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x and var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x or var_189_3 / var_189_2.sprite.bounds.size.y, var_189_3 / var_189_2.sprite.bounds.size.y < var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x and var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x or var_189_3 / var_189_2.sprite.bounds.size.y, 0)
				end

				for iter_189_0, iter_189_1 in pairs(arg_186_1.bgs_) do
					if iter_189_0 ~= "ST2005" then
						iter_189_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_189_4 = 1.7

			if 1.7 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.allBtn_.enabled = false
			end

			if arg_186_1.time_ >= var_189_4 + 0.3 and arg_186_1.time_ < var_189_4 + 0.3 + arg_189_0 then
				arg_186_1.allBtn_.enabled = true
			end

			local var_189_5 = 0

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_6 = 1.73400000184774

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 then
				local var_189_7 = Color.New(0, 0, 0)

				var_189_7.a = Mathf.Lerp(0, 1, (arg_186_1.time_ - var_189_5) / var_189_6)
				arg_186_1.mask_.color = var_189_7
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 then
				local var_189_8 = Color.New(0, 0, 0)

				var_189_8.a = 1
				arg_186_1.mask_.color = var_189_8
			end

			local var_189_9 = 1.7

			if 1.7 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_10 = 2

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_10 then
				local var_189_11 = Color.New(0, 0, 0)

				var_189_11.a = Mathf.Lerp(1, 0, (arg_186_1.time_ - var_189_9) / var_189_10)
				arg_186_1.mask_.color = var_189_11
			end

			if arg_186_1.time_ >= var_189_9 + var_189_10 and arg_186_1.time_ < var_189_9 + var_189_10 + arg_189_0 then
				local var_189_12 = Color.New(0, 0, 0)

				arg_186_1.mask_.enabled = false
				var_189_12.a = 0
				arg_186_1.mask_.color = var_189_12
			end

			local var_189_13 = arg_186_1.actors_["1077ui_story"].transform

			if 1.7 < arg_186_1.time_ and arg_186_1.time_ <= 1.7 + arg_189_0 then
				arg_186_1.var_.moveOldPos1077ui_story = var_189_13.localPosition

				local var_189_14 = GameObjectTools.GetOrAddComponent(var_189_13.gameObject, typeof(DynamicBoneHelper))

				if var_189_14 then
					var_189_14:EnableDynamicBone(false)
				end
			end

			local var_189_15 = 0.001

			if 1.7 <= arg_186_1.time_ and arg_186_1.time_ < 1.7 + var_189_15 then
				var_189_13.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 1.7) / var_189_15)
				var_189_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_13.position).x, (manager.ui.mainCamera.transform.position - var_189_13.position).y, (manager.ui.mainCamera.transform.position - var_189_13.position).z)
				var_189_13.localEulerAngles.z = 0
				var_189_13.localEulerAngles.x = 0
				var_189_13.localEulerAngles = var_189_13.localEulerAngles
			end

			if arg_186_1.time_ >= 1.7 + var_189_15 and arg_186_1.time_ < 1.7 + var_189_15 + arg_189_0 then
				var_189_13.localPosition = Vector3.New(0, 100, 0)
				var_189_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_13.position).x, (manager.ui.mainCamera.transform.position - var_189_13.position).y, (manager.ui.mainCamera.transform.position - var_189_13.position).z)
				var_189_13.localEulerAngles.z = 0
				var_189_13.localEulerAngles.x = 0
				var_189_13.localEulerAngles = var_189_13.localEulerAngles

				local var_189_16 = GameObjectTools.GetOrAddComponent(var_189_13.gameObject, typeof(DynamicBoneHelper))

				if var_189_16 then
					var_189_16:EnableDynamicBone(true)
				end
			end

			local var_189_17 = arg_186_1.actors_["1053ui_story"].transform

			if 1.7 < arg_186_1.time_ and arg_186_1.time_ <= 1.7 + arg_189_0 then
				arg_186_1.var_.moveOldPos1053ui_story = var_189_17.localPosition

				local var_189_18 = GameObjectTools.GetOrAddComponent(var_189_17.gameObject, typeof(DynamicBoneHelper))

				if var_189_18 then
					var_189_18:EnableDynamicBone(false)
				end
			end

			local var_189_19 = 0.001

			if 1.7 <= arg_186_1.time_ and arg_186_1.time_ < 1.7 + var_189_19 then
				var_189_17.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 1.7) / var_189_19)
				var_189_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_17.position).x, (manager.ui.mainCamera.transform.position - var_189_17.position).y, (manager.ui.mainCamera.transform.position - var_189_17.position).z)
				var_189_17.localEulerAngles.z = 0
				var_189_17.localEulerAngles.x = 0
				var_189_17.localEulerAngles = var_189_17.localEulerAngles
			end

			if arg_186_1.time_ >= 1.7 + var_189_19 and arg_186_1.time_ < 1.7 + var_189_19 + arg_189_0 then
				var_189_17.localPosition = Vector3.New(0, 100, 0)
				var_189_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_17.position).x, (manager.ui.mainCamera.transform.position - var_189_17.position).y, (manager.ui.mainCamera.transform.position - var_189_17.position).z)
				var_189_17.localEulerAngles.z = 0
				var_189_17.localEulerAngles.x = 0
				var_189_17.localEulerAngles = var_189_17.localEulerAngles

				local var_189_20 = GameObjectTools.GetOrAddComponent(var_189_17.gameObject, typeof(DynamicBoneHelper))

				if var_189_20 then
					var_189_20:EnableDynamicBone(true)
				end
			end

			local var_189_21 = arg_186_1.actors_["1061ui_story"].transform

			if 1.7 < arg_186_1.time_ and arg_186_1.time_ <= 1.7 + arg_189_0 then
				arg_186_1.var_.moveOldPos1061ui_story = var_189_21.localPosition
			end

			local var_189_22 = 0.001

			if 1.7 <= arg_186_1.time_ and arg_186_1.time_ < 1.7 + var_189_22 then
				var_189_21.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 1.7) / var_189_22)
				var_189_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_21.position).x, (manager.ui.mainCamera.transform.position - var_189_21.position).y, (manager.ui.mainCamera.transform.position - var_189_21.position).z)
				var_189_21.localEulerAngles.z = 0
				var_189_21.localEulerAngles.x = 0
				var_189_21.localEulerAngles = var_189_21.localEulerAngles
			end

			if arg_186_1.time_ >= 1.7 + var_189_22 and arg_186_1.time_ < 1.7 + var_189_22 + arg_189_0 then
				var_189_21.localPosition = Vector3.New(0, 100, 0)
				var_189_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_21.position).x, (manager.ui.mainCamera.transform.position - var_189_21.position).y, (manager.ui.mainCamera.transform.position - var_189_21.position).z)
				var_189_21.localEulerAngles.z = 0
				var_189_21.localEulerAngles.x = 0
				var_189_21.localEulerAngles = var_189_21.localEulerAngles
			end

			local var_189_23 = arg_186_1.actors_["1077ui_story"]

			if 1.7 < arg_186_1.time_ and arg_186_1.time_ <= 1.7 + arg_189_0 and not isNil(var_189_23) and arg_186_1.var_.characterEffect1077ui_story == nil then
				arg_186_1.var_.characterEffect1077ui_story = var_189_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_24 = 0.200000002980232

			if 1.7 <= arg_186_1.time_ and arg_186_1.time_ < 1.7 + var_189_24 and not isNil(var_189_23) then
				if arg_186_1.var_.characterEffect1077ui_story and not isNil(var_189_23) then
					arg_186_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 1.7) / var_189_24)
				end
			end

			if arg_186_1.time_ >= 1.7 + var_189_24 and arg_186_1.time_ < 1.7 + var_189_24 + arg_189_0 and not isNil(var_189_23) and arg_186_1.var_.characterEffect1077ui_story then
				arg_186_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_189_25 = 1.7

			arg_186_1.isInRecall_ = false

			if var_189_25 < arg_186_1.time_ and arg_186_1.time_ <= var_189_25 + arg_189_0 then
				arg_186_1.screenFilterGo_:SetActive(true)

				arg_186_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_189_2, iter_189_3 in pairs(arg_186_1.actors_) do
					for iter_189_4, iter_189_5 in ipairs((iter_189_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_189_5.color = iter_189_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_189_26 = 0.034000001847744

			if var_189_25 <= arg_186_1.time_ and arg_186_1.time_ < var_189_25 + var_189_26 then
				arg_186_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_186_1.time_ - var_189_25) / var_189_26)
			end

			if arg_186_1.time_ >= var_189_25 + var_189_26 and arg_186_1.time_ < var_189_25 + var_189_26 + arg_189_0 then
				arg_186_1.screenFilterEffect_.weight = 1
			end

			if 1.2 < arg_186_1.time_ and arg_186_1.time_ <= 1.2 + arg_189_0 then
				arg_186_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if arg_186_1.frameCnt_ <= 1 then
				arg_186_1.dialog_:SetActive(false)
			end

			local var_189_28 = 3.1
			local var_189_29 = 0.325

			if 3.1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_28 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_30 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_30:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_186_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_189_31 = arg_186_1:GetWordFromCfg(325132045)
				local var_189_32 = arg_186_1:FormatText(var_189_31.content)

				arg_186_1.text_.text = var_189_32

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_34 = 13 <= 0 and var_189_29 or var_189_29 * (utf8.len(var_189_32) / 13)

				if (13 <= 0 and var_189_29 or var_189_29 * (utf8.len(var_189_32) / 13)) > 0 and var_189_29 < var_189_34 then
					arg_186_1.talkMaxDuration = var_189_34
					var_189_28 = var_189_28 + 0.3

					if var_189_34 + var_189_28 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_34 + var_189_28
					end
				end

				arg_186_1.text_.text = var_189_32
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132045", "story_v_out_325132.awb") ~= 0 then
					local var_189_35 = manager.audio:GetVoiceLength("story_v_out_325132", "325132045", "story_v_out_325132.awb") / 1000

					if var_189_35 + var_189_28 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_35 + var_189_28
					end

					if var_189_31.prefab_name ~= "" and arg_186_1.actors_[var_189_31.prefab_name] ~= nil then
						local var_189_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_31.prefab_name].transform, "story_v_out_325132", "325132045", "story_v_out_325132.awb")

						arg_186_1:RecordAudio("325132045", var_189_36)
						arg_186_1:RecordAudio("325132045", var_189_36)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_325132", "325132045", "story_v_out_325132.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_325132", "325132045", "story_v_out_325132.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_37 = var_189_28 + 0.3
			local var_189_38 = math.max(var_189_29, arg_186_1.talkMaxDuration)

			if var_189_28 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_37 + var_189_38 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_37) / var_189_38

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_37 + var_189_38 and arg_186_1.time_ < var_189_37 + var_189_38 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play325132046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325132046
		arg_192_1.duration_ = 11.3

		local var_192_0 = {
			zh = 10.1,
			ja = 11.3
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
				arg_192_0:Play325132047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0.95 < arg_192_1.time_ and arg_192_1.time_ <= 0.95 + arg_195_0 then
				local var_195_0 = arg_192_1.bgs_.J23g

				arg_192_1.bgs_.J23g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_195_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_1 = var_195_0:GetComponent("SpriteRenderer")

				if var_195_1 and var_195_1.sprite then
					local var_195_2 = 2 * (var_195_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_195_0.transform.localScale = Vector3.New(var_195_2 / var_195_1.sprite.bounds.size.y < var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x and var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x or var_195_2 / var_195_1.sprite.bounds.size.y, var_195_2 / var_195_1.sprite.bounds.size.y < var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x and var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x or var_195_2 / var_195_1.sprite.bounds.size.y, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "J23g" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_3 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_3 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			if arg_192_1.time_ >= var_195_3 + 0.3 and arg_192_1.time_ < var_195_3 + 0.3 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			local var_195_4 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_5 = 0.95

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_5 then
				local var_195_6 = Color.New(0, 0, 0)

				var_195_6.a = Mathf.Lerp(0, 1, (arg_192_1.time_ - var_195_4) / var_195_5)
				arg_192_1.mask_.color = var_195_6
			end

			if arg_192_1.time_ >= var_195_4 + var_195_5 and arg_192_1.time_ < var_195_4 + var_195_5 + arg_195_0 then
				local var_195_7 = Color.New(0, 0, 0)

				var_195_7.a = 1
				arg_192_1.mask_.color = var_195_7
			end

			local var_195_8 = 0.95

			if 0.95 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_9 = 0.95

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_9 then
				local var_195_10 = Color.New(0, 0, 0)

				var_195_10.a = Mathf.Lerp(1, 0, (arg_192_1.time_ - var_195_8) / var_195_9)
				arg_192_1.mask_.color = var_195_10
			end

			if arg_192_1.time_ >= var_195_8 + var_195_9 and arg_192_1.time_ < var_195_8 + var_195_9 + arg_195_0 then
				local var_195_11 = Color.New(0, 0, 0)

				arg_192_1.mask_.enabled = false
				var_195_11.a = 0
				arg_192_1.mask_.color = var_195_11
			end

			local var_195_12 = arg_192_1.actors_["1077ui_story"].transform

			if 1.66666666666667 < arg_192_1.time_ and arg_192_1.time_ <= 1.66666666666667 + arg_195_0 then
				arg_192_1.var_.moveOldPos1077ui_story = var_195_12.localPosition

				local var_195_13 = GameObjectTools.GetOrAddComponent(var_195_12.gameObject, typeof(DynamicBoneHelper))

				if var_195_13 then
					var_195_13:EnableDynamicBone(false)
				end
			end

			local var_195_14 = 0.001

			if 1.66666666666667 <= arg_192_1.time_ and arg_192_1.time_ < 1.66666666666667 + var_195_14 then
				var_195_12.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_192_1.time_ - 1.66666666666667) / var_195_14)
				var_195_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_12.position).x, (manager.ui.mainCamera.transform.position - var_195_12.position).y, (manager.ui.mainCamera.transform.position - var_195_12.position).z)
				var_195_12.localEulerAngles.z = 0
				var_195_12.localEulerAngles.x = 0
				var_195_12.localEulerAngles = var_195_12.localEulerAngles
			end

			if arg_192_1.time_ >= 1.66666666666667 + var_195_14 and arg_192_1.time_ < 1.66666666666667 + var_195_14 + arg_195_0 then
				var_195_12.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_195_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_12.position).x, (manager.ui.mainCamera.transform.position - var_195_12.position).y, (manager.ui.mainCamera.transform.position - var_195_12.position).z)
				var_195_12.localEulerAngles.z = 0
				var_195_12.localEulerAngles.x = 0
				var_195_12.localEulerAngles = var_195_12.localEulerAngles

				local var_195_15 = GameObjectTools.GetOrAddComponent(var_195_12.gameObject, typeof(DynamicBoneHelper))

				if var_195_15 then
					var_195_15:EnableDynamicBone(true)
				end
			end

			local var_195_16 = arg_192_1.actors_["1077ui_story"]

			if 1.66666666666667 < arg_192_1.time_ and arg_192_1.time_ <= 1.66666666666667 + arg_195_0 and not isNil(var_195_16) and arg_192_1.var_.characterEffect1077ui_story == nil then
				arg_192_1.var_.characterEffect1077ui_story = var_195_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_17 = 0.200000002980232

			if 1.66666666666667 <= arg_192_1.time_ and arg_192_1.time_ < 1.66666666666667 + var_195_17 and not isNil(var_195_16) then
				if arg_192_1.var_.characterEffect1077ui_story and not isNil(var_195_16) then
					arg_192_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 1.66666666666667 + var_195_17 and arg_192_1.time_ < 1.66666666666667 + var_195_17 + arg_195_0 and not isNil(var_195_16) and arg_192_1.var_.characterEffect1077ui_story then
				arg_192_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_195_19 = 0.95

			arg_192_1.isInRecall_ = false

			if var_195_19 < arg_192_1.time_ and arg_192_1.time_ <= var_195_19 + arg_195_0 then
				arg_192_1.screenFilterGo_:SetActive(false)

				for iter_195_2, iter_195_3 in pairs(arg_192_1.actors_) do
					for iter_195_4, iter_195_5 in ipairs((iter_195_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_195_5.color = iter_195_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_195_20 = 0.034000001847744

			if var_195_19 <= arg_192_1.time_ and arg_192_1.time_ < var_195_19 + var_195_20 then
				arg_192_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_192_1.time_ - var_195_19) / var_195_20)
			end

			if arg_192_1.time_ >= var_195_19 + var_195_20 and arg_192_1.time_ < var_195_19 + var_195_20 + arg_195_0 then
				arg_192_1.screenFilterEffect_.weight = 0
			end

			if 1.66666666666667 < arg_192_1.time_ and arg_192_1.time_ <= 1.66666666666667 + arg_195_0 then
				arg_192_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 1.2 < arg_192_1.time_ and arg_192_1.time_ <= 1.2 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_workshop", "")
			end

			if 0.1 < arg_192_1.time_ and arg_192_1.time_ <= 0.1 + arg_195_0 then
				arg_192_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_23 = 1.9
			local var_195_24 = 0.95

			if 1.9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_23 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_25 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_25:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_26 = arg_192_1:GetWordFromCfg(325132046)
				local var_195_27 = arg_192_1:FormatText(var_195_26.content)

				arg_192_1.text_.text = var_195_27

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_29 = 38 <= 0 and var_195_24 or var_195_24 * (utf8.len(var_195_27) / 38)

				if (38 <= 0 and var_195_24 or var_195_24 * (utf8.len(var_195_27) / 38)) > 0 and var_195_24 < var_195_29 then
					arg_192_1.talkMaxDuration = var_195_29
					var_195_23 = var_195_23 + 0.3

					if var_195_29 + var_195_23 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_29 + var_195_23
					end
				end

				arg_192_1.text_.text = var_195_27
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132046", "story_v_out_325132.awb") ~= 0 then
					local var_195_30 = manager.audio:GetVoiceLength("story_v_out_325132", "325132046", "story_v_out_325132.awb") / 1000

					if var_195_30 + var_195_23 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_30 + var_195_23
					end

					if var_195_26.prefab_name ~= "" and arg_192_1.actors_[var_195_26.prefab_name] ~= nil then
						local var_195_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_26.prefab_name].transform, "story_v_out_325132", "325132046", "story_v_out_325132.awb")

						arg_192_1:RecordAudio("325132046", var_195_31)
						arg_192_1:RecordAudio("325132046", var_195_31)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325132", "325132046", "story_v_out_325132.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325132", "325132046", "story_v_out_325132.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_32 = var_195_23 + 0.3
			local var_195_33 = math.max(var_195_24, arg_192_1.talkMaxDuration)

			if var_195_23 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_32 + var_195_33 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_32) / var_195_33

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_32 + var_195_33 and arg_192_1.time_ < var_195_32 + var_195_33 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play325132047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325132047
		arg_198_1.duration_ = 13.4

		local var_198_0 = {
			zh = 10.2,
			ja = 13.4
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
				arg_198_0:Play325132048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 1.15

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
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

				local var_201_1 = arg_198_1:GetWordFromCfg(325132047)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 46 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 46)

				if (46 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 46)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132047", "story_v_out_325132.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132047", "story_v_out_325132.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_325132", "325132047", "story_v_out_325132.awb")

						arg_198_1:RecordAudio("325132047", var_201_6)
						arg_198_1:RecordAudio("325132047", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_325132", "325132047", "story_v_out_325132.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_325132", "325132047", "story_v_out_325132.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play325132048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325132048
		arg_202_1.duration_ = 7.7

		local var_202_0 = {
			zh = 7.2,
			ja = 7.7
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
				arg_202_0:Play325132049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.95

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
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

				local var_205_1 = arg_202_1:GetWordFromCfg(325132048)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 38 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 38)

				if (38 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 38)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132048", "story_v_out_325132.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132048", "story_v_out_325132.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_325132", "325132048", "story_v_out_325132.awb")

						arg_202_1:RecordAudio("325132048", var_205_6)
						arg_202_1:RecordAudio("325132048", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_325132", "325132048", "story_v_out_325132.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_325132", "325132048", "story_v_out_325132.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play325132049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325132049
		arg_206_1.duration_ = 10.17

		local var_206_0 = {
			zh = 6.7,
			ja = 10.166
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
				arg_206_0:Play325132050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action423")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_209_0 = 0
			local var_209_1 = 0.875

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:GetWordFromCfg(325132049)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 35 <= 0 and var_209_1 or var_209_1 * (utf8.len(var_209_3) / 35)

				if (35 <= 0 and var_209_1 or var_209_1 * (utf8.len(var_209_3) / 35)) > 0 and var_209_1 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132049", "story_v_out_325132.awb") ~= 0 then
					local var_209_6 = manager.audio:GetVoiceLength("story_v_out_325132", "325132049", "story_v_out_325132.awb") / 1000

					if var_209_6 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_0
					end

					if var_209_2.prefab_name ~= "" and arg_206_1.actors_[var_209_2.prefab_name] ~= nil then
						local var_209_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_2.prefab_name].transform, "story_v_out_325132", "325132049", "story_v_out_325132.awb")

						arg_206_1:RecordAudio("325132049", var_209_7)
						arg_206_1:RecordAudio("325132049", var_209_7)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325132", "325132049", "story_v_out_325132.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325132", "325132049", "story_v_out_325132.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_8 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_8 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_8

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_8 and arg_206_1.time_ < var_209_0 + var_209_8 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play325132050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325132050
		arg_210_1.duration_ = 7.2

		local var_210_0 = {
			zh = 3.5,
			ja = 7.2
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
				arg_210_0:Play325132051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.525

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
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

				local var_213_1 = arg_210_1:GetWordFromCfg(325132050)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 21 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 21)

				if (21 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 21)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132050", "story_v_out_325132.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_325132", "325132050", "story_v_out_325132.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_325132", "325132050", "story_v_out_325132.awb")

						arg_210_1:RecordAudio("325132050", var_213_6)
						arg_210_1:RecordAudio("325132050", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_325132", "325132050", "story_v_out_325132.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_325132", "325132050", "story_v_out_325132.awb")
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
	Play325132051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325132051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325132052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1077ui_story = arg_214_1.actors_["1077ui_story"].transform.localPosition

				local var_217_0 = GameObjectTools.GetOrAddComponent(arg_214_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_217_0 then
					var_217_0:EnableDynamicBone(false)
				end
			end

			local var_217_1 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 then
				arg_214_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_1)
				arg_214_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).z)
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles = arg_214_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 then
				arg_214_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).z)
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles = arg_214_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_217_2 = GameObjectTools.GetOrAddComponent(arg_214_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_217_2 then
					var_217_2:EnableDynamicBone(true)
				end
			end

			local var_217_3 = arg_214_1.actors_["1077ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect1077ui_story == nil then
				arg_214_1.var_.characterEffect1077ui_story = var_217_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_4 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 and not isNil(var_217_3) then
				if arg_214_1.var_.characterEffect1077ui_story and not isNil(var_217_3) then
					arg_214_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_4)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect1077ui_story then
				arg_214_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_217_5 = 0
			local var_217_6 = 1.075

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(325132051).content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 43 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_7) / 43)

				if (43 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_7) / 43)) > 0 and var_217_6 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_6, arg_214_1.talkMaxDuration)

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_5) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_5 + var_217_10 and arg_214_1.time_ < var_217_5 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play325132052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325132052
		arg_218_1.duration_ = 6

		local var_218_0 = {
			zh = 4.5,
			ja = 6
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
				arg_218_0:Play325132053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1053ui_story = arg_218_1.actors_["1053ui_story"].transform.localPosition

				local var_221_0 = GameObjectTools.GetOrAddComponent(arg_218_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_221_0 then
					var_221_0:EnableDynamicBone(false)
				end
			end

			local var_221_1 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 then
				arg_218_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_218_1.time_ - 0) / var_221_1)
				arg_218_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1053ui_story"].transform.position).z)
				arg_218_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1053ui_story"].transform.localEulerAngles = arg_218_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 then
				arg_218_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_218_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1053ui_story"].transform.position).z)
				arg_218_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1053ui_story"].transform.localEulerAngles = arg_218_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_221_2 = GameObjectTools.GetOrAddComponent(arg_218_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(true)
				end
			end

			local var_221_3 = arg_218_1.actors_["1053ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_3) and arg_218_1.var_.characterEffect1053ui_story == nil then
				arg_218_1.var_.characterEffect1053ui_story = var_221_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_4 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 and not isNil(var_221_3) then
				if arg_218_1.var_.characterEffect1053ui_story and not isNil(var_221_3) then
					arg_218_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 and not isNil(var_221_3) and arg_218_1.var_.characterEffect1053ui_story then
				arg_218_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_221_6 = 0
			local var_221_7 = 0.425

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_8 = arg_218_1:GetWordFromCfg(325132052)
				local var_221_9 = arg_218_1:FormatText(var_221_8.content)

				arg_218_1.text_.text = var_221_9

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 17 <= 0 and var_221_7 or var_221_7 * (utf8.len(var_221_9) / 17)

				if (17 <= 0 and var_221_7 or var_221_7 * (utf8.len(var_221_9) / 17)) > 0 and var_221_7 < var_221_11 then
					arg_218_1.talkMaxDuration = var_221_11

					if var_221_11 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_11 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_9
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132052", "story_v_out_325132.awb") ~= 0 then
					local var_221_12 = manager.audio:GetVoiceLength("story_v_out_325132", "325132052", "story_v_out_325132.awb") / 1000

					if var_221_12 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_12 + var_221_6
					end

					if var_221_8.prefab_name ~= "" and arg_218_1.actors_[var_221_8.prefab_name] ~= nil then
						local var_221_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_8.prefab_name].transform, "story_v_out_325132", "325132052", "story_v_out_325132.awb")

						arg_218_1:RecordAudio("325132052", var_221_13)
						arg_218_1:RecordAudio("325132052", var_221_13)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_325132", "325132052", "story_v_out_325132.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_325132", "325132052", "story_v_out_325132.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_14 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_14 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_14

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_14 and arg_218_1.time_ < var_221_6 + var_221_14 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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

		arg_218_1:InitPlayNodeList()
	end,
	Play325132053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325132053
		arg_222_1.duration_ = 13.03

		local var_222_0 = {
			zh = 7.466,
			ja = 13.033
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
				arg_222_0:Play325132054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1053ui_story = arg_222_1.actors_["1053ui_story"].transform.localPosition

				local var_225_0 = GameObjectTools.GetOrAddComponent(arg_222_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_225_0 then
					var_225_0:EnableDynamicBone(false)
				end
			end

			local var_225_1 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_1 then
				arg_222_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1053ui_story, Vector3.New(-0.7, -1.08, -6), (arg_222_1.time_ - 0) / var_225_1)
				arg_222_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1053ui_story"].transform.position).z)
				arg_222_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1053ui_story"].transform.localEulerAngles = arg_222_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_1 and arg_222_1.time_ < 0 + var_225_1 + arg_225_0 then
				arg_222_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6)
				arg_222_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1053ui_story"].transform.position).z)
				arg_222_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1053ui_story"].transform.localEulerAngles = arg_222_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_225_2 = GameObjectTools.GetOrAddComponent(arg_222_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_225_2 then
					var_225_2:EnableDynamicBone(true)
				end
			end

			local var_225_3 = arg_222_1.actors_["1077ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1077ui_story = var_225_3.localPosition

				local var_225_4 = GameObjectTools.GetOrAddComponent(var_225_3.gameObject, typeof(DynamicBoneHelper))

				if var_225_4 then
					var_225_4:EnableDynamicBone(false)
				end
			end

			local var_225_5 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_5 then
				var_225_3.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_222_1.time_ - 0) / var_225_5)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_5 and arg_222_1.time_ < 0 + var_225_5 + arg_225_0 then
				var_225_3.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles

				local var_225_6 = GameObjectTools.GetOrAddComponent(var_225_3.gameObject, typeof(DynamicBoneHelper))

				if var_225_6 then
					var_225_6:EnableDynamicBone(true)
				end
			end

			local var_225_7 = arg_222_1.actors_["1077ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_7) and arg_222_1.var_.characterEffect1077ui_story == nil then
				arg_222_1.var_.characterEffect1077ui_story = var_225_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_8 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_8 and not isNil(var_225_7) then
				if arg_222_1.var_.characterEffect1077ui_story and not isNil(var_225_7) then
					arg_222_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_8 and arg_222_1.time_ < 0 + var_225_8 + arg_225_0 and not isNil(var_225_7) and arg_222_1.var_.characterEffect1077ui_story then
				arg_222_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_225_10 = arg_222_1.actors_["1053ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_10) and arg_222_1.var_.characterEffect1053ui_story == nil then
				arg_222_1.var_.characterEffect1053ui_story = var_225_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_11 and not isNil(var_225_10) then
				if arg_222_1.var_.characterEffect1053ui_story and not isNil(var_225_10) then
					arg_222_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_11)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_11 and arg_222_1.time_ < 0 + var_225_11 + arg_225_0 and not isNil(var_225_10) and arg_222_1.var_.characterEffect1053ui_story then
				arg_222_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_225_12 = 0
			local var_225_13 = 0.925

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_12 + arg_225_0 then
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

				local var_225_14 = arg_222_1:GetWordFromCfg(325132053)
				local var_225_15 = arg_222_1:FormatText(var_225_14.content)

				arg_222_1.text_.text = var_225_15

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_17 = 37 <= 0 and var_225_13 or var_225_13 * (utf8.len(var_225_15) / 37)

				if (37 <= 0 and var_225_13 or var_225_13 * (utf8.len(var_225_15) / 37)) > 0 and var_225_13 < var_225_17 then
					arg_222_1.talkMaxDuration = var_225_17

					if var_225_17 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_17 + var_225_12
					end
				end

				arg_222_1.text_.text = var_225_15
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132053", "story_v_out_325132.awb") ~= 0 then
					local var_225_18 = manager.audio:GetVoiceLength("story_v_out_325132", "325132053", "story_v_out_325132.awb") / 1000

					if var_225_18 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_18 + var_225_12
					end

					if var_225_14.prefab_name ~= "" and arg_222_1.actors_[var_225_14.prefab_name] ~= nil then
						local var_225_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_14.prefab_name].transform, "story_v_out_325132", "325132053", "story_v_out_325132.awb")

						arg_222_1:RecordAudio("325132053", var_225_19)
						arg_222_1:RecordAudio("325132053", var_225_19)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_325132", "325132053", "story_v_out_325132.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_325132", "325132053", "story_v_out_325132.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_20 = math.max(var_225_13, arg_222_1.talkMaxDuration)

			if var_225_12 <= arg_222_1.time_ and arg_222_1.time_ < var_225_12 + var_225_20 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_12) / var_225_20

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_12 + var_225_20 and arg_222_1.time_ < var_225_12 + var_225_20 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play325132054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325132054
		arg_226_1.duration_ = 9.7

		local var_226_0 = {
			zh = 7.833,
			ja = 9.7
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
				arg_226_0:Play325132055(arg_226_1)
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
				arg_226_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.7

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

				local var_229_6 = arg_226_1:GetWordFromCfg(325132054)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 28 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 28)

				if (28 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 28)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132054", "story_v_out_325132.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132054", "story_v_out_325132.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_out_325132", "325132054", "story_v_out_325132.awb")

						arg_226_1:RecordAudio("325132054", var_229_11)
						arg_226_1:RecordAudio("325132054", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325132", "325132054", "story_v_out_325132.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325132", "325132054", "story_v_out_325132.awb")
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
	Play325132055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325132055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325132056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1053ui_story = arg_230_1.actors_["1053ui_story"].transform.localPosition

				local var_233_0 = GameObjectTools.GetOrAddComponent(arg_230_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_233_0 then
					var_233_0:EnableDynamicBone(false)
				end
			end

			local var_233_1 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_1 then
				arg_230_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_1)
				arg_230_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1053ui_story"].transform.position).z)
				arg_230_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1053ui_story"].transform.localEulerAngles = arg_230_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_1 and arg_230_1.time_ < 0 + var_233_1 + arg_233_0 then
				arg_230_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1053ui_story"].transform.position).z)
				arg_230_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1053ui_story"].transform.localEulerAngles = arg_230_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_233_2 = GameObjectTools.GetOrAddComponent(arg_230_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_233_2 then
					var_233_2:EnableDynamicBone(true)
				end
			end

			local var_233_3 = arg_230_1.actors_["1077ui_story"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1077ui_story = var_233_3.localPosition

				local var_233_4 = GameObjectTools.GetOrAddComponent(var_233_3.gameObject, typeof(DynamicBoneHelper))

				if var_233_4 then
					var_233_4:EnableDynamicBone(false)
				end
			end

			local var_233_5 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_5 then
				var_233_3.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_5)
				var_233_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_3.position).x, (manager.ui.mainCamera.transform.position - var_233_3.position).y, (manager.ui.mainCamera.transform.position - var_233_3.position).z)
				var_233_3.localEulerAngles.z = 0
				var_233_3.localEulerAngles.x = 0
				var_233_3.localEulerAngles = var_233_3.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_5 and arg_230_1.time_ < 0 + var_233_5 + arg_233_0 then
				var_233_3.localPosition = Vector3.New(0, 100, 0)
				var_233_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_3.position).x, (manager.ui.mainCamera.transform.position - var_233_3.position).y, (manager.ui.mainCamera.transform.position - var_233_3.position).z)
				var_233_3.localEulerAngles.z = 0
				var_233_3.localEulerAngles.x = 0
				var_233_3.localEulerAngles = var_233_3.localEulerAngles

				local var_233_6 = GameObjectTools.GetOrAddComponent(var_233_3.gameObject, typeof(DynamicBoneHelper))

				if var_233_6 then
					var_233_6:EnableDynamicBone(true)
				end
			end

			local var_233_7 = arg_230_1.actors_["1053ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_7) and arg_230_1.var_.characterEffect1053ui_story == nil then
				arg_230_1.var_.characterEffect1053ui_story = var_233_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_8 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_8 and not isNil(var_233_7) then
				if arg_230_1.var_.characterEffect1053ui_story and not isNil(var_233_7) then
					arg_230_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_8)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_8 and arg_230_1.time_ < 0 + var_233_8 + arg_233_0 and not isNil(var_233_7) and arg_230_1.var_.characterEffect1053ui_story then
				arg_230_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_233_9 = 0
			local var_233_10 = 1.025

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_11 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(325132055).content)

				arg_230_1.text_.text = var_233_11

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 41 <= 0 and var_233_10 or var_233_10 * (utf8.len(var_233_11) / 41)

				if (41 <= 0 and var_233_10 or var_233_10 * (utf8.len(var_233_11) / 41)) > 0 and var_233_10 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_9 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_9
					end
				end

				arg_230_1.text_.text = var_233_11
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_10, arg_230_1.talkMaxDuration)

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_9) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_9 + var_233_14 and arg_230_1.time_ < var_233_9 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play325132056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325132056
		arg_234_1.duration_ = 12.9

		local var_234_0 = {
			zh = 8.266,
			ja = 12.9
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
				arg_234_0:Play325132057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1077ui_story = arg_234_1.actors_["1077ui_story"].transform.localPosition

				local var_237_0 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_0 then
					var_237_0:EnableDynamicBone(false)
				end
			end

			local var_237_1 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 then
				arg_234_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_234_1.time_ - 0) / var_237_1)
				arg_234_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).z)
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles = arg_234_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 then
				arg_234_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_234_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).z)
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles = arg_234_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_237_2 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(true)
				end
			end

			local var_237_3 = arg_234_1.actors_["1077ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1077ui_story == nil then
				arg_234_1.var_.characterEffect1077ui_story = var_237_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_4 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 and not isNil(var_237_3) then
				if arg_234_1.var_.characterEffect1077ui_story and not isNil(var_237_3) then
					arg_234_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1077ui_story then
				arg_234_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_237_6 = 0
			local var_237_7 = 1.075

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
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

				local var_237_8 = arg_234_1:GetWordFromCfg(325132056)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 43 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 43)

				if (43 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 43)) > 0 and var_237_7 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132056", "story_v_out_325132.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_325132", "325132056", "story_v_out_325132.awb") / 1000

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end

					if var_237_8.prefab_name ~= "" and arg_234_1.actors_[var_237_8.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_8.prefab_name].transform, "story_v_out_325132", "325132056", "story_v_out_325132.awb")

						arg_234_1:RecordAudio("325132056", var_237_13)
						arg_234_1:RecordAudio("325132056", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325132", "325132056", "story_v_out_325132.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325132", "325132056", "story_v_out_325132.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play325132057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325132057
		arg_238_1.duration_ = 5.9

		local var_238_0 = {
			zh = 4.5,
			ja = 5.9
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
				arg_238_0:Play325132058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1077ui_story = arg_238_1.actors_["1077ui_story"].transform.localPosition

				local var_241_0 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_0 then
					var_241_0:EnableDynamicBone(false)
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_238_1.time_ - 0) / var_241_1)
				arg_238_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1077ui_story"].transform.position).z)
				arg_238_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1077ui_story"].transform.localEulerAngles = arg_238_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				arg_238_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1077ui_story"].transform.position).z)
				arg_238_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1077ui_story"].transform.localEulerAngles = arg_238_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_241_2 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(true)
				end
			end

			local var_241_3 = arg_238_1.actors_["1061ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1061ui_story = var_241_3.localPosition
			end

			local var_241_4 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				var_241_3.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_238_1.time_ - 0) / var_241_4)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				var_241_3.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles
			end

			local var_241_5 = arg_238_1.actors_["1061ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect1061ui_story == nil then
				arg_238_1.var_.characterEffect1061ui_story = var_241_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_6 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_6 and not isNil(var_241_5) then
				if arg_238_1.var_.characterEffect1061ui_story and not isNil(var_241_5) then
					arg_238_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_6 and arg_238_1.time_ < 0 + var_241_6 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect1061ui_story then
				arg_238_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_241_8 = arg_238_1.actors_["1077ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.characterEffect1077ui_story == nil then
				arg_238_1.var_.characterEffect1077ui_story = var_241_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_9 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_9 and not isNil(var_241_8) then
				if arg_238_1.var_.characterEffect1077ui_story and not isNil(var_241_8) then
					arg_238_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_9)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_9 and arg_238_1.time_ < 0 + var_241_9 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.characterEffect1077ui_story then
				arg_238_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_241_10 = 0
			local var_241_11 = 0.45

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_12 = arg_238_1:GetWordFromCfg(325132057)
				local var_241_13 = arg_238_1:FormatText(var_241_12.content)

				arg_238_1.text_.text = var_241_13

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_15 = 18 <= 0 and var_241_11 or var_241_11 * (utf8.len(var_241_13) / 18)

				if (18 <= 0 and var_241_11 or var_241_11 * (utf8.len(var_241_13) / 18)) > 0 and var_241_11 < var_241_15 then
					arg_238_1.talkMaxDuration = var_241_15

					if var_241_15 + var_241_10 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_15 + var_241_10
					end
				end

				arg_238_1.text_.text = var_241_13
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132057", "story_v_out_325132.awb") ~= 0 then
					local var_241_16 = manager.audio:GetVoiceLength("story_v_out_325132", "325132057", "story_v_out_325132.awb") / 1000

					if var_241_16 + var_241_10 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_16 + var_241_10
					end

					if var_241_12.prefab_name ~= "" and arg_238_1.actors_[var_241_12.prefab_name] ~= nil then
						local var_241_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_12.prefab_name].transform, "story_v_out_325132", "325132057", "story_v_out_325132.awb")

						arg_238_1:RecordAudio("325132057", var_241_17)
						arg_238_1:RecordAudio("325132057", var_241_17)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_325132", "325132057", "story_v_out_325132.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_325132", "325132057", "story_v_out_325132.awb")
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

		arg_238_1:InitPlayNodeList()
	end,
	Play325132058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325132058
		arg_242_1.duration_ = 9.77

		local var_242_0 = {
			zh = 7,
			ja = 9.766
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
				arg_242_0:Play325132059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1077ui_story"]) and arg_242_1.var_.characterEffect1077ui_story == nil then
				arg_242_1.var_.characterEffect1077ui_story = arg_242_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1077ui_story"]) then
				if arg_242_1.var_.characterEffect1077ui_story and not isNil(arg_242_1.actors_["1077ui_story"]) then
					arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1077ui_story"]) and arg_242_1.var_.characterEffect1077ui_story then
				arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_245_2 = arg_242_1.actors_["1061ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.characterEffect1061ui_story == nil then
				arg_242_1.var_.characterEffect1061ui_story = var_245_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_3 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.characterEffect1061ui_story and not isNil(var_245_2) then
					arg_242_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_3)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.characterEffect1061ui_story then
				arg_242_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_245_4 = 0
			local var_245_5 = 0.875

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(325132058)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 35 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 35)

				if (35 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 35)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132058", "story_v_out_325132.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132058", "story_v_out_325132.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_out_325132", "325132058", "story_v_out_325132.awb")

						arg_242_1:RecordAudio("325132058", var_245_11)
						arg_242_1:RecordAudio("325132058", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325132", "325132058", "story_v_out_325132.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325132", "325132058", "story_v_out_325132.awb")
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
	Play325132059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325132059
		arg_246_1.duration_ = 3.83

		local var_246_0 = {
			zh = 2.2,
			ja = 3.833
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
				arg_246_0:Play325132060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1061ui_story"]) and arg_246_1.var_.characterEffect1061ui_story == nil then
				arg_246_1.var_.characterEffect1061ui_story = arg_246_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1061ui_story"]) then
				if arg_246_1.var_.characterEffect1061ui_story and not isNil(arg_246_1.actors_["1061ui_story"]) then
					arg_246_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1061ui_story"]) and arg_246_1.var_.characterEffect1061ui_story then
				arg_246_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_249_2 = arg_246_1.actors_["1077ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.characterEffect1077ui_story == nil then
				arg_246_1.var_.characterEffect1077ui_story = var_249_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_3 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.characterEffect1077ui_story and not isNil(var_249_2) then
					arg_246_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_3)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.characterEffect1077ui_story then
				arg_246_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_249_4 = 0
			local var_249_5 = 0.225

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_6 = arg_246_1:GetWordFromCfg(325132059)
				local var_249_7 = arg_246_1:FormatText(var_249_6.content)

				arg_246_1.text_.text = var_249_7

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_9 = 9 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 9)

				if (9 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 9)) > 0 and var_249_5 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_4
					end
				end

				arg_246_1.text_.text = var_249_7
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132059", "story_v_out_325132.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_325132", "325132059", "story_v_out_325132.awb") / 1000

					if var_249_10 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_4
					end

					if var_249_6.prefab_name ~= "" and arg_246_1.actors_[var_249_6.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_6.prefab_name].transform, "story_v_out_325132", "325132059", "story_v_out_325132.awb")

						arg_246_1:RecordAudio("325132059", var_249_11)
						arg_246_1:RecordAudio("325132059", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325132", "325132059", "story_v_out_325132.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325132", "325132059", "story_v_out_325132.awb")
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
	Play325132060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325132060
		arg_250_1.duration_ = 9.67

		local var_250_0 = {
			zh = 7.033,
			ja = 9.666
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
			arg_250_1.auto_ = false
		end

		function arg_250_1.playNext_(arg_252_0)
			arg_250_1.onStoryFinished_()
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_253_1 = 0
			local var_253_2 = 0.8

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(325132060)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_6 = 32 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_4) / 32)

				if (32 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_4) / 32)) > 0 and var_253_2 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325132", "325132060", "story_v_out_325132.awb") ~= 0 then
					local var_253_7 = manager.audio:GetVoiceLength("story_v_out_325132", "325132060", "story_v_out_325132.awb") / 1000

					if var_253_7 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_1
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_325132", "325132060", "story_v_out_325132.awb")

						arg_250_1:RecordAudio("325132060", var_253_8)
						arg_250_1:RecordAudio("325132060", var_253_8)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_325132", "325132060", "story_v_out_325132.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_325132", "325132060", "story_v_out_325132.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_9 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_9 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_9

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_9 and arg_250_1.time_ < var_253_1 + var_253_9 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J23g",
		"TextureConfig/Background/ST2005"
	},
	voices = {
		"story_v_out_325132.awb"
	}
}
