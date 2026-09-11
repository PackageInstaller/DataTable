return {
	Play106604001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106604001
		arg_1_1.duration_ = 4.07

		local var_1_0 = {
			ja = 3.066,
			ko = 4.066,
			en = 3.2
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
				arg_1_0:Play106604002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_0.name = "1084ui_story"
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_["1084ui_story"] = var_4_0

				local var_4_1 = var_4_0:GetComponentInChildren(typeof(CharacterEffect))

				var_4_1.enabled = true

				local var_4_2 = GameObjectTools.GetOrAddComponent(var_4_0, typeof(DynamicBoneHelper))

				if var_4_2 then
					var_4_2:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_1.transform, false)

				arg_1_1.var_["1084ui_story" .. "Animator"] = var_4_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_1_1.var_["1084ui_story" .. "LipSync"] = var_4_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_3 = arg_1_1.actors_["1084ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_4 = 0.1

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 and not isNil(var_4_3) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_3) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_6 = "B10a"

			if arg_1_1.bgs_.B10a == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_8 = arg_1_1.bgs_.B10a

				arg_1_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_9 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_9 and var_4_9.sprite then
					local var_4_10 = 2 * (var_4_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_8.transform.localScale = Vector3.New(var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_11 = arg_1_1.actors_["1084ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_11.localPosition
			end

			local var_4_12 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_12 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_1_1.time_ - 0) / var_4_12)
				var_4_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_11.position).x, (manager.ui.mainCamera.transform.position - var_4_11.position).y, (manager.ui.mainCamera.transform.position - var_4_11.position).z)
				var_4_11.localEulerAngles.z = 0
				var_4_11.localEulerAngles.x = 0
				var_4_11.localEulerAngles = var_4_11.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_12 and arg_1_1.time_ < 0 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -1.16, -5)
				var_4_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_11.position).x, (manager.ui.mainCamera.transform.position - var_4_11.position).y, (manager.ui.mainCamera.transform.position - var_4_11.position).z)
				var_4_11.localEulerAngles.z = 0
				var_4_11.localEulerAngles.x = 0
				var_4_11.localEulerAngles = var_4_11.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			local var_4_19 = 0
			local var_4_20 = 0.4

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:GetWordFromCfg(106604001)
				local var_4_23 = arg_1_1:FormatText(var_4_22.content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 16 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 16)

				if (16 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 16)) > 0 and var_4_20 < var_4_25 then
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

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604001", "story_v_side_old_106604.awb") ~= 0 then
					local var_4_26 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604001", "story_v_side_old_106604.awb") / 1000

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end

					if var_4_22.prefab_name ~= "" and arg_1_1.actors_[var_4_22.prefab_name] ~= nil then
						local var_4_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_22.prefab_name].transform, "story_v_side_old_106604", "106604001", "story_v_side_old_106604.awb")

						arg_1_1:RecordAudio("106604001", var_4_27)
						arg_1_1:RecordAudio("106604001", var_4_27)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604001", "story_v_side_old_106604.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604001", "story_v_side_old_106604.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play106604002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 106604002
		arg_9_1.duration_ = 9.03

		local var_9_0 = {
			ja = 5.966,
			ko = 6.633,
			en = 9.033
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play106604003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_0 = 0
			local var_12_1 = 0.675

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(106604002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 27 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 27)

				if (27 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 27)) > 0 and var_12_1 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604002", "story_v_side_old_106604.awb") ~= 0 then
					local var_12_6 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604002", "story_v_side_old_106604.awb") / 1000

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end

					if var_12_2.prefab_name ~= "" and arg_9_1.actors_[var_12_2.prefab_name] ~= nil then
						local var_12_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_2.prefab_name].transform, "story_v_side_old_106604", "106604002", "story_v_side_old_106604.awb")

						arg_9_1:RecordAudio("106604002", var_12_7)
						arg_9_1:RecordAudio("106604002", var_12_7)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604002", "story_v_side_old_106604.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604002", "story_v_side_old_106604.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play106604003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 106604003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play106604004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = arg_13_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.1

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) then
				if arg_13_1.var_.characterEffect1084ui_story and not isNil(arg_13_1.actors_["1084ui_story"]) then
					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story then
				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(106604003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 16 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 16)

				if (16 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 16)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play106604004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 106604004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play106604005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(106604004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 45)

				if (45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 45)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play106604005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 106604005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play106604006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(106604005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 66 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 66)

				if (66 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 66)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play106604006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 106604006
		arg_25_1.duration_ = 14.17

		local var_25_0 = {
			ja = 7.133,
			ko = 11.633,
			en = 14.166
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
				arg_25_0:Play106604007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = arg_25_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.1

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(arg_25_1.actors_["1084ui_story"]) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_28_2 = arg_25_1.bgs_.B10a.transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPosB10a = var_28_2.localPosition
			end

			local var_28_3 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosB10a, Vector3.New(0, -100, 10), (arg_25_1.time_ - 0) / var_28_3)
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -100, 10)
			end

			local var_28_4 = "B08e"

			if arg_25_1.bgs_.B08e == nil then
				local var_28_5 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_4)
				var_28_5.name = var_28_4
				var_28_5.transform.parent = arg_25_1.stage_.transform
				var_28_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_4] = var_28_5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_6 = arg_25_1.bgs_.B08e

				arg_25_1.bgs_.B08e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_7 = var_28_6:GetComponent("SpriteRenderer")

				if var_28_7 and var_28_7.sprite then
					local var_28_8 = 2 * (var_28_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_6.transform.localScale = Vector3.New(var_28_8 / var_28_7.sprite.bounds.size.y < var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x and var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x or var_28_8 / var_28_7.sprite.bounds.size.y, var_28_8 / var_28_7.sprite.bounds.size.y < var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x and var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x or var_28_8 / var_28_7.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "B08e" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action496")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_28_9 = 0
			local var_28_10 = 1.15

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_11 = arg_25_1:GetWordFromCfg(106604006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_14 = 46 <= 0 and var_28_10 or var_28_10 * (utf8.len(var_28_12) / 46)

				if (46 <= 0 and var_28_10 or var_28_10 * (utf8.len(var_28_12) / 46)) > 0 and var_28_10 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_9
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604006", "story_v_side_old_106604.awb") ~= 0 then
					local var_28_15 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604006", "story_v_side_old_106604.awb") / 1000

					if var_28_15 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_9
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_side_old_106604", "106604006", "story_v_side_old_106604.awb")

						arg_25_1:RecordAudio("106604006", var_28_16)
						arg_25_1:RecordAudio("106604006", var_28_16)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604006", "story_v_side_old_106604.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604006", "story_v_side_old_106604.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_17 = math.max(var_28_10, arg_25_1.talkMaxDuration)

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_9) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_9 + var_28_17 and arg_25_1.time_ < var_28_9 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B10a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play106604007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 106604007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play106604008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = arg_29_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.1

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) then
				if arg_29_1.var_.characterEffect1084ui_story and not isNil(arg_29_1.actors_["1084ui_story"]) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(106604007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 6 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 6)

				if (6 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 6)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play106604008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 106604008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play106604009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(106604008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 15 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 15)

				if (15 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 15)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play106604009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 106604009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play106604010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1084ui_story = arg_37_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).z)
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles = arg_37_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(20, -1.16, -5)
				arg_37_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).z)
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles = arg_37_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_40_1 = 0
			local var_40_2 = 0.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(106604009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 10 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 10)

				if (10 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 10)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play106604010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 106604010
		arg_41_1.duration_ = 7.1

		local var_41_0 = {
			ja = 7.1,
			ko = 4.466,
			en = 4.866
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
				arg_41_0:Play106604011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.575

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(106604010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 23 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 23)

				if (23 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 23)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604010", "story_v_side_old_106604.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604010", "story_v_side_old_106604.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_side_old_106604", "106604010", "story_v_side_old_106604.awb")

						arg_41_1:RecordAudio("106604010", var_44_6)
						arg_41_1:RecordAudio("106604010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604010", "story_v_side_old_106604.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604010", "story_v_side_old_106604.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play106604011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 106604011
		arg_45_1.duration_ = 15.6

		local var_45_0 = {
			ja = 15.6,
			ko = 11,
			en = 8.733
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play106604012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.05

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(106604011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 42 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 42)

				if (42 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 42)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604011", "story_v_side_old_106604.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604011", "story_v_side_old_106604.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_side_old_106604", "106604011", "story_v_side_old_106604.awb")

						arg_45_1:RecordAudio("106604011", var_48_6)
						arg_45_1:RecordAudio("106604011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604011", "story_v_side_old_106604.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604011", "story_v_side_old_106604.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play106604012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 106604012
		arg_49_1.duration_ = 8.5

		local var_49_0 = {
			ja = 6.566,
			ko = 8.5,
			en = 7.1
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
				arg_49_0:Play106604013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.725

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(106604012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 29 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 29)

				if (29 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 29)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604012", "story_v_side_old_106604.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604012", "story_v_side_old_106604.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_side_old_106604", "106604012", "story_v_side_old_106604.awb")

						arg_49_1:RecordAudio("106604012", var_52_6)
						arg_49_1:RecordAudio("106604012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604012", "story_v_side_old_106604.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604012", "story_v_side_old_106604.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play106604013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 106604013
		arg_53_1.duration_ = 7.5

		local var_53_0 = {
			ja = 5.366,
			ko = 3.566,
			en = 7.5
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
				arg_53_0:Play106604014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = arg_53_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) then
				if arg_53_1.var_.characterEffect1084ui_story and not isNil(arg_53_1.actors_["1084ui_story"]) then
					arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story then
				arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_56_2 = arg_53_1.actors_["1084ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1084ui_story = var_56_2.localPosition
			end

			local var_56_3 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_53_1.time_ - 0) / var_56_3)
				var_56_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_2.position).x, (manager.ui.mainCamera.transform.position - var_56_2.position).y, (manager.ui.mainCamera.transform.position - var_56_2.position).z)
				var_56_2.localEulerAngles.z = 0
				var_56_2.localEulerAngles.x = 0
				var_56_2.localEulerAngles = var_56_2.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -1.16, -5)
				var_56_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_2.position).x, (manager.ui.mainCamera.transform.position - var_56_2.position).y, (manager.ui.mainCamera.transform.position - var_56_2.position).z)
				var_56_2.localEulerAngles.z = 0
				var_56_2.localEulerAngles.x = 0
				var_56_2.localEulerAngles = var_56_2.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_4 = 0
			local var_56_5 = 0.5

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(106604013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 20 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 20)

				if (20 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 20)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604013", "story_v_side_old_106604.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604013", "story_v_side_old_106604.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_old_106604", "106604013", "story_v_side_old_106604.awb")

						arg_53_1:RecordAudio("106604013", var_56_11)
						arg_53_1:RecordAudio("106604013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604013", "story_v_side_old_106604.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604013", "story_v_side_old_106604.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play106604014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 106604014
		arg_57_1.duration_ = 0.1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"

			SetActive(arg_57_1.choicesGo_, true)

			for iter_58_0, iter_58_1 in ipairs(arg_57_1.choices_) do
				SetActive(iter_58_1.go, iter_58_0 <= 2)
			end

			arg_57_1.choices_[1].txt.text = arg_57_1:FormatText(StoryChoiceCfg[82].name)
			arg_57_1.choices_[2].txt.text = arg_57_1:FormatText(StoryChoiceCfg[83].name)
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play106604015(arg_57_1)
			end

			if arg_59_0 == 2 then
				arg_57_0:Play106604016(arg_57_1)
			end

			arg_57_1:RecordChoiceLog(106604014, 82, 83)
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = arg_57_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(arg_57_1.actors_["1084ui_story"]) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_60_1 = arg_57_1.actors_["1084ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1084ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(20, -1.16, -5)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play106604015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 106604015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play106604016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(106604015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 16 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 16)

				if (16 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 16)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play106604016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 106604016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play106604017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.55

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(106604016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 22 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 22)

				if (22 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 22)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play106604017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 106604017
		arg_69_1.duration_ = 7.5

		local var_69_0 = {
			ja = 5,
			ko = 7.5,
			en = 4.666
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
				arg_69_0:Play106604018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.65

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(106604017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 26 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 26)

				if (26 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 26)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604017", "story_v_side_old_106604.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604017", "story_v_side_old_106604.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_side_old_106604", "106604017", "story_v_side_old_106604.awb")

						arg_69_1:RecordAudio("106604017", var_72_6)
						arg_69_1:RecordAudio("106604017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604017", "story_v_side_old_106604.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604017", "story_v_side_old_106604.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play106604018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 106604018
		arg_73_1.duration_ = 4.7

		local var_73_0 = {
			ja = 1.8,
			ko = 2.9,
			en = 4.7
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play106604019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.375

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(106604018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 15 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 15)

				if (15 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 15)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604018", "story_v_side_old_106604.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604018", "story_v_side_old_106604.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_side_old_106604", "106604018", "story_v_side_old_106604.awb")

						arg_73_1:RecordAudio("106604018", var_76_6)
						arg_73_1:RecordAudio("106604018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604018", "story_v_side_old_106604.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604018", "story_v_side_old_106604.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play106604019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 106604019
		arg_77_1.duration_ = 8.03

		local var_77_0 = {
			ja = 7,
			ko = 6.266,
			en = 8.033
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play106604020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.575

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(106604019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 23 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 23)

				if (23 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 23)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604019", "story_v_side_old_106604.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604019", "story_v_side_old_106604.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_side_old_106604", "106604019", "story_v_side_old_106604.awb")

						arg_77_1:RecordAudio("106604019", var_80_6)
						arg_77_1:RecordAudio("106604019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604019", "story_v_side_old_106604.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604019", "story_v_side_old_106604.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play106604020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 106604020
		arg_81_1.duration_ = 8.47

		local var_81_0 = {
			ja = 8.466,
			ko = 5.466,
			en = 6.033
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play106604021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.875

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(106604020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 35 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 35)

				if (35 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 35)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604020", "story_v_side_old_106604.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604020", "story_v_side_old_106604.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_side_old_106604", "106604020", "story_v_side_old_106604.awb")

						arg_81_1:RecordAudio("106604020", var_84_6)
						arg_81_1:RecordAudio("106604020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604020", "story_v_side_old_106604.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604020", "story_v_side_old_106604.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play106604021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 106604021
		arg_85_1.duration_ = 9.97

		local var_85_0 = {
			ja = 9.966,
			ko = 6.733,
			en = 7.033
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play106604022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.775

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(106604021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 31 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 31)

				if (31 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 31)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604021", "story_v_side_old_106604.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604021", "story_v_side_old_106604.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_side_old_106604", "106604021", "story_v_side_old_106604.awb")

						arg_85_1:RecordAudio("106604021", var_88_6)
						arg_85_1:RecordAudio("106604021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604021", "story_v_side_old_106604.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604021", "story_v_side_old_106604.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play106604022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 106604022
		arg_89_1.duration_ = 6.5

		local var_89_0 = {
			ja = 4.6,
			ko = 5.166,
			en = 6.5
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play106604023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(106604022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)

				if (18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604022", "story_v_side_old_106604.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604022", "story_v_side_old_106604.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_side_old_106604", "106604022", "story_v_side_old_106604.awb")

						arg_89_1:RecordAudio("106604022", var_92_6)
						arg_89_1:RecordAudio("106604022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604022", "story_v_side_old_106604.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604022", "story_v_side_old_106604.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play106604023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 106604023
		arg_93_1.duration_ = 18.2

		local var_93_0 = {
			ja = 18.2,
			ko = 10.2,
			en = 13.733
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play106604024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.275

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(106604023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 51 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 51)

				if (51 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 51)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604023", "story_v_side_old_106604.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604023", "story_v_side_old_106604.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_side_old_106604", "106604023", "story_v_side_old_106604.awb")

						arg_93_1:RecordAudio("106604023", var_96_6)
						arg_93_1:RecordAudio("106604023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604023", "story_v_side_old_106604.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604023", "story_v_side_old_106604.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play106604024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 106604024
		arg_97_1.duration_ = 7.03

		local var_97_0 = {
			ja = 7.033,
			ko = 3.4,
			en = 4.6
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play106604025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = arg_97_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.1

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) then
				if arg_97_1.var_.characterEffect1084ui_story and not isNil(arg_97_1.actors_["1084ui_story"]) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_100_2 = arg_97_1.actors_["1084ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_2.localPosition
			end

			local var_100_3 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_97_1.time_ - 0) / var_100_3)
				var_100_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_2.position).x, (manager.ui.mainCamera.transform.position - var_100_2.position).y, (manager.ui.mainCamera.transform.position - var_100_2.position).z)
				var_100_2.localEulerAngles.z = 0
				var_100_2.localEulerAngles.x = 0
				var_100_2.localEulerAngles = var_100_2.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -1.16, -5)
				var_100_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_2.position).x, (manager.ui.mainCamera.transform.position - var_100_2.position).y, (manager.ui.mainCamera.transform.position - var_100_2.position).z)
				var_100_2.localEulerAngles.z = 0
				var_100_2.localEulerAngles.x = 0
				var_100_2.localEulerAngles = var_100_2.localEulerAngles
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(106604024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 14 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 14)

				if (14 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 14)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604024", "story_v_side_old_106604.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604024", "story_v_side_old_106604.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_old_106604", "106604024", "story_v_side_old_106604.awb")

						arg_97_1:RecordAudio("106604024", var_100_11)
						arg_97_1:RecordAudio("106604024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604024", "story_v_side_old_106604.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604024", "story_v_side_old_106604.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play106604025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 106604025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play106604026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = arg_101_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.1

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(arg_101_1.actors_["1084ui_story"]) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.15

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(106604025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 6 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 6)

				if (6 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 6)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play106604026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 106604026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play106604027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.9

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(106604026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 36 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 36)

				if (36 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 36)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play106604027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 106604027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play106604028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1084ui_story = arg_109_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).z)
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles = arg_109_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(20, -1.16, -5)
				arg_109_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).z)
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles = arg_109_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_112_1 = 0
			local var_112_2 = 0.55

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(106604027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 22 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 22)

				if (22 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 22)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play106604028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 106604028
		arg_113_1.duration_ = 10.97

		local var_113_0 = {
			ja = 3.9,
			ko = 6.233,
			en = 10.966
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play106604029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.625

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(106604028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 25 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 25)

				if (25 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 25)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604028", "story_v_side_old_106604.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604028", "story_v_side_old_106604.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_side_old_106604", "106604028", "story_v_side_old_106604.awb")

						arg_113_1:RecordAudio("106604028", var_116_6)
						arg_113_1:RecordAudio("106604028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604028", "story_v_side_old_106604.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604028", "story_v_side_old_106604.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play106604029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 106604029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play106604030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(106604029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 9 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 9)

				if (9 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 9)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play106604030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 106604030
		arg_121_1.duration_ = 2

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play106604031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1084ui_story"]) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = arg_121_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.1

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1084ui_story"]) then
				if arg_121_1.var_.characterEffect1084ui_story and not isNil(arg_121_1.actors_["1084ui_story"]) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1084ui_story"]) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1084ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1084ui_story = var_124_2.localPosition
			end

			local var_124_3 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_121_1.time_ - 0) / var_124_3)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -1.16, -5)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.05

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(106604030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 2 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 2)

				if (2 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 2)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604030", "story_v_side_old_106604.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604030", "story_v_side_old_106604.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_old_106604", "106604030", "story_v_side_old_106604.awb")

						arg_121_1:RecordAudio("106604030", var_124_11)
						arg_121_1:RecordAudio("106604030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604030", "story_v_side_old_106604.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604030", "story_v_side_old_106604.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play106604031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 106604031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play106604032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = arg_125_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.1

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) then
				if arg_125_1.var_.characterEffect1084ui_story and not isNil(arg_125_1.actors_["1084ui_story"]) then
					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story then
				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_128_1 = arg_125_1.bgs_.B08e.transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPosB08e = var_128_1.localPosition
			end

			local var_128_2 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 then
				var_128_1.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPosB08e, Vector3.New(0, -100, 10), (arg_125_1.time_ - 0) / var_128_2)
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 then
				var_128_1.localPosition = Vector3.New(0, -100, 10)
			end

			local var_128_3 = "B03f"

			if arg_125_1.bgs_.B03f == nil then
				local var_128_4 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_128_3)
				var_128_4.name = var_128_3
				var_128_4.transform.parent = arg_125_1.stage_.transform
				var_128_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_[var_128_3] = var_128_4
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				local var_128_5 = arg_125_1.bgs_.B03f

				arg_125_1.bgs_.B03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_6 = var_128_5:GetComponent("SpriteRenderer")

				if var_128_6 and var_128_6.sprite then
					local var_128_7 = 2 * (var_128_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_5.transform.localScale = Vector3.New(var_128_7 / var_128_6.sprite.bounds.size.y < var_128_7 * manager.ui.mainCameraCom_.aspect / var_128_6.sprite.bounds.size.x and var_128_7 * manager.ui.mainCameraCom_.aspect / var_128_6.sprite.bounds.size.x or var_128_7 / var_128_6.sprite.bounds.size.y, var_128_7 / var_128_6.sprite.bounds.size.y < var_128_7 * manager.ui.mainCameraCom_.aspect / var_128_6.sprite.bounds.size.x and var_128_7 * manager.ui.mainCameraCom_.aspect / var_128_6.sprite.bounds.size.x or var_128_7 / var_128_6.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "B03f" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_8 = arg_125_1.actors_["1084ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = var_128_8.localPosition
			end

			local var_128_9 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 then
				var_128_8.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_125_1.time_ - 0) / var_128_9)
				var_128_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_8.position).x, (manager.ui.mainCamera.transform.position - var_128_8.position).y, (manager.ui.mainCamera.transform.position - var_128_8.position).z)
				var_128_8.localEulerAngles.z = 0
				var_128_8.localEulerAngles.x = 0
				var_128_8.localEulerAngles = var_128_8.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 then
				var_128_8.localPosition = Vector3.New(20, -1.16, -5)
				var_128_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_8.position).x, (manager.ui.mainCamera.transform.position - var_128_8.position).y, (manager.ui.mainCamera.transform.position - var_128_8.position).z)
				var_128_8.localEulerAngles.z = 0
				var_128_8.localEulerAngles.x = 0
				var_128_8.localEulerAngles = var_128_8.localEulerAngles
			end

			local var_128_10 = 0
			local var_128_11 = 0.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_12 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(106604031).content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_14 = 10 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_12) / 10)

				if (10 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_12) / 10)) > 0 and var_128_11 < var_128_14 then
					arg_125_1.talkMaxDuration = var_128_14

					if var_128_14 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_10
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_15 = math.max(var_128_11, arg_125_1.talkMaxDuration)

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_15 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_10) / var_128_15

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_10 + var_128_15 and arg_125_1.time_ < var_128_10 + var_128_15 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B08e",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play106604032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 106604032
		arg_129_1.duration_ = 5.07

		local var_129_0 = {
			ja = 5.066,
			ko = 4.433,
			en = 4.933
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play106604033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.5

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(106604032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 20 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 20)

				if (20 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 20)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604032", "story_v_side_old_106604.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604032", "story_v_side_old_106604.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_side_old_106604", "106604032", "story_v_side_old_106604.awb")

						arg_129_1:RecordAudio("106604032", var_132_6)
						arg_129_1:RecordAudio("106604032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604032", "story_v_side_old_106604.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604032", "story_v_side_old_106604.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play106604033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 106604033
		arg_133_1.duration_ = 5.13

		local var_133_0 = {
			ja = 5.133,
			ko = 5.066,
			en = 4.5
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play106604034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.7

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(106604033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 28 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 28)

				if (28 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 28)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604033", "story_v_side_old_106604.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604033", "story_v_side_old_106604.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_side_old_106604", "106604033", "story_v_side_old_106604.awb")

						arg_133_1:RecordAudio("106604033", var_136_6)
						arg_133_1:RecordAudio("106604033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604033", "story_v_side_old_106604.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604033", "story_v_side_old_106604.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play106604034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 106604034
		arg_137_1.duration_ = 5.37

		local var_137_0 = {
			ja = 5.366,
			ko = 3.7,
			en = 3.9
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play106604035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = arg_137_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.1

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) then
				if arg_137_1.var_.characterEffect1084ui_story and not isNil(arg_137_1.actors_["1084ui_story"]) then
					arg_137_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story then
				arg_137_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["1084ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1084ui_story = var_140_2.localPosition
			end

			local var_140_3 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_137_1.time_ - 0) / var_140_3)
				var_140_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_2.position).x, (manager.ui.mainCamera.transform.position - var_140_2.position).y, (manager.ui.mainCamera.transform.position - var_140_2.position).z)
				var_140_2.localEulerAngles.z = 0
				var_140_2.localEulerAngles.x = 0
				var_140_2.localEulerAngles = var_140_2.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(0, -1.16, -5)
				var_140_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_2.position).x, (manager.ui.mainCamera.transform.position - var_140_2.position).y, (manager.ui.mainCamera.transform.position - var_140_2.position).z)
				var_140_2.localEulerAngles.z = 0
				var_140_2.localEulerAngles.x = 0
				var_140_2.localEulerAngles = var_140_2.localEulerAngles
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_140_4 = 0
			local var_140_5 = 0.225

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(106604034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 9 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 9)

				if (9 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 9)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604034", "story_v_side_old_106604.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604034", "story_v_side_old_106604.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_side_old_106604", "106604034", "story_v_side_old_106604.awb")

						arg_137_1:RecordAudio("106604034", var_140_11)
						arg_137_1:RecordAudio("106604034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604034", "story_v_side_old_106604.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604034", "story_v_side_old_106604.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play106604035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 106604035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play106604036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = arg_141_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.1

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) then
				if arg_141_1.var_.characterEffect1084ui_story and not isNil(arg_141_1.actors_["1084ui_story"]) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.125

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(106604035).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 5 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 5)

				if (5 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 5)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play106604036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 106604036
		arg_145_1.duration_ = 4.9

		local var_145_0 = {
			ja = 2.966,
			ko = 3.366,
			en = 4.9
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play106604037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1084ui_story = arg_145_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).z)
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles = arg_145_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(20, -1.16, -5)
				arg_145_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).z)
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles = arg_145_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_148_1 = 0
			local var_148_2 = 0.425

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(106604036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 17 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 17)

				if (17 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 17)) > 0 and var_148_2 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604036", "story_v_side_old_106604.awb") ~= 0 then
					local var_148_7 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604036", "story_v_side_old_106604.awb") / 1000

					if var_148_7 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_1
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_side_old_106604", "106604036", "story_v_side_old_106604.awb")

						arg_145_1:RecordAudio("106604036", var_148_8)
						arg_145_1:RecordAudio("106604036", var_148_8)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604036", "story_v_side_old_106604.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604036", "story_v_side_old_106604.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_9 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_9 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_9

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_9 and arg_145_1.time_ < var_148_1 + var_148_9 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play106604037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 106604037
		arg_149_1.duration_ = 6.7

		local var_149_0 = {
			ja = 6.6,
			ko = 4.566,
			en = 6.7
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play106604038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.725

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(106604037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 29 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 29)

				if (29 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 29)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604037", "story_v_side_old_106604.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604037", "story_v_side_old_106604.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_side_old_106604", "106604037", "story_v_side_old_106604.awb")

						arg_149_1:RecordAudio("106604037", var_152_6)
						arg_149_1:RecordAudio("106604037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604037", "story_v_side_old_106604.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604037", "story_v_side_old_106604.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play106604038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 106604038
		arg_153_1.duration_ = 4.37

		local var_153_0 = {
			ja = 3.466,
			ko = 2.8,
			en = 4.366
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play106604039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.325

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(106604038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 13 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 13)

				if (13 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 13)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604038", "story_v_side_old_106604.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604038", "story_v_side_old_106604.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_side_old_106604", "106604038", "story_v_side_old_106604.awb")

						arg_153_1:RecordAudio("106604038", var_156_6)
						arg_153_1:RecordAudio("106604038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604038", "story_v_side_old_106604.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604038", "story_v_side_old_106604.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play106604039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 106604039
		arg_157_1.duration_ = 3.27

		local var_157_0 = {
			ja = 1.6,
			ko = 1.333,
			en = 3.266
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play106604040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.15

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(106604039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 6 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 6)

				if (6 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 6)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604039", "story_v_side_old_106604.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604039", "story_v_side_old_106604.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_side_old_106604", "106604039", "story_v_side_old_106604.awb")

						arg_157_1:RecordAudio("106604039", var_160_6)
						arg_157_1:RecordAudio("106604039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604039", "story_v_side_old_106604.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604039", "story_v_side_old_106604.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play106604040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 106604040
		arg_161_1.duration_ = 11.03

		local var_161_0 = {
			ja = 5.466,
			ko = 9.133,
			en = 11.033
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play106604041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.025

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(106604040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 41 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 41)

				if (41 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 41)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604040", "story_v_side_old_106604.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604040", "story_v_side_old_106604.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_side_old_106604", "106604040", "story_v_side_old_106604.awb")

						arg_161_1:RecordAudio("106604040", var_164_6)
						arg_161_1:RecordAudio("106604040", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604040", "story_v_side_old_106604.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604040", "story_v_side_old_106604.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play106604041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 106604041
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			ja = 4.166,
			ko = 4.3,
			en = 4.133
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play106604042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.425

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[151].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(106604041)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 17 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 17)

				if (17 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 17)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604041", "story_v_side_old_106604.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604041", "story_v_side_old_106604.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_side_old_106604", "106604041", "story_v_side_old_106604.awb")

						arg_165_1:RecordAudio("106604041", var_168_6)
						arg_165_1:RecordAudio("106604041", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604041", "story_v_side_old_106604.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604041", "story_v_side_old_106604.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play106604042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 106604042
		arg_169_1.duration_ = 5.3

		local var_169_0 = {
			ja = 4.966,
			ko = 3.366,
			en = 5.3
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play106604043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.3

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[151].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:GetWordFromCfg(106604042)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 12 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 12)

				if (12 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 12)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604042", "story_v_side_old_106604.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604042", "story_v_side_old_106604.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_side_old_106604", "106604042", "story_v_side_old_106604.awb")

						arg_169_1:RecordAudio("106604042", var_172_6)
						arg_169_1:RecordAudio("106604042", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604042", "story_v_side_old_106604.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604042", "story_v_side_old_106604.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play106604043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 106604043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play106604044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.2

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(106604043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 8 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 8)

				if (8 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 8)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play106604044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 106604044
		arg_177_1.duration_ = 4.33

		local var_177_0 = {
			ja = 4.333,
			ko = 4.066,
			en = 4.233
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play106604045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1084ui_story"]) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = arg_177_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.1

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1084ui_story"]) then
				if arg_177_1.var_.characterEffect1084ui_story and not isNil(arg_177_1.actors_["1084ui_story"]) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1084ui_story"]) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["1084ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = var_180_2.localPosition
			end

			local var_180_3 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 then
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_177_1.time_ - 0) / var_180_3)
				var_180_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_2.position).x, (manager.ui.mainCamera.transform.position - var_180_2.position).y, (manager.ui.mainCamera.transform.position - var_180_2.position).z)
				var_180_2.localEulerAngles.z = 0
				var_180_2.localEulerAngles.x = 0
				var_180_2.localEulerAngles = var_180_2.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(0, -1.16, -5)
				var_180_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_2.position).x, (manager.ui.mainCamera.transform.position - var_180_2.position).y, (manager.ui.mainCamera.transform.position - var_180_2.position).z)
				var_180_2.localEulerAngles.z = 0
				var_180_2.localEulerAngles.x = 0
				var_180_2.localEulerAngles = var_180_2.localEulerAngles
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_180_4 = 0
			local var_180_5 = 0.45

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(106604044)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 18 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 18)

				if (18 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 18)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604044", "story_v_side_old_106604.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604044", "story_v_side_old_106604.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_side_old_106604", "106604044", "story_v_side_old_106604.awb")

						arg_177_1:RecordAudio("106604044", var_180_11)
						arg_177_1:RecordAudio("106604044", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604044", "story_v_side_old_106604.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604044", "story_v_side_old_106604.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play106604045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 106604045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play106604046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = arg_181_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.1

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) then
				if arg_181_1.var_.characterEffect1084ui_story and not isNil(arg_181_1.actors_["1084ui_story"]) then
					arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) and arg_181_1.var_.characterEffect1084ui_story then
				arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.125

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(106604045).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 5 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 5)

				if (5 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 5)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play106604046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 106604046
		arg_185_1.duration_ = 7.37

		local var_185_0 = {
			ja = 5.033,
			ko = 7.366,
			en = 5.233
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play106604047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1084ui_story"]) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = arg_185_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.1

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1084ui_story"]) then
				if arg_185_1.var_.characterEffect1084ui_story and not isNil(arg_185_1.actors_["1084ui_story"]) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1084ui_story"]) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_188_2 = 0
			local var_188_3 = 0.625

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(106604046)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 25 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 25)

				if (25 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 25)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604046", "story_v_side_old_106604.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604046", "story_v_side_old_106604.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_side_old_106604", "106604046", "story_v_side_old_106604.awb")

						arg_185_1:RecordAudio("106604046", var_188_9)
						arg_185_1:RecordAudio("106604046", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604046", "story_v_side_old_106604.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604046", "story_v_side_old_106604.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play106604047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 106604047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play106604048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1084ui_story"]) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = arg_189_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.1

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1084ui_story"]) then
				if arg_189_1.var_.characterEffect1084ui_story and not isNil(arg_189_1.actors_["1084ui_story"]) then
					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1084ui_story"]) and arg_189_1.var_.characterEffect1084ui_story then
				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.25

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(106604047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 10 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 10)

				if (10 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 10)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play106604048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 106604048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play106604049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1084ui_story = arg_193_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).z)
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles = arg_193_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(20, -1.16, -5)
				arg_193_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).z)
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles = arg_193_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_196_1 = 0
			local var_196_2 = 0.8

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(106604048).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 32 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 32)

				if (32 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 32)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play106604049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 106604049
		arg_197_1.duration_ = 12.4

		local var_197_0 = {
			ja = 7.766,
			ko = 12.4,
			en = 12.2
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play106604050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPosB03f = arg_197_1.bgs_.B03f.transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.bgs_.B03f.transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPosB03f, Vector3.New(0, -100, 10), (arg_197_1.time_ - 0) / var_200_0)
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.bgs_.B03f.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_200_1 = "B03e"

			if arg_197_1.bgs_.B03e == nil then
				local var_200_2 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_1)
				var_200_2.name = var_200_1
				var_200_2.transform.parent = arg_197_1.stage_.transform
				var_200_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_1] = var_200_2
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_3 = arg_197_1.bgs_.B03e

				arg_197_1.bgs_.B03e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_4 = var_200_3:GetComponent("SpriteRenderer")

				if var_200_4 and var_200_4.sprite then
					local var_200_5 = 2 * (var_200_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_3.transform.localScale = Vector3.New(var_200_5 / var_200_4.sprite.bounds.size.y < var_200_5 * manager.ui.mainCameraCom_.aspect / var_200_4.sprite.bounds.size.x and var_200_5 * manager.ui.mainCameraCom_.aspect / var_200_4.sprite.bounds.size.x or var_200_5 / var_200_4.sprite.bounds.size.y, var_200_5 / var_200_4.sprite.bounds.size.y < var_200_5 * manager.ui.mainCameraCom_.aspect / var_200_4.sprite.bounds.size.x and var_200_5 * manager.ui.mainCameraCom_.aspect / var_200_4.sprite.bounds.size.x or var_200_5 / var_200_4.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "B03e" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_6 = 0
			local var_200_7 = 1.075

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[152].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(106604049)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 43 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 43)

				if (43 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 43)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604049", "story_v_side_old_106604.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604049", "story_v_side_old_106604.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_side_old_106604", "106604049", "story_v_side_old_106604.awb")

						arg_197_1:RecordAudio("106604049", var_200_13)
						arg_197_1:RecordAudio("106604049", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604049", "story_v_side_old_106604.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604049", "story_v_side_old_106604.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B03f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play106604050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 106604050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play106604051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:AudioAction("play", "effect", "se_story_side_1066", "se_story_1066_walk", "")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_204_3 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_201_1.bgmTxt_.text ~= var_204_3 and arg_201_1.bgmTxt_.text ~= "" then
						if arg_201_1.bgmTxt2_.text ~= "" then
							arg_201_1.bgmTxt_.text = arg_201_1.bgmTxt2_.text
						end

						arg_201_1.bgmTxt2_.text = var_204_3

						arg_201_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_201_1.bgmTxt_.text = var_204_3
						arg_201_1.bgmTxt2_.text = var_204_3
					end

					if arg_201_1.bgmTimer then
						arg_201_1.bgmTimer:Stop()

						arg_201_1.bgmTimer = nil
					end

					if arg_201_1.settingData.show_music_name == 1 then
						arg_201_1.musicController:SetSelectedState("show")
						arg_201_1.musicAnimator_:Play("open", 0, 0)

						if arg_201_1.settingData.music_time ~= 0 then
							arg_201_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_201_1.settingData.music_time), function()
								if arg_201_1 == nil or isNil(arg_201_1.bgmTxt_) then
									return
								end

								arg_201_1.musicController:SetSelectedState("hide")
								arg_201_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_204_4 = 0
			local var_204_5 = 1.375

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(106604050).content)

				arg_201_1.text_.text = var_204_6

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_8 = 55 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 55)

				if (55 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 55)) > 0 and var_204_5 < var_204_8 then
					arg_201_1.talkMaxDuration = var_204_8

					if var_204_8 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_6
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_9 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_9 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_9

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_9 and arg_201_1.time_ < var_204_4 + var_204_9 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play106604051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 106604051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play106604052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:AudioAction("play", "effect", "se_story_side_1066", "se_story_1066_bump", "")
			end

			local var_209_1 = 0
			local var_209_2 = 0.1

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(106604051).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 4 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 4)

				if (4 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 4)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play106604052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 106604052
		arg_210_1.duration_ = 1.03

		local var_210_0 = {
			ja = 1.033,
			ko = 0.933,
			en = 0.8
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
				arg_210_0:Play106604053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.1

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:GetWordFromCfg(106604052)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 4 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 4)

				if (4 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 4)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604052", "story_v_side_old_106604.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604052", "story_v_side_old_106604.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_side_old_106604", "106604052", "story_v_side_old_106604.awb")

						arg_210_1:RecordAudio("106604052", var_213_6)
						arg_210_1:RecordAudio("106604052", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604052", "story_v_side_old_106604.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604052", "story_v_side_old_106604.awb")
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
	Play106604053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 106604053
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play106604054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.7

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(106604053).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 28 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 28)

				if (28 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 28)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play106604054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 106604054
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play106604055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.175

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(106604054).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 7 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 7)

				if (7 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 7)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play106604055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 106604055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play106604056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.1

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(106604055).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 4 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 4)

				if (4 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 4)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play106604056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 106604056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play106604057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.925

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(106604056).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 77 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 77)

				if (77 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 77)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play106604057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 106604057
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play106604058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.3

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(106604057).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 12)

				if (12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 12)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play106604058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 106604058
		arg_234_1.duration_ = 5.4

		local var_234_0 = {
			ja = 2.8,
			ko = 2.4,
			en = 5.4
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
				arg_234_0:Play106604059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.175

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:GetWordFromCfg(106604058)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 7 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 7)

				if (7 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 7)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604058", "story_v_side_old_106604.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604058", "story_v_side_old_106604.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_side_old_106604", "106604058", "story_v_side_old_106604.awb")

						arg_234_1:RecordAudio("106604058", var_237_6)
						arg_234_1:RecordAudio("106604058", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604058", "story_v_side_old_106604.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604058", "story_v_side_old_106604.awb")
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
	Play106604059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 106604059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play106604060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.725

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(106604059).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 29 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 29)

				if (29 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 29)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play106604060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 106604060
		arg_242_1.duration_ = 2.8

		local var_242_0 = {
			ja = 2.1,
			ko = 2.4,
			en = 2.8
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
				arg_242_0:Play106604061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if arg_242_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_245_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_242_1.stage_.transform)

				var_245_0.name = "1066ui_story"
				var_245_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.actors_["1066ui_story"] = var_245_0

				local var_245_1 = var_245_0:GetComponentInChildren(typeof(CharacterEffect))

				var_245_1.enabled = true

				local var_245_2 = GameObjectTools.GetOrAddComponent(var_245_0, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(false)
				end

				arg_242_1:ShowWeapon(var_245_1.transform, false)

				arg_242_1.var_["1066ui_story" .. "Animator"] = var_245_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_242_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_242_1.var_["1066ui_story" .. "LipSync"] = var_245_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_245_3 = arg_242_1.actors_["1066ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1066ui_story == nil then
				arg_242_1.var_.characterEffect1066ui_story = var_245_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_4 = 0.1

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 and not isNil(var_245_3) then
				if arg_242_1.var_.characterEffect1066ui_story and not isNil(var_245_3) then
					arg_242_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1066ui_story then
				arg_242_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_245_6 = arg_242_1.actors_["1066ui_story"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1066ui_story = var_245_6.localPosition
			end

			local var_245_7 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				var_245_6.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.82, -5.5), (arg_242_1.time_ - 0) / var_245_7)
				var_245_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_6.position).x, (manager.ui.mainCamera.transform.position - var_245_6.position).y, (manager.ui.mainCamera.transform.position - var_245_6.position).z)
				var_245_6.localEulerAngles.z = 0
				var_245_6.localEulerAngles.x = 0
				var_245_6.localEulerAngles = var_245_6.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				var_245_6.localPosition = Vector3.New(0, -0.82, -5.5)
				var_245_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_6.position).x, (manager.ui.mainCamera.transform.position - var_245_6.position).y, (manager.ui.mainCamera.transform.position - var_245_6.position).z)
				var_245_6.localEulerAngles.z = 0
				var_245_6.localEulerAngles.x = 0
				var_245_6.localEulerAngles = var_245_6.localEulerAngles
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_245_8 = 0
			local var_245_9 = 0.275

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_10 = arg_242_1:GetWordFromCfg(106604060)
				local var_245_11 = arg_242_1:FormatText(var_245_10.content)

				arg_242_1.text_.text = var_245_11

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 11 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 11)

				if (11 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 11)) > 0 and var_245_9 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_11
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604060", "story_v_side_old_106604.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604060", "story_v_side_old_106604.awb") / 1000

					if var_245_14 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_8
					end

					if var_245_10.prefab_name ~= "" and arg_242_1.actors_[var_245_10.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_10.prefab_name].transform, "story_v_side_old_106604", "106604060", "story_v_side_old_106604.awb")

						arg_242_1:RecordAudio("106604060", var_245_15)
						arg_242_1:RecordAudio("106604060", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604060", "story_v_side_old_106604.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604060", "story_v_side_old_106604.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_9, arg_242_1.talkMaxDuration)

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_8) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_8 + var_245_16 and arg_242_1.time_ < var_245_8 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play106604061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 106604061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play106604062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1066ui_story"]) and arg_246_1.var_.characterEffect1066ui_story == nil then
				arg_246_1.var_.characterEffect1066ui_story = arg_246_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.1

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1066ui_story"]) then
				if arg_246_1.var_.characterEffect1066ui_story and not isNil(arg_246_1.actors_["1066ui_story"]) then
					arg_246_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1066ui_story"]) and arg_246_1.var_.characterEffect1066ui_story then
				arg_246_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 0.175

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(106604061).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 7 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 7)

				if (7 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 7)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play106604062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 106604062
		arg_250_1.duration_ = 2.17

		local var_250_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			en = 2.166
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
				arg_250_0:Play106604063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1066ui_story"]) and arg_250_1.var_.characterEffect1066ui_story == nil then
				arg_250_1.var_.characterEffect1066ui_story = arg_250_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.1

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1066ui_story"]) then
				if arg_250_1.var_.characterEffect1066ui_story and not isNil(arg_250_1.actors_["1066ui_story"]) then
					arg_250_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1066ui_story"]) and arg_250_1.var_.characterEffect1066ui_story then
				arg_250_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action452")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_253_2 = 0
			local var_253_3 = 0.175

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:GetWordFromCfg(106604062)
				local var_253_5 = arg_250_1:FormatText(var_253_4.content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 7 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 7)

				if (7 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 7)) > 0 and var_253_3 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604062", "story_v_side_old_106604.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604062", "story_v_side_old_106604.awb") / 1000

					if var_253_8 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_2
					end

					if var_253_4.prefab_name ~= "" and arg_250_1.actors_[var_253_4.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_4.prefab_name].transform, "story_v_side_old_106604", "106604062", "story_v_side_old_106604.awb")

						arg_250_1:RecordAudio("106604062", var_253_9)
						arg_250_1:RecordAudio("106604062", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604062", "story_v_side_old_106604.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604062", "story_v_side_old_106604.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_10 and arg_250_1.time_ < var_253_2 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play106604063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 106604063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play106604064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1066ui_story"]) and arg_254_1.var_.characterEffect1066ui_story == nil then
				arg_254_1.var_.characterEffect1066ui_story = arg_254_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.1

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1066ui_story"]) then
				if arg_254_1.var_.characterEffect1066ui_story and not isNil(arg_254_1.actors_["1066ui_story"]) then
					arg_254_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1066ui_story"]) and arg_254_1.var_.characterEffect1066ui_story then
				arg_254_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:AudioAction("play", "effect", "se_story_side_1066", "se_story_1066_walk02", "")
			end

			local var_257_2 = 0
			local var_257_3 = 0.5

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_4 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(106604063).content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_6 = 20 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_4) / 20)

				if (20 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_4) / 20)) > 0 and var_257_3 < var_257_6 then
					arg_254_1.talkMaxDuration = var_257_6

					if var_257_6 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_7 and arg_254_1.time_ < var_257_2 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play106604064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 106604064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play106604065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.075

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
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

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(106604064).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 3 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 3)

				if (3 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 3)) > 0 and var_261_0 < var_261_3 then
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
	Play106604065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 106604065
		arg_262_1.duration_ = 5.2

		local var_262_0 = {
			ja = 4.833,
			ko = 3.5,
			en = 5.2
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
				arg_262_0:Play106604066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1066ui_story"]) and arg_262_1.var_.characterEffect1066ui_story == nil then
				arg_262_1.var_.characterEffect1066ui_story = arg_262_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.1

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1066ui_story"]) then
				if arg_262_1.var_.characterEffect1066ui_story and not isNil(arg_262_1.actors_["1066ui_story"]) then
					arg_262_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1066ui_story"]) and arg_262_1.var_.characterEffect1066ui_story then
				arg_262_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action426")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_265_2 = 0
			local var_265_3 = 0.35

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_4 = arg_262_1:GetWordFromCfg(106604065)
				local var_265_5 = arg_262_1:FormatText(var_265_4.content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 14 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 14)

				if (14 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 14)) > 0 and var_265_3 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604065", "story_v_side_old_106604.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604065", "story_v_side_old_106604.awb") / 1000

					if var_265_8 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_2
					end

					if var_265_4.prefab_name ~= "" and arg_262_1.actors_[var_265_4.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_4.prefab_name].transform, "story_v_side_old_106604", "106604065", "story_v_side_old_106604.awb")

						arg_262_1:RecordAudio("106604065", var_265_9)
						arg_262_1:RecordAudio("106604065", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604065", "story_v_side_old_106604.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604065", "story_v_side_old_106604.awb")
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
	Play106604066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 106604066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play106604067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1066ui_story"]) and arg_266_1.var_.characterEffect1066ui_story == nil then
				arg_266_1.var_.characterEffect1066ui_story = arg_266_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.1

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1066ui_story"]) then
				if arg_266_1.var_.characterEffect1066ui_story and not isNil(arg_266_1.actors_["1066ui_story"]) then
					arg_266_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1066ui_story"]) and arg_266_1.var_.characterEffect1066ui_story then
				arg_266_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_269_1 = 0
			local var_269_2 = 0.475

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(106604066).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 19 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 19)

				if (19 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 19)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play106604067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 106604067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play106604068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1066ui_story = arg_270_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1066ui_story, Vector3.New(30, -0.82, -5.5), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1066ui_story"].transform.position).z)
				arg_270_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1066ui_story"].transform.localEulerAngles = arg_270_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(30, -0.82, -5.5)
				arg_270_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1066ui_story"].transform.position).z)
				arg_270_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1066ui_story"].transform.localEulerAngles = arg_270_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_273_1 = 0
			local var_273_2 = 0.6

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(106604067).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 24 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 24)

				if (24 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 24)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play106604068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 106604068
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play106604069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 1.025

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(106604068).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 41 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 41)

				if (41 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 41)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play106604069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 106604069
		arg_278_1.duration_ = 7.5

		local var_278_0 = {
			ja = 7.5,
			ko = 3.766,
			en = 3.366
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play106604070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.5

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:GetWordFromCfg(106604069)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 20)

				if (20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 20)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604069", "story_v_side_old_106604.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604069", "story_v_side_old_106604.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_side_old_106604", "106604069", "story_v_side_old_106604.awb")

						arg_278_1:RecordAudio("106604069", var_281_6)
						arg_278_1:RecordAudio("106604069", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604069", "story_v_side_old_106604.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604069", "story_v_side_old_106604.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play106604070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 106604070
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play106604071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1066ui_story"]) and arg_282_1.var_.characterEffect1066ui_story == nil then
				arg_282_1.var_.characterEffect1066ui_story = arg_282_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.1

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1066ui_story"]) then
				if arg_282_1.var_.characterEffect1066ui_story and not isNil(arg_282_1.actors_["1066ui_story"]) then
					arg_282_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_0)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1066ui_story"]) and arg_282_1.var_.characterEffect1066ui_story then
				arg_282_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_285_1 = 0
			local var_285_2 = 0.05

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(106604070).content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 2 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 2)

				if (2 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 2)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_6 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_6 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_6

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_6 and arg_282_1.time_ < var_285_1 + var_285_6 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play106604071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 106604071
		arg_286_1.duration_ = 6.9

		local var_286_0 = {
			ja = 4.566,
			ko = 6.9,
			en = 6.433
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play106604072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1066ui_story"]) and arg_286_1.var_.characterEffect1066ui_story == nil then
				arg_286_1.var_.characterEffect1066ui_story = arg_286_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.1

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1066ui_story"]) then
				if arg_286_1.var_.characterEffect1066ui_story and not isNil(arg_286_1.actors_["1066ui_story"]) then
					arg_286_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1066ui_story"]) and arg_286_1.var_.characterEffect1066ui_story then
				arg_286_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_289_2 = 0
			local var_289_3 = 0.725

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_2 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_4 = arg_286_1:GetWordFromCfg(106604071)
				local var_289_5 = arg_286_1:FormatText(var_289_4.content)

				arg_286_1.text_.text = var_289_5

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 29 <= 0 and var_289_3 or var_289_3 * (utf8.len(var_289_5) / 29)

				if (29 <= 0 and var_289_3 or var_289_3 * (utf8.len(var_289_5) / 29)) > 0 and var_289_3 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_2
					end
				end

				arg_286_1.text_.text = var_289_5
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604071", "story_v_side_old_106604.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604071", "story_v_side_old_106604.awb") / 1000

					if var_289_8 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_2
					end

					if var_289_4.prefab_name ~= "" and arg_286_1.actors_[var_289_4.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_4.prefab_name].transform, "story_v_side_old_106604", "106604071", "story_v_side_old_106604.awb")

						arg_286_1:RecordAudio("106604071", var_289_9)
						arg_286_1:RecordAudio("106604071", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604071", "story_v_side_old_106604.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604071", "story_v_side_old_106604.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_3, arg_286_1.talkMaxDuration)

			if var_289_2 <= arg_286_1.time_ and arg_286_1.time_ < var_289_2 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_2) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_2 + var_289_10 and arg_286_1.time_ < var_289_2 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play106604072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 106604072
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play106604073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1066ui_story"]) and arg_290_1.var_.characterEffect1066ui_story == nil then
				arg_290_1.var_.characterEffect1066ui_story = arg_290_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.1

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1066ui_story"]) then
				if arg_290_1.var_.characterEffect1066ui_story and not isNil(arg_290_1.actors_["1066ui_story"]) then
					arg_290_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1066ui_story"]) and arg_290_1.var_.characterEffect1066ui_story then
				arg_290_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.2

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(106604072).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 8 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 8)

				if (8 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 8)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play106604073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 106604073
		arg_294_1.duration_ = 9.63

		local var_294_0 = {
			ja = 4.466,
			ko = 9.633,
			en = 6.866
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play106604074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1066ui_story"]) and arg_294_1.var_.characterEffect1066ui_story == nil then
				arg_294_1.var_.characterEffect1066ui_story = arg_294_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.1

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1066ui_story"]) then
				if arg_294_1.var_.characterEffect1066ui_story and not isNil(arg_294_1.actors_["1066ui_story"]) then
					arg_294_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1066ui_story"]) and arg_294_1.var_.characterEffect1066ui_story then
				arg_294_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_297_2 = 0
			local var_297_3 = 1.05

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_4 = arg_294_1:GetWordFromCfg(106604073)
				local var_297_5 = arg_294_1:FormatText(var_297_4.content)

				arg_294_1.text_.text = var_297_5

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_7 = 42 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 42)

				if (42 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 42)) > 0 and var_297_3 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_2
					end
				end

				arg_294_1.text_.text = var_297_5
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604073", "story_v_side_old_106604.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604073", "story_v_side_old_106604.awb") / 1000

					if var_297_8 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_2
					end

					if var_297_4.prefab_name ~= "" and arg_294_1.actors_[var_297_4.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_4.prefab_name].transform, "story_v_side_old_106604", "106604073", "story_v_side_old_106604.awb")

						arg_294_1:RecordAudio("106604073", var_297_9)
						arg_294_1:RecordAudio("106604073", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604073", "story_v_side_old_106604.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604073", "story_v_side_old_106604.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_3, arg_294_1.talkMaxDuration)

			if var_297_2 <= arg_294_1.time_ and arg_294_1.time_ < var_297_2 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_2) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_2 + var_297_10 and arg_294_1.time_ < var_297_2 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play106604074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 106604074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play106604075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1066ui_story"]) and arg_298_1.var_.characterEffect1066ui_story == nil then
				arg_298_1.var_.characterEffect1066ui_story = arg_298_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.1

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1066ui_story"]) then
				if arg_298_1.var_.characterEffect1066ui_story and not isNil(arg_298_1.actors_["1066ui_story"]) then
					arg_298_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_0)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1066ui_story"]) and arg_298_1.var_.characterEffect1066ui_story then
				arg_298_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_301_1 = 0
			local var_301_2 = 0.225

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(106604074).content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 9 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 9)

				if (9 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 9)) > 0 and var_301_2 < var_301_5 then
					arg_298_1.talkMaxDuration = var_301_5

					if var_301_5 + var_301_1 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + var_301_1
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_6 = math.max(var_301_2, arg_298_1.talkMaxDuration)

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_6 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_1) / var_301_6

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_1 + var_301_6 and arg_298_1.time_ < var_301_1 + var_301_6 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play106604075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 106604075
		arg_302_1.duration_ = 3.33

		local var_302_0 = {
			ja = 3.333,
			ko = 1.999999999999,
			en = 1.999999999999
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play106604076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1066ui_story"]) and arg_302_1.var_.characterEffect1066ui_story == nil then
				arg_302_1.var_.characterEffect1066ui_story = arg_302_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_0 = 0.1

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1066ui_story"]) then
				if arg_302_1.var_.characterEffect1066ui_story and not isNil(arg_302_1.actors_["1066ui_story"]) then
					arg_302_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1066ui_story"]) and arg_302_1.var_.characterEffect1066ui_story then
				arg_302_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_305_2 = 0
			local var_305_3 = 0.075

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_4 = arg_302_1:GetWordFromCfg(106604075)
				local var_305_5 = arg_302_1:FormatText(var_305_4.content)

				arg_302_1.text_.text = var_305_5

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_7 = 3 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 3)

				if (3 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 3)) > 0 and var_305_3 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_5
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604075", "story_v_side_old_106604.awb") ~= 0 then
					local var_305_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604075", "story_v_side_old_106604.awb") / 1000

					if var_305_8 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_8 + var_305_2
					end

					if var_305_4.prefab_name ~= "" and arg_302_1.actors_[var_305_4.prefab_name] ~= nil then
						local var_305_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_4.prefab_name].transform, "story_v_side_old_106604", "106604075", "story_v_side_old_106604.awb")

						arg_302_1:RecordAudio("106604075", var_305_9)
						arg_302_1:RecordAudio("106604075", var_305_9)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604075", "story_v_side_old_106604.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604075", "story_v_side_old_106604.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_10 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_10 and arg_302_1.time_ < var_305_2 + var_305_10 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play106604076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 106604076
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play106604077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1066ui_story"]) and arg_306_1.var_.characterEffect1066ui_story == nil then
				arg_306_1.var_.characterEffect1066ui_story = arg_306_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.1

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1066ui_story"]) then
				if arg_306_1.var_.characterEffect1066ui_story and not isNil(arg_306_1.actors_["1066ui_story"]) then
					arg_306_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1066ui_story"]) and arg_306_1.var_.characterEffect1066ui_story then
				arg_306_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.05

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(106604076).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 2 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 2)

				if (2 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 2)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play106604077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 106604077
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play106604078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.45

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(106604077).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 18 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 18)

				if (18 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 18)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play106604078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 106604078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play106604079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1.325

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(106604078).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 53 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 53)

				if (53 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 53)) > 0 and var_317_0 < var_317_3 then
					arg_314_1.talkMaxDuration = var_317_3

					if var_317_3 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_3 + 0
					end
				end

				arg_314_1.text_.text = var_317_1
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_4 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_4

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play106604079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 106604079
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play106604080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPosB03e = arg_318_1.bgs_.B03e.transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.bgs_.B03e.transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPosB03e, Vector3.New(0, -100, 10), (arg_318_1.time_ - 0) / var_321_0)
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.bgs_.B03e.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_321_1 = "B10b"

			if arg_318_1.bgs_.B10b == nil then
				local var_321_2 = Object.Instantiate(arg_318_1.paintGo_)

				var_321_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_321_1)
				var_321_2.name = var_321_1
				var_321_2.transform.parent = arg_318_1.stage_.transform
				var_321_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_318_1.bgs_[var_321_1] = var_321_2
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				local var_321_3 = arg_318_1.bgs_.B10b

				arg_318_1.bgs_.B10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_321_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_4 = var_321_3:GetComponent("SpriteRenderer")

				if var_321_4 and var_321_4.sprite then
					local var_321_5 = 2 * (var_321_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_321_3.transform.localScale = Vector3.New(var_321_5 / var_321_4.sprite.bounds.size.y < var_321_5 * manager.ui.mainCameraCom_.aspect / var_321_4.sprite.bounds.size.x and var_321_5 * manager.ui.mainCameraCom_.aspect / var_321_4.sprite.bounds.size.x or var_321_5 / var_321_4.sprite.bounds.size.y, var_321_5 / var_321_4.sprite.bounds.size.y < var_321_5 * manager.ui.mainCameraCom_.aspect / var_321_4.sprite.bounds.size.x and var_321_5 * manager.ui.mainCameraCom_.aspect / var_321_4.sprite.bounds.size.x or var_321_5 / var_321_4.sprite.bounds.size.y, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "B10b" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_321_6 = 0
			local var_321_7 = 0.525

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_8 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(106604079).content)

				arg_318_1.text_.text = var_321_8

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_10 = 21 <= 0 and var_321_7 or var_321_7 * (utf8.len(var_321_8) / 21)

				if (21 <= 0 and var_321_7 or var_321_7 * (utf8.len(var_321_8) / 21)) > 0 and var_321_7 < var_321_10 then
					arg_318_1.talkMaxDuration = var_321_10

					if var_321_10 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_6
					end
				end

				arg_318_1.text_.text = var_321_8
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_11 = math.max(var_321_7, arg_318_1.talkMaxDuration)

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_11 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_6) / var_321_11

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_6 + var_321_11 and arg_318_1.time_ < var_321_6 + var_321_11 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B03e",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play106604080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 106604080
		arg_322_1.duration_ = 5.07

		local var_322_0 = {
			ja = 5.066,
			ko = 4.9,
			en = 4.766
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play106604081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1066ui_story"]) and arg_322_1.var_.characterEffect1066ui_story == nil then
				arg_322_1.var_.characterEffect1066ui_story = arg_322_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.1

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1066ui_story"]) then
				if arg_322_1.var_.characterEffect1066ui_story and not isNil(arg_322_1.actors_["1066ui_story"]) then
					arg_322_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1066ui_story"]) and arg_322_1.var_.characterEffect1066ui_story then
				arg_322_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_325_2 = arg_322_1.actors_["1066ui_story"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1066ui_story = var_325_2.localPosition
			end

			local var_325_3 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_3 then
				var_325_2.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.82, -5.5), (arg_322_1.time_ - 0) / var_325_3)
				var_325_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_2.position).x, (manager.ui.mainCamera.transform.position - var_325_2.position).y, (manager.ui.mainCamera.transform.position - var_325_2.position).z)
				var_325_2.localEulerAngles.z = 0
				var_325_2.localEulerAngles.x = 0
				var_325_2.localEulerAngles = var_325_2.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_3 and arg_322_1.time_ < 0 + var_325_3 + arg_325_0 then
				var_325_2.localPosition = Vector3.New(0, -0.82, -5.5)
				var_325_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_2.position).x, (manager.ui.mainCamera.transform.position - var_325_2.position).y, (manager.ui.mainCamera.transform.position - var_325_2.position).z)
				var_325_2.localEulerAngles.z = 0
				var_325_2.localEulerAngles.x = 0
				var_325_2.localEulerAngles = var_325_2.localEulerAngles
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_325_4 = 0
			local var_325_5 = 0.4

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_6 = arg_322_1:GetWordFromCfg(106604080)
				local var_325_7 = arg_322_1:FormatText(var_325_6.content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 16 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 16)

				if (16 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 16)) > 0 and var_325_5 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604080", "story_v_side_old_106604.awb") ~= 0 then
					local var_325_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604080", "story_v_side_old_106604.awb") / 1000

					if var_325_10 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_4
					end

					if var_325_6.prefab_name ~= "" and arg_322_1.actors_[var_325_6.prefab_name] ~= nil then
						local var_325_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_6.prefab_name].transform, "story_v_side_old_106604", "106604080", "story_v_side_old_106604.awb")

						arg_322_1:RecordAudio("106604080", var_325_11)
						arg_322_1:RecordAudio("106604080", var_325_11)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604080", "story_v_side_old_106604.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604080", "story_v_side_old_106604.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_12 = math.max(var_325_5, arg_322_1.talkMaxDuration)

			if var_325_4 <= arg_322_1.time_ and arg_322_1.time_ < var_325_4 + var_325_12 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_4) / var_325_12

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_4 + var_325_12 and arg_322_1.time_ < var_325_4 + var_325_12 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play106604081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 106604081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play106604082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1066ui_story"]) and arg_326_1.var_.characterEffect1066ui_story == nil then
				arg_326_1.var_.characterEffect1066ui_story = arg_326_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.1

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1066ui_story"]) then
				if arg_326_1.var_.characterEffect1066ui_story and not isNil(arg_326_1.actors_["1066ui_story"]) then
					arg_326_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_0)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1066ui_story"]) and arg_326_1.var_.characterEffect1066ui_story then
				arg_326_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_329_1 = 0
			local var_329_2 = 0.175

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(106604081).content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 7 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 7)

				if (7 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 7)) > 0 and var_329_2 < var_329_5 then
					arg_326_1.talkMaxDuration = var_329_5

					if var_329_5 + var_329_1 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + var_329_1
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_6 = math.max(var_329_2, arg_326_1.talkMaxDuration)

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_6 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_1) / var_329_6

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_1 + var_329_6 and arg_326_1.time_ < var_329_1 + var_329_6 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play106604082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 106604082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play106604083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1066ui_story = arg_330_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1066ui_story, Vector3.New(30, -0.82, -5.5), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1066ui_story"].transform.position).z)
				arg_330_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1066ui_story"].transform.localEulerAngles = arg_330_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(30, -0.82, -5.5)
				arg_330_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1066ui_story"].transform.position).z)
				arg_330_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1066ui_story"].transform.localEulerAngles = arg_330_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_333_1 = 0
			local var_333_2 = 0.525

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(106604082).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 21 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 21)

				if (21 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 21)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play106604083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 106604083
		arg_334_1.duration_ = 3.8

		local var_334_0 = {
			ja = 3.8,
			ko = 3.6,
			en = 1.7
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play106604084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.275

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officermb")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:GetWordFromCfg(106604083)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 11 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 11)

				if (11 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 11)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604083", "story_v_side_old_106604.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604083", "story_v_side_old_106604.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_side_old_106604", "106604083", "story_v_side_old_106604.awb")

						arg_334_1:RecordAudio("106604083", var_337_6)
						arg_334_1:RecordAudio("106604083", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604083", "story_v_side_old_106604.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604083", "story_v_side_old_106604.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play106604084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 106604084
		arg_338_1.duration_ = 8.67

		local var_338_0 = {
			ja = 6,
			ko = 8.666,
			en = 5.266
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play106604085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.8

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officermb")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_1 = arg_338_1:GetWordFromCfg(106604084)
				local var_341_2 = arg_338_1:FormatText(var_341_1.content)

				arg_338_1.text_.text = var_341_2

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 32 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 32)

				if (32 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 32)) > 0 and var_341_0 < var_341_4 then
					arg_338_1.talkMaxDuration = var_341_4

					if var_341_4 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_4 + 0
					end
				end

				arg_338_1.text_.text = var_341_2
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604084", "story_v_side_old_106604.awb") ~= 0 then
					local var_341_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604084", "story_v_side_old_106604.awb") / 1000

					if var_341_5 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + 0
					end

					if var_341_1.prefab_name ~= "" and arg_338_1.actors_[var_341_1.prefab_name] ~= nil then
						local var_341_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_1.prefab_name].transform, "story_v_side_old_106604", "106604084", "story_v_side_old_106604.awb")

						arg_338_1:RecordAudio("106604084", var_341_6)
						arg_338_1:RecordAudio("106604084", var_341_6)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604084", "story_v_side_old_106604.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604084", "story_v_side_old_106604.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play106604085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 106604085
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play106604086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.3

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(106604085).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 12 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 12)

				if (12 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 12)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play106604086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 106604086
		arg_346_1.duration_ = 2.83

		local var_346_0 = {
			ja = 2.833,
			ko = 2.066,
			en = 2.433
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play106604087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1066ui_story"]) and arg_346_1.var_.characterEffect1066ui_story == nil then
				arg_346_1.var_.characterEffect1066ui_story = arg_346_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.1

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1066ui_story"]) then
				if arg_346_1.var_.characterEffect1066ui_story and not isNil(arg_346_1.actors_["1066ui_story"]) then
					arg_346_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1066ui_story"]) and arg_346_1.var_.characterEffect1066ui_story then
				arg_346_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_349_2 = arg_346_1.actors_["1066ui_story"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1066ui_story = var_349_2.localPosition
			end

			local var_349_3 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_3 then
				var_349_2.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.82, -5.5), (arg_346_1.time_ - 0) / var_349_3)
				var_349_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_2.position).x, (manager.ui.mainCamera.transform.position - var_349_2.position).y, (manager.ui.mainCamera.transform.position - var_349_2.position).z)
				var_349_2.localEulerAngles.z = 0
				var_349_2.localEulerAngles.x = 0
				var_349_2.localEulerAngles = var_349_2.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_3 and arg_346_1.time_ < 0 + var_349_3 + arg_349_0 then
				var_349_2.localPosition = Vector3.New(0, -0.82, -5.5)
				var_349_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_2.position).x, (manager.ui.mainCamera.transform.position - var_349_2.position).y, (manager.ui.mainCamera.transform.position - var_349_2.position).z)
				var_349_2.localEulerAngles.z = 0
				var_349_2.localEulerAngles.x = 0
				var_349_2.localEulerAngles = var_349_2.localEulerAngles
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_349_4 = 0
			local var_349_5 = 0.2

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_6 = arg_346_1:GetWordFromCfg(106604086)
				local var_349_7 = arg_346_1:FormatText(var_349_6.content)

				arg_346_1.text_.text = var_349_7

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 8 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 8)

				if (8 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 8)) > 0 and var_349_5 < var_349_9 then
					arg_346_1.talkMaxDuration = var_349_9

					if var_349_9 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_9 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_7
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604086", "story_v_side_old_106604.awb") ~= 0 then
					local var_349_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604086", "story_v_side_old_106604.awb") / 1000

					if var_349_10 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_4
					end

					if var_349_6.prefab_name ~= "" and arg_346_1.actors_[var_349_6.prefab_name] ~= nil then
						local var_349_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_6.prefab_name].transform, "story_v_side_old_106604", "106604086", "story_v_side_old_106604.awb")

						arg_346_1:RecordAudio("106604086", var_349_11)
						arg_346_1:RecordAudio("106604086", var_349_11)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604086", "story_v_side_old_106604.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604086", "story_v_side_old_106604.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_12 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_12 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_12

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_12 and arg_346_1.time_ < var_349_4 + var_349_12 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play106604087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 106604087
		arg_350_1.duration_ = 3.3

		local var_350_0 = {
			ja = 3.3,
			ko = 1.3,
			en = 2.4
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play106604088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1066ui_story"]) and arg_350_1.var_.characterEffect1066ui_story == nil then
				arg_350_1.var_.characterEffect1066ui_story = arg_350_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.1

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1066ui_story"]) then
				if arg_350_1.var_.characterEffect1066ui_story and not isNil(arg_350_1.actors_["1066ui_story"]) then
					arg_350_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_0)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1066ui_story"]) and arg_350_1.var_.characterEffect1066ui_story then
				arg_350_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_353_1 = 0
			local var_353_2 = 0.15

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officermb")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:GetWordFromCfg(106604087)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_6 = 6 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_4) / 6)

				if (6 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_4) / 6)) > 0 and var_353_2 < var_353_6 then
					arg_350_1.talkMaxDuration = var_353_6

					if var_353_6 + var_353_1 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_6 + var_353_1
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604087", "story_v_side_old_106604.awb") ~= 0 then
					local var_353_7 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604087", "story_v_side_old_106604.awb") / 1000

					if var_353_7 + var_353_1 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_1
					end

					if var_353_3.prefab_name ~= "" and arg_350_1.actors_[var_353_3.prefab_name] ~= nil then
						local var_353_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_3.prefab_name].transform, "story_v_side_old_106604", "106604087", "story_v_side_old_106604.awb")

						arg_350_1:RecordAudio("106604087", var_353_8)
						arg_350_1:RecordAudio("106604087", var_353_8)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604087", "story_v_side_old_106604.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604087", "story_v_side_old_106604.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_9 = math.max(var_353_2, arg_350_1.talkMaxDuration)

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_9 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_1) / var_353_9

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_1 + var_353_9 and arg_350_1.time_ < var_353_1 + var_353_9 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play106604088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 106604088
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play106604089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.1

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(106604088).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 4 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 4)

				if (4 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 4)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play106604089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 106604089
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play106604090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.825

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(106604089).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 33 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 33)

				if (33 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 33)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play106604090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 106604090
		arg_362_1.duration_ = 3.87

		local var_362_0 = {
			ja = 3.866,
			ko = 3.066,
			en = 3.8
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play106604091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.25

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officermb")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_1 = arg_362_1:GetWordFromCfg(106604090)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 10 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 10)

				if (10 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 10)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604090", "story_v_side_old_106604.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604090", "story_v_side_old_106604.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_side_old_106604", "106604090", "story_v_side_old_106604.awb")

						arg_362_1:RecordAudio("106604090", var_365_6)
						arg_362_1:RecordAudio("106604090", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604090", "story_v_side_old_106604.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604090", "story_v_side_old_106604.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play106604091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 106604091
		arg_366_1.duration_ = 3.9

		local var_366_0 = {
			ja = 3.5,
			ko = 3.9,
			en = 3.833
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play106604092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.4

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officermb")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_1 = arg_366_1:GetWordFromCfg(106604091)
				local var_369_2 = arg_366_1:FormatText(var_369_1.content)

				arg_366_1.text_.text = var_369_2

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 16 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 16)

				if (16 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 16)) > 0 and var_369_0 < var_369_4 then
					arg_366_1.talkMaxDuration = var_369_4

					if var_369_4 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_4 + 0
					end
				end

				arg_366_1.text_.text = var_369_2
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604091", "story_v_side_old_106604.awb") ~= 0 then
					local var_369_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604091", "story_v_side_old_106604.awb") / 1000

					if var_369_5 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + 0
					end

					if var_369_1.prefab_name ~= "" and arg_366_1.actors_[var_369_1.prefab_name] ~= nil then
						local var_369_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_1.prefab_name].transform, "story_v_side_old_106604", "106604091", "story_v_side_old_106604.awb")

						arg_366_1:RecordAudio("106604091", var_369_6)
						arg_366_1:RecordAudio("106604091", var_369_6)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604091", "story_v_side_old_106604.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604091", "story_v_side_old_106604.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play106604092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 106604092
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play106604093(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.625

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(106604092).content)

				arg_370_1.text_.text = var_373_1

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_3 = 25 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 25)

				if (25 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 25)) > 0 and var_373_0 < var_373_3 then
					arg_370_1.talkMaxDuration = var_373_3

					if var_373_3 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_3 + 0
					end
				end

				arg_370_1.text_.text = var_373_1
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_4 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_4

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play106604093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 106604093
		arg_374_1.duration_ = 2.03

		local var_374_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			en = 2.033
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play106604094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["1066ui_story"]) and arg_374_1.var_.characterEffect1066ui_story == nil then
				arg_374_1.var_.characterEffect1066ui_story = arg_374_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.1

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["1066ui_story"]) then
				if arg_374_1.var_.characterEffect1066ui_story and not isNil(arg_374_1.actors_["1066ui_story"]) then
					arg_374_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["1066ui_story"]) and arg_374_1.var_.characterEffect1066ui_story then
				arg_374_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action446")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_377_2 = 0
			local var_377_3 = 0.2

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_2 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_4 = arg_374_1:GetWordFromCfg(106604093)
				local var_377_5 = arg_374_1:FormatText(var_377_4.content)

				arg_374_1.text_.text = var_377_5

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_7 = 8 <= 0 and var_377_3 or var_377_3 * (utf8.len(var_377_5) / 8)

				if (8 <= 0 and var_377_3 or var_377_3 * (utf8.len(var_377_5) / 8)) > 0 and var_377_3 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_2 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_2
					end
				end

				arg_374_1.text_.text = var_377_5
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604093", "story_v_side_old_106604.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604093", "story_v_side_old_106604.awb") / 1000

					if var_377_8 + var_377_2 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_2
					end

					if var_377_4.prefab_name ~= "" and arg_374_1.actors_[var_377_4.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_4.prefab_name].transform, "story_v_side_old_106604", "106604093", "story_v_side_old_106604.awb")

						arg_374_1:RecordAudio("106604093", var_377_9)
						arg_374_1:RecordAudio("106604093", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604093", "story_v_side_old_106604.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604093", "story_v_side_old_106604.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_3, arg_374_1.talkMaxDuration)

			if var_377_2 <= arg_374_1.time_ and arg_374_1.time_ < var_377_2 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_2) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_2 + var_377_10 and arg_374_1.time_ < var_377_2 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play106604094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 106604094
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play106604095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1066ui_story"]) and arg_378_1.var_.characterEffect1066ui_story == nil then
				arg_378_1.var_.characterEffect1066ui_story = arg_378_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.1

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1066ui_story"]) then
				if arg_378_1.var_.characterEffect1066ui_story and not isNil(arg_378_1.actors_["1066ui_story"]) then
					arg_378_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1066ui_story"]) and arg_378_1.var_.characterEffect1066ui_story then
				arg_378_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_381_1 = 0
			local var_381_2 = 0.15

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(106604094).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 6 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 6)

				if (6 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 6)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play106604095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 106604095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play106604096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1066ui_story = arg_382_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1066ui_story, Vector3.New(30, -0.82, -5.5), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1066ui_story"].transform.position).z)
				arg_382_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1066ui_story"].transform.localEulerAngles = arg_382_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(30, -0.82, -5.5)
				arg_382_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1066ui_story"].transform.position).z)
				arg_382_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1066ui_story"].transform.localEulerAngles = arg_382_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_385_1 = 0
			local var_385_2 = 1.475

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(106604095).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 59 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 59)

				if (59 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 59)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play106604096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 106604096
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play106604097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.2

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(106604096).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 8 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 8)

				if (8 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 8)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play106604097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 106604097
		arg_390_1.duration_ = 2

		local var_390_0 = {
			ja = 1.9,
			ko = 1.9,
			en = 2
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play106604098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.2

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:GetWordFromCfg(106604097)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 8)

				if (8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 8)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604097", "story_v_side_old_106604.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604097", "story_v_side_old_106604.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_side_old_106604", "106604097", "story_v_side_old_106604.awb")

						arg_390_1:RecordAudio("106604097", var_393_6)
						arg_390_1:RecordAudio("106604097", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604097", "story_v_side_old_106604.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604097", "story_v_side_old_106604.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play106604098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 106604098
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play106604099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.95

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(106604098).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 38 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 38)

				if (38 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 38)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play106604099 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 106604099
		arg_398_1.duration_ = 4.6

		local var_398_0 = {
			ja = 3.333,
			ko = 3.633,
			en = 4.6
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play106604100(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1066ui_story"]) and arg_398_1.var_.characterEffect1066ui_story == nil then
				arg_398_1.var_.characterEffect1066ui_story = arg_398_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.1

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1066ui_story"]) then
				if arg_398_1.var_.characterEffect1066ui_story and not isNil(arg_398_1.actors_["1066ui_story"]) then
					arg_398_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1066ui_story"]) and arg_398_1.var_.characterEffect1066ui_story then
				arg_398_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_401_2 = arg_398_1.actors_["1066ui_story"].transform

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1066ui_story = var_401_2.localPosition
			end

			local var_401_3 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_3 then
				var_401_2.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.82, -5.5), (arg_398_1.time_ - 0) / var_401_3)
				var_401_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_401_2.position).x, (manager.ui.mainCamera.transform.position - var_401_2.position).y, (manager.ui.mainCamera.transform.position - var_401_2.position).z)
				var_401_2.localEulerAngles.z = 0
				var_401_2.localEulerAngles.x = 0
				var_401_2.localEulerAngles = var_401_2.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_3 and arg_398_1.time_ < 0 + var_401_3 + arg_401_0 then
				var_401_2.localPosition = Vector3.New(0, -0.82, -5.5)
				var_401_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_401_2.position).x, (manager.ui.mainCamera.transform.position - var_401_2.position).y, (manager.ui.mainCamera.transform.position - var_401_2.position).z)
				var_401_2.localEulerAngles.z = 0
				var_401_2.localEulerAngles.x = 0
				var_401_2.localEulerAngles = var_401_2.localEulerAngles
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_401_4 = 0
			local var_401_5 = 0.3

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_6 = arg_398_1:GetWordFromCfg(106604099)
				local var_401_7 = arg_398_1:FormatText(var_401_6.content)

				arg_398_1.text_.text = var_401_7

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 12 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 12)

				if (12 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 12)) > 0 and var_401_5 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_7
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604099", "story_v_side_old_106604.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604099", "story_v_side_old_106604.awb") / 1000

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end

					if var_401_6.prefab_name ~= "" and arg_398_1.actors_[var_401_6.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_6.prefab_name].transform, "story_v_side_old_106604", "106604099", "story_v_side_old_106604.awb")

						arg_398_1:RecordAudio("106604099", var_401_11)
						arg_398_1:RecordAudio("106604099", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604099", "story_v_side_old_106604.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604099", "story_v_side_old_106604.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 <= arg_398_1.time_ and arg_398_1.time_ < var_401_4 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_4) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_4 + var_401_12 and arg_398_1.time_ < var_401_4 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play106604100 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 106604100
		arg_402_1.duration_ = 1.63

		local var_402_0 = {
			ja = 1.166,
			ko = 1.3,
			en = 1.633
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play106604101(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1066ui_story"]) and arg_402_1.var_.characterEffect1066ui_story == nil then
				arg_402_1.var_.characterEffect1066ui_story = arg_402_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.1

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1066ui_story"]) then
				if arg_402_1.var_.characterEffect1066ui_story and not isNil(arg_402_1.actors_["1066ui_story"]) then
					arg_402_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1066ui_story"]) and arg_402_1.var_.characterEffect1066ui_story then
				arg_402_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_405_1 = 0
			local var_405_2 = 0.175

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_3 = arg_402_1:GetWordFromCfg(106604100)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_6 = 7 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_4) / 7)

				if (7 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_4) / 7)) > 0 and var_405_2 < var_405_6 then
					arg_402_1.talkMaxDuration = var_405_6

					if var_405_6 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_1
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604100", "story_v_side_old_106604.awb") ~= 0 then
					local var_405_7 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604100", "story_v_side_old_106604.awb") / 1000

					if var_405_7 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_1
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_side_old_106604", "106604100", "story_v_side_old_106604.awb")

						arg_402_1:RecordAudio("106604100", var_405_8)
						arg_402_1:RecordAudio("106604100", var_405_8)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604100", "story_v_side_old_106604.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604100", "story_v_side_old_106604.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_9 = math.max(var_405_2, arg_402_1.talkMaxDuration)

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_9 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_1) / var_405_9

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_1 + var_405_9 and arg_402_1.time_ < var_405_1 + var_405_9 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play106604101 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 106604101
		arg_406_1.duration_ = 9.47

		local var_406_0 = {
			ja = 9.033,
			ko = 9.466,
			en = 9.1
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play106604102(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1066ui_story"]) and arg_406_1.var_.characterEffect1066ui_story == nil then
				arg_406_1.var_.characterEffect1066ui_story = arg_406_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.1

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1066ui_story"]) then
				if arg_406_1.var_.characterEffect1066ui_story and not isNil(arg_406_1.actors_["1066ui_story"]) then
					arg_406_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1066ui_story"]) and arg_406_1.var_.characterEffect1066ui_story then
				arg_406_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action442")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_409_2 = 0
			local var_409_3 = 1.025

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_2 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_4 = arg_406_1:GetWordFromCfg(106604101)
				local var_409_5 = arg_406_1:FormatText(var_409_4.content)

				arg_406_1.text_.text = var_409_5

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_7 = 41 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 41)

				if (41 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 41)) > 0 and var_409_3 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_2
					end
				end

				arg_406_1.text_.text = var_409_5
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604101", "story_v_side_old_106604.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604101", "story_v_side_old_106604.awb") / 1000

					if var_409_8 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_2
					end

					if var_409_4.prefab_name ~= "" and arg_406_1.actors_[var_409_4.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_4.prefab_name].transform, "story_v_side_old_106604", "106604101", "story_v_side_old_106604.awb")

						arg_406_1:RecordAudio("106604101", var_409_9)
						arg_406_1:RecordAudio("106604101", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604101", "story_v_side_old_106604.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604101", "story_v_side_old_106604.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_3, arg_406_1.talkMaxDuration)

			if var_409_2 <= arg_406_1.time_ and arg_406_1.time_ < var_409_2 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_2) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_2 + var_409_10 and arg_406_1.time_ < var_409_2 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play106604102 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 106604102
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play106604103(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1066ui_story"]) and arg_410_1.var_.characterEffect1066ui_story == nil then
				arg_410_1.var_.characterEffect1066ui_story = arg_410_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.1

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1066ui_story"]) then
				if arg_410_1.var_.characterEffect1066ui_story and not isNil(arg_410_1.actors_["1066ui_story"]) then
					arg_410_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_0)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1066ui_story"]) and arg_410_1.var_.characterEffect1066ui_story then
				arg_410_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_413_1 = 0
			local var_413_2 = 0.3

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(106604102).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 12 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 12)

				if (12 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 12)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play106604103 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 106604103
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play106604104(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.75

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(106604103).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 30 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 30)

				if (30 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 30)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play106604104 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 106604104
		arg_418_1.duration_ = 8.67

		local var_418_0 = {
			ja = 8.666,
			ko = 7.366,
			en = 7.5
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play106604105(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1066ui_story"]) and arg_418_1.var_.characterEffect1066ui_story == nil then
				arg_418_1.var_.characterEffect1066ui_story = arg_418_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.1

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1066ui_story"]) then
				if arg_418_1.var_.characterEffect1066ui_story and not isNil(arg_418_1.actors_["1066ui_story"]) then
					arg_418_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1066ui_story"]) and arg_418_1.var_.characterEffect1066ui_story then
				arg_418_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action425")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_421_2 = 0
			local var_421_3 = 0.8

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(106604104)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 32 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 32)

				if (32 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 32)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604104", "story_v_side_old_106604.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604104", "story_v_side_old_106604.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_side_old_106604", "106604104", "story_v_side_old_106604.awb")

						arg_418_1:RecordAudio("106604104", var_421_9)
						arg_418_1:RecordAudio("106604104", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604104", "story_v_side_old_106604.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604104", "story_v_side_old_106604.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play106604105 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 106604105
		arg_422_1.duration_ = 5.23

		local var_422_0 = {
			ja = 3.566,
			ko = 5.233,
			en = 2.233
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play106604106(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1066ui_story"]) and arg_422_1.var_.characterEffect1066ui_story == nil then
				arg_422_1.var_.characterEffect1066ui_story = arg_422_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.1

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1066ui_story"]) then
				if arg_422_1.var_.characterEffect1066ui_story and not isNil(arg_422_1.actors_["1066ui_story"]) then
					arg_422_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_422_1.time_ - 0) / var_425_0)
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1066ui_story"]) and arg_422_1.var_.characterEffect1066ui_story then
				arg_422_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_425_1 = 0
			local var_425_2 = 0.3

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_3 = arg_422_1:GetWordFromCfg(106604105)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_6 = 12 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_4) / 12)

				if (12 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_4) / 12)) > 0 and var_425_2 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_1
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604105", "story_v_side_old_106604.awb") ~= 0 then
					local var_425_7 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604105", "story_v_side_old_106604.awb") / 1000

					if var_425_7 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_1
					end

					if var_425_3.prefab_name ~= "" and arg_422_1.actors_[var_425_3.prefab_name] ~= nil then
						local var_425_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_3.prefab_name].transform, "story_v_side_old_106604", "106604105", "story_v_side_old_106604.awb")

						arg_422_1:RecordAudio("106604105", var_425_8)
						arg_422_1:RecordAudio("106604105", var_425_8)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604105", "story_v_side_old_106604.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604105", "story_v_side_old_106604.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_9 = math.max(var_425_2, arg_422_1.talkMaxDuration)

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_9 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_1) / var_425_9

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_1 + var_425_9 and arg_422_1.time_ < var_425_1 + var_425_9 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play106604106 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 106604106
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play106604107(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.3

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(106604106).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 12 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 12)

				if (12 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 12)) > 0 and var_429_0 < var_429_3 then
					arg_426_1.talkMaxDuration = var_429_3

					if var_429_3 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_3 + 0
					end
				end

				arg_426_1.text_.text = var_429_1
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_4 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_4

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play106604107 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 106604107
		arg_430_1.duration_ = 6.63

		local var_430_0 = {
			ja = 5.266,
			ko = 6.633,
			en = 6.3
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play106604108(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1066ui_story"]) and arg_430_1.var_.characterEffect1066ui_story == nil then
				arg_430_1.var_.characterEffect1066ui_story = arg_430_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.1

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1066ui_story"]) then
				if arg_430_1.var_.characterEffect1066ui_story and not isNil(arg_430_1.actors_["1066ui_story"]) then
					arg_430_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1066ui_story"]) and arg_430_1.var_.characterEffect1066ui_story then
				arg_430_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action453")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_433_2 = 0
			local var_433_3 = 0.725

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_2 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_4 = arg_430_1:GetWordFromCfg(106604107)
				local var_433_5 = arg_430_1:FormatText(var_433_4.content)

				arg_430_1.text_.text = var_433_5

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_7 = 29 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 29)

				if (29 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 29)) > 0 and var_433_3 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_2
					end
				end

				arg_430_1.text_.text = var_433_5
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604107", "story_v_side_old_106604.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604107", "story_v_side_old_106604.awb") / 1000

					if var_433_8 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_2
					end

					if var_433_4.prefab_name ~= "" and arg_430_1.actors_[var_433_4.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_4.prefab_name].transform, "story_v_side_old_106604", "106604107", "story_v_side_old_106604.awb")

						arg_430_1:RecordAudio("106604107", var_433_9)
						arg_430_1:RecordAudio("106604107", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604107", "story_v_side_old_106604.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604107", "story_v_side_old_106604.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_3, arg_430_1.talkMaxDuration)

			if var_433_2 <= arg_430_1.time_ and arg_430_1.time_ < var_433_2 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_2) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_2 + var_433_10 and arg_430_1.time_ < var_433_2 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play106604108 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 106604108
		arg_434_1.duration_ = 10.67

		local var_434_0 = {
			ja = 7,
			ko = 10.666,
			en = 8.933
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play106604109(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_437_0 = 0
			local var_437_1 = 1.225

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_2 = arg_434_1:GetWordFromCfg(106604108)
				local var_437_3 = arg_434_1:FormatText(var_437_2.content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 49 <= 0 and var_437_1 or var_437_1 * (utf8.len(var_437_3) / 49)

				if (49 <= 0 and var_437_1 or var_437_1 * (utf8.len(var_437_3) / 49)) > 0 and var_437_1 < var_437_5 then
					arg_434_1.talkMaxDuration = var_437_5

					if var_437_5 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604108", "story_v_side_old_106604.awb") ~= 0 then
					local var_437_6 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604108", "story_v_side_old_106604.awb") / 1000

					if var_437_6 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_6 + var_437_0
					end

					if var_437_2.prefab_name ~= "" and arg_434_1.actors_[var_437_2.prefab_name] ~= nil then
						local var_437_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_2.prefab_name].transform, "story_v_side_old_106604", "106604108", "story_v_side_old_106604.awb")

						arg_434_1:RecordAudio("106604108", var_437_7)
						arg_434_1:RecordAudio("106604108", var_437_7)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604108", "story_v_side_old_106604.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604108", "story_v_side_old_106604.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_8 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_8 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_8

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_8 and arg_434_1.time_ < var_437_0 + var_437_8 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play106604109 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 106604109
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play106604110(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1066ui_story"]) and arg_438_1.var_.characterEffect1066ui_story == nil then
				arg_438_1.var_.characterEffect1066ui_story = arg_438_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.1

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1066ui_story"]) then
				if arg_438_1.var_.characterEffect1066ui_story and not isNil(arg_438_1.actors_["1066ui_story"]) then
					arg_438_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_438_1.time_ - 0) / var_441_0)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1066ui_story"]) and arg_438_1.var_.characterEffect1066ui_story then
				arg_438_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_441_1 = 0
			local var_441_2 = 0.75

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(106604109).content)

				arg_438_1.text_.text = var_441_3

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 30 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 30)

				if (30 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 30)) > 0 and var_441_2 < var_441_5 then
					arg_438_1.talkMaxDuration = var_441_5

					if var_441_5 + var_441_1 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + var_441_1
					end
				end

				arg_438_1.text_.text = var_441_3
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_6 = math.max(var_441_2, arg_438_1.talkMaxDuration)

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_6 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_1) / var_441_6

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_1 + var_441_6 and arg_438_1.time_ < var_441_1 + var_441_6 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play106604110 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 106604110
		arg_442_1.duration_ = 13.8

		local var_442_0 = {
			ja = 13.8,
			ko = 11,
			en = 8.833
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play106604111(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1066ui_story"]) and arg_442_1.var_.characterEffect1066ui_story == nil then
				arg_442_1.var_.characterEffect1066ui_story = arg_442_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_0 = 0.1

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1066ui_story"]) then
				if arg_442_1.var_.characterEffect1066ui_story and not isNil(arg_442_1.actors_["1066ui_story"]) then
					arg_442_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1066ui_story"]) and arg_442_1.var_.characterEffect1066ui_story then
				arg_442_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_445_2 = 0
			local var_445_3 = 1.25

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_4 = arg_442_1:GetWordFromCfg(106604110)
				local var_445_5 = arg_442_1:FormatText(var_445_4.content)

				arg_442_1.text_.text = var_445_5

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_7 = 50 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 50)

				if (50 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 50)) > 0 and var_445_3 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_2
					end
				end

				arg_442_1.text_.text = var_445_5
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604110", "story_v_side_old_106604.awb") ~= 0 then
					local var_445_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604110", "story_v_side_old_106604.awb") / 1000

					if var_445_8 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_2
					end

					if var_445_4.prefab_name ~= "" and arg_442_1.actors_[var_445_4.prefab_name] ~= nil then
						local var_445_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_4.prefab_name].transform, "story_v_side_old_106604", "106604110", "story_v_side_old_106604.awb")

						arg_442_1:RecordAudio("106604110", var_445_9)
						arg_442_1:RecordAudio("106604110", var_445_9)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604110", "story_v_side_old_106604.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604110", "story_v_side_old_106604.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_10 = math.max(var_445_3, arg_442_1.talkMaxDuration)

			if var_445_2 <= arg_442_1.time_ and arg_442_1.time_ < var_445_2 + var_445_10 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_2) / var_445_10

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_2 + var_445_10 and arg_442_1.time_ < var_445_2 + var_445_10 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play106604111 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 106604111
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play106604112(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["1066ui_story"]) and arg_446_1.var_.characterEffect1066ui_story == nil then
				arg_446_1.var_.characterEffect1066ui_story = arg_446_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.1

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["1066ui_story"]) then
				if arg_446_1.var_.characterEffect1066ui_story and not isNil(arg_446_1.actors_["1066ui_story"]) then
					arg_446_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_0)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["1066ui_story"]) and arg_446_1.var_.characterEffect1066ui_story then
				arg_446_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_449_1 = 0
			local var_449_2 = 1.025

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(106604111).content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 42 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_3) / 42)

				if (42 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_3) / 42)) > 0 and var_449_2 < var_449_5 then
					arg_446_1.talkMaxDuration = var_449_5

					if var_449_5 + var_449_1 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + var_449_1
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_6 = math.max(var_449_2, arg_446_1.talkMaxDuration)

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_6 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_1) / var_449_6

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_1 + var_449_6 and arg_446_1.time_ < var_449_1 + var_449_6 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play106604112 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 106604112
		arg_450_1.duration_ = 17.3

		local var_450_0 = {
			ja = 6.233,
			ko = 17.3,
			en = 14.666
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play106604113(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1066ui_story"]) and arg_450_1.var_.characterEffect1066ui_story == nil then
				arg_450_1.var_.characterEffect1066ui_story = arg_450_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_0 = 0.1

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1066ui_story"]) then
				if arg_450_1.var_.characterEffect1066ui_story and not isNil(arg_450_1.actors_["1066ui_story"]) then
					arg_450_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1066ui_story"]) and arg_450_1.var_.characterEffect1066ui_story then
				arg_450_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_453_2 = 0
			local var_453_3 = 1.55

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_2 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_4 = arg_450_1:GetWordFromCfg(106604112)
				local var_453_5 = arg_450_1:FormatText(var_453_4.content)

				arg_450_1.text_.text = var_453_5

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_7 = 62 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 62)

				if (62 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 62)) > 0 and var_453_3 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_2
					end
				end

				arg_450_1.text_.text = var_453_5
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604112", "story_v_side_old_106604.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604112", "story_v_side_old_106604.awb") / 1000

					if var_453_8 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_2
					end

					if var_453_4.prefab_name ~= "" and arg_450_1.actors_[var_453_4.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_4.prefab_name].transform, "story_v_side_old_106604", "106604112", "story_v_side_old_106604.awb")

						arg_450_1:RecordAudio("106604112", var_453_9)
						arg_450_1:RecordAudio("106604112", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604112", "story_v_side_old_106604.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604112", "story_v_side_old_106604.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_3, arg_450_1.talkMaxDuration)

			if var_453_2 <= arg_450_1.time_ and arg_450_1.time_ < var_453_2 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_2) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_2 + var_453_10 and arg_450_1.time_ < var_453_2 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play106604113 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 106604113
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play106604114(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.45

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, false)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_1 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(106604113).content)

				arg_454_1.text_.text = var_457_1

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_3 = 18 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 18)

				if (18 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 18)) > 0 and var_457_0 < var_457_3 then
					arg_454_1.talkMaxDuration = var_457_3

					if var_457_3 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_3 + 0
					end
				end

				arg_454_1.text_.text = var_457_1
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_4 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_4

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play106604114 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 106604114
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play106604115(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1066ui_story"]) and arg_458_1.var_.characterEffect1066ui_story == nil then
				arg_458_1.var_.characterEffect1066ui_story = arg_458_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.1

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1066ui_story"]) then
				if arg_458_1.var_.characterEffect1066ui_story and not isNil(arg_458_1.actors_["1066ui_story"]) then
					arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1066ui_story"]) and arg_458_1.var_.characterEffect1066ui_story then
				arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.55

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_3 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(106604114).content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 22 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 22)

				if (22 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 22)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_6 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_6 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_6

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_6 and arg_458_1.time_ < var_461_1 + var_461_6 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play106604115 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 106604115
		arg_462_1.duration_ = 5.93

		local var_462_0 = {
			ja = 5.933,
			ko = 4.266,
			en = 4.666
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play106604116(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1066ui_story"]) and arg_462_1.var_.characterEffect1066ui_story == nil then
				arg_462_1.var_.characterEffect1066ui_story = arg_462_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.1

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1066ui_story"]) then
				if arg_462_1.var_.characterEffect1066ui_story and not isNil(arg_462_1.actors_["1066ui_story"]) then
					arg_462_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1066ui_story"]) and arg_462_1.var_.characterEffect1066ui_story then
				arg_462_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_465_2 = 0
			local var_465_3 = 0.4

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:GetWordFromCfg(106604115)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_7 = 16 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 16)

				if (16 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 16)) > 0 and var_465_3 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604115", "story_v_side_old_106604.awb") ~= 0 then
					local var_465_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604115", "story_v_side_old_106604.awb") / 1000

					if var_465_8 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_2
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_side_old_106604", "106604115", "story_v_side_old_106604.awb")

						arg_462_1:RecordAudio("106604115", var_465_9)
						arg_462_1:RecordAudio("106604115", var_465_9)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604115", "story_v_side_old_106604.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604115", "story_v_side_old_106604.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_10 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_10 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_10

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_10 and arg_462_1.time_ < var_465_2 + var_465_10 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play106604116 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 106604116
		arg_466_1.duration_ = 3.3

		local var_466_0 = {
			ja = 1.9,
			ko = 3.033,
			en = 3.3
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play106604117(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_469_0 = 0
			local var_469_1 = 0.35

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_2 = arg_466_1:GetWordFromCfg(106604116)
				local var_469_3 = arg_466_1:FormatText(var_469_2.content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 14 <= 0 and var_469_1 or var_469_1 * (utf8.len(var_469_3) / 14)

				if (14 <= 0 and var_469_1 or var_469_1 * (utf8.len(var_469_3) / 14)) > 0 and var_469_1 < var_469_5 then
					arg_466_1.talkMaxDuration = var_469_5

					if var_469_5 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604116", "story_v_side_old_106604.awb") ~= 0 then
					local var_469_6 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604116", "story_v_side_old_106604.awb") / 1000

					if var_469_6 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_6 + var_469_0
					end

					if var_469_2.prefab_name ~= "" and arg_466_1.actors_[var_469_2.prefab_name] ~= nil then
						local var_469_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_2.prefab_name].transform, "story_v_side_old_106604", "106604116", "story_v_side_old_106604.awb")

						arg_466_1:RecordAudio("106604116", var_469_7)
						arg_466_1:RecordAudio("106604116", var_469_7)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604116", "story_v_side_old_106604.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604116", "story_v_side_old_106604.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_8 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_8 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_8

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_8 and arg_466_1.time_ < var_469_0 + var_469_8 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play106604117 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 106604117
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play106604118(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(arg_470_1.actors_["1066ui_story"]) and arg_470_1.var_.characterEffect1066ui_story == nil then
				arg_470_1.var_.characterEffect1066ui_story = arg_470_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_0 = 0.1

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 and not isNil(arg_470_1.actors_["1066ui_story"]) then
				if arg_470_1.var_.characterEffect1066ui_story and not isNil(arg_470_1.actors_["1066ui_story"]) then
					arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 0) / var_473_0)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 and not isNil(arg_470_1.actors_["1066ui_story"]) and arg_470_1.var_.characterEffect1066ui_story then
				arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_473_1 = 0
			local var_473_2 = 0.35

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_3 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(106604117).content)

				arg_470_1.text_.text = var_473_3

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 14 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 14)

				if (14 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 14)) > 0 and var_473_2 < var_473_5 then
					arg_470_1.talkMaxDuration = var_473_5

					if var_473_5 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + var_473_1
					end
				end

				arg_470_1.text_.text = var_473_3
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_6 = math.max(var_473_2, arg_470_1.talkMaxDuration)

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_6 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_1) / var_473_6

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_1 + var_473_6 and arg_470_1.time_ < var_473_1 + var_473_6 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play106604118 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 106604118
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play106604119(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1066ui_story = arg_474_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1066ui_story, Vector3.New(30, -0.82, -5.5), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).z)
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles = arg_474_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(30, -0.82, -5.5)
				arg_474_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).z)
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles = arg_474_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_477_1 = 0
			local var_477_2 = 0.8

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_3 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(106604118).content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 31 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 31)

				if (31 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 31)) > 0 and var_477_2 < var_477_5 then
					arg_474_1.talkMaxDuration = var_477_5

					if var_477_5 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + var_477_1
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_6 = math.max(var_477_2, arg_474_1.talkMaxDuration)

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_6 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_1) / var_477_6

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_1 + var_477_6 and arg_474_1.time_ < var_477_1 + var_477_6 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play106604119 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 106604119
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play106604120(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0.5

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_1 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(106604119).content)

				arg_478_1.text_.text = var_481_1

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_3 = 20 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 20)

				if (20 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 20)) > 0 and var_481_0 < var_481_3 then
					arg_478_1.talkMaxDuration = var_481_3

					if var_481_3 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_3 + 0
					end
				end

				arg_478_1.text_.text = var_481_1
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_4 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_4 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_4

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_4 and arg_478_1.time_ < 0 + var_481_4 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play106604120 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 106604120
		arg_482_1.duration_ = 5.37

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play106604121(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.65

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[153].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_1 = arg_482_1:GetWordFromCfg(106604120)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 26 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 26)

				if (26 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 26)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604120", "story_v_side_old_106604.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604120", "story_v_side_old_106604.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_side_old_106604", "106604120", "story_v_side_old_106604.awb")

						arg_482_1:RecordAudio("106604120", var_485_6)
						arg_482_1:RecordAudio("106604120", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604120", "story_v_side_old_106604.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604120", "story_v_side_old_106604.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play106604121 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 106604121
		arg_486_1.duration_ = 6.63

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play106604122(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0.875

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[154].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_1 = arg_486_1:GetWordFromCfg(106604121)
				local var_489_2 = arg_486_1:FormatText(var_489_1.content)

				arg_486_1.text_.text = var_489_2

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 35 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 35)

				if (35 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 35)) > 0 and var_489_0 < var_489_4 then
					arg_486_1.talkMaxDuration = var_489_4

					if var_489_4 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_4 + 0
					end
				end

				arg_486_1.text_.text = var_489_2
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604121", "story_v_side_old_106604.awb") ~= 0 then
					local var_489_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604121", "story_v_side_old_106604.awb") / 1000

					if var_489_5 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + 0
					end

					if var_489_1.prefab_name ~= "" and arg_486_1.actors_[var_489_1.prefab_name] ~= nil then
						local var_489_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_1.prefab_name].transform, "story_v_side_old_106604", "106604121", "story_v_side_old_106604.awb")

						arg_486_1:RecordAudio("106604121", var_489_6)
						arg_486_1:RecordAudio("106604121", var_489_6)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604121", "story_v_side_old_106604.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604121", "story_v_side_old_106604.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_7 and arg_486_1.time_ < 0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play106604122 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 106604122
		arg_490_1.duration_ = 1.93

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play106604123(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0.3

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[153].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_1 = arg_490_1:GetWordFromCfg(106604122)
				local var_493_2 = arg_490_1:FormatText(var_493_1.content)

				arg_490_1.text_.text = var_493_2

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_4 = 12 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 12)

				if (12 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 12)) > 0 and var_493_0 < var_493_4 then
					arg_490_1.talkMaxDuration = var_493_4

					if var_493_4 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_4 + 0
					end
				end

				arg_490_1.text_.text = var_493_2
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604122", "story_v_side_old_106604.awb") ~= 0 then
					local var_493_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604122", "story_v_side_old_106604.awb") / 1000

					if var_493_5 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + 0
					end

					if var_493_1.prefab_name ~= "" and arg_490_1.actors_[var_493_1.prefab_name] ~= nil then
						local var_493_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_1.prefab_name].transform, "story_v_side_old_106604", "106604122", "story_v_side_old_106604.awb")

						arg_490_1:RecordAudio("106604122", var_493_6)
						arg_490_1:RecordAudio("106604122", var_493_6)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604122", "story_v_side_old_106604.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604122", "story_v_side_old_106604.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_7 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_7 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_7

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_7 and arg_490_1.time_ < 0 + var_493_7 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play106604123 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 106604123
		arg_494_1.duration_ = 3.03

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play106604124(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.3

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[153].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_1 = arg_494_1:GetWordFromCfg(106604123)
				local var_497_2 = arg_494_1:FormatText(var_497_1.content)

				arg_494_1.text_.text = var_497_2

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_4 = 12 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 12)

				if (12 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 12)) > 0 and var_497_0 < var_497_4 then
					arg_494_1.talkMaxDuration = var_497_4

					if var_497_4 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_4 + 0
					end
				end

				arg_494_1.text_.text = var_497_2
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604123", "story_v_side_old_106604.awb") ~= 0 then
					local var_497_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604123", "story_v_side_old_106604.awb") / 1000

					if var_497_5 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + 0
					end

					if var_497_1.prefab_name ~= "" and arg_494_1.actors_[var_497_1.prefab_name] ~= nil then
						local var_497_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_1.prefab_name].transform, "story_v_side_old_106604", "106604123", "story_v_side_old_106604.awb")

						arg_494_1:RecordAudio("106604123", var_497_6)
						arg_494_1:RecordAudio("106604123", var_497_6)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604123", "story_v_side_old_106604.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604123", "story_v_side_old_106604.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_7 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_7 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_7

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_7 and arg_494_1.time_ < 0 + var_497_7 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play106604124 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 106604124
		arg_498_1.duration_ = 8.9

		local var_498_0 = {
			ja = 8.9,
			ko = 5.233,
			en = 5.4
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play106604125(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0.575

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_1 = arg_498_1:GetWordFromCfg(106604124)
				local var_501_2 = arg_498_1:FormatText(var_501_1.content)

				arg_498_1.text_.text = var_501_2

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_4 = 23 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 23)

				if (23 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 23)) > 0 and var_501_0 < var_501_4 then
					arg_498_1.talkMaxDuration = var_501_4

					if var_501_4 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_4 + 0
					end
				end

				arg_498_1.text_.text = var_501_2
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604124", "story_v_side_old_106604.awb") ~= 0 then
					local var_501_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604124", "story_v_side_old_106604.awb") / 1000

					if var_501_5 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_5 + 0
					end

					if var_501_1.prefab_name ~= "" and arg_498_1.actors_[var_501_1.prefab_name] ~= nil then
						local var_501_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_1.prefab_name].transform, "story_v_side_old_106604", "106604124", "story_v_side_old_106604.awb")

						arg_498_1:RecordAudio("106604124", var_501_6)
						arg_498_1:RecordAudio("106604124", var_501_6)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604124", "story_v_side_old_106604.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604124", "story_v_side_old_106604.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_7 = math.max(var_501_0, arg_498_1.talkMaxDuration)

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_7 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - 0) / var_501_7

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= 0 + var_501_7 and arg_498_1.time_ < 0 + var_501_7 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play106604125 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 106604125
		arg_502_1.duration_ = 6.4

		local var_502_0 = {
			ja = 3.166,
			ko = 3.966,
			en = 6.4
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play106604126(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.4

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[146].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_1 = arg_502_1:GetWordFromCfg(106604125)
				local var_505_2 = arg_502_1:FormatText(var_505_1.content)

				arg_502_1.text_.text = var_505_2

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_4 = 16 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 16)

				if (16 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 16)) > 0 and var_505_0 < var_505_4 then
					arg_502_1.talkMaxDuration = var_505_4

					if var_505_4 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_4 + 0
					end
				end

				arg_502_1.text_.text = var_505_2
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604125", "story_v_side_old_106604.awb") ~= 0 then
					local var_505_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604125", "story_v_side_old_106604.awb") / 1000

					if var_505_5 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + 0
					end

					if var_505_1.prefab_name ~= "" and arg_502_1.actors_[var_505_1.prefab_name] ~= nil then
						local var_505_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_1.prefab_name].transform, "story_v_side_old_106604", "106604125", "story_v_side_old_106604.awb")

						arg_502_1:RecordAudio("106604125", var_505_6)
						arg_502_1:RecordAudio("106604125", var_505_6)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604125", "story_v_side_old_106604.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604125", "story_v_side_old_106604.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_7 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_7 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_7

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_7 and arg_502_1.time_ < 0 + var_505_7 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play106604126 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 106604126
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play106604127(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 1.15

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(106604126).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 46 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 46)

				if (46 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 46)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play106604127 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 106604127
		arg_510_1.duration_ = 18.7

		local var_510_0 = {
			ja = 11.033,
			ko = 18.7,
			en = 14.5
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play106604128(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["1066ui_story"]) and arg_510_1.var_.characterEffect1066ui_story == nil then
				arg_510_1.var_.characterEffect1066ui_story = arg_510_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.1

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["1066ui_story"]) then
				if arg_510_1.var_.characterEffect1066ui_story and not isNil(arg_510_1.actors_["1066ui_story"]) then
					arg_510_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["1066ui_story"]) and arg_510_1.var_.characterEffect1066ui_story then
				arg_510_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_513_2 = arg_510_1.actors_["1066ui_story"].transform

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos1066ui_story = var_513_2.localPosition
			end

			local var_513_3 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_3 then
				var_513_2.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.82, -5.5), (arg_510_1.time_ - 0) / var_513_3)
				var_513_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_513_2.position).x, (manager.ui.mainCamera.transform.position - var_513_2.position).y, (manager.ui.mainCamera.transform.position - var_513_2.position).z)
				var_513_2.localEulerAngles.z = 0
				var_513_2.localEulerAngles.x = 0
				var_513_2.localEulerAngles = var_513_2.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_3 and arg_510_1.time_ < 0 + var_513_3 + arg_513_0 then
				var_513_2.localPosition = Vector3.New(0, -0.82, -5.5)
				var_513_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_513_2.position).x, (manager.ui.mainCamera.transform.position - var_513_2.position).y, (manager.ui.mainCamera.transform.position - var_513_2.position).z)
				var_513_2.localEulerAngles.z = 0
				var_513_2.localEulerAngles.x = 0
				var_513_2.localEulerAngles = var_513_2.localEulerAngles
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_513_4 = 0
			local var_513_5 = 1.825

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_4 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_6 = arg_510_1:GetWordFromCfg(106604127)
				local var_513_7 = arg_510_1:FormatText(var_513_6.content)

				arg_510_1.text_.text = var_513_7

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_9 = 73 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 73)

				if (73 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 73)) > 0 and var_513_5 < var_513_9 then
					arg_510_1.talkMaxDuration = var_513_9

					if var_513_9 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_9 + var_513_4
					end
				end

				arg_510_1.text_.text = var_513_7
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604127", "story_v_side_old_106604.awb") ~= 0 then
					local var_513_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604127", "story_v_side_old_106604.awb") / 1000

					if var_513_10 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_10 + var_513_4
					end

					if var_513_6.prefab_name ~= "" and arg_510_1.actors_[var_513_6.prefab_name] ~= nil then
						local var_513_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_6.prefab_name].transform, "story_v_side_old_106604", "106604127", "story_v_side_old_106604.awb")

						arg_510_1:RecordAudio("106604127", var_513_11)
						arg_510_1:RecordAudio("106604127", var_513_11)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604127", "story_v_side_old_106604.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604127", "story_v_side_old_106604.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_12 = math.max(var_513_5, arg_510_1.talkMaxDuration)

			if var_513_4 <= arg_510_1.time_ and arg_510_1.time_ < var_513_4 + var_513_12 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_4) / var_513_12

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_4 + var_513_12 and arg_510_1.time_ < var_513_4 + var_513_12 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play106604128 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 106604128
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play106604129(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["1066ui_story"]) and arg_514_1.var_.characterEffect1066ui_story == nil then
				arg_514_1.var_.characterEffect1066ui_story = arg_514_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_0 = 0.1

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["1066ui_story"]) then
				if arg_514_1.var_.characterEffect1066ui_story and not isNil(arg_514_1.actors_["1066ui_story"]) then
					arg_514_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 0) / var_517_0)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["1066ui_story"]) and arg_514_1.var_.characterEffect1066ui_story then
				arg_514_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_517_1 = 0
			local var_517_2 = 0.475

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_3 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(106604128).content)

				arg_514_1.text_.text = var_517_3

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 19 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_3) / 19)

				if (19 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_3) / 19)) > 0 and var_517_2 < var_517_5 then
					arg_514_1.talkMaxDuration = var_517_5

					if var_517_5 + var_517_1 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_5 + var_517_1
					end
				end

				arg_514_1.text_.text = var_517_3
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_6 = math.max(var_517_2, arg_514_1.talkMaxDuration)

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_6 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_1) / var_517_6

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_1 + var_517_6 and arg_514_1.time_ < var_517_1 + var_517_6 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play106604129 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 106604129
		arg_518_1.duration_ = 9.8

		local var_518_0 = {
			ja = 4.933,
			ko = 9.8,
			en = 8.566
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play106604130(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["1066ui_story"]) and arg_518_1.var_.characterEffect1066ui_story == nil then
				arg_518_1.var_.characterEffect1066ui_story = arg_518_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.1

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["1066ui_story"]) then
				if arg_518_1.var_.characterEffect1066ui_story and not isNil(arg_518_1.actors_["1066ui_story"]) then
					arg_518_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["1066ui_story"]) and arg_518_1.var_.characterEffect1066ui_story then
				arg_518_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_521_2 = 0
			local var_521_3 = 1.025

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_2 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_4 = arg_518_1:GetWordFromCfg(106604129)
				local var_521_5 = arg_518_1:FormatText(var_521_4.content)

				arg_518_1.text_.text = var_521_5

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_7 = 41 <= 0 and var_521_3 or var_521_3 * (utf8.len(var_521_5) / 41)

				if (41 <= 0 and var_521_3 or var_521_3 * (utf8.len(var_521_5) / 41)) > 0 and var_521_3 < var_521_7 then
					arg_518_1.talkMaxDuration = var_521_7

					if var_521_7 + var_521_2 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_7 + var_521_2
					end
				end

				arg_518_1.text_.text = var_521_5
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604129", "story_v_side_old_106604.awb") ~= 0 then
					local var_521_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604129", "story_v_side_old_106604.awb") / 1000

					if var_521_8 + var_521_2 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_8 + var_521_2
					end

					if var_521_4.prefab_name ~= "" and arg_518_1.actors_[var_521_4.prefab_name] ~= nil then
						local var_521_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_4.prefab_name].transform, "story_v_side_old_106604", "106604129", "story_v_side_old_106604.awb")

						arg_518_1:RecordAudio("106604129", var_521_9)
						arg_518_1:RecordAudio("106604129", var_521_9)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604129", "story_v_side_old_106604.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604129", "story_v_side_old_106604.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_10 = math.max(var_521_3, arg_518_1.talkMaxDuration)

			if var_521_2 <= arg_518_1.time_ and arg_518_1.time_ < var_521_2 + var_521_10 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_2) / var_521_10

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_2 + var_521_10 and arg_518_1.time_ < var_521_2 + var_521_10 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play106604130 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 106604130
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play106604131(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1066ui_story"]) and arg_522_1.var_.characterEffect1066ui_story == nil then
				arg_522_1.var_.characterEffect1066ui_story = arg_522_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.1

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1066ui_story"]) then
				if arg_522_1.var_.characterEffect1066ui_story and not isNil(arg_522_1.actors_["1066ui_story"]) then
					arg_522_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_0)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1066ui_story"]) and arg_522_1.var_.characterEffect1066ui_story then
				arg_522_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_525_1 = 0
			local var_525_2 = 0.325

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_3 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(106604130).content)

				arg_522_1.text_.text = var_525_3

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 13 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 13)

				if (13 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 13)) > 0 and var_525_2 < var_525_5 then
					arg_522_1.talkMaxDuration = var_525_5

					if var_525_5 + var_525_1 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_5 + var_525_1
					end
				end

				arg_522_1.text_.text = var_525_3
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_6 = math.max(var_525_2, arg_522_1.talkMaxDuration)

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_6 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_1) / var_525_6

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_1 + var_525_6 and arg_522_1.time_ < var_525_1 + var_525_6 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play106604131 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 106604131
		arg_526_1.duration_ = 11.03

		local var_526_0 = {
			ja = 8.833,
			ko = 9.3,
			en = 11.033
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play106604132(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(arg_526_1.actors_["1066ui_story"]) and arg_526_1.var_.characterEffect1066ui_story == nil then
				arg_526_1.var_.characterEffect1066ui_story = arg_526_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_0 = 0.1

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 and not isNil(arg_526_1.actors_["1066ui_story"]) then
				if arg_526_1.var_.characterEffect1066ui_story and not isNil(arg_526_1.actors_["1066ui_story"]) then
					arg_526_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 and not isNil(arg_526_1.actors_["1066ui_story"]) and arg_526_1.var_.characterEffect1066ui_story then
				arg_526_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action446")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_529_2 = 0
			local var_529_3 = 1.2

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_2 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_4 = arg_526_1:GetWordFromCfg(106604131)
				local var_529_5 = arg_526_1:FormatText(var_529_4.content)

				arg_526_1.text_.text = var_529_5

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_7 = 48 <= 0 and var_529_3 or var_529_3 * (utf8.len(var_529_5) / 48)

				if (48 <= 0 and var_529_3 or var_529_3 * (utf8.len(var_529_5) / 48)) > 0 and var_529_3 < var_529_7 then
					arg_526_1.talkMaxDuration = var_529_7

					if var_529_7 + var_529_2 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_2
					end
				end

				arg_526_1.text_.text = var_529_5
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604131", "story_v_side_old_106604.awb") ~= 0 then
					local var_529_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604131", "story_v_side_old_106604.awb") / 1000

					if var_529_8 + var_529_2 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_8 + var_529_2
					end

					if var_529_4.prefab_name ~= "" and arg_526_1.actors_[var_529_4.prefab_name] ~= nil then
						local var_529_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_4.prefab_name].transform, "story_v_side_old_106604", "106604131", "story_v_side_old_106604.awb")

						arg_526_1:RecordAudio("106604131", var_529_9)
						arg_526_1:RecordAudio("106604131", var_529_9)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604131", "story_v_side_old_106604.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604131", "story_v_side_old_106604.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_10 = math.max(var_529_3, arg_526_1.talkMaxDuration)

			if var_529_2 <= arg_526_1.time_ and arg_526_1.time_ < var_529_2 + var_529_10 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_2) / var_529_10

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_2 + var_529_10 and arg_526_1.time_ < var_529_2 + var_529_10 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play106604132 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 106604132
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play106604133(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["1066ui_story"]) and arg_530_1.var_.characterEffect1066ui_story == nil then
				arg_530_1.var_.characterEffect1066ui_story = arg_530_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_0 = 0.1

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["1066ui_story"]) then
				if arg_530_1.var_.characterEffect1066ui_story and not isNil(arg_530_1.actors_["1066ui_story"]) then
					arg_530_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_530_1.time_ - 0) / var_533_0)
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["1066ui_story"]) and arg_530_1.var_.characterEffect1066ui_story then
				arg_530_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_533_1 = 0
			local var_533_2 = 0.125

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_3 = arg_530_1:FormatText(arg_530_1:GetWordFromCfg(106604132).content)

				arg_530_1.text_.text = var_533_3

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 5 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_3) / 5)

				if (5 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_3) / 5)) > 0 and var_533_2 < var_533_5 then
					arg_530_1.talkMaxDuration = var_533_5

					if var_533_5 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_5 + var_533_1
					end
				end

				arg_530_1.text_.text = var_533_3
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_6 = math.max(var_533_2, arg_530_1.talkMaxDuration)

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_6 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_1) / var_533_6

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_1 + var_533_6 and arg_530_1.time_ < var_533_1 + var_533_6 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play106604133 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 106604133
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play106604134(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPosB10b = arg_534_1.bgs_.B10b.transform.localPosition
			end

			local var_537_0 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 then
				arg_534_1.bgs_.B10b.transform.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPosB10b, Vector3.New(0, -100, 10), (arg_534_1.time_ - 0) / var_537_0)
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 then
				arg_534_1.bgs_.B10b.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_537_1 = "B10e"

			if arg_534_1.bgs_.B10e == nil then
				local var_537_2 = Object.Instantiate(arg_534_1.paintGo_)

				var_537_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_537_1)
				var_537_2.name = var_537_1
				var_537_2.transform.parent = arg_534_1.stage_.transform
				var_537_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_534_1.bgs_[var_537_1] = var_537_2
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				local var_537_3 = arg_534_1.bgs_.B10e

				arg_534_1.bgs_.B10e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_537_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_537_4 = var_537_3:GetComponent("SpriteRenderer")

				if var_537_4 and var_537_4.sprite then
					local var_537_5 = 2 * (var_537_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_537_3.transform.localScale = Vector3.New(var_537_5 / var_537_4.sprite.bounds.size.y < var_537_5 * manager.ui.mainCameraCom_.aspect / var_537_4.sprite.bounds.size.x and var_537_5 * manager.ui.mainCameraCom_.aspect / var_537_4.sprite.bounds.size.x or var_537_5 / var_537_4.sprite.bounds.size.y, var_537_5 / var_537_4.sprite.bounds.size.y < var_537_5 * manager.ui.mainCameraCom_.aspect / var_537_4.sprite.bounds.size.x and var_537_5 * manager.ui.mainCameraCom_.aspect / var_537_4.sprite.bounds.size.x or var_537_5 / var_537_4.sprite.bounds.size.y, 0)
				end

				for iter_537_0, iter_537_1 in pairs(arg_534_1.bgs_) do
					if iter_537_0 ~= "B10e" then
						iter_537_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_537_6 = arg_534_1.actors_["1066ui_story"].transform

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos1066ui_story = var_537_6.localPosition
			end

			local var_537_7 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_7 then
				var_537_6.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1066ui_story, Vector3.New(30, -0.82, -5.5), (arg_534_1.time_ - 0) / var_537_7)
				var_537_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_537_6.position).x, (manager.ui.mainCamera.transform.position - var_537_6.position).y, (manager.ui.mainCamera.transform.position - var_537_6.position).z)
				var_537_6.localEulerAngles.z = 0
				var_537_6.localEulerAngles.x = 0
				var_537_6.localEulerAngles = var_537_6.localEulerAngles
			end

			if arg_534_1.time_ >= 0 + var_537_7 and arg_534_1.time_ < 0 + var_537_7 + arg_537_0 then
				var_537_6.localPosition = Vector3.New(30, -0.82, -5.5)
				var_537_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_537_6.position).x, (manager.ui.mainCamera.transform.position - var_537_6.position).y, (manager.ui.mainCamera.transform.position - var_537_6.position).z)
				var_537_6.localEulerAngles.z = 0
				var_537_6.localEulerAngles.x = 0
				var_537_6.localEulerAngles = var_537_6.localEulerAngles
			end

			local var_537_8 = 0
			local var_537_9 = 0.3

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_8 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_10 = arg_534_1:FormatText(arg_534_1:GetWordFromCfg(106604133).content)

				arg_534_1.text_.text = var_537_10

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_12 = 12 <= 0 and var_537_9 or var_537_9 * (utf8.len(var_537_10) / 12)

				if (12 <= 0 and var_537_9 or var_537_9 * (utf8.len(var_537_10) / 12)) > 0 and var_537_9 < var_537_12 then
					arg_534_1.talkMaxDuration = var_537_12

					if var_537_12 + var_537_8 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_12 + var_537_8
					end
				end

				arg_534_1.text_.text = var_537_10
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_13 = math.max(var_537_9, arg_534_1.talkMaxDuration)

			if var_537_8 <= arg_534_1.time_ and arg_534_1.time_ < var_537_8 + var_537_13 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_8) / var_537_13

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_8 + var_537_13 and arg_534_1.time_ < var_537_8 + var_537_13 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B10b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play106604134 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 106604134
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play106604135(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0.725

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_1 = arg_538_1:FormatText(arg_538_1:GetWordFromCfg(106604134).content)

				arg_538_1.text_.text = var_541_1

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_3 = 29 <= 0 and var_541_0 or var_541_0 * (utf8.len(var_541_1) / 29)

				if (29 <= 0 and var_541_0 or var_541_0 * (utf8.len(var_541_1) / 29)) > 0 and var_541_0 < var_541_3 then
					arg_538_1.talkMaxDuration = var_541_3

					if var_541_3 + 0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_3 + 0
					end
				end

				arg_538_1.text_.text = var_541_1
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_4 = math.max(var_541_0, arg_538_1.talkMaxDuration)

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_4 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - 0) / var_541_4

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= 0 + var_541_4 and arg_538_1.time_ < 0 + var_541_4 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play106604135 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 106604135
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play106604136(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 1.1

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_1 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(106604135).content)

				arg_542_1.text_.text = var_545_1

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_3 = 44 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 44)

				if (44 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 44)) > 0 and var_545_0 < var_545_3 then
					arg_542_1.talkMaxDuration = var_545_3

					if var_545_3 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_3 + 0
					end
				end

				arg_542_1.text_.text = var_545_1
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_4 = math.max(var_545_0, arg_542_1.talkMaxDuration)

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_4 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - 0) / var_545_4

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= 0 + var_545_4 and arg_542_1.time_ < 0 + var_545_4 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play106604136 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 106604136
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play106604137(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0.725

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_1 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(106604136).content)

				arg_546_1.text_.text = var_549_1

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_3 = 29 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_1) / 29)

				if (29 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_1) / 29)) > 0 and var_549_0 < var_549_3 then
					arg_546_1.talkMaxDuration = var_549_3

					if var_549_3 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_3 + 0
					end
				end

				arg_546_1.text_.text = var_549_1
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_4 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_4 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_4

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_4 and arg_546_1.time_ < 0 + var_549_4 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play106604137 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 106604137
		arg_550_1.duration_ = 2.07

		local var_550_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			en = 1.999999999999
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play106604138(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(arg_550_1.actors_["1066ui_story"]) and arg_550_1.var_.characterEffect1066ui_story == nil then
				arg_550_1.var_.characterEffect1066ui_story = arg_550_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_0 = 0.1

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 and not isNil(arg_550_1.actors_["1066ui_story"]) then
				if arg_550_1.var_.characterEffect1066ui_story and not isNil(arg_550_1.actors_["1066ui_story"]) then
					arg_550_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 and not isNil(arg_550_1.actors_["1066ui_story"]) and arg_550_1.var_.characterEffect1066ui_story then
				arg_550_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_553_2 = arg_550_1.actors_["1066ui_story"].transform

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.var_.moveOldPos1066ui_story = var_553_2.localPosition
			end

			local var_553_3 = 0.001

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_3 then
				var_553_2.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.82, -5.5), (arg_550_1.time_ - 0) / var_553_3)
				var_553_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_553_2.position).x, (manager.ui.mainCamera.transform.position - var_553_2.position).y, (manager.ui.mainCamera.transform.position - var_553_2.position).z)
				var_553_2.localEulerAngles.z = 0
				var_553_2.localEulerAngles.x = 0
				var_553_2.localEulerAngles = var_553_2.localEulerAngles
			end

			if arg_550_1.time_ >= 0 + var_553_3 and arg_550_1.time_ < 0 + var_553_3 + arg_553_0 then
				var_553_2.localPosition = Vector3.New(0, -0.82, -5.5)
				var_553_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_553_2.position).x, (manager.ui.mainCamera.transform.position - var_553_2.position).y, (manager.ui.mainCamera.transform.position - var_553_2.position).z)
				var_553_2.localEulerAngles.z = 0
				var_553_2.localEulerAngles.x = 0
				var_553_2.localEulerAngles = var_553_2.localEulerAngles
			end

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_553_4 = 0
			local var_553_5 = 0.2

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_4 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_6 = arg_550_1:GetWordFromCfg(106604137)
				local var_553_7 = arg_550_1:FormatText(var_553_6.content)

				arg_550_1.text_.text = var_553_7

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_9 = 8 <= 0 and var_553_5 or var_553_5 * (utf8.len(var_553_7) / 8)

				if (8 <= 0 and var_553_5 or var_553_5 * (utf8.len(var_553_7) / 8)) > 0 and var_553_5 < var_553_9 then
					arg_550_1.talkMaxDuration = var_553_9

					if var_553_9 + var_553_4 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_9 + var_553_4
					end
				end

				arg_550_1.text_.text = var_553_7
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604137", "story_v_side_old_106604.awb") ~= 0 then
					local var_553_10 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604137", "story_v_side_old_106604.awb") / 1000

					if var_553_10 + var_553_4 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_10 + var_553_4
					end

					if var_553_6.prefab_name ~= "" and arg_550_1.actors_[var_553_6.prefab_name] ~= nil then
						local var_553_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_6.prefab_name].transform, "story_v_side_old_106604", "106604137", "story_v_side_old_106604.awb")

						arg_550_1:RecordAudio("106604137", var_553_11)
						arg_550_1:RecordAudio("106604137", var_553_11)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604137", "story_v_side_old_106604.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604137", "story_v_side_old_106604.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_12 = math.max(var_553_5, arg_550_1.talkMaxDuration)

			if var_553_4 <= arg_550_1.time_ and arg_550_1.time_ < var_553_4 + var_553_12 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_4) / var_553_12

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_4 + var_553_12 and arg_550_1.time_ < var_553_4 + var_553_12 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_550_1:InitPlayNodeList()
	end,
	Play106604138 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 106604138
		arg_554_1.duration_ = 5

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play106604139(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(arg_554_1.actors_["1066ui_story"]) and arg_554_1.var_.characterEffect1066ui_story == nil then
				arg_554_1.var_.characterEffect1066ui_story = arg_554_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_0 = 0.1

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 and not isNil(arg_554_1.actors_["1066ui_story"]) then
				if arg_554_1.var_.characterEffect1066ui_story and not isNil(arg_554_1.actors_["1066ui_story"]) then
					arg_554_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_554_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_554_1.time_ - 0) / var_557_0)
				end
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 and not isNil(arg_554_1.actors_["1066ui_story"]) and arg_554_1.var_.characterEffect1066ui_story then
				arg_554_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_554_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_557_1 = 0
			local var_557_2 = 0.7

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_3 = arg_554_1:FormatText(arg_554_1:GetWordFromCfg(106604138).content)

				arg_554_1.text_.text = var_557_3

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 28 <= 0 and var_557_2 or var_557_2 * (utf8.len(var_557_3) / 28)

				if (28 <= 0 and var_557_2 or var_557_2 * (utf8.len(var_557_3) / 28)) > 0 and var_557_2 < var_557_5 then
					arg_554_1.talkMaxDuration = var_557_5

					if var_557_5 + var_557_1 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_5 + var_557_1
					end
				end

				arg_554_1.text_.text = var_557_3
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_6 = math.max(var_557_2, arg_554_1.talkMaxDuration)

			if var_557_1 <= arg_554_1.time_ and arg_554_1.time_ < var_557_1 + var_557_6 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_1) / var_557_6

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_1 + var_557_6 and arg_554_1.time_ < var_557_1 + var_557_6 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play106604139 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 106604139
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play106604140(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.75

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_1 = arg_558_1:FormatText(arg_558_1:GetWordFromCfg(106604139).content)

				arg_558_1.text_.text = var_561_1

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_3 = 30 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_1) / 30)

				if (30 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_1) / 30)) > 0 and var_561_0 < var_561_3 then
					arg_558_1.talkMaxDuration = var_561_3

					if var_561_3 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_3 + 0
					end
				end

				arg_558_1.text_.text = var_561_1
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_4 = math.max(var_561_0, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - 0) / var_561_4

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play106604140 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 106604140
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play106604141(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0.8

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_1 = arg_562_1:FormatText(arg_562_1:GetWordFromCfg(106604140).content)

				arg_562_1.text_.text = var_565_1

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_3 = 32 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_1) / 32)

				if (32 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_1) / 32)) > 0 and var_565_0 < var_565_3 then
					arg_562_1.talkMaxDuration = var_565_3

					if var_565_3 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_3 + 0
					end
				end

				arg_562_1.text_.text = var_565_1
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_4 = math.max(var_565_0, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_4 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - 0) / var_565_4

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_4 and arg_562_1.time_ < 0 + var_565_4 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play106604141 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 106604141
		arg_566_1.duration_ = 2

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play106604142(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(arg_566_1.actors_["1066ui_story"]) and arg_566_1.var_.characterEffect1066ui_story == nil then
				arg_566_1.var_.characterEffect1066ui_story = arg_566_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_0 = 0.1

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 and not isNil(arg_566_1.actors_["1066ui_story"]) then
				if arg_566_1.var_.characterEffect1066ui_story and not isNil(arg_566_1.actors_["1066ui_story"]) then
					arg_566_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 and not isNil(arg_566_1.actors_["1066ui_story"]) and arg_566_1.var_.characterEffect1066ui_story then
				arg_566_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_569_2 = 0
			local var_569_3 = 0.2

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_2 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_4 = arg_566_1:GetWordFromCfg(106604141)
				local var_569_5 = arg_566_1:FormatText(var_569_4.content)

				arg_566_1.text_.text = var_569_5

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_7 = 8 <= 0 and var_569_3 or var_569_3 * (utf8.len(var_569_5) / 8)

				if (8 <= 0 and var_569_3 or var_569_3 * (utf8.len(var_569_5) / 8)) > 0 and var_569_3 < var_569_7 then
					arg_566_1.talkMaxDuration = var_569_7

					if var_569_7 + var_569_2 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_7 + var_569_2
					end
				end

				arg_566_1.text_.text = var_569_5
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604141", "story_v_side_old_106604.awb") ~= 0 then
					local var_569_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604141", "story_v_side_old_106604.awb") / 1000

					if var_569_8 + var_569_2 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_8 + var_569_2
					end

					if var_569_4.prefab_name ~= "" and arg_566_1.actors_[var_569_4.prefab_name] ~= nil then
						local var_569_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_4.prefab_name].transform, "story_v_side_old_106604", "106604141", "story_v_side_old_106604.awb")

						arg_566_1:RecordAudio("106604141", var_569_9)
						arg_566_1:RecordAudio("106604141", var_569_9)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604141", "story_v_side_old_106604.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604141", "story_v_side_old_106604.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_10 = math.max(var_569_3, arg_566_1.talkMaxDuration)

			if var_569_2 <= arg_566_1.time_ and arg_566_1.time_ < var_569_2 + var_569_10 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_2) / var_569_10

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_2 + var_569_10 and arg_566_1.time_ < var_569_2 + var_569_10 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play106604142 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 106604142
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play106604143(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1066ui_story"]) and arg_570_1.var_.characterEffect1066ui_story == nil then
				arg_570_1.var_.characterEffect1066ui_story = arg_570_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.1

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1066ui_story"]) then
				if arg_570_1.var_.characterEffect1066ui_story and not isNil(arg_570_1.actors_["1066ui_story"]) then
					arg_570_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_570_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_570_1.time_ - 0) / var_573_0)
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1066ui_story"]) and arg_570_1.var_.characterEffect1066ui_story then
				arg_570_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_570_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_573_1 = 0
			local var_573_2 = 0.05

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, true)
				arg_570_1.iconController_:SetSelectedState("hero")

				arg_570_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_570_1.callingController_:SetSelectedState("normal")

				arg_570_1.keyicon_.color = Color.New(1, 1, 1)
				arg_570_1.icon_.color = Color.New(1, 1, 1)

				local var_573_3 = arg_570_1:FormatText(arg_570_1:GetWordFromCfg(106604142).content)

				arg_570_1.text_.text = var_573_3

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_5 = 2 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_3) / 2)

				if (2 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_3) / 2)) > 0 and var_573_2 < var_573_5 then
					arg_570_1.talkMaxDuration = var_573_5

					if var_573_5 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_5 + var_573_1
					end
				end

				arg_570_1.text_.text = var_573_3
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_6 = math.max(var_573_2, arg_570_1.talkMaxDuration)

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_6 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_1) / var_573_6

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_1 + var_573_6 and arg_570_1.time_ < var_573_1 + var_573_6 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play106604143 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 106604143
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play106604144(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0.75

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_1 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(106604143).content)

				arg_574_1.text_.text = var_577_1

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_3 = 30 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 30)

				if (30 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 30)) > 0 and var_577_0 < var_577_3 then
					arg_574_1.talkMaxDuration = var_577_3

					if var_577_3 + 0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_3 + 0
					end
				end

				arg_574_1.text_.text = var_577_1
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_4 = math.max(var_577_0, arg_574_1.talkMaxDuration)

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_4 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - 0) / var_577_4

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= 0 + var_577_4 and arg_574_1.time_ < 0 + var_577_4 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play106604144 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 106604144
		arg_578_1.duration_ = 5.3

		local var_578_0 = {
			ja = 3.866,
			ko = 5.3,
			en = 4.166
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play106604145(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(arg_578_1.actors_["1066ui_story"]) and arg_578_1.var_.characterEffect1066ui_story == nil then
				arg_578_1.var_.characterEffect1066ui_story = arg_578_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_0 = 0.1

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 and not isNil(arg_578_1.actors_["1066ui_story"]) then
				if arg_578_1.var_.characterEffect1066ui_story and not isNil(arg_578_1.actors_["1066ui_story"]) then
					arg_578_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 and not isNil(arg_578_1.actors_["1066ui_story"]) and arg_578_1.var_.characterEffect1066ui_story then
				arg_578_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_581_2 = 0
			local var_581_3 = 0.6

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_2 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_4 = arg_578_1:GetWordFromCfg(106604144)
				local var_581_5 = arg_578_1:FormatText(var_581_4.content)

				arg_578_1.text_.text = var_581_5

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_7 = 24 <= 0 and var_581_3 or var_581_3 * (utf8.len(var_581_5) / 24)

				if (24 <= 0 and var_581_3 or var_581_3 * (utf8.len(var_581_5) / 24)) > 0 and var_581_3 < var_581_7 then
					arg_578_1.talkMaxDuration = var_581_7

					if var_581_7 + var_581_2 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_7 + var_581_2
					end
				end

				arg_578_1.text_.text = var_581_5
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604144", "story_v_side_old_106604.awb") ~= 0 then
					local var_581_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604144", "story_v_side_old_106604.awb") / 1000

					if var_581_8 + var_581_2 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_8 + var_581_2
					end

					if var_581_4.prefab_name ~= "" and arg_578_1.actors_[var_581_4.prefab_name] ~= nil then
						local var_581_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_4.prefab_name].transform, "story_v_side_old_106604", "106604144", "story_v_side_old_106604.awb")

						arg_578_1:RecordAudio("106604144", var_581_9)
						arg_578_1:RecordAudio("106604144", var_581_9)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604144", "story_v_side_old_106604.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604144", "story_v_side_old_106604.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_10 = math.max(var_581_3, arg_578_1.talkMaxDuration)

			if var_581_2 <= arg_578_1.time_ and arg_578_1.time_ < var_581_2 + var_581_10 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_2) / var_581_10

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_2 + var_581_10 and arg_578_1.time_ < var_581_2 + var_581_10 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play106604145 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 106604145
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play106604146(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(arg_582_1.actors_["1066ui_story"]) and arg_582_1.var_.characterEffect1066ui_story == nil then
				arg_582_1.var_.characterEffect1066ui_story = arg_582_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_0 = 0.1

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 and not isNil(arg_582_1.actors_["1066ui_story"]) then
				if arg_582_1.var_.characterEffect1066ui_story and not isNil(arg_582_1.actors_["1066ui_story"]) then
					arg_582_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_582_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_582_1.time_ - 0) / var_585_0)
				end
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 and not isNil(arg_582_1.actors_["1066ui_story"]) and arg_582_1.var_.characterEffect1066ui_story then
				arg_582_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_582_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_585_1 = 0
			local var_585_2 = 0.125

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_3 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(106604145).content)

				arg_582_1.text_.text = var_585_3

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_5 = 5 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 5)

				if (5 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 5)) > 0 and var_585_2 < var_585_5 then
					arg_582_1.talkMaxDuration = var_585_5

					if var_585_5 + var_585_1 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_5 + var_585_1
					end
				end

				arg_582_1.text_.text = var_585_3
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_6 = math.max(var_585_2, arg_582_1.talkMaxDuration)

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_6 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_1) / var_585_6

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_1 + var_585_6 and arg_582_1.time_ < var_585_1 + var_585_6 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play106604146 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 106604146
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play106604147(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.var_.moveOldPos1066ui_story = arg_586_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_589_0 = 0.001

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 then
				arg_586_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1066ui_story, Vector3.New(30, -0.82, -5.5), (arg_586_1.time_ - 0) / var_589_0)
				arg_586_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_586_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1066ui_story"].transform.position).z)
				arg_586_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_586_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_586_1.actors_["1066ui_story"].transform.localEulerAngles = arg_586_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 then
				arg_586_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(30, -0.82, -5.5)
				arg_586_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_586_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1066ui_story"].transform.position).z)
				arg_586_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_586_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_586_1.actors_["1066ui_story"].transform.localEulerAngles = arg_586_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_589_1 = 0
			local var_589_2 = 0.65

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_3 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(106604146).content)

				arg_586_1.text_.text = var_589_3

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_5 = 26 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 26)

				if (26 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 26)) > 0 and var_589_2 < var_589_5 then
					arg_586_1.talkMaxDuration = var_589_5

					if var_589_5 + var_589_1 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_5 + var_589_1
					end
				end

				arg_586_1.text_.text = var_589_3
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_6 = math.max(var_589_2, arg_586_1.talkMaxDuration)

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_6 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_1) / var_589_6

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_1 + var_589_6 and arg_586_1.time_ < var_589_1 + var_589_6 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play106604147 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 106604147
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play106604148(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.var_.moveOldPosB10e = arg_590_1.bgs_.B10e.transform.localPosition
			end

			local var_593_0 = 0.001

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_0 then
				arg_590_1.bgs_.B10e.transform.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPosB10e, Vector3.New(0, -100, 10), (arg_590_1.time_ - 0) / var_593_0)
			end

			if arg_590_1.time_ >= 0 + var_593_0 and arg_590_1.time_ < 0 + var_593_0 + arg_593_0 then
				arg_590_1.bgs_.B10e.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_593_1 = "R6601"

			if arg_590_1.bgs_.R6601 == nil then
				local var_593_2 = Object.Instantiate(arg_590_1.paintGo_)

				var_593_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_593_1)
				var_593_2.name = var_593_1
				var_593_2.transform.parent = arg_590_1.stage_.transform
				var_593_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_590_1.bgs_[var_593_1] = var_593_2
			end

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				local var_593_3 = arg_590_1.bgs_.R6601

				arg_590_1.bgs_.R6601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_593_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_593_4 = var_593_3:GetComponent("SpriteRenderer")

				if var_593_4 and var_593_4.sprite then
					local var_593_5 = 2 * (var_593_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_593_3.transform.localScale = Vector3.New(var_593_5 / var_593_4.sprite.bounds.size.y < var_593_5 * manager.ui.mainCameraCom_.aspect / var_593_4.sprite.bounds.size.x and var_593_5 * manager.ui.mainCameraCom_.aspect / var_593_4.sprite.bounds.size.x or var_593_5 / var_593_4.sprite.bounds.size.y, var_593_5 / var_593_4.sprite.bounds.size.y < var_593_5 * manager.ui.mainCameraCom_.aspect / var_593_4.sprite.bounds.size.x and var_593_5 * manager.ui.mainCameraCom_.aspect / var_593_4.sprite.bounds.size.x or var_593_5 / var_593_4.sprite.bounds.size.y, 0)
				end

				for iter_593_0, iter_593_1 in pairs(arg_590_1.bgs_) do
					if iter_593_0 ~= "R6601" then
						iter_593_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_593_6 = 0
			local var_593_7 = 0.675

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_6 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_8 = arg_590_1:FormatText(arg_590_1:GetWordFromCfg(106604147).content)

				arg_590_1.text_.text = var_593_8

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_10 = 27 <= 0 and var_593_7 or var_593_7 * (utf8.len(var_593_8) / 27)

				if (27 <= 0 and var_593_7 or var_593_7 * (utf8.len(var_593_8) / 27)) > 0 and var_593_7 < var_593_10 then
					arg_590_1.talkMaxDuration = var_593_10

					if var_593_10 + var_593_6 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_10 + var_593_6
					end
				end

				arg_590_1.text_.text = var_593_8
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_11 = math.max(var_593_7, arg_590_1.talkMaxDuration)

			if var_593_6 <= arg_590_1.time_ and arg_590_1.time_ < var_593_6 + var_593_11 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_6) / var_593_11

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_6 + var_593_11 and arg_590_1.time_ < var_593_6 + var_593_11 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B10e",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_590_1:InitPlayNodeList()
	end,
	Play106604148 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 106604148
		arg_594_1.duration_ = 0.87

		local var_594_0 = {
			ja = 0.866,
			ko = 0.733,
			en = 0.8
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play106604149(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = 0.05

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, true)
				arg_594_1.iconController_:SetSelectedState("hero")

				arg_594_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_594_1.callingController_:SetSelectedState("normal")

				arg_594_1.keyicon_.color = Color.New(1, 1, 1)
				arg_594_1.icon_.color = Color.New(1, 1, 1)

				local var_597_1 = arg_594_1:GetWordFromCfg(106604148)
				local var_597_2 = arg_594_1:FormatText(var_597_1.content)

				arg_594_1.text_.text = var_597_2

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_4 = 2 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_2) / 2)

				if (2 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_2) / 2)) > 0 and var_597_0 < var_597_4 then
					arg_594_1.talkMaxDuration = var_597_4

					if var_597_4 + 0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_4 + 0
					end
				end

				arg_594_1.text_.text = var_597_2
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604148", "story_v_side_old_106604.awb") ~= 0 then
					local var_597_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604148", "story_v_side_old_106604.awb") / 1000

					if var_597_5 + 0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_5 + 0
					end

					if var_597_1.prefab_name ~= "" and arg_594_1.actors_[var_597_1.prefab_name] ~= nil then
						local var_597_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_1.prefab_name].transform, "story_v_side_old_106604", "106604148", "story_v_side_old_106604.awb")

						arg_594_1:RecordAudio("106604148", var_597_6)
						arg_594_1:RecordAudio("106604148", var_597_6)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604148", "story_v_side_old_106604.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604148", "story_v_side_old_106604.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_7 = math.max(var_597_0, arg_594_1.talkMaxDuration)

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_7 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - 0) / var_597_7

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= 0 + var_597_7 and arg_594_1.time_ < 0 + var_597_7 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play106604149 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 106604149
		arg_598_1.duration_ = 5

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play106604150(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = 0.825

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, true)
				arg_598_1.iconController_:SetSelectedState("hero")

				arg_598_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_598_1.callingController_:SetSelectedState("normal")

				arg_598_1.keyicon_.color = Color.New(1, 1, 1)
				arg_598_1.icon_.color = Color.New(1, 1, 1)

				local var_601_1 = arg_598_1:FormatText(arg_598_1:GetWordFromCfg(106604149).content)

				arg_598_1.text_.text = var_601_1

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_3 = 33 <= 0 and var_601_0 or var_601_0 * (utf8.len(var_601_1) / 33)

				if (33 <= 0 and var_601_0 or var_601_0 * (utf8.len(var_601_1) / 33)) > 0 and var_601_0 < var_601_3 then
					arg_598_1.talkMaxDuration = var_601_3

					if var_601_3 + 0 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_3 + 0
					end
				end

				arg_598_1.text_.text = var_601_1
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)
				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_4 = math.max(var_601_0, arg_598_1.talkMaxDuration)

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_4 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - 0) / var_601_4

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= 0 + var_601_4 and arg_598_1.time_ < 0 + var_601_4 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play106604150 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 106604150
		arg_602_1.duration_ = 5

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play106604151(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = 1.225

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, true)
				arg_602_1.iconController_:SetSelectedState("hero")

				arg_602_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_602_1.callingController_:SetSelectedState("normal")

				arg_602_1.keyicon_.color = Color.New(1, 1, 1)
				arg_602_1.icon_.color = Color.New(1, 1, 1)

				local var_605_1 = arg_602_1:FormatText(arg_602_1:GetWordFromCfg(106604150).content)

				arg_602_1.text_.text = var_605_1

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_3 = 49 <= 0 and var_605_0 or var_605_0 * (utf8.len(var_605_1) / 49)

				if (49 <= 0 and var_605_0 or var_605_0 * (utf8.len(var_605_1) / 49)) > 0 and var_605_0 < var_605_3 then
					arg_602_1.talkMaxDuration = var_605_3

					if var_605_3 + 0 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_3 + 0
					end
				end

				arg_602_1.text_.text = var_605_1
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)
				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_4 = math.max(var_605_0, arg_602_1.talkMaxDuration)

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_4 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - 0) / var_605_4

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= 0 + var_605_4 and arg_602_1.time_ < 0 + var_605_4 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play106604151 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 106604151
		arg_606_1.duration_ = 2.03

		local var_606_0 = {
			ja = 1.3,
			ko = 1.2,
			en = 2.033
		}
		local var_606_1 = manager.audio:GetLocalizationFlag()

		if var_606_0[var_606_1] ~= nil then
			arg_606_1.duration_ = var_606_0[var_606_1]
		end

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play106604152(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = 0.05

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				arg_606_1.leftNameTxt_.text = arg_606_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, true)
				arg_606_1.iconController_:SetSelectedState("hero")

				arg_606_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_606_1.callingController_:SetSelectedState("normal")

				arg_606_1.keyicon_.color = Color.New(1, 1, 1)
				arg_606_1.icon_.color = Color.New(1, 1, 1)

				local var_609_1 = arg_606_1:GetWordFromCfg(106604151)
				local var_609_2 = arg_606_1:FormatText(var_609_1.content)

				arg_606_1.text_.text = var_609_2

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_4 = 2 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_2) / 2)

				if (2 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_2) / 2)) > 0 and var_609_0 < var_609_4 then
					arg_606_1.talkMaxDuration = var_609_4

					if var_609_4 + 0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_4 + 0
					end
				end

				arg_606_1.text_.text = var_609_2
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604151", "story_v_side_old_106604.awb") ~= 0 then
					local var_609_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604151", "story_v_side_old_106604.awb") / 1000

					if var_609_5 + 0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_5 + 0
					end

					if var_609_1.prefab_name ~= "" and arg_606_1.actors_[var_609_1.prefab_name] ~= nil then
						local var_609_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_1.prefab_name].transform, "story_v_side_old_106604", "106604151", "story_v_side_old_106604.awb")

						arg_606_1:RecordAudio("106604151", var_609_6)
						arg_606_1:RecordAudio("106604151", var_609_6)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604151", "story_v_side_old_106604.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604151", "story_v_side_old_106604.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_7 = math.max(var_609_0, arg_606_1.talkMaxDuration)

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_7 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - 0) / var_609_7

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= 0 + var_609_7 and arg_606_1.time_ < 0 + var_609_7 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play106604152 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 106604152
		arg_610_1.duration_ = 14.17

		local var_610_0 = {
			ja = 7.066,
			ko = 8.1,
			en = 14.166
		}
		local var_610_1 = manager.audio:GetLocalizationFlag()

		if var_610_0[var_610_1] ~= nil then
			arg_610_1.duration_ = var_610_0[var_610_1]
		end

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play106604153(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = 0.975

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				arg_610_1.leftNameTxt_.text = arg_610_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, true)
				arg_610_1.iconController_:SetSelectedState("hero")

				arg_610_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_610_1.callingController_:SetSelectedState("normal")

				arg_610_1.keyicon_.color = Color.New(1, 1, 1)
				arg_610_1.icon_.color = Color.New(1, 1, 1)

				local var_613_1 = arg_610_1:GetWordFromCfg(106604152)
				local var_613_2 = arg_610_1:FormatText(var_613_1.content)

				arg_610_1.text_.text = var_613_2

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_4 = 39 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_2) / 39)

				if (39 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_2) / 39)) > 0 and var_613_0 < var_613_4 then
					arg_610_1.talkMaxDuration = var_613_4

					if var_613_4 + 0 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_4 + 0
					end
				end

				arg_610_1.text_.text = var_613_2
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604152", "story_v_side_old_106604.awb") ~= 0 then
					local var_613_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604152", "story_v_side_old_106604.awb") / 1000

					if var_613_5 + 0 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_5 + 0
					end

					if var_613_1.prefab_name ~= "" and arg_610_1.actors_[var_613_1.prefab_name] ~= nil then
						local var_613_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_610_1.actors_[var_613_1.prefab_name].transform, "story_v_side_old_106604", "106604152", "story_v_side_old_106604.awb")

						arg_610_1:RecordAudio("106604152", var_613_6)
						arg_610_1:RecordAudio("106604152", var_613_6)
					else
						arg_610_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604152", "story_v_side_old_106604.awb")
					end

					arg_610_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604152", "story_v_side_old_106604.awb")
				end

				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_7 = math.max(var_613_0, arg_610_1.talkMaxDuration)

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_7 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - 0) / var_613_7

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= 0 + var_613_7 and arg_610_1.time_ < 0 + var_613_7 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play106604153 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 106604153
		arg_614_1.duration_ = 11.3

		local var_614_0 = {
			ja = 8.166,
			ko = 6.2,
			en = 11.3
		}
		local var_614_1 = manager.audio:GetLocalizationFlag()

		if var_614_0[var_614_1] ~= nil then
			arg_614_1.duration_ = var_614_0[var_614_1]
		end

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play106604154(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0.775

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, true)
				arg_614_1.iconController_:SetSelectedState("hero")

				arg_614_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_614_1.callingController_:SetSelectedState("normal")

				arg_614_1.keyicon_.color = Color.New(1, 1, 1)
				arg_614_1.icon_.color = Color.New(1, 1, 1)

				local var_617_1 = arg_614_1:GetWordFromCfg(106604153)
				local var_617_2 = arg_614_1:FormatText(var_617_1.content)

				arg_614_1.text_.text = var_617_2

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_4 = 31 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_2) / 31)

				if (31 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_2) / 31)) > 0 and var_617_0 < var_617_4 then
					arg_614_1.talkMaxDuration = var_617_4

					if var_617_4 + 0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_4 + 0
					end
				end

				arg_614_1.text_.text = var_617_2
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604153", "story_v_side_old_106604.awb") ~= 0 then
					local var_617_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604153", "story_v_side_old_106604.awb") / 1000

					if var_617_5 + 0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_5 + 0
					end

					if var_617_1.prefab_name ~= "" and arg_614_1.actors_[var_617_1.prefab_name] ~= nil then
						local var_617_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_1.prefab_name].transform, "story_v_side_old_106604", "106604153", "story_v_side_old_106604.awb")

						arg_614_1:RecordAudio("106604153", var_617_6)
						arg_614_1:RecordAudio("106604153", var_617_6)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604153", "story_v_side_old_106604.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604153", "story_v_side_old_106604.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_7 = math.max(var_617_0, arg_614_1.talkMaxDuration)

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_7 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - 0) / var_617_7

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= 0 + var_617_7 and arg_614_1.time_ < 0 + var_617_7 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play106604154 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 106604154
		arg_618_1.duration_ = 6.5

		local var_618_0 = {
			ja = 6.5,
			ko = 4.2,
			en = 4.866
		}
		local var_618_1 = manager.audio:GetLocalizationFlag()

		if var_618_0[var_618_1] ~= nil then
			arg_618_1.duration_ = var_618_0[var_618_1]
		end

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play106604155(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = 0.55

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, true)
				arg_618_1.iconController_:SetSelectedState("hero")

				arg_618_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_618_1.callingController_:SetSelectedState("normal")

				arg_618_1.keyicon_.color = Color.New(1, 1, 1)
				arg_618_1.icon_.color = Color.New(1, 1, 1)

				local var_621_1 = arg_618_1:GetWordFromCfg(106604154)
				local var_621_2 = arg_618_1:FormatText(var_621_1.content)

				arg_618_1.text_.text = var_621_2

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_4 = 22 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 22)

				if (22 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 22)) > 0 and var_621_0 < var_621_4 then
					arg_618_1.talkMaxDuration = var_621_4

					if var_621_4 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_4 + 0
					end
				end

				arg_618_1.text_.text = var_621_2
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604154", "story_v_side_old_106604.awb") ~= 0 then
					local var_621_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604154", "story_v_side_old_106604.awb") / 1000

					if var_621_5 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_5 + 0
					end

					if var_621_1.prefab_name ~= "" and arg_618_1.actors_[var_621_1.prefab_name] ~= nil then
						local var_621_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_1.prefab_name].transform, "story_v_side_old_106604", "106604154", "story_v_side_old_106604.awb")

						arg_618_1:RecordAudio("106604154", var_621_6)
						arg_618_1:RecordAudio("106604154", var_621_6)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604154", "story_v_side_old_106604.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604154", "story_v_side_old_106604.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_7 = math.max(var_621_0, arg_618_1.talkMaxDuration)

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_7 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - 0) / var_621_7

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= 0 + var_621_7 and arg_618_1.time_ < 0 + var_621_7 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {}

		arg_618_1:InitPlayNodeList()
	end,
	Play106604155 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 106604155
		arg_622_1.duration_ = 12.43

		local var_622_0 = {
			ja = 9.6,
			ko = 11.966,
			en = 12.433
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play106604156(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = 1.225

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_1 = arg_622_1:GetWordFromCfg(106604155)
				local var_625_2 = arg_622_1:FormatText(var_625_1.content)

				arg_622_1.text_.text = var_625_2

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_4 = 49 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_2) / 49)

				if (49 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_2) / 49)) > 0 and var_625_0 < var_625_4 then
					arg_622_1.talkMaxDuration = var_625_4

					if var_625_4 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_4 + 0
					end
				end

				arg_622_1.text_.text = var_625_2
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604155", "story_v_side_old_106604.awb") ~= 0 then
					local var_625_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604155", "story_v_side_old_106604.awb") / 1000

					if var_625_5 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_5 + 0
					end

					if var_625_1.prefab_name ~= "" and arg_622_1.actors_[var_625_1.prefab_name] ~= nil then
						local var_625_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_1.prefab_name].transform, "story_v_side_old_106604", "106604155", "story_v_side_old_106604.awb")

						arg_622_1:RecordAudio("106604155", var_625_6)
						arg_622_1:RecordAudio("106604155", var_625_6)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604155", "story_v_side_old_106604.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604155", "story_v_side_old_106604.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_7 = math.max(var_625_0, arg_622_1.talkMaxDuration)

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_7 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - 0) / var_625_7

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= 0 + var_625_7 and arg_622_1.time_ < 0 + var_625_7 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play106604156 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 106604156
		arg_626_1.duration_ = 7

		local var_626_0 = {
			ja = 6.566,
			ko = 6.1,
			en = 7
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play106604157(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0.65

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, true)
				arg_626_1.iconController_:SetSelectedState("hero")

				arg_626_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_626_1.callingController_:SetSelectedState("normal")

				arg_626_1.keyicon_.color = Color.New(1, 1, 1)
				arg_626_1.icon_.color = Color.New(1, 1, 1)

				local var_629_1 = arg_626_1:GetWordFromCfg(106604156)
				local var_629_2 = arg_626_1:FormatText(var_629_1.content)

				arg_626_1.text_.text = var_629_2

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_4 = 26 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 26)

				if (26 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 26)) > 0 and var_629_0 < var_629_4 then
					arg_626_1.talkMaxDuration = var_629_4

					if var_629_4 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_4 + 0
					end
				end

				arg_626_1.text_.text = var_629_2
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604156", "story_v_side_old_106604.awb") ~= 0 then
					local var_629_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604156", "story_v_side_old_106604.awb") / 1000

					if var_629_5 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_5 + 0
					end

					if var_629_1.prefab_name ~= "" and arg_626_1.actors_[var_629_1.prefab_name] ~= nil then
						local var_629_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_1.prefab_name].transform, "story_v_side_old_106604", "106604156", "story_v_side_old_106604.awb")

						arg_626_1:RecordAudio("106604156", var_629_6)
						arg_626_1:RecordAudio("106604156", var_629_6)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604156", "story_v_side_old_106604.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604156", "story_v_side_old_106604.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_7 = math.max(var_629_0, arg_626_1.talkMaxDuration)

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_7 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - 0) / var_629_7

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= 0 + var_629_7 and arg_626_1.time_ < 0 + var_629_7 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play106604157 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 106604157
		arg_630_1.duration_ = 6.93

		local var_630_0 = {
			ja = 4.4,
			ko = 4.733,
			en = 6.933
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play106604158(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0.8

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, true)
				arg_630_1.iconController_:SetSelectedState("hero")

				arg_630_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_630_1.callingController_:SetSelectedState("normal")

				arg_630_1.keyicon_.color = Color.New(1, 1, 1)
				arg_630_1.icon_.color = Color.New(1, 1, 1)

				local var_633_1 = arg_630_1:GetWordFromCfg(106604157)
				local var_633_2 = arg_630_1:FormatText(var_633_1.content)

				arg_630_1.text_.text = var_633_2

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_4 = 32 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_2) / 32)

				if (32 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_2) / 32)) > 0 and var_633_0 < var_633_4 then
					arg_630_1.talkMaxDuration = var_633_4

					if var_633_4 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_4 + 0
					end
				end

				arg_630_1.text_.text = var_633_2
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604157", "story_v_side_old_106604.awb") ~= 0 then
					local var_633_5 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604157", "story_v_side_old_106604.awb") / 1000

					if var_633_5 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_5 + 0
					end

					if var_633_1.prefab_name ~= "" and arg_630_1.actors_[var_633_1.prefab_name] ~= nil then
						local var_633_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_1.prefab_name].transform, "story_v_side_old_106604", "106604157", "story_v_side_old_106604.awb")

						arg_630_1:RecordAudio("106604157", var_633_6)
						arg_630_1:RecordAudio("106604157", var_633_6)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604157", "story_v_side_old_106604.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604157", "story_v_side_old_106604.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_7 = math.max(var_633_0, arg_630_1.talkMaxDuration)

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_7 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - 0) / var_633_7

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= 0 + var_633_7 and arg_630_1.time_ < 0 + var_633_7 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play106604158 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 106604158
		arg_634_1.duration_ = 5

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play106604159(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(arg_634_1.actors_["1066ui_story"]) and arg_634_1.var_.characterEffect1066ui_story == nil then
				arg_634_1.var_.characterEffect1066ui_story = arg_634_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_0 = 0.1

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_0 and not isNil(arg_634_1.actors_["1066ui_story"]) then
				if arg_634_1.var_.characterEffect1066ui_story and not isNil(arg_634_1.actors_["1066ui_story"]) then
					arg_634_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_634_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_634_1.time_ - 0) / var_637_0)
				end
			end

			if arg_634_1.time_ >= 0 + var_637_0 and arg_634_1.time_ < 0 + var_637_0 + arg_637_0 and not isNil(arg_634_1.actors_["1066ui_story"]) and arg_634_1.var_.characterEffect1066ui_story then
				arg_634_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_634_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_637_1 = 0
			local var_637_2 = 0.05

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_3 = arg_634_1:FormatText(arg_634_1:GetWordFromCfg(106604158).content)

				arg_634_1.text_.text = var_637_3

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_5 = 2 <= 0 and var_637_2 or var_637_2 * (utf8.len(var_637_3) / 2)

				if (2 <= 0 and var_637_2 or var_637_2 * (utf8.len(var_637_3) / 2)) > 0 and var_637_2 < var_637_5 then
					arg_634_1.talkMaxDuration = var_637_5

					if var_637_5 + var_637_1 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_5 + var_637_1
					end
				end

				arg_634_1.text_.text = var_637_3
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)
				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_6 = math.max(var_637_2, arg_634_1.talkMaxDuration)

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_6 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_1) / var_637_6

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_1 + var_637_6 and arg_634_1.time_ < var_637_1 + var_637_6 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play106604159 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 106604159
		arg_638_1.duration_ = 9.03

		local var_638_0 = {
			ja = 6.566,
			ko = 9.033,
			en = 8.333
		}
		local var_638_1 = manager.audio:GetLocalizationFlag()

		if var_638_0[var_638_1] ~= nil then
			arg_638_1.duration_ = var_638_0[var_638_1]
		end

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play106604160(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 and not isNil(arg_638_1.actors_["1066ui_story"]) and arg_638_1.var_.characterEffect1066ui_story == nil then
				arg_638_1.var_.characterEffect1066ui_story = arg_638_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_641_0 = 0.1

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_0 and not isNil(arg_638_1.actors_["1066ui_story"]) then
				if arg_638_1.var_.characterEffect1066ui_story and not isNil(arg_638_1.actors_["1066ui_story"]) then
					arg_638_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_638_1.time_ >= 0 + var_641_0 and arg_638_1.time_ < 0 + var_641_0 + arg_641_0 and not isNil(arg_638_1.actors_["1066ui_story"]) and arg_638_1.var_.characterEffect1066ui_story then
				arg_638_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_641_2 = 0
			local var_641_3 = 0.925

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_2 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				arg_638_1.leftNameTxt_.text = arg_638_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, true)
				arg_638_1.iconController_:SetSelectedState("hero")

				arg_638_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_638_1.callingController_:SetSelectedState("normal")

				arg_638_1.keyicon_.color = Color.New(1, 1, 1)
				arg_638_1.icon_.color = Color.New(1, 1, 1)

				local var_641_4 = arg_638_1:GetWordFromCfg(106604159)
				local var_641_5 = arg_638_1:FormatText(var_641_4.content)

				arg_638_1.text_.text = var_641_5

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_7 = 37 <= 0 and var_641_3 or var_641_3 * (utf8.len(var_641_5) / 37)

				if (37 <= 0 and var_641_3 or var_641_3 * (utf8.len(var_641_5) / 37)) > 0 and var_641_3 < var_641_7 then
					arg_638_1.talkMaxDuration = var_641_7

					if var_641_7 + var_641_2 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_7 + var_641_2
					end
				end

				arg_638_1.text_.text = var_641_5
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604159", "story_v_side_old_106604.awb") ~= 0 then
					local var_641_8 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604159", "story_v_side_old_106604.awb") / 1000

					if var_641_8 + var_641_2 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_8 + var_641_2
					end

					if var_641_4.prefab_name ~= "" and arg_638_1.actors_[var_641_4.prefab_name] ~= nil then
						local var_641_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_4.prefab_name].transform, "story_v_side_old_106604", "106604159", "story_v_side_old_106604.awb")

						arg_638_1:RecordAudio("106604159", var_641_9)
						arg_638_1:RecordAudio("106604159", var_641_9)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604159", "story_v_side_old_106604.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604159", "story_v_side_old_106604.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_10 = math.max(var_641_3, arg_638_1.talkMaxDuration)

			if var_641_2 <= arg_638_1.time_ and arg_638_1.time_ < var_641_2 + var_641_10 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_2) / var_641_10

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_2 + var_641_10 and arg_638_1.time_ < var_641_2 + var_641_10 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play106604160 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 106604160
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play106604161(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1.var_.moveOldPosR6601 = arg_642_1.bgs_.R6601.transform.localPosition
			end

			local var_645_0 = 0.001

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_0 then
				arg_642_1.bgs_.R6601.transform.localPosition = Vector3.Lerp(arg_642_1.var_.moveOldPosR6601, Vector3.New(0, -100, 10), (arg_642_1.time_ - 0) / var_645_0)
			end

			if arg_642_1.time_ >= 0 + var_645_0 and arg_642_1.time_ < 0 + var_645_0 + arg_645_0 then
				arg_642_1.bgs_.R6601.transform.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				local var_645_1 = arg_642_1.bgs_.B10e

				arg_642_1.bgs_.B10e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_645_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_645_2 = var_645_1:GetComponent("SpriteRenderer")

				if var_645_2 and var_645_2.sprite then
					local var_645_3 = 2 * (var_645_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_645_1.transform.localScale = Vector3.New(var_645_3 / var_645_2.sprite.bounds.size.y < var_645_3 * manager.ui.mainCameraCom_.aspect / var_645_2.sprite.bounds.size.x and var_645_3 * manager.ui.mainCameraCom_.aspect / var_645_2.sprite.bounds.size.x or var_645_3 / var_645_2.sprite.bounds.size.y, var_645_3 / var_645_2.sprite.bounds.size.y < var_645_3 * manager.ui.mainCameraCom_.aspect / var_645_2.sprite.bounds.size.x and var_645_3 * manager.ui.mainCameraCom_.aspect / var_645_2.sprite.bounds.size.x or var_645_3 / var_645_2.sprite.bounds.size.y, 0)
				end

				for iter_645_0, iter_645_1 in pairs(arg_642_1.bgs_) do
					if iter_645_0 ~= "B10e" then
						iter_645_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_645_4 = 0
			local var_645_5 = 0.65

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_4 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, false)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_6 = arg_642_1:FormatText(arg_642_1:GetWordFromCfg(106604160).content)

				arg_642_1.text_.text = var_645_6

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_8 = 26 <= 0 and var_645_5 or var_645_5 * (utf8.len(var_645_6) / 26)

				if (26 <= 0 and var_645_5 or var_645_5 * (utf8.len(var_645_6) / 26)) > 0 and var_645_5 < var_645_8 then
					arg_642_1.talkMaxDuration = var_645_8

					if var_645_8 + var_645_4 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_8 + var_645_4
					end
				end

				arg_642_1.text_.text = var_645_6
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_9 = math.max(var_645_5, arg_642_1.talkMaxDuration)

			if var_645_4 <= arg_642_1.time_ and arg_642_1.time_ < var_645_4 + var_645_9 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_4) / var_645_9

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_4 + var_645_9 and arg_642_1.time_ < var_645_4 + var_645_9 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R6601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_642_1:InitPlayNodeList()
	end,
	Play106604161 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 106604161
		arg_646_1.duration_ = 6.87

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play106604162(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.var_.moveOldPos1066ui_story = arg_646_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_649_0 = 0.001

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_0 then
				arg_646_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.82, -5.5), (arg_646_1.time_ - 0) / var_649_0)
				arg_646_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_646_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1066ui_story"].transform.position).z)
				arg_646_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_646_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_646_1.actors_["1066ui_story"].transform.localEulerAngles = arg_646_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_646_1.time_ >= 0 + var_649_0 and arg_646_1.time_ < 0 + var_649_0 + arg_649_0 then
				arg_646_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.82, -5.5)
				arg_646_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_646_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1066ui_story"].transform.position).z)
				arg_646_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_646_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_646_1.actors_["1066ui_story"].transform.localEulerAngles = arg_646_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_649_1 = 0
			local var_649_2 = 0.425

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_3 = arg_646_1:FormatText(arg_646_1:GetWordFromCfg(106604161).content)

				arg_646_1.text_.text = var_649_3

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_5 = 17 <= 0 and var_649_2 or var_649_2 * (utf8.len(var_649_3) / 17)

				if (17 <= 0 and var_649_2 or var_649_2 * (utf8.len(var_649_3) / 17)) > 0 and var_649_2 < var_649_5 then
					arg_646_1.talkMaxDuration = var_649_5

					if var_649_5 + var_649_1 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_5 + var_649_1
					end
				end

				arg_646_1.text_.text = var_649_3
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_6 = math.max(var_649_2, arg_646_1.talkMaxDuration)

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_6 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_1) / var_649_6

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_1 + var_649_6 and arg_646_1.time_ < var_649_1 + var_649_6 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play106604162 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 106604162
		arg_650_1.duration_ = 6.57

		local var_650_0 = {
			ja = 6.566,
			ko = 2.2,
			en = 2
		}
		local var_650_1 = manager.audio:GetLocalizationFlag()

		if var_650_0[var_650_1] ~= nil then
			arg_650_1.duration_ = var_650_0[var_650_1]
		end

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play106604163(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_653_0 = 0
			local var_653_1 = 0.2

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_0 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				arg_650_1.leftNameTxt_.text = arg_650_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_2 = arg_650_1:GetWordFromCfg(106604162)
				local var_653_3 = arg_650_1:FormatText(var_653_2.content)

				arg_650_1.text_.text = var_653_3

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_5 = 8 <= 0 and var_653_1 or var_653_1 * (utf8.len(var_653_3) / 8)

				if (8 <= 0 and var_653_1 or var_653_1 * (utf8.len(var_653_3) / 8)) > 0 and var_653_1 < var_653_5 then
					arg_650_1.talkMaxDuration = var_653_5

					if var_653_5 + var_653_0 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_5 + var_653_0
					end
				end

				arg_650_1.text_.text = var_653_3
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106604", "106604162", "story_v_side_old_106604.awb") ~= 0 then
					local var_653_6 = manager.audio:GetVoiceLength("story_v_side_old_106604", "106604162", "story_v_side_old_106604.awb") / 1000

					if var_653_6 + var_653_0 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_6 + var_653_0
					end

					if var_653_2.prefab_name ~= "" and arg_650_1.actors_[var_653_2.prefab_name] ~= nil then
						local var_653_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_2.prefab_name].transform, "story_v_side_old_106604", "106604162", "story_v_side_old_106604.awb")

						arg_650_1:RecordAudio("106604162", var_653_7)
						arg_650_1:RecordAudio("106604162", var_653_7)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_side_old_106604", "106604162", "story_v_side_old_106604.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_side_old_106604", "106604162", "story_v_side_old_106604.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_8 = math.max(var_653_1, arg_650_1.talkMaxDuration)

			if var_653_0 <= arg_650_1.time_ and arg_650_1.time_ < var_653_0 + var_653_8 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_0) / var_653_8

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_0 + var_653_8 and arg_650_1.time_ < var_653_0 + var_653_8 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {}

		arg_650_1:InitPlayNodeList()
	end,
	Play106604163 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 106604163
		arg_654_1.duration_ = 5

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play106604164(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 and not isNil(arg_654_1.actors_["1066ui_story"]) and arg_654_1.var_.characterEffect1066ui_story == nil then
				arg_654_1.var_.characterEffect1066ui_story = arg_654_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_0 = 0.1

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_0 and not isNil(arg_654_1.actors_["1066ui_story"]) then
				if arg_654_1.var_.characterEffect1066ui_story and not isNil(arg_654_1.actors_["1066ui_story"]) then
					arg_654_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_654_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_654_1.time_ - 0) / var_657_0)
				end
			end

			if arg_654_1.time_ >= 0 + var_657_0 and arg_654_1.time_ < 0 + var_657_0 + arg_657_0 and not isNil(arg_654_1.actors_["1066ui_story"]) and arg_654_1.var_.characterEffect1066ui_story then
				arg_654_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_654_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_657_1 = 0
			local var_657_2 = 0.05

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_1 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, true)
				arg_654_1.iconController_:SetSelectedState("hero")

				arg_654_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_654_1.callingController_:SetSelectedState("normal")

				arg_654_1.keyicon_.color = Color.New(1, 1, 1)
				arg_654_1.icon_.color = Color.New(1, 1, 1)

				local var_657_3 = arg_654_1:FormatText(arg_654_1:GetWordFromCfg(106604163).content)

				arg_654_1.text_.text = var_657_3

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_5 = 2 <= 0 and var_657_2 or var_657_2 * (utf8.len(var_657_3) / 2)

				if (2 <= 0 and var_657_2 or var_657_2 * (utf8.len(var_657_3) / 2)) > 0 and var_657_2 < var_657_5 then
					arg_654_1.talkMaxDuration = var_657_5

					if var_657_5 + var_657_1 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_5 + var_657_1
					end
				end

				arg_654_1.text_.text = var_657_3
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_6 = math.max(var_657_2, arg_654_1.talkMaxDuration)

			if var_657_1 <= arg_654_1.time_ and arg_654_1.time_ < var_657_1 + var_657_6 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_1) / var_657_6

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_1 + var_657_6 and arg_654_1.time_ < var_657_1 + var_657_6 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play106604164 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 106604164
		arg_658_1.duration_ = 5

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
			arg_658_1.auto_ = false
		end

		function arg_658_1.playNext_(arg_660_0)
			arg_658_1.onStoryFinished_()
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1.var_.moveOldPos1066ui_story = arg_658_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_661_0 = 0.001

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_0 then
				arg_658_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_658_1.var_.moveOldPos1066ui_story, Vector3.New(30, -0.82, -5.5), (arg_658_1.time_ - 0) / var_661_0)
				arg_658_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_658_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1066ui_story"].transform.position).z)
				arg_658_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_658_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_658_1.actors_["1066ui_story"].transform.localEulerAngles = arg_658_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_658_1.time_ >= 0 + var_661_0 and arg_658_1.time_ < 0 + var_661_0 + arg_661_0 then
				arg_658_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(30, -0.82, -5.5)
				arg_658_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_658_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1066ui_story"].transform.position).z)
				arg_658_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_658_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_658_1.actors_["1066ui_story"].transform.localEulerAngles = arg_658_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_661_1 = 0
			local var_661_2 = 0.1

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_1 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				arg_658_1.leftNameTxt_.text = arg_658_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, true)
				arg_658_1.iconController_:SetSelectedState("hero")

				arg_658_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_658_1.callingController_:SetSelectedState("normal")

				arg_658_1.keyicon_.color = Color.New(1, 1, 1)
				arg_658_1.icon_.color = Color.New(1, 1, 1)

				local var_661_3 = arg_658_1:FormatText(arg_658_1:GetWordFromCfg(106604164).content)

				arg_658_1.text_.text = var_661_3

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_5 = 4 <= 0 and var_661_2 or var_661_2 * (utf8.len(var_661_3) / 4)

				if (4 <= 0 and var_661_2 or var_661_2 * (utf8.len(var_661_3) / 4)) > 0 and var_661_2 < var_661_5 then
					arg_658_1.talkMaxDuration = var_661_5

					if var_661_5 + var_661_1 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_5 + var_661_1
					end
				end

				arg_658_1.text_.text = var_661_3
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)
				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_6 = math.max(var_661_2, arg_658_1.talkMaxDuration)

			if var_661_1 <= arg_658_1.time_ and arg_658_1.time_ < var_661_1 + var_661_6 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_1) / var_661_6

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_1 + var_661_6 and arg_658_1.time_ < var_661_1 + var_661_6 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_658_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a",
		"TextureConfig/Background/B08e",
		"TextureConfig/Background/B03f",
		"TextureConfig/Background/B03e",
		"TextureConfig/Background/B10b",
		"TextureConfig/Background/B10e",
		"TextureConfig/Background/R6601"
	},
	voices = {
		"story_v_side_old_106604.awb"
	}
}
