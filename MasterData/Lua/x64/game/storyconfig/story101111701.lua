return {
	Play111171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111171001
		arg_1_1.duration_ = 4.33

		local var_1_0 = {
			ja = 2.999999999999,
			ko = 4.334,
			zh = 3.634,
			en = 3.334
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
				arg_1_0:Play111171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_4_0.name = "ST10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST10

				arg_1_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.ST10:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueST10 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueST10 = var_4_4
				end

				arg_1_1.var_.alphaOldValueST10 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueST10 then
					arg_1_1.var_.alphaMatValueST10.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueST10, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueST10.color = arg_1_1.var_.alphaMatValueST10.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueST10 then
				arg_1_1.var_.alphaMatValueST10.color.a = 1
				arg_1_1.var_.alphaMatValueST10.color = arg_1_1.var_.alphaMatValueST10.color
			end

			local var_4_6 = "1019ui_story"

			if arg_1_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_4_7 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

				var_4_7.name = var_4_6
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_6] = var_4_7

				local var_4_8 = var_4_7:GetComponentInChildren(typeof(CharacterEffect))

				var_4_8.enabled = true

				local var_4_9 = GameObjectTools.GetOrAddComponent(var_4_7, typeof(DynamicBoneHelper))

				if var_4_9 then
					var_4_9:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_8.transform, false)

				arg_1_1.var_[var_4_6 .. "Animator"] = var_4_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_10 = arg_1_1.actors_["1019ui_story"].transform

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_10.localPosition
			end

			local var_4_11 = 0.001

			if 1.5 <= arg_1_1.time_ and arg_1_1.time_ < 1.5 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_1_1.time_ - 1.5) / var_4_11)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles
			end

			if arg_1_1.time_ >= 1.5 + var_4_11 and arg_1_1.time_ < 1.5 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles
			end

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_4_12 = arg_1_1.actors_["1019ui_story"]

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.2

			if 1.5 <= arg_1_1.time_ and arg_1_1.time_ < 1.5 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_12) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.5 + var_4_13 and arg_1_1.time_ < 1.5 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 1.534 and arg_1_1.time_ < var_4_15 + 1.534 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			local var_4_19 = 1.534
			local var_4_20 = 0.25

			if 1.534 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:GetWordFromCfg(111171001)
				local var_4_23 = arg_1_1:FormatText(var_4_22.content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 10 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 10)

				if (10 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 10)) > 0 and var_4_20 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_19 = var_4_19 + 0.3

					if var_4_25 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171001", "story_v_out_111171.awb") ~= 0 then
					local var_4_26 = manager.audio:GetVoiceLength("story_v_out_111171", "111171001", "story_v_out_111171.awb") / 1000

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end

					if var_4_22.prefab_name ~= "" and arg_1_1.actors_[var_4_22.prefab_name] ~= nil then
						local var_4_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_22.prefab_name].transform, "story_v_out_111171", "111171001", "story_v_out_111171.awb")

						arg_1_1:RecordAudio("111171001", var_4_27)
						arg_1_1:RecordAudio("111171001", var_4_27)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_111171", "111171001", "story_v_out_111171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_111171", "111171001", "story_v_out_111171.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_19 + 0.3
			local var_4_29 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play111171002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111171002
		arg_8_1.duration_ = 4.73

		local var_8_0 = {
			ja = 4.333,
			ko = 4.733,
			zh = 4.466,
			en = 4.433
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
				arg_8_0:Play111171003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1066ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1066ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1066ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1066ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1066ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1066ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_5 = arg_8_1.actors_["1019ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_6)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_11_7 = arg_8_1.actors_["1066ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1066ui_story == nil then
				arg_8_1.var_.characterEffect1066ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect1066ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1066ui_story then
				arg_8_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_11_12 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_12 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_12

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_12
						arg_8_1.bgmTxt2_.text = var_11_12
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_13 = 0
			local var_11_14 = 0.475

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_15 = arg_8_1:GetWordFromCfg(111171002)
				local var_11_16 = arg_8_1:FormatText(var_11_15.content)

				arg_8_1.text_.text = var_11_16

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_18 = 19 <= 0 and var_11_14 or var_11_14 * (utf8.len(var_11_16) / 19)

				if (19 <= 0 and var_11_14 or var_11_14 * (utf8.len(var_11_16) / 19)) > 0 and var_11_14 < var_11_18 then
					arg_8_1.talkMaxDuration = var_11_18

					if var_11_18 + var_11_13 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_13
					end
				end

				arg_8_1.text_.text = var_11_16
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171002", "story_v_out_111171.awb") ~= 0 then
					local var_11_19 = manager.audio:GetVoiceLength("story_v_out_111171", "111171002", "story_v_out_111171.awb") / 1000

					if var_11_19 + var_11_13 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_19 + var_11_13
					end

					if var_11_15.prefab_name ~= "" and arg_8_1.actors_[var_11_15.prefab_name] ~= nil then
						local var_11_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_15.prefab_name].transform, "story_v_out_111171", "111171002", "story_v_out_111171.awb")

						arg_8_1:RecordAudio("111171002", var_11_20)
						arg_8_1:RecordAudio("111171002", var_11_20)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_111171", "111171002", "story_v_out_111171.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_111171", "111171002", "story_v_out_111171.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_21 = math.max(var_11_14, arg_8_1.talkMaxDuration)

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_21 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_13) / var_11_21

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_13 + var_11_21 and arg_8_1.time_ < var_11_13 + var_11_21 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play111171003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 111171003
		arg_13_1.duration_ = 4.77

		local var_13_0 = {
			ja = 4.766,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_13_0:Play111171004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_16_0 = arg_13_1.actors_["1019ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_1 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 and not isNil(var_16_0) then
				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_16_3 = arg_13_1.actors_["1066ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1066ui_story == nil then
				arg_13_1.var_.characterEffect1066ui_story = var_16_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_4 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 and not isNil(var_16_3) then
				if arg_13_1.var_.characterEffect1066ui_story and not isNil(var_16_3) then
					arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_4)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1066ui_story then
				arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_16_5 = 0
			local var_16_6 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(111171003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 7 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 7)

				if (7 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 7)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171003", "story_v_out_111171.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_111171", "111171003", "story_v_out_111171.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_111171", "111171003", "story_v_out_111171.awb")

						arg_13_1:RecordAudio("111171003", var_16_12)
						arg_13_1:RecordAudio("111171003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_111171", "111171003", "story_v_out_111171.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_111171", "111171003", "story_v_out_111171.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_13 and arg_13_1.time_ < var_16_5 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play111171004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 111171004
		arg_17_1.duration_ = 9.53

		local var_17_0 = {
			ja = 2.933,
			ko = 9.533,
			zh = 5.733,
			en = 6.5
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play111171005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_20_0 = arg_17_1.actors_["1066ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1066ui_story == nil then
				arg_17_1.var_.characterEffect1066ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_1 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 and not isNil(var_20_0) then
				if arg_17_1.var_.characterEffect1066ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1066ui_story then
				arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_20_3 = arg_17_1.actors_["1019ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_4 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 and not isNil(var_20_3) then
				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_3) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_4)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_20_5 = 0
			local var_20_6 = 0.65

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(111171004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 26 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 26)

				if (26 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 26)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171004", "story_v_out_111171.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_111171", "111171004", "story_v_out_111171.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_111171", "111171004", "story_v_out_111171.awb")

						arg_17_1:RecordAudio("111171004", var_20_12)
						arg_17_1:RecordAudio("111171004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_111171", "111171004", "story_v_out_111171.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_111171", "111171004", "story_v_out_111171.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_13 and arg_17_1.time_ < var_20_5 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play111171005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 111171005
		arg_21_1.duration_ = 13.43

		local var_21_0 = {
			ja = 7.7,
			ko = 13.433,
			zh = 9.833,
			en = 12.8
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play111171006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_24_0 = 0
			local var_24_1 = 1.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(111171005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 56 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_3) / 56)

				if (56 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_3) / 56)) > 0 and var_24_1 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171005", "story_v_out_111171.awb") ~= 0 then
					local var_24_6 = manager.audio:GetVoiceLength("story_v_out_111171", "111171005", "story_v_out_111171.awb") / 1000

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end

					if var_24_2.prefab_name ~= "" and arg_21_1.actors_[var_24_2.prefab_name] ~= nil then
						local var_24_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_2.prefab_name].transform, "story_v_out_111171", "111171005", "story_v_out_111171.awb")

						arg_21_1:RecordAudio("111171005", var_24_7)
						arg_21_1:RecordAudio("111171005", var_24_7)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_111171", "111171005", "story_v_out_111171.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_111171", "111171005", "story_v_out_111171.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play111171006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 111171006
		arg_25_1.duration_ = 3.9

		local var_25_0 = {
			ja = 3.9,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.033
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play111171007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_28_0 = arg_25_1.actors_["1019ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_1 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 and not isNil(var_28_0) then
				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_28_3 = arg_25_1.actors_["1066ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect1066ui_story == nil then
				arg_25_1.var_.characterEffect1066ui_story = var_28_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_4 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 and not isNil(var_28_3) then
				if arg_25_1.var_.characterEffect1066ui_story and not isNil(var_28_3) then
					arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_4)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect1066ui_story then
				arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_28_5 = 0
			local var_28_6 = 0.15

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(111171006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 6 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 6)

				if (6 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 6)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171006", "story_v_out_111171.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_111171", "111171006", "story_v_out_111171.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_111171", "111171006", "story_v_out_111171.awb")

						arg_25_1:RecordAudio("111171006", var_28_12)
						arg_25_1:RecordAudio("111171006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_111171", "111171006", "story_v_out_111171.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_111171", "111171006", "story_v_out_111171.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play111171007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 111171007
		arg_29_1.duration_ = 8.77

		local var_29_0 = {
			ja = 6.333,
			ko = 8.766,
			zh = 6.966,
			en = 8.633
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
				arg_29_0:Play111171008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_32_0 = arg_29_1.actors_["1066ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1066ui_story == nil then
				arg_29_1.var_.characterEffect1066ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_1 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(var_32_0) then
				if arg_29_1.var_.characterEffect1066ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1066ui_story then
				arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_32_3 = arg_29_1.actors_["1019ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect1019ui_story == nil then
				arg_29_1.var_.characterEffect1019ui_story = var_32_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 and not isNil(var_32_3) then
				if arg_29_1.var_.characterEffect1019ui_story and not isNil(var_32_3) then
					arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_4)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect1019ui_story then
				arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_32_5 = 0
			local var_32_6 = 0.85

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(111171007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 34 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 34)

				if (34 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 34)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171007", "story_v_out_111171.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_111171", "111171007", "story_v_out_111171.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_111171", "111171007", "story_v_out_111171.awb")

						arg_29_1:RecordAudio("111171007", var_32_12)
						arg_29_1:RecordAudio("111171007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_111171", "111171007", "story_v_out_111171.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_111171", "111171007", "story_v_out_111171.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_13 and arg_29_1.time_ < var_32_5 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play111171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 111171008
		arg_33_1.duration_ = 12.7

		local var_33_0 = {
			ja = 8.5,
			ko = 12.7,
			zh = 8.6,
			en = 11.966
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play111171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_0 = 0
			local var_36_1 = 1.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(111171008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 44 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 44)

				if (44 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 44)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171008", "story_v_out_111171.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_111171", "111171008", "story_v_out_111171.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_111171", "111171008", "story_v_out_111171.awb")

						arg_33_1:RecordAudio("111171008", var_36_7)
						arg_33_1:RecordAudio("111171008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_111171", "111171008", "story_v_out_111171.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_111171", "111171008", "story_v_out_111171.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play111171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 111171009
		arg_37_1.duration_ = 3.27

		local var_37_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 3.2,
			en = 3.266
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
				arg_37_0:Play111171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_0 = arg_37_1.actors_["1019ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1019ui_story == nil then
				arg_37_1.var_.characterEffect1019ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(var_40_0) then
				if arg_37_1.var_.characterEffect1019ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1019ui_story then
				arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_40_3 = arg_37_1.actors_["1066ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = var_40_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_4 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 and not isNil(var_40_3) then
				if arg_37_1.var_.characterEffect1066ui_story and not isNil(var_40_3) then
					arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_4)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1066ui_story then
				arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_40_5 = 0
			local var_40_6 = 0.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(111171009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 8 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 8)

				if (8 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 8)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171009", "story_v_out_111171.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_111171", "111171009", "story_v_out_111171.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_111171", "111171009", "story_v_out_111171.awb")

						arg_37_1:RecordAudio("111171009", var_40_12)
						arg_37_1:RecordAudio("111171009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_111171", "111171009", "story_v_out_111171.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_111171", "111171009", "story_v_out_111171.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play111171010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 111171010
		arg_41_1.duration_ = 2.83

		local var_41_0 = {
			ja = 2.833,
			ko = 2.266,
			zh = 1.666,
			en = 2.666
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
				arg_41_0:Play111171011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1019ui_story = arg_41_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1019ui_story"].transform.position).z)
				arg_41_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1019ui_story"].transform.localEulerAngles = arg_41_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1019ui_story"].transform.position).z)
				arg_41_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1019ui_story"].transform.localEulerAngles = arg_41_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1066ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1066ui_story = var_44_1.localPosition
			end

			local var_44_2 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 then
				var_44_1.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				var_44_1.localPosition = Vector3.New(0, 100, 0)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			local var_44_3 = manager.ui.mainCamera.transform

			if 0.5 < arg_41_1.time_ and arg_41_1.time_ <= 0.5 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = var_44_3.localPosition
			end

			local var_44_4 = 0.3

			if 0.5 <= arg_41_1.time_ and arg_41_1.time_ < 0.5 + var_44_4 then
				local var_44_5, var_44_6 = math.modf((arg_41_1.time_ - 0.5) / 0.066)

				var_44_3.localPosition = Vector3.New(var_44_6 * 0.13, var_44_6 * 0.13, var_44_6 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= 0.5 + var_44_4 and arg_41_1.time_ < 0.5 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_7 = 0
			local var_44_8 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(111171010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 5 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_10) / 5)

				if (5 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_10) / 5)) > 0 and var_44_8 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12

					if var_44_12 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171010", "story_v_out_111171.awb") ~= 0 then
					local var_44_13 = manager.audio:GetVoiceLength("story_v_out_111171", "111171010", "story_v_out_111171.awb") / 1000

					if var_44_13 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_7
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_111171", "111171010", "story_v_out_111171.awb")

						arg_41_1:RecordAudio("111171010", var_44_14)
						arg_41_1:RecordAudio("111171010", var_44_14)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_111171", "111171010", "story_v_out_111171.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_111171", "111171010", "story_v_out_111171.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_15 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_15 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_7) / var_44_15

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_7 + var_44_15 and arg_41_1.time_ < var_44_7 + var_44_15 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play111171011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111171011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play111171012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.75

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(111171011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 30)

				if (30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 30)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play111171012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 111171012
		arg_49_1.duration_ = 15.3

		local var_49_0 = {
			ja = 15.3,
			ko = 10.566,
			zh = 9.7,
			en = 9.133
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
				arg_49_0:Play111171013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1066ui_story = arg_49_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).z)
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles = arg_49_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_49_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).z)
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles = arg_49_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_52_1 = arg_49_1.actors_["1066ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1066ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1066ui_story then
				arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_52_4 = 0
			local var_52_5 = 1.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(111171012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 52 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 52)

				if (52 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 52)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171012", "story_v_out_111171.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_111171", "111171012", "story_v_out_111171.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_111171", "111171012", "story_v_out_111171.awb")

						arg_49_1:RecordAudio("111171012", var_52_11)
						arg_49_1:RecordAudio("111171012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_111171", "111171012", "story_v_out_111171.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_111171", "111171012", "story_v_out_111171.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play111171013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 111171013
		arg_53_1.duration_ = 4.87

		local var_53_0 = {
			ja = 4.866,
			ko = 1.999999999999,
			zh = 4.3,
			en = 2.4
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
				arg_53_0:Play111171014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1019ui_story = arg_53_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1019ui_story"].transform.position).z)
				arg_53_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1019ui_story"].transform.localEulerAngles = arg_53_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_53_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1019ui_story"].transform.position).z)
				arg_53_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1019ui_story"].transform.localEulerAngles = arg_53_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_1 = arg_53_1.actors_["1019ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1019ui_story == nil then
				arg_53_1.var_.characterEffect1019ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1019ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1019ui_story then
				arg_53_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["1066ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_5 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and not isNil(var_56_4) then
				if arg_53_1.var_.characterEffect1066ui_story and not isNil(var_56_4) then
					arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_5)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1066ui_story then
				arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_56_6 = 0
			local var_56_7 = 0.2

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(111171013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 8 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 8)

				if (8 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 8)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171013", "story_v_out_111171.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_111171", "111171013", "story_v_out_111171.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_111171", "111171013", "story_v_out_111171.awb")

						arg_53_1:RecordAudio("111171013", var_56_13)
						arg_53_1:RecordAudio("111171013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_111171", "111171013", "story_v_out_111171.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_111171", "111171013", "story_v_out_111171.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play111171014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 111171014
		arg_57_1.duration_ = 12.1

		local var_57_0 = {
			ja = 12.1,
			ko = 9.833,
			zh = 8.933,
			en = 8.266
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play111171015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_0 = arg_57_1.actors_["1066ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1066ui_story == nil then
				arg_57_1.var_.characterEffect1066ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_1 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 and not isNil(var_60_0) then
				if arg_57_1.var_.characterEffect1066ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1066ui_story then
				arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_60_3 = arg_57_1.actors_["1019ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1019ui_story == nil then
				arg_57_1.var_.characterEffect1019ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1019ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_4)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1019ui_story then
				arg_57_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_60_5 = 0
			local var_60_6 = 1.05

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(111171014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 41 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 41)

				if (41 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 41)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171014", "story_v_out_111171.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_111171", "111171014", "story_v_out_111171.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_111171", "111171014", "story_v_out_111171.awb")

						arg_57_1:RecordAudio("111171014", var_60_12)
						arg_57_1:RecordAudio("111171014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_111171", "111171014", "story_v_out_111171.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_111171", "111171014", "story_v_out_111171.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play111171015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 111171015
		arg_61_1.duration_ = 4.57

		local var_61_0 = {
			ja = 3.4,
			ko = 3.966,
			zh = 4.566,
			en = 2.966
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
				arg_61_0:Play111171016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_64_0 = arg_61_1.actors_["1066ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1066ui_story == nil then
				arg_61_1.var_.characterEffect1066ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_1 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 and not isNil(var_64_0) then
				if arg_61_1.var_.characterEffect1066ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1066ui_story then
				arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_64_3 = 0
			local var_64_4 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(111171015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_8 = 16 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_6) / 16)

				if (16 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_6) / 16)) > 0 and var_64_4 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171015", "story_v_out_111171.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_111171", "111171015", "story_v_out_111171.awb") / 1000

					if var_64_9 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_3
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_111171", "111171015", "story_v_out_111171.awb")

						arg_61_1:RecordAudio("111171015", var_64_10)
						arg_61_1:RecordAudio("111171015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_111171", "111171015", "story_v_out_111171.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_111171", "111171015", "story_v_out_111171.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_11 and arg_61_1.time_ < var_64_3 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play111171016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 111171016
		arg_65_1.duration_ = 10.6

		local var_65_0 = {
			ja = 10.6,
			ko = 7.366,
			zh = 7.733,
			en = 8.6
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
				arg_65_0:Play111171017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_0 = arg_65_1.actors_["1019ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_1 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 and not isNil(var_68_0) then
				if arg_65_1.var_.characterEffect1019ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1019ui_story then
				arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_68_3 = arg_65_1.actors_["1066ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect1066ui_story == nil then
				arg_65_1.var_.characterEffect1066ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect1066ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_4)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect1066ui_story then
				arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_68_5 = 0
			local var_68_6 = 0.95

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(111171016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 38 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 38)

				if (38 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 38)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171016", "story_v_out_111171.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_111171", "111171016", "story_v_out_111171.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_111171", "111171016", "story_v_out_111171.awb")

						arg_65_1:RecordAudio("111171016", var_68_12)
						arg_65_1:RecordAudio("111171016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_111171", "111171016", "story_v_out_111171.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_111171", "111171016", "story_v_out_111171.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play111171017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 111171017
		arg_69_1.duration_ = 6.18

		local var_69_0 = {
			ja = 6.175,
			ko = 4.308,
			zh = 5.475,
			en = 5.541
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play111171018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1019ui_story = arg_69_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1019ui_story"].transform.position).z)
				arg_69_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1019ui_story"].transform.localEulerAngles = arg_69_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1019ui_story"].transform.position).z)
				arg_69_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1019ui_story"].transform.localEulerAngles = arg_69_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1066ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1066ui_story = var_72_1.localPosition
			end

			local var_72_2 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 then
				var_72_1.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_2)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 then
				var_72_1.localPosition = Vector3.New(0, 100, 0)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_3 = arg_69_1.bgs_.ST10:GetComponent("SpriteRenderer")

				if var_72_3 then
					arg_69_1.var_.alphaOldValueST10 = var_72_3.color.a
					arg_69_1.var_.alphaMatValueST10 = var_72_3
				end

				arg_69_1.var_.alphaOldValueST10 = 1
			end

			local var_72_4 = 1.5

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				if arg_69_1.var_.alphaMatValueST10 then
					arg_69_1.var_.alphaMatValueST10.color.a = Mathf.Lerp(arg_69_1.var_.alphaOldValueST10, 0, (arg_69_1.time_ - 0) / var_72_4)
					arg_69_1.var_.alphaMatValueST10.color = arg_69_1.var_.alphaMatValueST10.color
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and arg_69_1.var_.alphaMatValueST10 then
				arg_69_1.var_.alphaMatValueST10.color.a = 0
				arg_69_1.var_.alphaMatValueST10.color = arg_69_1.var_.alphaMatValueST10.color
			end

			local var_72_5 = "D05"

			if arg_69_1.bgs_.D05 == nil then
				local var_72_6 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_5)
				var_72_6.name = var_72_5
				var_72_6.transform.parent = arg_69_1.stage_.transform
				var_72_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_5] = var_72_6
			end

			if 1.5 < arg_69_1.time_ and arg_69_1.time_ <= 1.5 + arg_72_0 then
				local var_72_7 = arg_69_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_72_7 then
					arg_69_1.var_.alphaOldValueD05 = var_72_7.color.a
					arg_69_1.var_.alphaMatValueD05 = var_72_7
				end

				arg_69_1.var_.alphaOldValueD05 = 0
			end

			local var_72_8 = 1.5

			if 1.5 <= arg_69_1.time_ and arg_69_1.time_ < 1.5 + var_72_8 then
				if arg_69_1.var_.alphaMatValueD05 then
					arg_69_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_69_1.var_.alphaOldValueD05, 1, (arg_69_1.time_ - 1.5) / var_72_8)
					arg_69_1.var_.alphaMatValueD05.color = arg_69_1.var_.alphaMatValueD05.color
				end
			end

			if arg_69_1.time_ >= 1.5 + var_72_8 and arg_69_1.time_ < 1.5 + var_72_8 + arg_72_0 and arg_69_1.var_.alphaMatValueD05 then
				arg_69_1.var_.alphaMatValueD05.color.a = 1
				arg_69_1.var_.alphaMatValueD05.color = arg_69_1.var_.alphaMatValueD05.color
			end

			if 1.5 < arg_69_1.time_ and arg_69_1.time_ <= 1.5 + arg_72_0 then
				local var_72_9 = arg_69_1.bgs_.D05

				arg_69_1.bgs_.D05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_10 = var_72_9:GetComponent("SpriteRenderer")

				if var_72_10 and var_72_10.sprite then
					local var_72_11 = 2 * (var_72_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_9.transform.localScale = Vector3.New(var_72_11 / var_72_10.sprite.bounds.size.y < var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x and var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x or var_72_11 / var_72_10.sprite.bounds.size.y, var_72_11 / var_72_10.sprite.bounds.size.y < var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x and var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x or var_72_11 / var_72_10.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "D05" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_12 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_12 + 2.675 and arg_69_1.time_ < var_72_12 + 2.675 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			if 2.675 < arg_69_1.time_ and arg_69_1.time_ <= 2.675 + arg_72_0 then
				arg_69_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_72_15 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_15 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_15

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_15
						arg_69_1.bgmTxt2_.text = var_72_15
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_16 = 2.675
			local var_72_17 = 0.325

			if 2.675 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_18 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_18:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_69_1.dialogCg_.alpha = arg_74_0
				end))
				var_72_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_19 = arg_69_1:GetWordFromCfg(111171017)
				local var_72_20 = arg_69_1:FormatText(var_72_19.content)

				arg_69_1.text_.text = var_72_20

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_22 = 9 <= 0 and var_72_17 or var_72_17 * (utf8.len(var_72_20) / 9)

				if (9 <= 0 and var_72_17 or var_72_17 * (utf8.len(var_72_20) / 9)) > 0 and var_72_17 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22
					var_72_16 = var_72_16 + 0.3

					if var_72_22 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_16
					end
				end

				arg_69_1.text_.text = var_72_20
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171017", "story_v_out_111171.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_111171", "111171017", "story_v_out_111171.awb") / 1000

					if var_72_23 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_16
					end

					if var_72_19.prefab_name ~= "" and arg_69_1.actors_[var_72_19.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_19.prefab_name].transform, "story_v_out_111171", "111171017", "story_v_out_111171.awb")

						arg_69_1:RecordAudio("111171017", var_72_24)
						arg_69_1:RecordAudio("111171017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_111171", "111171017", "story_v_out_111171.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_111171", "111171017", "story_v_out_111171.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = var_72_16 + 0.3
			local var_72_26 = math.max(var_72_17, arg_69_1.talkMaxDuration)

			if var_72_16 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_25 + var_72_26 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_25) / var_72_26

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_25 + var_72_26 and arg_69_1.time_ < var_72_25 + var_72_26 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play111171018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111171018
		arg_76_1.duration_ = 6.97

		local var_76_0 = {
			ja = 6.966,
			ko = 3.666,
			zh = 5.5,
			en = 5.533
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play111171019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0.4 < arg_76_1.time_ and arg_76_1.time_ <= 0.4 + arg_79_0 then
				arg_76_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_79_0 = 0.6

			if 0.4 <= arg_76_1.time_ and arg_76_1.time_ < 0.4 + var_79_0 then
				local var_79_1, var_79_2 = math.modf((arg_76_1.time_ - 0.4) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_79_2 * 0.13, var_79_2 * 0.13, var_79_2 * 0.13) + arg_76_1.var_.shakeOldPos
			end

			if arg_76_1.time_ >= 0.4 + var_79_0 and arg_76_1.time_ < 0.4 + var_79_0 + arg_79_0 then
				manager.ui.mainCamera.transform.localPosition = arg_76_1.var_.shakeOldPos
			end

			local var_79_3 = 0
			local var_79_4 = 0.55

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_5 = arg_76_1:GetWordFromCfg(111171018)
				local var_79_6 = arg_76_1:FormatText(var_79_5.content)

				arg_76_1.text_.text = var_79_6

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_8 = 18 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_6) / 18)

				if (18 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_6) / 18)) > 0 and var_79_4 < var_79_8 then
					arg_76_1.talkMaxDuration = var_79_8

					if var_79_8 + var_79_3 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_3
					end
				end

				arg_76_1.text_.text = var_79_6
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171018", "story_v_out_111171.awb") ~= 0 then
					local var_79_9 = manager.audio:GetVoiceLength("story_v_out_111171", "111171018", "story_v_out_111171.awb") / 1000

					if var_79_9 + var_79_3 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_3
					end

					if var_79_5.prefab_name ~= "" and arg_76_1.actors_[var_79_5.prefab_name] ~= nil then
						local var_79_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_5.prefab_name].transform, "story_v_out_111171", "111171018", "story_v_out_111171.awb")

						arg_76_1:RecordAudio("111171018", var_79_10)
						arg_76_1:RecordAudio("111171018", var_79_10)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_111171", "111171018", "story_v_out_111171.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_111171", "111171018", "story_v_out_111171.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_11 = math.max(var_79_4, arg_76_1.talkMaxDuration)

			if var_79_3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_3 + var_79_11 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_3) / var_79_11

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_3 + var_79_11 and arg_76_1.time_ < var_79_3 + var_79_11 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play111171019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 111171019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play111171020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 1.15

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

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(111171019).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 46 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 46)

				if (46 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 46)) > 0 and var_83_0 < var_83_3 then
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
	Play111171020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 111171020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play111171021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.65

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(111171020).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 26 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 26)

				if (26 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 26)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play111171021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 111171021
		arg_88_1.duration_ = 2.87

		local var_88_0 = {
			ja = 1.933,
			ko = 2.866,
			zh = 2.4,
			en = 2.3
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
				arg_88_0:Play111171022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "se_story", "se_story_fight_metal", "")
			end

			local var_91_1 = 0
			local var_91_2 = 0.25

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_3 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_3:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_4 = arg_88_1:GetWordFromCfg(111171021)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 10 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_5) / 10)

				if (10 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_5) / 10)) > 0 and var_91_2 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7
					var_91_1 = var_91_1 + 0.3

					if var_91_7 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171021", "story_v_out_111171.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_111171", "111171021", "story_v_out_111171.awb") / 1000

					if var_91_8 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_1
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_111171", "111171021", "story_v_out_111171.awb")

						arg_88_1:RecordAudio("111171021", var_91_9)
						arg_88_1:RecordAudio("111171021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_111171", "111171021", "story_v_out_111171.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_111171", "111171021", "story_v_out_111171.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = var_91_1 + 0.3
			local var_91_11 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_10) / var_91_11

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play111171022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111171022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play111171023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.025

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(111171022).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 41 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 41)

				if (41 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 41)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111171023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111171023
		arg_98_1.duration_ = 7.1

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111171024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if arg_98_1.bgs_.AS0108 == nil then
				local var_101_0 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "AS0108")
				var_101_0.name = "AS0108"
				var_101_0.transform.parent = arg_98_1.stage_.transform
				var_101_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_.AS0108 = var_101_0
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				local var_101_1 = arg_98_1.bgs_.AS0108:GetComponent("SpriteRenderer")

				if var_101_1 then
					arg_98_1.var_.alphaOldValueAS0108 = var_101_1.color.a
					arg_98_1.var_.alphaMatValueAS0108 = var_101_1
				end

				arg_98_1.var_.alphaOldValueAS0108 = 0
			end

			local var_101_2 = 1.5

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 then
				if arg_98_1.var_.alphaMatValueAS0108 then
					arg_98_1.var_.alphaMatValueAS0108.color.a = Mathf.Lerp(arg_98_1.var_.alphaOldValueAS0108, 1, (arg_98_1.time_ - 0) / var_101_2)
					arg_98_1.var_.alphaMatValueAS0108.color = arg_98_1.var_.alphaMatValueAS0108.color
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and arg_98_1.var_.alphaMatValueAS0108 then
				arg_98_1.var_.alphaMatValueAS0108.color.a = 1
				arg_98_1.var_.alphaMatValueAS0108.color = arg_98_1.var_.alphaMatValueAS0108.color
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				local var_101_3 = arg_98_1.bgs_.AS0108

				arg_98_1.bgs_.AS0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_101_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_4 = var_101_3:GetComponent("SpriteRenderer")

				if var_101_4 and var_101_4.sprite then
					local var_101_5 = 2 * (var_101_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_101_3.transform.localScale = Vector3.New(var_101_5 / var_101_4.sprite.bounds.size.y < var_101_5 * manager.ui.mainCameraCom_.aspect / var_101_4.sprite.bounds.size.x and var_101_5 * manager.ui.mainCameraCom_.aspect / var_101_4.sprite.bounds.size.x or var_101_5 / var_101_4.sprite.bounds.size.y, var_101_5 / var_101_4.sprite.bounds.size.y < var_101_5 * manager.ui.mainCameraCom_.aspect / var_101_4.sprite.bounds.size.x and var_101_5 * manager.ui.mainCameraCom_.aspect / var_101_4.sprite.bounds.size.x or var_101_5 / var_101_4.sprite.bounds.size.y, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "AS0108" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_6 = manager.ui.mainCamera.transform

			if 1.5 < arg_98_1.time_ and arg_98_1.time_ <= 1.5 + arg_101_0 then
				arg_98_1.var_.shakeOldPos = var_101_6.localPosition
			end

			local var_101_7 = 0.6

			if 1.5 <= arg_98_1.time_ and arg_98_1.time_ < 1.5 + var_101_7 then
				local var_101_8, var_101_9 = math.modf((arg_98_1.time_ - 1.5) / 0.066)

				var_101_6.localPosition = Vector3.New(var_101_9 * 0.13, var_101_9 * 0.13, var_101_9 * 0.13) + arg_98_1.var_.shakeOldPos
			end

			if arg_98_1.time_ >= 1.5 + var_101_7 and arg_98_1.time_ < 1.5 + var_101_7 + arg_101_0 then
				var_101_6.localPosition = arg_98_1.var_.shakeOldPos
			end

			local var_101_10 = arg_98_1.bgs_.AS0108.transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPosAS0108 = var_101_10.localPosition
			end

			local var_101_11 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_11 then
				var_101_10.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPosAS0108, Vector3.New(0.5, 1, 8), (arg_98_1.time_ - 0) / var_101_11)
			end

			if arg_98_1.time_ >= 0 + var_101_11 and arg_98_1.time_ < 0 + var_101_11 + arg_101_0 then
				var_101_10.localPosition = Vector3.New(0.5, 1, 8)
			end

			local var_101_12 = arg_98_1.bgs_.AS0108.transform

			if 0.034 < arg_98_1.time_ and arg_98_1.time_ <= 0.034 + arg_101_0 then
				arg_98_1.var_.moveOldPosAS0108 = var_101_12.localPosition
			end

			local var_101_13 = 2.066

			if 0.034 <= arg_98_1.time_ and arg_98_1.time_ < 0.034 + var_101_13 then
				var_101_12.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPosAS0108, Vector3.New(0, 1, 10), (arg_98_1.time_ - 0.034) / var_101_13)
			end

			if arg_98_1.time_ >= 0.034 + var_101_13 and arg_98_1.time_ < 0.034 + var_101_13 + arg_101_0 then
				var_101_12.localPosition = Vector3.New(0, 1, 10)
			end

			local var_101_14 = 0

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			if arg_98_1.time_ >= var_101_14 + 2.1 and arg_98_1.time_ < var_101_14 + 2.1 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_15 = 1.3

			if 1.3 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = false

				arg_98_1:SetGaussion(false)
			end

			local var_101_16 = 0.5

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_16 then
				local var_101_17 = Color.New(1, 1, 1)

				var_101_17.a = Mathf.Lerp(1, 0, (arg_98_1.time_ - var_101_15) / var_101_16)
				arg_98_1.mask_.color = var_101_17
			end

			if arg_98_1.time_ >= var_101_15 + var_101_16 and arg_98_1.time_ < var_101_15 + var_101_16 + arg_101_0 then
				local var_101_18 = Color.New(1, 1, 1)

				arg_98_1.mask_.enabled = false
				var_101_18.a = 0
				arg_98_1.mask_.color = var_101_18
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_19 = 2.1
			local var_101_20 = 1.35

			if 2.1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_21 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_21:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_22 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(111171023).content)

				arg_98_1.text_.text = var_101_22

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_24 = 54 <= 0 and var_101_20 or var_101_20 * (utf8.len(var_101_22) / 54)

				if (54 <= 0 and var_101_20 or var_101_20 * (utf8.len(var_101_22) / 54)) > 0 and var_101_20 < var_101_24 then
					arg_98_1.talkMaxDuration = var_101_24
					var_101_19 = var_101_19 + 0.3

					if var_101_24 + var_101_19 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_19
					end
				end

				arg_98_1.text_.text = var_101_22
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_25 = var_101_19 + 0.3
			local var_101_26 = math.max(var_101_20, arg_98_1.talkMaxDuration)

			if var_101_19 + 0.3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_25 + var_101_26 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_25) / var_101_26

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_25 + var_101_26 and arg_98_1.time_ < var_101_25 + var_101_26 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "AS0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "AS0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.066,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play111171024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 111171024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play111171025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.875

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(111171024).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 35 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 35)

				if (35 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 35)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play111171025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 111171025
		arg_108_1.duration_ = 2.13

		local var_108_0 = {
			ja = 1.2,
			ko = 1.2,
			zh = 2.133,
			en = 1.333
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play111171026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.125

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:GetWordFromCfg(111171025)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 5 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 5)

				if (5 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 5)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171025", "story_v_out_111171.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_111171", "111171025", "story_v_out_111171.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_111171", "111171025", "story_v_out_111171.awb")

						arg_108_1:RecordAudio("111171025", var_111_6)
						arg_108_1:RecordAudio("111171025", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_111171", "111171025", "story_v_out_111171.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_111171", "111171025", "story_v_out_111171.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play111171026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 111171026
		arg_112_1.duration_ = 6.4

		local var_112_0 = {
			ja = 3.033,
			ko = 1.433,
			zh = 6.4,
			en = 0.966
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
				arg_112_0:Play111171027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.225

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:GetWordFromCfg(111171026)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 4 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 4)

				if (4 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 4)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171026", "story_v_out_111171.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_111171", "111171026", "story_v_out_111171.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_111171", "111171026", "story_v_out_111171.awb")

						arg_112_1:RecordAudio("111171026", var_115_6)
						arg_112_1:RecordAudio("111171026", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_111171", "111171026", "story_v_out_111171.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_111171", "111171026", "story_v_out_111171.awb")
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
	Play111171027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 111171027
		arg_116_1.duration_ = 16.97

		local var_116_0 = {
			ja = 16.966,
			ko = 11.933,
			zh = 16.633,
			en = 12.1
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
				arg_116_0:Play111171028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 1 < arg_116_1.time_ and arg_116_1.time_ <= 1 + arg_119_0 then
				local var_119_0 = arg_116_1.bgs_.D05

				arg_116_1.bgs_.D05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_119_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_1 = var_119_0:GetComponent("SpriteRenderer")

				if var_119_1 and var_119_1.sprite then
					local var_119_2 = 2 * (var_119_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_119_0.transform.localScale = Vector3.New(var_119_2 / var_119_1.sprite.bounds.size.y < var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x and var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x or var_119_2 / var_119_1.sprite.bounds.size.y, var_119_2 / var_119_1.sprite.bounds.size.y < var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x and var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x or var_119_2 / var_119_1.sprite.bounds.size.y, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "D05" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				local var_119_3 = arg_116_1.bgs_.AS0108:GetComponent("SpriteRenderer")

				if var_119_3 then
					arg_116_1.var_.alphaOldValueAS0108 = var_119_3.color.a
					arg_116_1.var_.alphaMatValueAS0108 = var_119_3
				end

				arg_116_1.var_.alphaOldValueAS0108 = 1
			end

			local var_119_4 = 1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				if arg_116_1.var_.alphaMatValueAS0108 then
					arg_116_1.var_.alphaMatValueAS0108.color.a = Mathf.Lerp(arg_116_1.var_.alphaOldValueAS0108, 0, (arg_116_1.time_ - 0) / var_119_4)
					arg_116_1.var_.alphaMatValueAS0108.color = arg_116_1.var_.alphaMatValueAS0108.color
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and arg_116_1.var_.alphaMatValueAS0108 then
				arg_116_1.var_.alphaMatValueAS0108.color.a = 0
				arg_116_1.var_.alphaMatValueAS0108.color = arg_116_1.var_.alphaMatValueAS0108.color
			end

			if 1 < arg_116_1.time_ and arg_116_1.time_ <= 1 + arg_119_0 then
				local var_119_5 = arg_116_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_119_5 then
					arg_116_1.var_.alphaOldValueD05 = var_119_5.color.a
					arg_116_1.var_.alphaMatValueD05 = var_119_5
				end

				arg_116_1.var_.alphaOldValueD05 = 0
			end

			local var_119_6 = 1

			if 1 <= arg_116_1.time_ and arg_116_1.time_ < 1 + var_119_6 then
				if arg_116_1.var_.alphaMatValueD05 then
					arg_116_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_116_1.var_.alphaOldValueD05, 1, (arg_116_1.time_ - 1) / var_119_6)
					arg_116_1.var_.alphaMatValueD05.color = arg_116_1.var_.alphaMatValueD05.color
				end
			end

			if arg_116_1.time_ >= 1 + var_119_6 and arg_116_1.time_ < 1 + var_119_6 + arg_119_0 and arg_116_1.var_.alphaMatValueD05 then
				arg_116_1.var_.alphaMatValueD05.color.a = 1
				arg_116_1.var_.alphaMatValueD05.color = arg_116_1.var_.alphaMatValueD05.color
			end

			local var_119_7 = "1096ui_story"

			if arg_116_1.actors_["1096ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1096ui_story"))) then
				local var_119_8 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_116_1.stage_.transform)

				var_119_8.name = var_119_7
				var_119_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_[var_119_7] = var_119_8

				local var_119_9 = var_119_8:GetComponentInChildren(typeof(CharacterEffect))

				var_119_9.enabled = true

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_8, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(false)
				end

				arg_116_1:ShowWeapon(var_119_9.transform, false)

				arg_116_1.var_[var_119_7 .. "Animator"] = var_119_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_116_1.var_[var_119_7 .. "Animator"].applyRootMotion = true
				arg_116_1.var_[var_119_7 .. "LipSync"] = var_119_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_119_11 = arg_116_1.actors_["1096ui_story"].transform

			if 1.8 < arg_116_1.time_ and arg_116_1.time_ <= 1.8 + arg_119_0 then
				arg_116_1.var_.moveOldPos1096ui_story = var_119_11.localPosition
			end

			local var_119_12 = 0.1

			if 1.8 <= arg_116_1.time_ and arg_116_1.time_ < 1.8 + var_119_12 then
				var_119_11.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_116_1.time_ - 1.8) / var_119_12)
				var_119_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_11.position).x, (manager.ui.mainCamera.transform.position - var_119_11.position).y, (manager.ui.mainCamera.transform.position - var_119_11.position).z)
				var_119_11.localEulerAngles.z = 0
				var_119_11.localEulerAngles.x = 0
				var_119_11.localEulerAngles = var_119_11.localEulerAngles
			end

			if arg_116_1.time_ >= 1.8 + var_119_12 and arg_116_1.time_ < 1.8 + var_119_12 + arg_119_0 then
				var_119_11.localPosition = Vector3.New(0, -1.13, -5.6)
				var_119_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_11.position).x, (manager.ui.mainCamera.transform.position - var_119_11.position).y, (manager.ui.mainCamera.transform.position - var_119_11.position).z)
				var_119_11.localEulerAngles.z = 0
				var_119_11.localEulerAngles.x = 0
				var_119_11.localEulerAngles = var_119_11.localEulerAngles
			end

			if 1.8 < arg_116_1.time_ and arg_116_1.time_ <= 1.8 + arg_119_0 then
				arg_116_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			if 1.8 < arg_116_1.time_ and arg_116_1.time_ <= 1.8 + arg_119_0 then
				arg_116_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_119_13 = arg_116_1.actors_["1096ui_story"]

			if 1.8 < arg_116_1.time_ and arg_116_1.time_ <= 1.8 + arg_119_0 and not isNil(var_119_13) and arg_116_1.var_.characterEffect1096ui_story == nil then
				arg_116_1.var_.characterEffect1096ui_story = var_119_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_14 = 0.2

			if 1.8 <= arg_116_1.time_ and arg_116_1.time_ < 1.8 + var_119_14 and not isNil(var_119_13) then
				if arg_116_1.var_.characterEffect1096ui_story and not isNil(var_119_13) then
					arg_116_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 1.8 + var_119_14 and arg_116_1.time_ < 1.8 + var_119_14 + arg_119_0 and not isNil(var_119_13) and arg_116_1.var_.characterEffect1096ui_story then
				arg_116_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_119_16 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= var_119_16 + 2 and arg_116_1.time_ < var_119_16 + 2 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_17 = 2
			local var_119_18 = 1.025

			if 2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_19 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_19:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_20 = arg_116_1:GetWordFromCfg(111171027)
				local var_119_21 = arg_116_1:FormatText(var_119_20.content)

				arg_116_1.text_.text = var_119_21

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_23 = 41 <= 0 and var_119_18 or var_119_18 * (utf8.len(var_119_21) / 41)

				if (41 <= 0 and var_119_18 or var_119_18 * (utf8.len(var_119_21) / 41)) > 0 and var_119_18 < var_119_23 then
					arg_116_1.talkMaxDuration = var_119_23
					var_119_17 = var_119_17 + 0.3

					if var_119_23 + var_119_17 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_17
					end
				end

				arg_116_1.text_.text = var_119_21
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171027", "story_v_out_111171.awb") ~= 0 then
					local var_119_24 = manager.audio:GetVoiceLength("story_v_out_111171", "111171027", "story_v_out_111171.awb") / 1000

					if var_119_24 + var_119_17 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_24 + var_119_17
					end

					if var_119_20.prefab_name ~= "" and arg_116_1.actors_[var_119_20.prefab_name] ~= nil then
						local var_119_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_20.prefab_name].transform, "story_v_out_111171", "111171027", "story_v_out_111171.awb")

						arg_116_1:RecordAudio("111171027", var_119_25)
						arg_116_1:RecordAudio("111171027", var_119_25)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_111171", "111171027", "story_v_out_111171.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_111171", "111171027", "story_v_out_111171.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_26 = var_119_17 + 0.3
			local var_119_27 = math.max(var_119_18, arg_116_1.talkMaxDuration)

			if var_119_17 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_26 + var_119_27 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_26) / var_119_27

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_26 + var_119_27 and arg_116_1.time_ < var_119_26 + var_119_27 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play111171028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 111171028
		arg_122_1.duration_ = 8.1

		local var_122_0 = {
			ja = 4.6,
			ko = 3.6,
			zh = 8.1,
			en = 6.833
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
				arg_122_0:Play111171029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1096ui_story"]) and arg_122_1.var_.characterEffect1096ui_story == nil then
				arg_122_1.var_.characterEffect1096ui_story = arg_122_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1096ui_story"]) then
				if arg_122_1.var_.characterEffect1096ui_story and not isNil(arg_122_1.actors_["1096ui_story"]) then
					arg_122_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1096ui_story"]) and arg_122_1.var_.characterEffect1096ui_story then
				arg_122_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_125_1 = 0
			local var_125_2 = 0.425

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(111171028)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 13 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 13)

				if (13 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 13)) > 0 and var_125_2 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171028", "story_v_out_111171.awb") ~= 0 then
					local var_125_7 = manager.audio:GetVoiceLength("story_v_out_111171", "111171028", "story_v_out_111171.awb") / 1000

					if var_125_7 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_1
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_111171", "111171028", "story_v_out_111171.awb")

						arg_122_1:RecordAudio("111171028", var_125_8)
						arg_122_1:RecordAudio("111171028", var_125_8)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_111171", "111171028", "story_v_out_111171.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_111171", "111171028", "story_v_out_111171.awb")
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
	Play111171029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 111171029
		arg_126_1.duration_ = 7.2

		local var_126_0 = {
			ja = 3.4,
			ko = 7.2,
			zh = 5.3,
			en = 5.5
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
				arg_126_0:Play111171030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_2")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_129_0 = arg_126_1.actors_["1096ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1096ui_story == nil then
				arg_126_1.var_.characterEffect1096ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_1 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_1 and not isNil(var_129_0) then
				if arg_126_1.var_.characterEffect1096ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_1 and arg_126_1.time_ < 0 + var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1096ui_story then
				arg_126_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_129_3 = 0
			local var_129_4 = 0.6

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_3 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_5 = arg_126_1:GetWordFromCfg(111171029)
				local var_129_6 = arg_126_1:FormatText(var_129_5.content)

				arg_126_1.text_.text = var_129_6

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_8 = 24 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_6) / 24)

				if (24 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_6) / 24)) > 0 and var_129_4 < var_129_8 then
					arg_126_1.talkMaxDuration = var_129_8

					if var_129_8 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_3
					end
				end

				arg_126_1.text_.text = var_129_6
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171029", "story_v_out_111171.awb") ~= 0 then
					local var_129_9 = manager.audio:GetVoiceLength("story_v_out_111171", "111171029", "story_v_out_111171.awb") / 1000

					if var_129_9 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_3
					end

					if var_129_5.prefab_name ~= "" and arg_126_1.actors_[var_129_5.prefab_name] ~= nil then
						local var_129_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_5.prefab_name].transform, "story_v_out_111171", "111171029", "story_v_out_111171.awb")

						arg_126_1:RecordAudio("111171029", var_129_10)
						arg_126_1:RecordAudio("111171029", var_129_10)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_111171", "111171029", "story_v_out_111171.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_111171", "111171029", "story_v_out_111171.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_11 = math.max(var_129_4, arg_126_1.talkMaxDuration)

			if var_129_3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_3 + var_129_11 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_3) / var_129_11

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_3 + var_129_11 and arg_126_1.time_ < var_129_3 + var_129_11 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play111171030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 111171030
		arg_130_1.duration_ = 8.13

		local var_130_0 = {
			ja = 8.133,
			ko = 7.733,
			zh = 5.3,
			en = 4.966
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
				arg_130_0:Play111171031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_133_0 = 0
			local var_133_1 = 0.775

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(111171030)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 31 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 31)

				if (31 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 31)) > 0 and var_133_1 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171030", "story_v_out_111171.awb") ~= 0 then
					local var_133_6 = manager.audio:GetVoiceLength("story_v_out_111171", "111171030", "story_v_out_111171.awb") / 1000

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end

					if var_133_2.prefab_name ~= "" and arg_130_1.actors_[var_133_2.prefab_name] ~= nil then
						local var_133_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_2.prefab_name].transform, "story_v_out_111171", "111171030", "story_v_out_111171.awb")

						arg_130_1:RecordAudio("111171030", var_133_7)
						arg_130_1:RecordAudio("111171030", var_133_7)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_111171", "111171030", "story_v_out_111171.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_111171", "111171030", "story_v_out_111171.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_8 and arg_130_1.time_ < var_133_0 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play111171031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111171031
		arg_134_1.duration_ = 5.33

		local var_134_0 = {
			ja = 2.633,
			ko = 3.866,
			zh = 5.333,
			en = 4.833
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
				arg_134_0:Play111171032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1096ui_story"]) and arg_134_1.var_.characterEffect1096ui_story == nil then
				arg_134_1.var_.characterEffect1096ui_story = arg_134_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1096ui_story"]) then
				if arg_134_1.var_.characterEffect1096ui_story and not isNil(arg_134_1.actors_["1096ui_story"]) then
					arg_134_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1096ui_story"]) and arg_134_1.var_.characterEffect1096ui_story then
				arg_134_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.575

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(111171031)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_6 = 19 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_4) / 19)

				if (19 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_4) / 19)) > 0 and var_137_2 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171031", "story_v_out_111171.awb") ~= 0 then
					local var_137_7 = manager.audio:GetVoiceLength("story_v_out_111171", "111171031", "story_v_out_111171.awb") / 1000

					if var_137_7 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_1
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_111171", "111171031", "story_v_out_111171.awb")

						arg_134_1:RecordAudio("111171031", var_137_8)
						arg_134_1:RecordAudio("111171031", var_137_8)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_111171", "111171031", "story_v_out_111171.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_111171", "111171031", "story_v_out_111171.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_9 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_9 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_9

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_9 and arg_134_1.time_ < var_137_1 + var_137_9 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play111171032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 111171032
		arg_138_1.duration_ = 4.63

		local var_138_0 = {
			ja = 4.633,
			ko = 4.633,
			zh = 4.1,
			en = 3.4
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
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_141_0 = arg_138_1.actors_["1096ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1096ui_story == nil then
				arg_138_1.var_.characterEffect1096ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_1 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 and not isNil(var_141_0) then
				if arg_138_1.var_.characterEffect1096ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1096ui_story then
				arg_138_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_141_3 = 0
			local var_141_4 = 0.475

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_5 = arg_138_1:GetWordFromCfg(111171032)
				local var_141_6 = arg_138_1:FormatText(var_141_5.content)

				arg_138_1.text_.text = var_141_6

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_8 = 17 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 17)

				if (17 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 17)) > 0 and var_141_4 < var_141_8 then
					arg_138_1.talkMaxDuration = var_141_8

					if var_141_8 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_3
					end
				end

				arg_138_1.text_.text = var_141_6
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171032", "story_v_out_111171.awb") ~= 0 then
					local var_141_9 = manager.audio:GetVoiceLength("story_v_out_111171", "111171032", "story_v_out_111171.awb") / 1000

					if var_141_9 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_3
					end

					if var_141_5.prefab_name ~= "" and arg_138_1.actors_[var_141_5.prefab_name] ~= nil then
						local var_141_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_5.prefab_name].transform, "story_v_out_111171", "111171032", "story_v_out_111171.awb")

						arg_138_1:RecordAudio("111171032", var_141_10)
						arg_138_1:RecordAudio("111171032", var_141_10)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_111171", "111171032", "story_v_out_111171.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_111171", "111171032", "story_v_out_111171.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_11 = math.max(var_141_4, arg_138_1.talkMaxDuration)

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_11 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_3) / var_141_11

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_3 + var_141_11 and arg_138_1.time_ < var_141_3 + var_141_11 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/D05",
		"TextureConfig/Background/AS0108"
	},
	voices = {
		"story_v_out_111171.awb"
	}
}
