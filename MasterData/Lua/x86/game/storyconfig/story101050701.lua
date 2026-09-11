return {
	Play105071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105071001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			ja = 5.166,
			ko = 3.799999952315,
			zh = 5.4,
			en = 4.2
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
				arg_1_0:Play105071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_1 = "1013ui_story"

			if arg_1_1.actors_["1013ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1013ui_story"))) then
				local var_4_2 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_1_1.stage_.transform)

				var_4_2.name = var_4_1
				var_4_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_1] = var_4_2

				local var_4_3 = var_4_2:GetComponentInChildren(typeof(CharacterEffect))

				var_4_3.enabled = true

				local var_4_4 = GameObjectTools.GetOrAddComponent(var_4_2, typeof(DynamicBoneHelper))

				if var_4_4 then
					var_4_4:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_3.transform, false)

				arg_1_1.var_[var_4_1 .. "Animator"] = var_4_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_1 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_1 .. "LipSync"] = var_4_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_5 = arg_1_1.actors_["1013ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1013ui_story == nil then
				arg_1_1.var_.characterEffect1013ui_story = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_6 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_6 and not isNil(var_4_5) then
				if arg_1_1.var_.characterEffect1013ui_story and not isNil(var_4_5) then
					arg_1_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_6 and arg_1_1.time_ < 2 + var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1013ui_story then
				arg_1_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_4_8 = "B01c"

			if arg_1_1.bgs_.B01c == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.B01c:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueB01c = var_4_10.color.a
					arg_1_1.var_.alphaMatValueB01c = var_4_10
				end

				arg_1_1.var_.alphaOldValueB01c = 0
			end

			local var_4_11 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_11 then
				if arg_1_1.var_.alphaMatValueB01c then
					arg_1_1.var_.alphaMatValueB01c.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB01c, 1, (arg_1_1.time_ - 0) / var_4_11)
					arg_1_1.var_.alphaMatValueB01c.color = arg_1_1.var_.alphaMatValueB01c.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_11 and arg_1_1.time_ < 0 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueB01c then
				arg_1_1.var_.alphaMatValueB01c.color.a = 1
				arg_1_1.var_.alphaMatValueB01c.color = arg_1_1.var_.alphaMatValueB01c.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.bgs_.B01c

				arg_1_1.bgs_.B01c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_13 = var_4_12:GetComponent("SpriteRenderer")

				if var_4_13 and var_4_13.sprite then
					local var_4_14 = 2 * (var_4_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_12.transform.localScale = Vector3.New(var_4_14 / var_4_13.sprite.bounds.size.y < var_4_14 * manager.ui.mainCameraCom_.aspect / var_4_13.sprite.bounds.size.x and var_4_14 * manager.ui.mainCameraCom_.aspect / var_4_13.sprite.bounds.size.x or var_4_14 / var_4_13.sprite.bounds.size.y, var_4_14 / var_4_13.sprite.bounds.size.y < var_4_14 * manager.ui.mainCameraCom_.aspect / var_4_13.sprite.bounds.size.x and var_4_14 * manager.ui.mainCameraCom_.aspect / var_4_13.sprite.bounds.size.x or var_4_14 / var_4_13.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B01c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_15 = arg_1_1.actors_["1013ui_story"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos1013ui_story = var_4_15.localPosition
			end

			local var_4_16 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1013ui_story, Vector3.New(-0.7, -0.66, -6.15), (arg_1_1.time_ - 1.79999995231628) / var_4_16)
				var_4_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_15.position).x, (manager.ui.mainCamera.transform.position - var_4_15.position).y, (manager.ui.mainCamera.transform.position - var_4_15.position).z)
				var_4_15.localEulerAngles.z = 0
				var_4_15.localEulerAngles.x = 0
				var_4_15.localEulerAngles = var_4_15.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_16 and arg_1_1.time_ < 1.79999995231628 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-0.7, -0.66, -6.15)
				var_4_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_15.position).x, (manager.ui.mainCamera.transform.position - var_4_15.position).y, (manager.ui.mainCamera.transform.position - var_4_15.position).z)
				var_4_15.localEulerAngles.z = 0
				var_4_15.localEulerAngles.x = 0
				var_4_15.localEulerAngles = var_4_15.localEulerAngles
			end

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_17 + 2 and arg_1_1.time_ < var_4_17 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:GetWordFromCfg(105071001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 4 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 4)

				if (4 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 4)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071001", "story_v_out_105071.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_105071", "105071001", "story_v_out_105071.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_105071", "105071001", "story_v_out_105071.awb")

						arg_1_1:RecordAudio("105071001", var_4_26)
						arg_1_1:RecordAudio("105071001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105071", "105071001", "story_v_out_105071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105071", "105071001", "story_v_out_105071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play105071002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 105071002
		arg_7_1.duration_ = 4.53

		local var_7_0 = {
			ja = 4.533,
			ko = 2.633,
			zh = 2.6,
			en = 1.999999999999
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play105071003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_10_2 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_7_1.bgmTxt_.text ~= var_10_2 and arg_7_1.bgmTxt_.text ~= "" then
						if arg_7_1.bgmTxt2_.text ~= "" then
							arg_7_1.bgmTxt_.text = arg_7_1.bgmTxt2_.text
						end

						arg_7_1.bgmTxt2_.text = var_10_2

						arg_7_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_7_1.bgmTxt_.text = var_10_2
						arg_7_1.bgmTxt2_.text = var_10_2
					end

					if arg_7_1.bgmTimer then
						arg_7_1.bgmTimer:Stop()

						arg_7_1.bgmTimer = nil
					end

					if arg_7_1.settingData.show_music_name == 1 then
						arg_7_1.musicController:SetSelectedState("show")
						arg_7_1.musicAnimator_:Play("open", 0, 0)

						if arg_7_1.settingData.music_time ~= 0 then
							arg_7_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_7_1.settingData.music_time), function()
								if arg_7_1 == nil or isNil(arg_7_1.bgmTxt_) then
									return
								end

								arg_7_1.musicController:SetSelectedState("hide")
								arg_7_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_10_3 = "10002ui_story"

			if arg_7_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_10_4 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_7_1.stage_.transform)

				var_10_4.name = var_10_3
				var_10_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_3] = var_10_4

				local var_10_5 = var_10_4:GetComponentInChildren(typeof(CharacterEffect))

				var_10_5.enabled = true

				local var_10_6 = GameObjectTools.GetOrAddComponent(var_10_4, typeof(DynamicBoneHelper))

				if var_10_6 then
					var_10_6:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_5.transform, false)

				arg_7_1.var_[var_10_3 .. "Animator"] = var_10_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_3 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_3 .. "LipSync"] = var_10_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_7 = arg_7_1.actors_["10002ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_7) and arg_7_1.var_.characterEffect10002ui_story == nil then
				arg_7_1.var_.characterEffect10002ui_story = var_10_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_8 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_8 and not isNil(var_10_7) then
				if arg_7_1.var_.characterEffect10002ui_story and not isNil(var_10_7) then
					arg_7_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_8 and arg_7_1.time_ < 0 + var_10_8 + arg_10_0 and not isNil(var_10_7) and arg_7_1.var_.characterEffect10002ui_story then
				arg_7_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_10_10 = arg_7_1.actors_["1013ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1013ui_story == nil then
				arg_7_1.var_.characterEffect1013ui_story = var_10_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_11 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_11 and not isNil(var_10_10) then
				if arg_7_1.var_.characterEffect1013ui_story and not isNil(var_10_10) then
					arg_7_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_11)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_11 and arg_7_1.time_ < 0 + var_10_11 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1013ui_story then
				arg_7_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_10_12 = arg_7_1.actors_["10002ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos10002ui_story = var_10_12.localPosition
			end

			local var_10_13 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_13 then
				var_10_12.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_7_1.time_ - 0) / var_10_13)
				var_10_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_12.position).x, (manager.ui.mainCamera.transform.position - var_10_12.position).y, (manager.ui.mainCamera.transform.position - var_10_12.position).z)
				var_10_12.localEulerAngles.z = 0
				var_10_12.localEulerAngles.x = 0
				var_10_12.localEulerAngles = var_10_12.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_13 and arg_7_1.time_ < 0 + var_10_13 + arg_10_0 then
				var_10_12.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_10_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_12.position).x, (manager.ui.mainCamera.transform.position - var_10_12.position).y, (manager.ui.mainCamera.transform.position - var_10_12.position).z)
				var_10_12.localEulerAngles.z = 0
				var_10_12.localEulerAngles.x = 0
				var_10_12.localEulerAngles = var_10_12.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_10_14 = 0
			local var_10_15 = 0.25

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_16 = arg_7_1:GetWordFromCfg(105071002)
				local var_10_17 = arg_7_1:FormatText(var_10_16.content)

				arg_7_1.text_.text = var_10_17

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_19 = 8 <= 0 and var_10_15 or var_10_15 * (utf8.len(var_10_17) / 8)

				if (8 <= 0 and var_10_15 or var_10_15 * (utf8.len(var_10_17) / 8)) > 0 and var_10_15 < var_10_19 then
					arg_7_1.talkMaxDuration = var_10_19

					if var_10_19 + var_10_14 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_19 + var_10_14
					end
				end

				arg_7_1.text_.text = var_10_17
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071002", "story_v_out_105071.awb") ~= 0 then
					local var_10_20 = manager.audio:GetVoiceLength("story_v_out_105071", "105071002", "story_v_out_105071.awb") / 1000

					if var_10_20 + var_10_14 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_20 + var_10_14
					end

					if var_10_16.prefab_name ~= "" and arg_7_1.actors_[var_10_16.prefab_name] ~= nil then
						local var_10_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_16.prefab_name].transform, "story_v_out_105071", "105071002", "story_v_out_105071.awb")

						arg_7_1:RecordAudio("105071002", var_10_21)
						arg_7_1:RecordAudio("105071002", var_10_21)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_105071", "105071002", "story_v_out_105071.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_105071", "105071002", "story_v_out_105071.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_22 = math.max(var_10_15, arg_7_1.talkMaxDuration)

			if var_10_14 <= arg_7_1.time_ and arg_7_1.time_ < var_10_14 + var_10_22 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_14) / var_10_22

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_14 + var_10_22 and arg_7_1.time_ < var_10_14 + var_10_22 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play105071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105071003
		arg_12_1.duration_ = 5.03

		local var_12_0 = {
			ja = 5.033,
			ko = 2.3,
			zh = 4.166,
			en = 4.233
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
				arg_12_0:Play105071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1013ui_story"]) and arg_12_1.var_.characterEffect1013ui_story == nil then
				arg_12_1.var_.characterEffect1013ui_story = arg_12_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1013ui_story"]) then
				if arg_12_1.var_.characterEffect1013ui_story and not isNil(arg_12_1.actors_["1013ui_story"]) then
					arg_12_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1013ui_story"]) and arg_12_1.var_.characterEffect1013ui_story then
				arg_12_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["10002ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect10002ui_story == nil then
				arg_12_1.var_.characterEffect10002ui_story = var_15_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_3 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.characterEffect10002ui_story and not isNil(var_15_2) then
					arg_12_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_3)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect10002ui_story then
				arg_12_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4104")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_4 = 0
			local var_15_5 = 0.25

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_6 = arg_12_1:GetWordFromCfg(105071003)
				local var_15_7 = arg_12_1:FormatText(var_15_6.content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 10 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 10)

				if (10 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 10)) > 0 and var_15_5 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071003", "story_v_out_105071.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071003", "story_v_out_105071.awb") / 1000

					if var_15_10 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_4
					end

					if var_15_6.prefab_name ~= "" and arg_12_1.actors_[var_15_6.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_6.prefab_name].transform, "story_v_out_105071", "105071003", "story_v_out_105071.awb")

						arg_12_1:RecordAudio("105071003", var_15_11)
						arg_12_1:RecordAudio("105071003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_105071", "105071003", "story_v_out_105071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_105071", "105071003", "story_v_out_105071.awb")
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
	Play105071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105071004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play105071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10002ui_story = arg_16_1.actors_["10002ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["10002ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["10002ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10002ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10002ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10002ui_story"].transform.position).z)
				arg_16_1.actors_["10002ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10002ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10002ui_story"].transform.localEulerAngles = arg_16_1.actors_["10002ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["10002ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["10002ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10002ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10002ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10002ui_story"].transform.position).z)
				arg_16_1.actors_["10002ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10002ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10002ui_story"].transform.localEulerAngles = arg_16_1.actors_["10002ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1013ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1013ui_story = var_19_1.localPosition
			end

			local var_19_2 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 then
				var_19_1.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_2)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 then
				var_19_1.localPosition = Vector3.New(0, 100, 0)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			local var_19_3 = 0
			local var_19_4 = 0.825

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_5 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(105071004).content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 33 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 33)

				if (33 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 33)) > 0 and var_19_4 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_8 and arg_16_1.time_ < var_19_3 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play105071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105071005
		arg_20_1.duration_ = 2

		local var_20_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
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
				arg_20_0:Play105071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1013ui_story"]) and arg_20_1.var_.characterEffect1013ui_story == nil then
				arg_20_1.var_.characterEffect1013ui_story = arg_20_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1013ui_story"]) then
				if arg_20_1.var_.characterEffect1013ui_story and not isNil(arg_20_1.actors_["1013ui_story"]) then
					arg_20_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1013ui_story"]) and arg_20_1.var_.characterEffect1013ui_story then
				arg_20_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1013ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1013ui_story = var_23_2.localPosition
			end

			local var_23_3 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 then
				var_23_2.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_20_1.time_ - 0) / var_23_3)
				var_23_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_2.position).x, (manager.ui.mainCamera.transform.position - var_23_2.position).y, (manager.ui.mainCamera.transform.position - var_23_2.position).z)
				var_23_2.localEulerAngles.z = 0
				var_23_2.localEulerAngles.x = 0
				var_23_2.localEulerAngles = var_23_2.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 then
				var_23_2.localPosition = Vector3.New(0, -0.66, -6.15)
				var_23_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_2.position).x, (manager.ui.mainCamera.transform.position - var_23_2.position).y, (manager.ui.mainCamera.transform.position - var_23_2.position).z)
				var_23_2.localEulerAngles.z = 0
				var_23_2.localEulerAngles.x = 0
				var_23_2.localEulerAngles = var_23_2.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action5_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_4 = 0
			local var_23_5 = 0.1

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(105071005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 4 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 4)

				if (4 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 4)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071005", "story_v_out_105071.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071005", "story_v_out_105071.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_105071", "105071005", "story_v_out_105071.awb")

						arg_20_1:RecordAudio("105071005", var_23_11)
						arg_20_1:RecordAudio("105071005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105071", "105071005", "story_v_out_105071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105071", "105071005", "story_v_out_105071.awb")
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

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play105071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105071006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play105071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_27_0 = 0.600000023841858

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				local var_27_1, var_27_2 = math.modf((arg_24_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_27_2 * 0.13, var_27_2 * 0.13, var_27_2 * 0.13) + arg_24_1.var_.shakeOldPosMainCamera
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				manager.ui.mainCamera.transform.localPosition = arg_24_1.var_.shakeOldPosMainCamera
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action459")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_27_3 = 0
			local var_27_4 = 0.1

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_5 = arg_24_1:GetWordFromCfg(105071006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 4 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 4)

				if (4 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 4)) > 0 and var_27_4 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_3
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071006", "story_v_out_105071.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_105071", "105071006", "story_v_out_105071.awb") / 1000

					if var_27_9 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_3
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_105071", "105071006", "story_v_out_105071.awb")

						arg_24_1:RecordAudio("105071006", var_27_10)
						arg_24_1:RecordAudio("105071006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_105071", "105071006", "story_v_out_105071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_105071", "105071006", "story_v_out_105071.awb")
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

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play105071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105071007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_5", "se_story_5_fist", "")
			end

			local var_31_1 = arg_28_1.actors_["1013ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1013ui_story == nil then
				arg_28_1.var_.characterEffect1013ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1013ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_2)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1013ui_story then
				arg_28_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_31_3 = manager.ui.mainCamera.transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.shakeOldPosMainCamera = var_31_3.localPosition
			end

			local var_31_4 = 0.600000023841858

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				local var_31_5, var_31_6 = math.modf((arg_28_1.time_ - 0) / 0.066)

				var_31_3.localPosition = Vector3.New(var_31_6 * 0.13, var_31_6 * 0.13, var_31_6 * 0.13) + arg_28_1.var_.shakeOldPosMainCamera
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = arg_28_1.var_.shakeOldPosMainCamera
			end

			local var_31_7 = arg_28_1.actors_["1013ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1013ui_story = var_31_7.localPosition
			end

			local var_31_8 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_8 then
				var_31_7.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_8)
				var_31_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_7.position).x, (manager.ui.mainCamera.transform.position - var_31_7.position).y, (manager.ui.mainCamera.transform.position - var_31_7.position).z)
				var_31_7.localEulerAngles.z = 0
				var_31_7.localEulerAngles.x = 0
				var_31_7.localEulerAngles = var_31_7.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_8 and arg_28_1.time_ < 0 + var_31_8 + arg_31_0 then
				var_31_7.localPosition = Vector3.New(0, 100, 0)
				var_31_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_7.position).x, (manager.ui.mainCamera.transform.position - var_31_7.position).y, (manager.ui.mainCamera.transform.position - var_31_7.position).z)
				var_31_7.localEulerAngles.z = 0
				var_31_7.localEulerAngles.x = 0
				var_31_7.localEulerAngles = var_31_7.localEulerAngles
			end

			local var_31_9 = 0
			local var_31_10 = 1.55

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_11 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(105071007).content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 62 <= 0 and var_31_10 or var_31_10 * (utf8.len(var_31_11) / 62)

				if (62 <= 0 and var_31_10 or var_31_10 * (utf8.len(var_31_11) / 62)) > 0 and var_31_10 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_9
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_10, arg_28_1.talkMaxDuration)

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_9) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_9 + var_31_14 and arg_28_1.time_ < var_31_9 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play105071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105071008
		arg_32_1.duration_ = 3.8

		local var_32_0 = {
			ja = 1.999999999999,
			ko = 2.833,
			zh = 3.8,
			en = 3.566
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
				arg_32_0:Play105071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1013ui_story"]) and arg_32_1.var_.characterEffect1013ui_story == nil then
				arg_32_1.var_.characterEffect1013ui_story = arg_32_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1013ui_story"]) then
				if arg_32_1.var_.characterEffect1013ui_story and not isNil(arg_32_1.actors_["1013ui_story"]) then
					arg_32_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1013ui_story"]) and arg_32_1.var_.characterEffect1013ui_story then
				arg_32_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1013ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1013ui_story = var_35_2.localPosition
			end

			local var_35_3 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 then
				var_35_2.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_32_1.time_ - 0) / var_35_3)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 then
				var_35_2.localPosition = Vector3.New(0, -0.66, -6.15)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action13_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.25

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(105071008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 10 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 10)

				if (10 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 10)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071008", "story_v_out_105071.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071008", "story_v_out_105071.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_105071", "105071008", "story_v_out_105071.awb")

						arg_32_1:RecordAudio("105071008", var_35_11)
						arg_32_1:RecordAudio("105071008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_105071", "105071008", "story_v_out_105071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_105071", "105071008", "story_v_out_105071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play105071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 105071009
		arg_36_1.duration_ = 2

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play105071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10002ui_story"]) and arg_36_1.var_.characterEffect10002ui_story == nil then
				arg_36_1.var_.characterEffect10002ui_story = arg_36_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10002ui_story"]) then
				if arg_36_1.var_.characterEffect10002ui_story and not isNil(arg_36_1.actors_["10002ui_story"]) then
					arg_36_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10002ui_story"]) and arg_36_1.var_.characterEffect10002ui_story then
				arg_36_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1013ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1013ui_story == nil then
				arg_36_1.var_.characterEffect1013ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1013ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1013ui_story then
				arg_36_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_39_4 = arg_36_1.actors_["1013ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1013ui_story = var_39_4.localPosition
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(0, 100, 0)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			local var_39_6 = arg_36_1.actors_["10002ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10002ui_story = var_39_6.localPosition
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_36_1.time_ - 0) / var_39_7)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, -1.2, -5.8)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_8 = 0
			local var_39_9 = 0.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(105071009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 4 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 4)

				if (4 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 4)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071009", "story_v_out_105071.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_105071", "105071009", "story_v_out_105071.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_out_105071", "105071009", "story_v_out_105071.awb")

						arg_36_1:RecordAudio("105071009", var_39_15)
						arg_36_1:RecordAudio("105071009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_105071", "105071009", "story_v_out_105071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_105071", "105071009", "story_v_out_105071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play105071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 105071010
		arg_40_1.duration_ = 4.37

		local var_40_0 = {
			ja = 3.5,
			ko = 2.566,
			zh = 4.366,
			en = 2.1
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
				arg_40_0:Play105071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1013ui_story"]) and arg_40_1.var_.characterEffect1013ui_story == nil then
				arg_40_1.var_.characterEffect1013ui_story = arg_40_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1013ui_story"]) then
				if arg_40_1.var_.characterEffect1013ui_story and not isNil(arg_40_1.actors_["1013ui_story"]) then
					arg_40_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1013ui_story"]) and arg_40_1.var_.characterEffect1013ui_story then
				arg_40_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["10002ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10002ui_story then
				arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_43_4 = arg_40_1.actors_["10002ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_4.localPosition
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_5)
				var_43_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_4.position).x, (manager.ui.mainCamera.transform.position - var_43_4.position).y, (manager.ui.mainCamera.transform.position - var_43_4.position).z)
				var_43_4.localEulerAngles.z = 0
				var_43_4.localEulerAngles.x = 0
				var_43_4.localEulerAngles = var_43_4.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_4.localPosition = Vector3.New(0, 100, 0)
				var_43_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_4.position).x, (manager.ui.mainCamera.transform.position - var_43_4.position).y, (manager.ui.mainCamera.transform.position - var_43_4.position).z)
				var_43_4.localEulerAngles.z = 0
				var_43_4.localEulerAngles.x = 0
				var_43_4.localEulerAngles = var_43_4.localEulerAngles
			end

			local var_43_6 = arg_40_1.actors_["1013ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1013ui_story = var_43_6.localPosition
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_40_1.time_ - 0) / var_43_7)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, -0.66, -6.15)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action12_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_43_8 = 0
			local var_43_9 = 0.25

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:GetWordFromCfg(105071010)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 10 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 10)

				if (10 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 10)) > 0 and var_43_9 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071010", "story_v_out_105071.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_105071", "105071010", "story_v_out_105071.awb") / 1000

					if var_43_14 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_8
					end

					if var_43_10.prefab_name ~= "" and arg_40_1.actors_[var_43_10.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_10.prefab_name].transform, "story_v_out_105071", "105071010", "story_v_out_105071.awb")

						arg_40_1:RecordAudio("105071010", var_43_15)
						arg_40_1:RecordAudio("105071010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_105071", "105071010", "story_v_out_105071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_105071", "105071010", "story_v_out_105071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_9, arg_40_1.talkMaxDuration)

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_8) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_8 + var_43_16 and arg_40_1.time_ < var_43_8 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play105071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105071011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play105071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1013ui_story"]) and arg_44_1.var_.characterEffect1013ui_story == nil then
				arg_44_1.var_.characterEffect1013ui_story = arg_44_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1013ui_story"]) then
				if arg_44_1.var_.characterEffect1013ui_story and not isNil(arg_44_1.actors_["1013ui_story"]) then
					arg_44_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1013ui_story"]) and arg_44_1.var_.characterEffect1013ui_story then
				arg_44_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_47_1 = arg_44_1.actors_["1013ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1013ui_story = var_47_1.localPosition
			end

			local var_47_2 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 then
				var_47_1.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_2)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 then
				var_47_1.localPosition = Vector3.New(0, 100, 0)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			local var_47_3 = 0
			local var_47_4 = 1.05

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_3 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(105071011).content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 42 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_5) / 42)

				if (42 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_5) / 42)) > 0 and var_47_4 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_3
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_4, arg_44_1.talkMaxDuration)

			if var_47_3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_3 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_3) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_3 + var_47_8 and arg_44_1.time_ < var_47_3 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play105071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105071012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play105071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story_5", "se_story_5_wall", "")
			end

			local var_51_1 = 0
			local var_51_2 = 0.9

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(105071012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 36 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 36)

				if (36 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 36)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play105071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105071013
		arg_52_1.duration_ = 3.7

		local var_52_0 = {
			ja = 3.7,
			ko = 2.2,
			zh = 2.666,
			en = 3.166
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
				arg_52_0:Play105071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10002ui_story"]) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = arg_52_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10002ui_story"]) then
				if arg_52_1.var_.characterEffect10002ui_story and not isNil(arg_52_1.actors_["10002ui_story"]) then
					arg_52_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10002ui_story"]) and arg_52_1.var_.characterEffect10002ui_story then
				arg_52_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["10002ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10002ui_story = var_55_2.localPosition
			end

			local var_55_3 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 then
				var_55_2.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10002ui_story, Vector3.New(-0.7, -1.2, -5.8), (arg_52_1.time_ - 0) / var_55_3)
				var_55_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_2.position).x, (manager.ui.mainCamera.transform.position - var_55_2.position).y, (manager.ui.mainCamera.transform.position - var_55_2.position).z)
				var_55_2.localEulerAngles.z = 0
				var_55_2.localEulerAngles.x = 0
				var_55_2.localEulerAngles = var_55_2.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 then
				var_55_2.localPosition = Vector3.New(-0.7, -1.2, -5.8)
				var_55_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_2.position).x, (manager.ui.mainCamera.transform.position - var_55_2.position).y, (manager.ui.mainCamera.transform.position - var_55_2.position).z)
				var_55_2.localEulerAngles.z = 0
				var_55_2.localEulerAngles.x = 0
				var_55_2.localEulerAngles = var_55_2.localEulerAngles
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_55_4 = 0
			local var_55_5 = 0.225

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(105071013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 9 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 9)

				if (9 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 9)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071013", "story_v_out_105071.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071013", "story_v_out_105071.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_105071", "105071013", "story_v_out_105071.awb")

						arg_52_1:RecordAudio("105071013", var_55_11)
						arg_52_1:RecordAudio("105071013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_105071", "105071013", "story_v_out_105071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_105071", "105071013", "story_v_out_105071.awb")
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

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play105071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105071014
		arg_56_1.duration_ = 8.7

		local var_56_0 = {
			ja = 8,
			ko = 7.866,
			zh = 8.7,
			en = 8.166
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
				arg_56_0:Play105071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1013ui_story"]) and arg_56_1.var_.characterEffect1013ui_story == nil then
				arg_56_1.var_.characterEffect1013ui_story = arg_56_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1013ui_story"]) then
				if arg_56_1.var_.characterEffect1013ui_story and not isNil(arg_56_1.actors_["1013ui_story"]) then
					arg_56_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1013ui_story"]) and arg_56_1.var_.characterEffect1013ui_story then
				arg_56_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["10002ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect10002ui_story == nil then
				arg_56_1.var_.characterEffect10002ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect10002ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect10002ui_story then
				arg_56_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_59_4 = arg_56_1.actors_["1013ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1013ui_story = var_59_4.localPosition
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_4.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1013ui_story, Vector3.New(0.7, -0.66, -6.15), (arg_56_1.time_ - 0) / var_59_5)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_4.localPosition = Vector3.New(0.7, -0.66, -6.15)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action7_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_59_6 = 0
			local var_59_7 = 0.7

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(105071014)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 28 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 28)

				if (28 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 28)) > 0 and var_59_7 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071014", "story_v_out_105071.awb") ~= 0 then
					local var_59_12 = manager.audio:GetVoiceLength("story_v_out_105071", "105071014", "story_v_out_105071.awb") / 1000

					if var_59_12 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_6
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_105071", "105071014", "story_v_out_105071.awb")

						arg_56_1:RecordAudio("105071014", var_59_13)
						arg_56_1:RecordAudio("105071014", var_59_13)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_105071", "105071014", "story_v_out_105071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_105071", "105071014", "story_v_out_105071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play105071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 105071015
		arg_60_1.duration_ = 7

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play105071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 2 < arg_60_1.time_ and arg_60_1.time_ <= 2 + arg_63_0 and not isNil(arg_60_1.actors_["1013ui_story"]) and arg_60_1.var_.characterEffect1013ui_story == nil then
				arg_60_1.var_.characterEffect1013ui_story = arg_60_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 2 <= arg_60_1.time_ and arg_60_1.time_ < 2 + var_63_0 and not isNil(arg_60_1.actors_["1013ui_story"]) then
				if arg_60_1.var_.characterEffect1013ui_story and not isNil(arg_60_1.actors_["1013ui_story"]) then
					arg_60_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 2) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 2 + var_63_0 and arg_60_1.time_ < 2 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1013ui_story"]) and arg_60_1.var_.characterEffect1013ui_story then
				arg_60_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				local var_63_1 = arg_60_1.bgs_.B01c:GetComponent("SpriteRenderer")

				if var_63_1 then
					arg_60_1.var_.alphaOldValueB01c = var_63_1.color.a
					arg_60_1.var_.alphaMatValueB01c = var_63_1
				end

				arg_60_1.var_.alphaOldValueB01c = 1
			end

			local var_63_2 = 1.5

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 then
				if arg_60_1.var_.alphaMatValueB01c then
					arg_60_1.var_.alphaMatValueB01c.color.a = Mathf.Lerp(arg_60_1.var_.alphaOldValueB01c, 0, (arg_60_1.time_ - 0) / var_63_2)
					arg_60_1.var_.alphaMatValueB01c.color = arg_60_1.var_.alphaMatValueB01c.color
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and arg_60_1.var_.alphaMatValueB01c then
				arg_60_1.var_.alphaMatValueB01c.color.a = 0
				arg_60_1.var_.alphaMatValueB01c.color = arg_60_1.var_.alphaMatValueB01c.color
			end

			local var_63_3 = arg_60_1.bgs_.B01c.transform

			if 1.5 < arg_60_1.time_ and arg_60_1.time_ <= 1.5 + arg_63_0 then
				arg_60_1.var_.moveOldPosB01c = var_63_3.localPosition
			end

			local var_63_4 = 0.001

			if 1.5 <= arg_60_1.time_ and arg_60_1.time_ < 1.5 + var_63_4 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPosB01c, Vector3.New(0, -100, 10), (arg_60_1.time_ - 1.5) / var_63_4)
			end

			if arg_60_1.time_ >= 1.5 + var_63_4 and arg_60_1.time_ < 1.5 + var_63_4 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0, -100, 10)
			end

			local var_63_5 = "B03f"

			if arg_60_1.bgs_.B03f == nil then
				local var_63_6 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_5)
				var_63_6.name = var_63_5
				var_63_6.transform.parent = arg_60_1.stage_.transform
				var_63_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_5] = var_63_6
			end

			if 1.5 < arg_60_1.time_ and arg_60_1.time_ <= 1.5 + arg_63_0 then
				local var_63_7 = arg_60_1.bgs_.B03f:GetComponent("SpriteRenderer")

				if var_63_7 then
					arg_60_1.var_.alphaOldValueB03f = var_63_7.color.a
					arg_60_1.var_.alphaMatValueB03f = var_63_7
				end

				arg_60_1.var_.alphaOldValueB03f = 0
			end

			local var_63_8 = 1.5

			if 1.5 <= arg_60_1.time_ and arg_60_1.time_ < 1.5 + var_63_8 then
				if arg_60_1.var_.alphaMatValueB03f then
					arg_60_1.var_.alphaMatValueB03f.color.a = Mathf.Lerp(arg_60_1.var_.alphaOldValueB03f, 1, (arg_60_1.time_ - 1.5) / var_63_8)
					arg_60_1.var_.alphaMatValueB03f.color = arg_60_1.var_.alphaMatValueB03f.color
				end
			end

			if arg_60_1.time_ >= 1.5 + var_63_8 and arg_60_1.time_ < 1.5 + var_63_8 + arg_63_0 and arg_60_1.var_.alphaMatValueB03f then
				arg_60_1.var_.alphaMatValueB03f.color.a = 1
				arg_60_1.var_.alphaMatValueB03f.color = arg_60_1.var_.alphaMatValueB03f.color
			end

			if 1.5 < arg_60_1.time_ and arg_60_1.time_ <= 1.5 + arg_63_0 then
				local var_63_9 = arg_60_1.bgs_.B03f

				arg_60_1.bgs_.B03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_10 = var_63_9:GetComponent("SpriteRenderer")

				if var_63_10 and var_63_10.sprite then
					local var_63_11 = 2 * (var_63_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_9.transform.localScale = Vector3.New(var_63_11 / var_63_10.sprite.bounds.size.y < var_63_11 * manager.ui.mainCameraCom_.aspect / var_63_10.sprite.bounds.size.x and var_63_11 * manager.ui.mainCameraCom_.aspect / var_63_10.sprite.bounds.size.x or var_63_11 / var_63_10.sprite.bounds.size.y, var_63_11 / var_63_10.sprite.bounds.size.y < var_63_11 * manager.ui.mainCameraCom_.aspect / var_63_10.sprite.bounds.size.x and var_63_11 * manager.ui.mainCameraCom_.aspect / var_63_10.sprite.bounds.size.x or var_63_11 / var_63_10.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "B03f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_12 = arg_60_1.actors_["10002ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10002ui_story = var_63_12.localPosition
			end

			local var_63_13 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_13 then
				var_63_12.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_13)
				var_63_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_12.position).x, (manager.ui.mainCamera.transform.position - var_63_12.position).y, (manager.ui.mainCamera.transform.position - var_63_12.position).z)
				var_63_12.localEulerAngles.z = 0
				var_63_12.localEulerAngles.x = 0
				var_63_12.localEulerAngles = var_63_12.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_13 and arg_60_1.time_ < 0 + var_63_13 + arg_63_0 then
				var_63_12.localPosition = Vector3.New(0, 100, 0)
				var_63_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_12.position).x, (manager.ui.mainCamera.transform.position - var_63_12.position).y, (manager.ui.mainCamera.transform.position - var_63_12.position).z)
				var_63_12.localEulerAngles.z = 0
				var_63_12.localEulerAngles.x = 0
				var_63_12.localEulerAngles = var_63_12.localEulerAngles
			end

			local var_63_14 = arg_60_1.actors_["1013ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1013ui_story = var_63_14.localPosition
			end

			local var_63_15 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_15 then
				var_63_14.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_15)
				var_63_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_14.position).x, (manager.ui.mainCamera.transform.position - var_63_14.position).y, (manager.ui.mainCamera.transform.position - var_63_14.position).z)
				var_63_14.localEulerAngles.z = 0
				var_63_14.localEulerAngles.x = 0
				var_63_14.localEulerAngles = var_63_14.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_15 and arg_60_1.time_ < 0 + var_63_15 + arg_63_0 then
				var_63_14.localPosition = Vector3.New(0, 100, 0)
				var_63_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_14.position).x, (manager.ui.mainCamera.transform.position - var_63_14.position).y, (manager.ui.mainCamera.transform.position - var_63_14.position).z)
				var_63_14.localEulerAngles.z = 0
				var_63_14.localEulerAngles.x = 0
				var_63_14.localEulerAngles = var_63_14.localEulerAngles
			end

			local var_63_16 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_16 + 2 and arg_60_1.time_ < var_63_16 + 2 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_17 = 2
			local var_63_18 = 1.4

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_19 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_19:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_20 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(105071015).content)

				arg_60_1.text_.text = var_63_20

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_22 = 55 <= 0 and var_63_18 or var_63_18 * (utf8.len(var_63_20) / 55)

				if (55 <= 0 and var_63_18 or var_63_18 * (utf8.len(var_63_20) / 55)) > 0 and var_63_18 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22
					var_63_17 = var_63_17 + 0.3

					if var_63_22 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_17
					end
				end

				arg_60_1.text_.text = var_63_20
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_23 = var_63_17 + 0.3
			local var_63_24 = math.max(var_63_18, arg_60_1.talkMaxDuration)

			if var_63_17 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_23) / var_63_24

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B01c",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play105071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 105071016
		arg_66_1.duration_ = 5.2

		local var_66_0 = {
			ja = 5.2,
			ko = 4.4,
			zh = 4.566,
			en = 4.833
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
				arg_66_0:Play105071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10002ui_story"]) and arg_66_1.var_.characterEffect10002ui_story == nil then
				arg_66_1.var_.characterEffect10002ui_story = arg_66_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10002ui_story"]) then
				if arg_66_1.var_.characterEffect10002ui_story and not isNil(arg_66_1.actors_["10002ui_story"]) then
					arg_66_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10002ui_story"]) and arg_66_1.var_.characterEffect10002ui_story then
				arg_66_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["10002ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos10002ui_story = var_69_2.localPosition
			end

			local var_69_3 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 then
				var_69_2.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10002ui_story, Vector3.New(-0.7, -1.2, -5.8), (arg_66_1.time_ - 0) / var_69_3)
				var_69_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_2.position).x, (manager.ui.mainCamera.transform.position - var_69_2.position).y, (manager.ui.mainCamera.transform.position - var_69_2.position).z)
				var_69_2.localEulerAngles.z = 0
				var_69_2.localEulerAngles.x = 0
				var_69_2.localEulerAngles = var_69_2.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 then
				var_69_2.localPosition = Vector3.New(-0.7, -1.2, -5.8)
				var_69_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_2.position).x, (manager.ui.mainCamera.transform.position - var_69_2.position).y, (manager.ui.mainCamera.transform.position - var_69_2.position).z)
				var_69_2.localEulerAngles.z = 0
				var_69_2.localEulerAngles.x = 0
				var_69_2.localEulerAngles = var_69_2.localEulerAngles
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_69_4 = 0
			local var_69_5 = 0.5

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(105071016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 20 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 20)

				if (20 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 20)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071016", "story_v_out_105071.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071016", "story_v_out_105071.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_105071", "105071016", "story_v_out_105071.awb")

						arg_66_1:RecordAudio("105071016", var_69_11)
						arg_66_1:RecordAudio("105071016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_105071", "105071016", "story_v_out_105071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_105071", "105071016", "story_v_out_105071.awb")
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

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play105071017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 105071017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play105071018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1013ui_story"]) and arg_70_1.var_.characterEffect1013ui_story == nil then
				arg_70_1.var_.characterEffect1013ui_story = arg_70_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1013ui_story"]) then
				if arg_70_1.var_.characterEffect1013ui_story and not isNil(arg_70_1.actors_["1013ui_story"]) then
					arg_70_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1013ui_story"]) and arg_70_1.var_.characterEffect1013ui_story then
				arg_70_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1013ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1013ui_story = var_73_2.localPosition
			end

			local var_73_3 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 then
				var_73_2.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1013ui_story, Vector3.New(0.7, -0.66, -6.15), (arg_70_1.time_ - 0) / var_73_3)
				var_73_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_2.position).x, (manager.ui.mainCamera.transform.position - var_73_2.position).y, (manager.ui.mainCamera.transform.position - var_73_2.position).z)
				var_73_2.localEulerAngles.z = 0
				var_73_2.localEulerAngles.x = 0
				var_73_2.localEulerAngles = var_73_2.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 then
				var_73_2.localPosition = Vector3.New(0.7, -0.66, -6.15)
				var_73_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_2.position).x, (manager.ui.mainCamera.transform.position - var_73_2.position).y, (manager.ui.mainCamera.transform.position - var_73_2.position).z)
				var_73_2.localEulerAngles.z = 0
				var_73_2.localEulerAngles.x = 0
				var_73_2.localEulerAngles = var_73_2.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action3_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_73_4 = 0
			local var_73_5 = 0.075

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(105071017)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 3 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 3)

				if (3 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 3)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071017", "story_v_out_105071.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071017", "story_v_out_105071.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_out_105071", "105071017", "story_v_out_105071.awb")

						arg_70_1:RecordAudio("105071017", var_73_11)
						arg_70_1:RecordAudio("105071017", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_105071", "105071017", "story_v_out_105071.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_105071", "105071017", "story_v_out_105071.awb")
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

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play105071018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 105071018
		arg_74_1.duration_ = 2

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play105071019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10002ui_story"]) and arg_74_1.var_.characterEffect10002ui_story == nil then
				arg_74_1.var_.characterEffect10002ui_story = arg_74_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10002ui_story"]) then
				if arg_74_1.var_.characterEffect10002ui_story and not isNil(arg_74_1.actors_["10002ui_story"]) then
					arg_74_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10002ui_story"]) and arg_74_1.var_.characterEffect10002ui_story then
				arg_74_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_77_2 = arg_74_1.actors_["1013ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1013ui_story == nil then
				arg_74_1.var_.characterEffect1013ui_story = var_77_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.characterEffect1013ui_story and not isNil(var_77_2) then
					arg_74_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_3)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1013ui_story then
				arg_74_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_2")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_77_4 = 0
			local var_77_5 = 0.1

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(105071018)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 4 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 4)

				if (4 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 4)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071018", "story_v_out_105071.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071018", "story_v_out_105071.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_105071", "105071018", "story_v_out_105071.awb")

						arg_74_1:RecordAudio("105071018", var_77_11)
						arg_74_1:RecordAudio("105071018", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_105071", "105071018", "story_v_out_105071.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_105071", "105071018", "story_v_out_105071.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play105071019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 105071019
		arg_78_1.duration_ = 7.8

		local var_78_0 = {
			ja = 6,
			ko = 5.2,
			zh = 7.8,
			en = 4.933
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
				arg_78_0:Play105071020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1013ui_story"]) and arg_78_1.var_.characterEffect1013ui_story == nil then
				arg_78_1.var_.characterEffect1013ui_story = arg_78_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1013ui_story"]) then
				if arg_78_1.var_.characterEffect1013ui_story and not isNil(arg_78_1.actors_["1013ui_story"]) then
					arg_78_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1013ui_story"]) and arg_78_1.var_.characterEffect1013ui_story then
				arg_78_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["10002ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect10002ui_story == nil then
				arg_78_1.var_.characterEffect10002ui_story = var_81_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.characterEffect10002ui_story and not isNil(var_81_2) then
					arg_78_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect10002ui_story then
				arg_78_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_81_4 = arg_78_1.actors_["1013ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1013ui_story = var_81_4.localPosition
			end

			local var_81_5 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_5 then
				var_81_4.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1013ui_story, Vector3.New(0.7, -0.66, -6.15), (arg_78_1.time_ - 0) / var_81_5)
				var_81_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_4.position).x, (manager.ui.mainCamera.transform.position - var_81_4.position).y, (manager.ui.mainCamera.transform.position - var_81_4.position).z)
				var_81_4.localEulerAngles.z = 0
				var_81_4.localEulerAngles.x = 0
				var_81_4.localEulerAngles = var_81_4.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_5 and arg_78_1.time_ < 0 + var_81_5 + arg_81_0 then
				var_81_4.localPosition = Vector3.New(0.7, -0.66, -6.15)
				var_81_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_4.position).x, (manager.ui.mainCamera.transform.position - var_81_4.position).y, (manager.ui.mainCamera.transform.position - var_81_4.position).z)
				var_81_4.localEulerAngles.z = 0
				var_81_4.localEulerAngles.x = 0
				var_81_4.localEulerAngles = var_81_4.localEulerAngles
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4311")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_81_6 = 0
			local var_81_7 = 0.6

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(105071019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 23 <= 0 and var_81_7 or var_81_7 * (utf8.len(var_81_9) / 23)

				if (23 <= 0 and var_81_7 or var_81_7 * (utf8.len(var_81_9) / 23)) > 0 and var_81_7 < var_81_11 then
					arg_78_1.talkMaxDuration = var_81_11

					if var_81_11 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071019", "story_v_out_105071.awb") ~= 0 then
					local var_81_12 = manager.audio:GetVoiceLength("story_v_out_105071", "105071019", "story_v_out_105071.awb") / 1000

					if var_81_12 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_6
					end

					if var_81_8.prefab_name ~= "" and arg_78_1.actors_[var_81_8.prefab_name] ~= nil then
						local var_81_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_8.prefab_name].transform, "story_v_out_105071", "105071019", "story_v_out_105071.awb")

						arg_78_1:RecordAudio("105071019", var_81_13)
						arg_78_1:RecordAudio("105071019", var_81_13)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_105071", "105071019", "story_v_out_105071.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_105071", "105071019", "story_v_out_105071.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_14 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_14

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_14 and arg_78_1.time_ < var_81_6 + var_81_14 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play105071020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 105071020
		arg_82_1.duration_ = 2.2

		local var_82_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_82_0:Play105071021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10002ui_story"]) and arg_82_1.var_.characterEffect10002ui_story == nil then
				arg_82_1.var_.characterEffect10002ui_story = arg_82_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10002ui_story"]) then
				if arg_82_1.var_.characterEffect10002ui_story and not isNil(arg_82_1.actors_["10002ui_story"]) then
					arg_82_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10002ui_story"]) and arg_82_1.var_.characterEffect10002ui_story then
				arg_82_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_85_2 = arg_82_1.actors_["1013ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1013ui_story == nil then
				arg_82_1.var_.characterEffect1013ui_story = var_85_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_3 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.characterEffect1013ui_story and not isNil(var_85_2) then
					arg_82_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_3)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1013ui_story then
				arg_82_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_85_4 = 0
			local var_85_5 = 0.075

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(105071020)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 3 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 3)

				if (3 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 3)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071020", "story_v_out_105071.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071020", "story_v_out_105071.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_105071", "105071020", "story_v_out_105071.awb")

						arg_82_1:RecordAudio("105071020", var_85_11)
						arg_82_1:RecordAudio("105071020", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_105071", "105071020", "story_v_out_105071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_105071", "105071020", "story_v_out_105071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_12 and arg_82_1.time_ < var_85_4 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play105071021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 105071021
		arg_86_1.duration_ = 5.83

		local var_86_0 = {
			ja = 5.366,
			ko = 4.2,
			zh = 5.833,
			en = 3.6
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
				arg_86_0:Play105071022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1013ui_story"]) and arg_86_1.var_.characterEffect1013ui_story == nil then
				arg_86_1.var_.characterEffect1013ui_story = arg_86_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1013ui_story"]) then
				if arg_86_1.var_.characterEffect1013ui_story and not isNil(arg_86_1.actors_["1013ui_story"]) then
					arg_86_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1013ui_story"]) and arg_86_1.var_.characterEffect1013ui_story then
				arg_86_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["10002ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect10002ui_story == nil then
				arg_86_1.var_.characterEffect10002ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_3 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.characterEffect10002ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_3)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect10002ui_story then
				arg_86_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_89_4 = arg_86_1.actors_["1013ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1013ui_story = var_89_4.localPosition
			end

			local var_89_5 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 then
				var_89_4.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1013ui_story, Vector3.New(0.7, -0.66, -6.15), (arg_86_1.time_ - 0) / var_89_5)
				var_89_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_4.position).x, (manager.ui.mainCamera.transform.position - var_89_4.position).y, (manager.ui.mainCamera.transform.position - var_89_4.position).z)
				var_89_4.localEulerAngles.z = 0
				var_89_4.localEulerAngles.x = 0
				var_89_4.localEulerAngles = var_89_4.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 then
				var_89_4.localPosition = Vector3.New(0.7, -0.66, -6.15)
				var_89_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_4.position).x, (manager.ui.mainCamera.transform.position - var_89_4.position).y, (manager.ui.mainCamera.transform.position - var_89_4.position).z)
				var_89_4.localEulerAngles.z = 0
				var_89_4.localEulerAngles.x = 0
				var_89_4.localEulerAngles = var_89_4.localEulerAngles
			end

			local var_89_6 = arg_86_1.actors_["1013ui_story"].transform

			if 0.033 < arg_86_1.time_ and arg_86_1.time_ <= 0.033 + arg_89_0 then
				arg_86_1.var_.moveOldPos1013ui_story = var_89_6.localPosition
			end

			local var_89_7 = 0.5

			if 0.033 <= arg_86_1.time_ and arg_86_1.time_ < 0.033 + var_89_7 then
				var_89_6.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_86_1.time_ - 0.033) / var_89_7)
				var_89_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_6.position).x, (manager.ui.mainCamera.transform.position - var_89_6.position).y, (manager.ui.mainCamera.transform.position - var_89_6.position).z)
				var_89_6.localEulerAngles.z = 0
				var_89_6.localEulerAngles.x = 0
				var_89_6.localEulerAngles = var_89_6.localEulerAngles
			end

			if arg_86_1.time_ >= 0.033 + var_89_7 and arg_86_1.time_ < 0.033 + var_89_7 + arg_89_0 then
				var_89_6.localPosition = Vector3.New(0, -0.66, -6.15)
				var_89_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_6.position).x, (manager.ui.mainCamera.transform.position - var_89_6.position).y, (manager.ui.mainCamera.transform.position - var_89_6.position).z)
				var_89_6.localEulerAngles.z = 0
				var_89_6.localEulerAngles.x = 0
				var_89_6.localEulerAngles = var_89_6.localEulerAngles
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action11_2")
			end

			local var_89_8 = arg_86_1.actors_["10002ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10002ui_story = var_89_8.localPosition
			end

			local var_89_9 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_9 then
				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_9)
				var_89_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_8.position).x, (manager.ui.mainCamera.transform.position - var_89_8.position).y, (manager.ui.mainCamera.transform.position - var_89_8.position).z)
				var_89_8.localEulerAngles.z = 0
				var_89_8.localEulerAngles.x = 0
				var_89_8.localEulerAngles = var_89_8.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_9 and arg_86_1.time_ < 0 + var_89_9 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(0, 100, 0)
				var_89_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_8.position).x, (manager.ui.mainCamera.transform.position - var_89_8.position).y, (manager.ui.mainCamera.transform.position - var_89_8.position).z)
				var_89_8.localEulerAngles.z = 0
				var_89_8.localEulerAngles.x = 0
				var_89_8.localEulerAngles = var_89_8.localEulerAngles
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_89_10 = 0
			local var_89_11 = 0.45

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_12 = arg_86_1:GetWordFromCfg(105071021)
				local var_89_13 = arg_86_1:FormatText(var_89_12.content)

				arg_86_1.text_.text = var_89_13

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 18 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 18)

				if (18 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 18)) > 0 and var_89_11 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_13
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071021", "story_v_out_105071.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_105071", "105071021", "story_v_out_105071.awb") / 1000

					if var_89_16 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_10
					end

					if var_89_12.prefab_name ~= "" and arg_86_1.actors_[var_89_12.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_12.prefab_name].transform, "story_v_out_105071", "105071021", "story_v_out_105071.awb")

						arg_86_1:RecordAudio("105071021", var_89_17)
						arg_86_1:RecordAudio("105071021", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_105071", "105071021", "story_v_out_105071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_105071", "105071021", "story_v_out_105071.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_18 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_18 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_18

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_18 and arg_86_1.time_ < var_89_10 + var_89_18 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play105071022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 105071022
		arg_90_1.duration_ = 7.73

		local var_90_0 = {
			ja = 5.5,
			ko = 6.9,
			zh = 7.733,
			en = 5.3
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
				arg_90_0:Play105071023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action3_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_93_0 = 0
			local var_93_1 = 0.6

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(105071022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 24 <= 0 and var_93_1 or var_93_1 * (utf8.len(var_93_3) / 24)

				if (24 <= 0 and var_93_1 or var_93_1 * (utf8.len(var_93_3) / 24)) > 0 and var_93_1 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071022", "story_v_out_105071.awb") ~= 0 then
					local var_93_6 = manager.audio:GetVoiceLength("story_v_out_105071", "105071022", "story_v_out_105071.awb") / 1000

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end

					if var_93_2.prefab_name ~= "" and arg_90_1.actors_[var_93_2.prefab_name] ~= nil then
						local var_93_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_2.prefab_name].transform, "story_v_out_105071", "105071022", "story_v_out_105071.awb")

						arg_90_1:RecordAudio("105071022", var_93_7)
						arg_90_1:RecordAudio("105071022", var_93_7)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_105071", "105071022", "story_v_out_105071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_105071", "105071022", "story_v_out_105071.awb")
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
	Play105071023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105071023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play105071024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:AudioAction("play", "effect", "se_story_5", "se_story_5_stone", "")
			end

			local var_97_1 = arg_94_1.actors_["1013ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1013ui_story == nil then
				arg_94_1.var_.characterEffect1013ui_story = var_97_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 and not isNil(var_97_1) then
				if arg_94_1.var_.characterEffect1013ui_story and not isNil(var_97_1) then
					arg_94_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_2)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1013ui_story then
				arg_94_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_97_3 = arg_94_1.actors_["1013ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1013ui_story = var_97_3.localPosition
			end

			local var_97_4 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_3.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_4)
				var_97_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_3.position).x, (manager.ui.mainCamera.transform.position - var_97_3.position).y, (manager.ui.mainCamera.transform.position - var_97_3.position).z)
				var_97_3.localEulerAngles.z = 0
				var_97_3.localEulerAngles.x = 0
				var_97_3.localEulerAngles = var_97_3.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_3.localPosition = Vector3.New(0, 100, 0)
				var_97_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_3.position).x, (manager.ui.mainCamera.transform.position - var_97_3.position).y, (manager.ui.mainCamera.transform.position - var_97_3.position).z)
				var_97_3.localEulerAngles.z = 0
				var_97_3.localEulerAngles.x = 0
				var_97_3.localEulerAngles = var_97_3.localEulerAngles
			end

			local var_97_5 = 0
			local var_97_6 = 0.925

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(105071023).content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 37 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_7) / 37)

				if (37 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_7) / 37)) > 0 and var_97_6 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_10 and arg_94_1.time_ < var_97_5 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play105071024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105071024
		arg_98_1.duration_ = 6.9

		local var_98_0 = {
			ja = 6.9,
			ko = 2.7,
			zh = 3.7,
			en = 3.833
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
				arg_98_0:Play105071025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1013ui_story"]) and arg_98_1.var_.characterEffect1013ui_story == nil then
				arg_98_1.var_.characterEffect1013ui_story = arg_98_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1013ui_story"]) then
				if arg_98_1.var_.characterEffect1013ui_story and not isNil(arg_98_1.actors_["1013ui_story"]) then
					arg_98_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1013ui_story"]) and arg_98_1.var_.characterEffect1013ui_story then
				arg_98_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["1013ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1013ui_story = var_101_2.localPosition
			end

			local var_101_3 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 then
				var_101_2.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_98_1.time_ - 0) / var_101_3)
				var_101_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_2.position).x, (manager.ui.mainCamera.transform.position - var_101_2.position).y, (manager.ui.mainCamera.transform.position - var_101_2.position).z)
				var_101_2.localEulerAngles.z = 0
				var_101_2.localEulerAngles.x = 0
				var_101_2.localEulerAngles = var_101_2.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 then
				var_101_2.localPosition = Vector3.New(0, -0.66, -6.15)
				var_101_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_2.position).x, (manager.ui.mainCamera.transform.position - var_101_2.position).y, (manager.ui.mainCamera.transform.position - var_101_2.position).z)
				var_101_2.localEulerAngles.z = 0
				var_101_2.localEulerAngles.x = 0
				var_101_2.localEulerAngles = var_101_2.localEulerAngles
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action2_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_101_4 = 0
			local var_101_5 = 0.35

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(105071024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 14 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 14)

				if (14 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 14)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071024", "story_v_out_105071.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071024", "story_v_out_105071.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_105071", "105071024", "story_v_out_105071.awb")

						arg_98_1:RecordAudio("105071024", var_101_11)
						arg_98_1:RecordAudio("105071024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105071", "105071024", "story_v_out_105071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105071", "105071024", "story_v_out_105071.awb")
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

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play105071025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105071025
		arg_102_1.duration_ = 5.7

		local var_102_0 = {
			ja = 4.633,
			ko = 4.066,
			zh = 4.333,
			en = 5.7
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
				arg_102_0:Play105071026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10002ui_story"]) and arg_102_1.var_.characterEffect10002ui_story == nil then
				arg_102_1.var_.characterEffect10002ui_story = arg_102_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10002ui_story"]) then
				if arg_102_1.var_.characterEffect10002ui_story and not isNil(arg_102_1.actors_["10002ui_story"]) then
					arg_102_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10002ui_story"]) and arg_102_1.var_.characterEffect10002ui_story then
				arg_102_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["1013ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1013ui_story == nil then
				arg_102_1.var_.characterEffect1013ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect1013ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1013ui_story then
				arg_102_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_105_4 = arg_102_1.actors_["1013ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1013ui_story = var_105_4.localPosition
			end

			local var_105_5 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_5 then
				var_105_4.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_5)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_5 and arg_102_1.time_ < 0 + var_105_5 + arg_105_0 then
				var_105_4.localPosition = Vector3.New(0, 100, 0)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			local var_105_6 = arg_102_1.actors_["10002ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos10002ui_story = var_105_6.localPosition
			end

			local var_105_7 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				var_105_6.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_102_1.time_ - 0) / var_105_7)
				var_105_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_6.position).x, (manager.ui.mainCamera.transform.position - var_105_6.position).y, (manager.ui.mainCamera.transform.position - var_105_6.position).z)
				var_105_6.localEulerAngles.z = 0
				var_105_6.localEulerAngles.x = 0
				var_105_6.localEulerAngles = var_105_6.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				var_105_6.localPosition = Vector3.New(0, -1.2, -5.8)
				var_105_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_6.position).x, (manager.ui.mainCamera.transform.position - var_105_6.position).y, (manager.ui.mainCamera.transform.position - var_105_6.position).z)
				var_105_6.localEulerAngles.z = 0
				var_105_6.localEulerAngles.x = 0
				var_105_6.localEulerAngles = var_105_6.localEulerAngles
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_105_8 = 0
			local var_105_9 = 0.3

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_10 = arg_102_1:GetWordFromCfg(105071025)
				local var_105_11 = arg_102_1:FormatText(var_105_10.content)

				arg_102_1.text_.text = var_105_11

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 12 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 12)

				if (12 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 12)) > 0 and var_105_9 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_11
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071025", "story_v_out_105071.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_105071", "105071025", "story_v_out_105071.awb") / 1000

					if var_105_14 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_8
					end

					if var_105_10.prefab_name ~= "" and arg_102_1.actors_[var_105_10.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_10.prefab_name].transform, "story_v_out_105071", "105071025", "story_v_out_105071.awb")

						arg_102_1:RecordAudio("105071025", var_105_15)
						arg_102_1:RecordAudio("105071025", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105071", "105071025", "story_v_out_105071.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105071", "105071025", "story_v_out_105071.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_16 and arg_102_1.time_ < var_105_8 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play105071026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105071026
		arg_106_1.duration_ = 9.7

		local var_106_0 = {
			ja = 9.7,
			ko = 3.866,
			zh = 4.333,
			en = 5.2
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
				arg_106_0:Play105071027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_109_1 = "3005_tpose"

			if arg_106_1.actors_["3005_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3005_tpose"))) then
				local var_109_2 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_106_1.stage_.transform)

				var_109_2.name = var_109_1
				var_109_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_[var_109_1] = var_109_2

				local var_109_3 = var_109_2:GetComponentInChildren(typeof(CharacterEffect))

				var_109_3.enabled = true

				local var_109_4 = GameObjectTools.GetOrAddComponent(var_109_2, typeof(DynamicBoneHelper))

				if var_109_4 then
					var_109_4:EnableDynamicBone(false)
				end

				arg_106_1:ShowWeapon(var_109_3.transform, false)

				arg_106_1.var_[var_109_1 .. "Animator"] = var_109_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_106_1.var_[var_109_1 .. "Animator"].applyRootMotion = true
				arg_106_1.var_[var_109_1 .. "LipSync"] = var_109_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_109_5 = arg_106_1.actors_["3005_tpose"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect3005_tpose == nil then
				arg_106_1.var_.characterEffect3005_tpose = var_109_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_6 and not isNil(var_109_5) then
				if arg_106_1.var_.characterEffect3005_tpose and not isNil(var_109_5) then
					arg_106_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_6 and arg_106_1.time_ < 0 + var_109_6 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect3005_tpose then
				arg_106_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_109_8 = arg_106_1.actors_["10002ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.characterEffect10002ui_story == nil then
				arg_106_1.var_.characterEffect10002ui_story = var_109_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_9 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_9 and not isNil(var_109_8) then
				if arg_106_1.var_.characterEffect10002ui_story and not isNil(var_109_8) then
					arg_106_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_9)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_9 and arg_106_1.time_ < 0 + var_109_9 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.characterEffect10002ui_story then
				arg_106_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_109_10 = arg_106_1.actors_["10002ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10002ui_story = var_109_10.localPosition
			end

			local var_109_11 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_11 then
				var_109_10.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_11)
				var_109_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_10.position).x, (manager.ui.mainCamera.transform.position - var_109_10.position).y, (manager.ui.mainCamera.transform.position - var_109_10.position).z)
				var_109_10.localEulerAngles.z = 0
				var_109_10.localEulerAngles.x = 0
				var_109_10.localEulerAngles = var_109_10.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_11 and arg_106_1.time_ < 0 + var_109_11 + arg_109_0 then
				var_109_10.localPosition = Vector3.New(0, 100, 0)
				var_109_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_10.position).x, (manager.ui.mainCamera.transform.position - var_109_10.position).y, (manager.ui.mainCamera.transform.position - var_109_10.position).z)
				var_109_10.localEulerAngles.z = 0
				var_109_10.localEulerAngles.x = 0
				var_109_10.localEulerAngles = var_109_10.localEulerAngles
			end

			local var_109_12 = arg_106_1.actors_["3005_tpose"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos3005_tpose = var_109_12.localPosition

				local var_109_13 = GameObjectTools.GetOrAddComponent(var_109_12.gameObject, typeof(DynamicBoneHelper))

				if var_109_13 then
					var_109_13:EnableDynamicBone(false)
				end
			end

			local var_109_14 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_14 then
				var_109_12.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos3005_tpose, Vector3.New(-0.7, -1.95, -3.4), (arg_106_1.time_ - 0) / var_109_14)
				var_109_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_12.position).x, (manager.ui.mainCamera.transform.position - var_109_12.position).y, (manager.ui.mainCamera.transform.position - var_109_12.position).z)
				var_109_12.localEulerAngles.z = 0
				var_109_12.localEulerAngles.x = 0
				var_109_12.localEulerAngles = var_109_12.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_14 and arg_106_1.time_ < 0 + var_109_14 + arg_109_0 then
				var_109_12.localPosition = Vector3.New(-0.7, -1.95, -3.4)
				var_109_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_12.position).x, (manager.ui.mainCamera.transform.position - var_109_12.position).y, (manager.ui.mainCamera.transform.position - var_109_12.position).z)
				var_109_12.localEulerAngles.z = 0
				var_109_12.localEulerAngles.x = 0
				var_109_12.localEulerAngles = var_109_12.localEulerAngles

				local var_109_15 = GameObjectTools.GetOrAddComponent(var_109_12.gameObject, typeof(DynamicBoneHelper))

				if var_109_15 then
					var_109_15:EnableDynamicBone(true)
				end
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_109_16 = 0
			local var_109_17 = 0.35

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[69].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(105071026)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_21 = 14 <= 0 and var_109_17 or var_109_17 * (utf8.len(var_109_19) / 14)

				if (14 <= 0 and var_109_17 or var_109_17 * (utf8.len(var_109_19) / 14)) > 0 and var_109_17 < var_109_21 then
					arg_106_1.talkMaxDuration = var_109_21

					if var_109_21 + var_109_16 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_21 + var_109_16
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071026", "story_v_out_105071.awb") ~= 0 then
					local var_109_22 = manager.audio:GetVoiceLength("story_v_out_105071", "105071026", "story_v_out_105071.awb") / 1000

					if var_109_22 + var_109_16 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_16
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_105071", "105071026", "story_v_out_105071.awb")

						arg_106_1:RecordAudio("105071026", var_109_23)
						arg_106_1:RecordAudio("105071026", var_109_23)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_105071", "105071026", "story_v_out_105071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_105071", "105071026", "story_v_out_105071.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_24 = math.max(var_109_17, arg_106_1.talkMaxDuration)

			if var_109_16 <= arg_106_1.time_ and arg_106_1.time_ < var_109_16 + var_109_24 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_16) / var_109_24

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_16 + var_109_24 and arg_106_1.time_ < var_109_16 + var_109_24 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play105071027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105071027
		arg_110_1.duration_ = 5.43

		local var_110_0 = {
			ja = 4.3,
			ko = 2.5,
			zh = 5.433,
			en = 5
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
				arg_110_0:Play105071028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_113_1 = "2043_tpose"

			if arg_110_1.actors_["2043_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2043_tpose"))) then
				local var_113_2 = Object.Instantiate(Asset.Load("Char/" .. "2043_tpose"), arg_110_1.stage_.transform)

				var_113_2.name = var_113_1
				var_113_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_[var_113_1] = var_113_2

				local var_113_3 = var_113_2:GetComponentInChildren(typeof(CharacterEffect))

				var_113_3.enabled = true

				local var_113_4 = GameObjectTools.GetOrAddComponent(var_113_2, typeof(DynamicBoneHelper))

				if var_113_4 then
					var_113_4:EnableDynamicBone(false)
				end

				arg_110_1:ShowWeapon(var_113_3.transform, false)

				arg_110_1.var_[var_113_1 .. "Animator"] = var_113_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_110_1.var_[var_113_1 .. "Animator"].applyRootMotion = true
				arg_110_1.var_[var_113_1 .. "LipSync"] = var_113_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_113_5 = arg_110_1.actors_["2043_tpose"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect2043_tpose == nil then
				arg_110_1.var_.characterEffect2043_tpose = var_113_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_6 and not isNil(var_113_5) then
				if arg_110_1.var_.characterEffect2043_tpose and not isNil(var_113_5) then
					arg_110_1.var_.characterEffect2043_tpose.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_6 and arg_110_1.time_ < 0 + var_113_6 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect2043_tpose then
				arg_110_1.var_.characterEffect2043_tpose.fillFlat = false
			end

			local var_113_8 = arg_110_1.actors_["3005_tpose"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.characterEffect3005_tpose == nil then
				arg_110_1.var_.characterEffect3005_tpose = var_113_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_9 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_9 and not isNil(var_113_8) then
				if arg_110_1.var_.characterEffect3005_tpose and not isNil(var_113_8) then
					arg_110_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_110_1.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_9)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_9 and arg_110_1.time_ < 0 + var_113_9 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.characterEffect3005_tpose then
				arg_110_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_110_1.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			local var_113_10 = arg_110_1.actors_["2043_tpose"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos2043_tpose = var_113_10.localPosition

				local var_113_11 = GameObjectTools.GetOrAddComponent(var_113_10.gameObject, typeof(DynamicBoneHelper))

				if var_113_11 then
					var_113_11:EnableDynamicBone(false)
				end
			end

			local var_113_12 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_12 then
				var_113_10.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos2043_tpose, Vector3.New(0.7, -0.95, -2), (arg_110_1.time_ - 0) / var_113_12)
				var_113_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_10.position).x, (manager.ui.mainCamera.transform.position - var_113_10.position).y, (manager.ui.mainCamera.transform.position - var_113_10.position).z)
				var_113_10.localEulerAngles.z = 0
				var_113_10.localEulerAngles.x = 0
				var_113_10.localEulerAngles = var_113_10.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_12 and arg_110_1.time_ < 0 + var_113_12 + arg_113_0 then
				var_113_10.localPosition = Vector3.New(0.7, -0.95, -2)
				var_113_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_10.position).x, (manager.ui.mainCamera.transform.position - var_113_10.position).y, (manager.ui.mainCamera.transform.position - var_113_10.position).z)
				var_113_10.localEulerAngles.z = 0
				var_113_10.localEulerAngles.x = 0
				var_113_10.localEulerAngles = var_113_10.localEulerAngles

				local var_113_13 = GameObjectTools.GetOrAddComponent(var_113_10.gameObject, typeof(DynamicBoneHelper))

				if var_113_13 then
					var_113_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("2043_tpose", "StoryTimeline/CharAction/story2043/story2043action/2043action1_1")
			end

			local var_113_14 = 0
			local var_113_15 = 0.3

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[69].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_16 = arg_110_1:GetWordFromCfg(105071027)
				local var_113_17 = arg_110_1:FormatText(var_113_16.content)

				arg_110_1.text_.text = var_113_17

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_19 = 12 <= 0 and var_113_15 or var_113_15 * (utf8.len(var_113_17) / 12)

				if (12 <= 0 and var_113_15 or var_113_15 * (utf8.len(var_113_17) / 12)) > 0 and var_113_15 < var_113_19 then
					arg_110_1.talkMaxDuration = var_113_19

					if var_113_19 + var_113_14 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_14
					end
				end

				arg_110_1.text_.text = var_113_17
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071027", "story_v_out_105071.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_105071", "105071027", "story_v_out_105071.awb") / 1000

					if var_113_20 + var_113_14 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_14
					end

					if var_113_16.prefab_name ~= "" and arg_110_1.actors_[var_113_16.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_16.prefab_name].transform, "story_v_out_105071", "105071027", "story_v_out_105071.awb")

						arg_110_1:RecordAudio("105071027", var_113_21)
						arg_110_1:RecordAudio("105071027", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105071", "105071027", "story_v_out_105071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105071", "105071027", "story_v_out_105071.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = math.max(var_113_15, arg_110_1.talkMaxDuration)

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_22 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_14) / var_113_22

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_14 + var_113_22 and arg_110_1.time_ < var_113_14 + var_113_22 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play105071028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105071028
		arg_114_1.duration_ = 8.17

		local var_114_0 = {
			ja = 8.166,
			ko = 5.1,
			zh = 6.1,
			en = 6.866
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
				arg_114_0:Play105071029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1013ui_story"]) and arg_114_1.var_.characterEffect1013ui_story == nil then
				arg_114_1.var_.characterEffect1013ui_story = arg_114_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1013ui_story"]) then
				if arg_114_1.var_.characterEffect1013ui_story and not isNil(arg_114_1.actors_["1013ui_story"]) then
					arg_114_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1013ui_story"]) and arg_114_1.var_.characterEffect1013ui_story then
				arg_114_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["2043_tpose"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect2043_tpose == nil then
				arg_114_1.var_.characterEffect2043_tpose = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect2043_tpose and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect2043_tpose.fillFlat = true
					arg_114_1.var_.characterEffect2043_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect2043_tpose then
				arg_114_1.var_.characterEffect2043_tpose.fillFlat = true
				arg_114_1.var_.characterEffect2043_tpose.fillRatio = 0.5
			end

			local var_117_4 = arg_114_1.actors_["3005_tpose"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos3005_tpose = var_117_4.localPosition

				local var_117_5 = GameObjectTools.GetOrAddComponent(var_117_4.gameObject, typeof(DynamicBoneHelper))

				if var_117_5 then
					var_117_5:EnableDynamicBone(false)
				end
			end

			local var_117_6 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 then
				var_117_4.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos3005_tpose, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_6)
				var_117_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_4.position).x, (manager.ui.mainCamera.transform.position - var_117_4.position).y, (manager.ui.mainCamera.transform.position - var_117_4.position).z)
				var_117_4.localEulerAngles.z = 0
				var_117_4.localEulerAngles.x = 0
				var_117_4.localEulerAngles = var_117_4.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 then
				var_117_4.localPosition = Vector3.New(0, 100, 0)
				var_117_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_4.position).x, (manager.ui.mainCamera.transform.position - var_117_4.position).y, (manager.ui.mainCamera.transform.position - var_117_4.position).z)
				var_117_4.localEulerAngles.z = 0
				var_117_4.localEulerAngles.x = 0
				var_117_4.localEulerAngles = var_117_4.localEulerAngles

				local var_117_7 = GameObjectTools.GetOrAddComponent(var_117_4.gameObject, typeof(DynamicBoneHelper))

				if var_117_7 then
					var_117_7:EnableDynamicBone(true)
				end
			end

			local var_117_8 = arg_114_1.actors_["2043_tpose"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos2043_tpose = var_117_8.localPosition

				local var_117_9 = GameObjectTools.GetOrAddComponent(var_117_8.gameObject, typeof(DynamicBoneHelper))

				if var_117_9 then
					var_117_9:EnableDynamicBone(false)
				end
			end

			local var_117_10 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_10 then
				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos2043_tpose, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_10)
				var_117_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_8.position).x, (manager.ui.mainCamera.transform.position - var_117_8.position).y, (manager.ui.mainCamera.transform.position - var_117_8.position).z)
				var_117_8.localEulerAngles.z = 0
				var_117_8.localEulerAngles.x = 0
				var_117_8.localEulerAngles = var_117_8.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_10 and arg_114_1.time_ < 0 + var_117_10 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(0, 100, 0)
				var_117_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_8.position).x, (manager.ui.mainCamera.transform.position - var_117_8.position).y, (manager.ui.mainCamera.transform.position - var_117_8.position).z)
				var_117_8.localEulerAngles.z = 0
				var_117_8.localEulerAngles.x = 0
				var_117_8.localEulerAngles = var_117_8.localEulerAngles

				local var_117_11 = GameObjectTools.GetOrAddComponent(var_117_8.gameObject, typeof(DynamicBoneHelper))

				if var_117_11 then
					var_117_11:EnableDynamicBone(true)
				end
			end

			local var_117_12 = arg_114_1.actors_["1013ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1013ui_story = var_117_12.localPosition
			end

			local var_117_13 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_13 then
				var_117_12.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_114_1.time_ - 0) / var_117_13)
				var_117_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_12.position).x, (manager.ui.mainCamera.transform.position - var_117_12.position).y, (manager.ui.mainCamera.transform.position - var_117_12.position).z)
				var_117_12.localEulerAngles.z = 0
				var_117_12.localEulerAngles.x = 0
				var_117_12.localEulerAngles = var_117_12.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_13 and arg_114_1.time_ < 0 + var_117_13 + arg_117_0 then
				var_117_12.localPosition = Vector3.New(0, -0.66, -6.15)
				var_117_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_12.position).x, (manager.ui.mainCamera.transform.position - var_117_12.position).y, (manager.ui.mainCamera.transform.position - var_117_12.position).z)
				var_117_12.localEulerAngles.z = 0
				var_117_12.localEulerAngles.x = 0
				var_117_12.localEulerAngles = var_117_12.localEulerAngles
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action4_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_117_14 = 0
			local var_117_15 = 0.55

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_16 = arg_114_1:GetWordFromCfg(105071028)
				local var_117_17 = arg_114_1:FormatText(var_117_16.content)

				arg_114_1.text_.text = var_117_17

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_19 = 22 <= 0 and var_117_15 or var_117_15 * (utf8.len(var_117_17) / 22)

				if (22 <= 0 and var_117_15 or var_117_15 * (utf8.len(var_117_17) / 22)) > 0 and var_117_15 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_14 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_14
					end
				end

				arg_114_1.text_.text = var_117_17
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071028", "story_v_out_105071.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_105071", "105071028", "story_v_out_105071.awb") / 1000

					if var_117_20 + var_117_14 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_14
					end

					if var_117_16.prefab_name ~= "" and arg_114_1.actors_[var_117_16.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_16.prefab_name].transform, "story_v_out_105071", "105071028", "story_v_out_105071.awb")

						arg_114_1:RecordAudio("105071028", var_117_21)
						arg_114_1:RecordAudio("105071028", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_105071", "105071028", "story_v_out_105071.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_105071", "105071028", "story_v_out_105071.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_15, arg_114_1.talkMaxDuration)

			if var_117_14 <= arg_114_1.time_ and arg_114_1.time_ < var_117_14 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_14) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_14 + var_117_22 and arg_114_1.time_ < var_117_14 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play105071029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105071029
		arg_118_1.duration_ = 9

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play105071030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1013ui_story"]) and arg_118_1.var_.characterEffect1013ui_story == nil then
				arg_118_1.var_.characterEffect1013ui_story = arg_118_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1013ui_story"]) then
				if arg_118_1.var_.characterEffect1013ui_story and not isNil(arg_118_1.actors_["1013ui_story"]) then
					arg_118_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1013ui_story"]) and arg_118_1.var_.characterEffect1013ui_story then
				arg_118_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_121_1 = arg_118_1.actors_["1013ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1013ui_story = var_121_1.localPosition
			end

			local var_121_2 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 then
				var_121_1.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1013ui_story, Vector3.New(10, -0.78, -5.4), (arg_118_1.time_ - 0) / var_121_2)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 then
				var_121_1.localPosition = Vector3.New(10, -0.78, -5.4)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			local var_121_3 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_4 = 2

			if var_121_3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_3 + var_121_4 then
				local var_121_5 = Color.New(0, 0, 0)

				var_121_5.a = Mathf.Lerp(0, 1, (arg_118_1.time_ - var_121_3) / var_121_4)
				arg_118_1.mask_.color = var_121_5
			end

			if arg_118_1.time_ >= var_121_3 + var_121_4 and arg_118_1.time_ < var_121_3 + var_121_4 + arg_121_0 then
				local var_121_6 = Color.New(0, 0, 0)

				var_121_6.a = 1
				arg_118_1.mask_.color = var_121_6
			end

			local var_121_7 = 2

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_8 = 2

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_8 then
				local var_121_9 = Color.New(0, 0, 0)

				var_121_9.a = Mathf.Lerp(1, 0, (arg_118_1.time_ - var_121_7) / var_121_8)
				arg_118_1.mask_.color = var_121_9
			end

			if arg_118_1.time_ >= var_121_7 + var_121_8 and arg_118_1.time_ < var_121_7 + var_121_8 + arg_121_0 then
				local var_121_10 = Color.New(0, 0, 0)

				arg_118_1.mask_.enabled = false
				var_121_10.a = 0
				arg_118_1.mask_.color = var_121_10
			end

			local var_121_11 = "S0507"

			if arg_118_1.bgs_.S0507 == nil then
				local var_121_12 = Object.Instantiate(arg_118_1.paintGo_)

				var_121_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_121_11)
				var_121_12.name = var_121_11
				var_121_12.transform.parent = arg_118_1.stage_.transform
				var_121_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.bgs_[var_121_11] = var_121_12
			end

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= 2 + arg_121_0 then
				local var_121_13 = arg_118_1.bgs_.S0507

				arg_118_1.bgs_.S0507.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_121_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_14 = var_121_13:GetComponent("SpriteRenderer")

				if var_121_14 and var_121_14.sprite then
					local var_121_15 = 2 * (var_121_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_121_13.transform.localScale = Vector3.New(var_121_15 / var_121_14.sprite.bounds.size.y < var_121_15 * manager.ui.mainCameraCom_.aspect / var_121_14.sprite.bounds.size.x and var_121_15 * manager.ui.mainCameraCom_.aspect / var_121_14.sprite.bounds.size.x or var_121_15 / var_121_14.sprite.bounds.size.y, var_121_15 / var_121_14.sprite.bounds.size.y < var_121_15 * manager.ui.mainCameraCom_.aspect / var_121_14.sprite.bounds.size.x and var_121_15 * manager.ui.mainCameraCom_.aspect / var_121_14.sprite.bounds.size.x or var_121_15 / var_121_14.sprite.bounds.size.y, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "S0507" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_16 = arg_118_1.bgs_.S0507.transform

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= 2 + arg_121_0 then
				arg_118_1.var_.moveOldPosS0507 = var_121_16.localPosition
			end

			local var_121_17 = 0.001

			if 2 <= arg_118_1.time_ and arg_118_1.time_ < 2 + var_121_17 then
				var_121_16.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosS0507, Vector3.New(4.65, 3.19, -4.27), (arg_118_1.time_ - 2) / var_121_17)
			end

			if arg_118_1.time_ >= 2 + var_121_17 and arg_118_1.time_ < 2 + var_121_17 + arg_121_0 then
				var_121_16.localPosition = Vector3.New(4.65, 3.19, -4.27)
			end

			local var_121_18 = arg_118_1.bgs_.S0507.transform

			if 2.01666666666667 < arg_118_1.time_ and arg_118_1.time_ <= 2.01666666666667 + arg_121_0 then
				arg_118_1.var_.moveOldPosS0507 = var_121_18.localPosition
			end

			local var_121_19 = 4

			if 2.01666666666667 <= arg_118_1.time_ and arg_118_1.time_ < 2.01666666666667 + var_121_19 then
				var_121_18.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosS0507, Vector3.New(4.65, 3.19, -3.01), (arg_118_1.time_ - 2.01666666666667) / var_121_19)
			end

			if arg_118_1.time_ >= 2.01666666666667 + var_121_19 and arg_118_1.time_ < 2.01666666666667 + var_121_19 + arg_121_0 then
				var_121_18.localPosition = Vector3.New(4.65, 3.19, -3.01)
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_20 = 4
			local var_121_21 = 0.6

			if 4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_22 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_22:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_23 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(105071029).content)

				arg_118_1.text_.text = var_121_23

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_25 = 24 <= 0 and var_121_21 or var_121_21 * (utf8.len(var_121_23) / 24)

				if (24 <= 0 and var_121_21 or var_121_21 * (utf8.len(var_121_23) / 24)) > 0 and var_121_21 < var_121_25 then
					arg_118_1.talkMaxDuration = var_121_25
					var_121_20 = var_121_20 + 0.3

					if var_121_25 + var_121_20 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_25 + var_121_20
					end
				end

				arg_118_1.text_.text = var_121_23
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_26 = var_121_20 + 0.3
			local var_121_27 = math.max(var_121_21, arg_118_1.talkMaxDuration)

			if var_121_20 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_26 + var_121_27 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_26) / var_121_27

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_26 + var_121_27 and arg_118_1.time_ < var_121_26 + var_121_27 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "S0507",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0507",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play105071030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 105071030
		arg_124_1.duration_ = 7.53

		local var_124_0 = {
			ja = 7.533,
			ko = 4.966,
			zh = 6.466,
			en = 6.266
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
				arg_124_0:Play105071031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.8

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(105071030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 32 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 32)

				if (32 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 32)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071030", "story_v_out_105071.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_105071", "105071030", "story_v_out_105071.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_105071", "105071030", "story_v_out_105071.awb")

						arg_124_1:RecordAudio("105071030", var_127_6)
						arg_124_1:RecordAudio("105071030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_105071", "105071030", "story_v_out_105071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_105071", "105071030", "story_v_out_105071.awb")
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
	Play105071031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 105071031
		arg_128_1.duration_ = 6

		local var_128_0 = {
			ja = 3.266,
			ko = 4.966,
			zh = 4.3,
			en = 6
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
				arg_128_0:Play105071032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.4

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_1 = arg_128_1:GetWordFromCfg(105071031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 16 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 16)

				if (16 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 16)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071031", "story_v_out_105071.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_105071", "105071031", "story_v_out_105071.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_105071", "105071031", "story_v_out_105071.awb")

						arg_128_1:RecordAudio("105071031", var_131_6)
						arg_128_1:RecordAudio("105071031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_105071", "105071031", "story_v_out_105071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_105071", "105071031", "story_v_out_105071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play105071032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 105071032
		arg_132_1.duration_ = 12.2

		local var_132_0 = {
			ja = 12.2,
			ko = 10.4,
			zh = 11.133,
			en = 9.666
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
			arg_132_1.auto_ = false
		end

		function arg_132_1.playNext_(arg_134_0)
			arg_132_1.onStoryFinished_()
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_0 = 2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				local var_135_1 = Color.New(0, 0, 0)

				var_135_1.a = Mathf.Lerp(0, 1, (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.mask_.color = var_135_1
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				local var_135_2 = Color.New(0, 0, 0)

				var_135_2.a = 1
				arg_132_1.mask_.color = var_135_2
			end

			local var_135_3 = 2

			if 2 < arg_132_1.time_ and arg_132_1.time_ <= var_135_3 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_4 = 2

			if var_135_3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_3 + var_135_4 then
				local var_135_5 = Color.New(0, 0, 0)

				var_135_5.a = Mathf.Lerp(1, 0, (arg_132_1.time_ - var_135_3) / var_135_4)
				arg_132_1.mask_.color = var_135_5
			end

			if arg_132_1.time_ >= var_135_3 + var_135_4 and arg_132_1.time_ < var_135_3 + var_135_4 + arg_135_0 then
				local var_135_6 = Color.New(0, 0, 0)

				arg_132_1.mask_.enabled = false
				var_135_6.a = 0
				arg_132_1.mask_.color = var_135_6
			end

			if 2 < arg_132_1.time_ and arg_132_1.time_ <= 2 + arg_135_0 then
				local var_135_7 = arg_132_1.bgs_.S0507

				arg_132_1.bgs_.S0507.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_135_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_135_8 = var_135_7:GetComponent("SpriteRenderer")

				if var_135_8 and var_135_8.sprite then
					local var_135_9 = 2 * (var_135_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_135_7.transform.localScale = Vector3.New(var_135_9 / var_135_8.sprite.bounds.size.y < var_135_9 * manager.ui.mainCameraCom_.aspect / var_135_8.sprite.bounds.size.x and var_135_9 * manager.ui.mainCameraCom_.aspect / var_135_8.sprite.bounds.size.x or var_135_9 / var_135_8.sprite.bounds.size.y, var_135_9 / var_135_8.sprite.bounds.size.y < var_135_9 * manager.ui.mainCameraCom_.aspect / var_135_8.sprite.bounds.size.x and var_135_9 * manager.ui.mainCameraCom_.aspect / var_135_8.sprite.bounds.size.x or var_135_9 / var_135_8.sprite.bounds.size.y, 0)
				end

				for iter_135_0, iter_135_1 in pairs(arg_132_1.bgs_) do
					if iter_135_0 ~= "S0507" then
						iter_135_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_10 = 4
			local var_135_11 = 0.85

			if 4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_12 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_12:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_132_1.dialogCg_.alpha = arg_136_0
				end))
				var_135_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_13 = arg_132_1:GetWordFromCfg(105071032)
				local var_135_14 = arg_132_1:FormatText(var_135_13.content)

				arg_132_1.text_.text = var_135_14

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_16 = 33 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_14) / 33)

				if (33 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_14) / 33)) > 0 and var_135_11 < var_135_16 then
					arg_132_1.talkMaxDuration = var_135_16
					var_135_10 = var_135_10 + 0.3

					if var_135_16 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_10
					end
				end

				arg_132_1.text_.text = var_135_14
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071032", "story_v_out_105071.awb") ~= 0 then
					local var_135_17 = manager.audio:GetVoiceLength("story_v_out_105071", "105071032", "story_v_out_105071.awb") / 1000

					if var_135_17 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_17 + var_135_10
					end

					if var_135_13.prefab_name ~= "" and arg_132_1.actors_[var_135_13.prefab_name] ~= nil then
						local var_135_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_13.prefab_name].transform, "story_v_out_105071", "105071032", "story_v_out_105071.awb")

						arg_132_1:RecordAudio("105071032", var_135_18)
						arg_132_1:RecordAudio("105071032", var_135_18)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_105071", "105071032", "story_v_out_105071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_105071", "105071032", "story_v_out_105071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_19 = var_135_10 + 0.3
			local var_135_20 = math.max(var_135_11, arg_132_1.talkMaxDuration)

			if var_135_10 + 0.3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_19 + var_135_20 then
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
	assets = {
		"TextureConfig/Background/B01c",
		"TextureConfig/Background/B03f",
		"TextureConfig/Background/S0507"
	},
	voices = {
		"story_v_out_105071.awb"
	}
}
