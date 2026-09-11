return {
	Play120061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J03h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03h")
				var_4_0.name = "J03h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J03h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J03h

				arg_1_1.bgs_.J03h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J03h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = "1071ui_story"

			if arg_1_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_1_1.stage_.transform)

				var_4_12.name = var_4_11
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_11] = var_4_12

				local var_4_13 = var_4_12:GetComponentInChildren(typeof(CharacterEffect))

				var_4_13.enabled = true

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_12, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_13.transform, false)

				arg_1_1.var_[var_4_11 .. "Animator"] = var_4_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_11 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_11 .. "LipSync"] = var_4_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_4_15 = 2
			local var_4_16 = 0.55

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(120061001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 22 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_17) / 22)

				if (22 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_17) / 22)) > 0 and var_4_16 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19

					if var_4_19 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_15) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_15 + var_4_20 and arg_1_1.time_ < var_4_15 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play120061002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 120061002
		arg_6_1.duration_ = 11.5

		local var_6_0 = {
			zh = 10.666,
			ja = 11.5
		}
		local var_6_1 = manager.audio:GetLocalizationFlag()

		if var_6_0[var_6_1] ~= nil then
			arg_6_1.duration_ = var_6_0[var_6_1]
		end

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play120061003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.var_.moveOldPos1071ui_story = arg_6_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_9_0 = 0.001

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_0 then
				arg_6_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_6_1.time_ - 0) / var_9_0)
				arg_6_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_6_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_6_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_6_1.actors_["1071ui_story"].transform.position).z)
				arg_6_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_6_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_6_1.actors_["1071ui_story"].transform.localEulerAngles = arg_6_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_6_1.time_ >= 0 + var_9_0 and arg_6_1.time_ < 0 + var_9_0 + arg_9_0 then
				arg_6_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_6_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_6_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_6_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_6_1.actors_["1071ui_story"].transform.position).z)
				arg_6_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_6_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_6_1.actors_["1071ui_story"].transform.localEulerAngles = arg_6_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_9_1 = "1069ui_story"

			if arg_6_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_9_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_6_1.stage_.transform)

				var_9_2.name = var_9_1
				var_9_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.actors_[var_9_1] = var_9_2

				local var_9_3 = var_9_2:GetComponentInChildren(typeof(CharacterEffect))

				var_9_3.enabled = true

				local var_9_4 = GameObjectTools.GetOrAddComponent(var_9_2, typeof(DynamicBoneHelper))

				if var_9_4 then
					var_9_4:EnableDynamicBone(false)
				end

				arg_6_1:ShowWeapon(var_9_3.transform, false)

				arg_6_1.var_[var_9_1 .. "Animator"] = var_9_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_6_1.var_[var_9_1 .. "Animator"].applyRootMotion = true
				arg_6_1.var_[var_9_1 .. "LipSync"] = var_9_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_9_5 = arg_6_1.actors_["1069ui_story"].transform

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.var_.moveOldPos1069ui_story = var_9_5.localPosition
			end

			local var_9_6 = 0.001

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_6 then
				var_9_5.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_6_1.time_ - 0) / var_9_6)
				var_9_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_5.position).x, (manager.ui.mainCamera.transform.position - var_9_5.position).y, (manager.ui.mainCamera.transform.position - var_9_5.position).z)
				var_9_5.localEulerAngles.z = 0
				var_9_5.localEulerAngles.x = 0
				var_9_5.localEulerAngles = var_9_5.localEulerAngles
			end

			if arg_6_1.time_ >= 0 + var_9_6 and arg_6_1.time_ < 0 + var_9_6 + arg_9_0 then
				var_9_5.localPosition = Vector3.New(0.7, -1, -6)
				var_9_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_5.position).x, (manager.ui.mainCamera.transform.position - var_9_5.position).y, (manager.ui.mainCamera.transform.position - var_9_5.position).z)
				var_9_5.localEulerAngles.z = 0
				var_9_5.localEulerAngles.x = 0
				var_9_5.localEulerAngles = var_9_5.localEulerAngles
			end

			local var_9_7 = arg_6_1.actors_["1071ui_story"]

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 and not isNil(var_9_7) and arg_6_1.var_.characterEffect1071ui_story == nil then
				arg_6_1.var_.characterEffect1071ui_story = var_9_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_8 = 0.2

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_8 and not isNil(var_9_7) then
				if arg_6_1.var_.characterEffect1071ui_story and not isNil(var_9_7) then
					arg_6_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= 0 + var_9_8 and arg_6_1.time_ < 0 + var_9_8 + arg_9_0 and not isNil(var_9_7) and arg_6_1.var_.characterEffect1071ui_story then
				arg_6_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_9_10 = arg_6_1.actors_["1069ui_story"]

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 and not isNil(var_9_10) and arg_6_1.var_.characterEffect1069ui_story == nil then
				arg_6_1.var_.characterEffect1069ui_story = var_9_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_11 = 0.2

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_11 and not isNil(var_9_10) then
				if arg_6_1.var_.characterEffect1069ui_story and not isNil(var_9_10) then
					arg_6_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_6_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_6_1.time_ - 0) / var_9_11)
				end
			end

			if arg_6_1.time_ >= 0 + var_9_11 and arg_6_1.time_ < 0 + var_9_11 + arg_9_0 and not isNil(var_9_10) and arg_6_1.var_.characterEffect1069ui_story then
				arg_6_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_6_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_1")
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_9_12 = 0
			local var_9_13 = 0.325

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_12 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0
				arg_6_1.dialogCg_.alpha = 1

				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.leftNameGo_, true)

				arg_6_1.leftNameTxt_.text = arg_6_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_14 = arg_6_1:GetWordFromCfg(120061002)
				local var_9_15 = arg_6_1:FormatText(var_9_14.content)

				arg_6_1.text_.text = var_9_15

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_17 = 13 <= 0 and var_9_13 or var_9_13 * (utf8.len(var_9_15) / 13)

				if (13 <= 0 and var_9_13 or var_9_13 * (utf8.len(var_9_15) / 13)) > 0 and var_9_13 < var_9_17 then
					arg_6_1.talkMaxDuration = var_9_17

					if var_9_17 + var_9_12 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_17 + var_9_12
					end
				end

				arg_6_1.text_.text = var_9_15
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061002", "story_v_out_120061.awb") ~= 0 then
					local var_9_18 = manager.audio:GetVoiceLength("story_v_out_120061", "120061002", "story_v_out_120061.awb") / 1000

					if var_9_18 + var_9_12 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_18 + var_9_12
					end

					if var_9_14.prefab_name ~= "" and arg_6_1.actors_[var_9_14.prefab_name] ~= nil then
						local var_9_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_14.prefab_name].transform, "story_v_out_120061", "120061002", "story_v_out_120061.awb")

						arg_6_1:RecordAudio("120061002", var_9_19)
						arg_6_1:RecordAudio("120061002", var_9_19)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_120061", "120061002", "story_v_out_120061.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_120061", "120061002", "story_v_out_120061.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_20 = math.max(var_9_13, arg_6_1.talkMaxDuration)

			if var_9_12 <= arg_6_1.time_ and arg_6_1.time_ < var_9_12 + var_9_20 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_12) / var_9_20

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_12 + var_9_20 and arg_6_1.time_ < var_9_12 + var_9_20 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play120061003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 120061003
		arg_10_1.duration_ = 12.4

		local var_10_0 = {
			zh = 9.966,
			ja = 12.4
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play120061004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0.325

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:GetWordFromCfg(120061003)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.text_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 13 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 13)

				if (13 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 13)) > 0 and var_13_0 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end

				arg_10_1.text_.text = var_13_2
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061003", "story_v_out_120061.awb") ~= 0 then
					local var_13_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061003", "story_v_out_120061.awb") / 1000

					if var_13_5 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + 0
					end

					if var_13_1.prefab_name ~= "" and arg_10_1.actors_[var_13_1.prefab_name] ~= nil then
						local var_13_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_1.prefab_name].transform, "story_v_out_120061", "120061003", "story_v_out_120061.awb")

						arg_10_1:RecordAudio("120061003", var_13_6)
						arg_10_1:RecordAudio("120061003", var_13_6)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_120061", "120061003", "story_v_out_120061.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_120061", "120061003", "story_v_out_120061.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play120061004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 120061004
		arg_14_1.duration_ = 5.4

		local var_14_0 = {
			zh = 4.133,
			ja = 5.4
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play120061005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["1071ui_story"]) and arg_14_1.var_.characterEffect1071ui_story == nil then
				arg_14_1.var_.characterEffect1071ui_story = arg_14_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_0 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["1071ui_story"]) then
				if arg_14_1.var_.characterEffect1071ui_story and not isNil(arg_14_1.actors_["1071ui_story"]) then
					arg_14_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_14_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_14_1.time_ - 0) / var_17_0)
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["1071ui_story"]) and arg_14_1.var_.characterEffect1071ui_story then
				arg_14_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_14_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_17_1 = arg_14_1.actors_["1069ui_story"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_1) and arg_14_1.var_.characterEffect1069ui_story == nil then
				arg_14_1.var_.characterEffect1069ui_story = var_17_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_2 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_2 and not isNil(var_17_1) then
				if arg_14_1.var_.characterEffect1069ui_story and not isNil(var_17_1) then
					arg_14_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= 0 + var_17_2 and arg_14_1.time_ < 0 + var_17_2 + arg_17_0 and not isNil(var_17_1) and arg_14_1.var_.characterEffect1069ui_story then
				arg_14_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_17_4 = 0
			local var_17_5 = 0.45

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_6 = arg_14_1:GetWordFromCfg(120061004)
				local var_17_7 = arg_14_1:FormatText(var_17_6.content)

				arg_14_1.text_.text = var_17_7

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_9 = 18 <= 0 and var_17_5 or var_17_5 * (utf8.len(var_17_7) / 18)

				if (18 <= 0 and var_17_5 or var_17_5 * (utf8.len(var_17_7) / 18)) > 0 and var_17_5 < var_17_9 then
					arg_14_1.talkMaxDuration = var_17_9

					if var_17_9 + var_17_4 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_9 + var_17_4
					end
				end

				arg_14_1.text_.text = var_17_7
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061004", "story_v_out_120061.awb") ~= 0 then
					local var_17_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061004", "story_v_out_120061.awb") / 1000

					if var_17_10 + var_17_4 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_4
					end

					if var_17_6.prefab_name ~= "" and arg_14_1.actors_[var_17_6.prefab_name] ~= nil then
						local var_17_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_6.prefab_name].transform, "story_v_out_120061", "120061004", "story_v_out_120061.awb")

						arg_14_1:RecordAudio("120061004", var_17_11)
						arg_14_1:RecordAudio("120061004", var_17_11)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_120061", "120061004", "story_v_out_120061.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_120061", "120061004", "story_v_out_120061.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_12 = math.max(var_17_5, arg_14_1.talkMaxDuration)

			if var_17_4 <= arg_14_1.time_ and arg_14_1.time_ < var_17_4 + var_17_12 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_4) / var_17_12

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_4 + var_17_12 and arg_14_1.time_ < var_17_4 + var_17_12 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play120061005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 120061005
		arg_18_1.duration_ = 7.1

		local var_18_0 = {
			zh = 7.1,
			ja = 5.766
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play120061006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1071ui_story"]) and arg_18_1.var_.characterEffect1071ui_story == nil then
				arg_18_1.var_.characterEffect1071ui_story = arg_18_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1071ui_story"]) then
				if arg_18_1.var_.characterEffect1071ui_story and not isNil(arg_18_1.actors_["1071ui_story"]) then
					arg_18_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1071ui_story"]) and arg_18_1.var_.characterEffect1071ui_story then
				arg_18_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_21_2 = arg_18_1.actors_["1069ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.characterEffect1069ui_story == nil then
				arg_18_1.var_.characterEffect1069ui_story = var_21_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_3 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_3 and not isNil(var_21_2) then
				if arg_18_1.var_.characterEffect1069ui_story and not isNil(var_21_2) then
					arg_18_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_18_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_18_1.time_ - 0) / var_21_3)
				end
			end

			if arg_18_1.time_ >= 0 + var_21_3 and arg_18_1.time_ < 0 + var_21_3 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.characterEffect1069ui_story then
				arg_18_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_18_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_2")
			end

			local var_21_4 = 0
			local var_21_5 = 0.625

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_6 = arg_18_1:GetWordFromCfg(120061005)
				local var_21_7 = arg_18_1:FormatText(var_21_6.content)

				arg_18_1.text_.text = var_21_7

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_9 = 25 <= 0 and var_21_5 or var_21_5 * (utf8.len(var_21_7) / 25)

				if (25 <= 0 and var_21_5 or var_21_5 * (utf8.len(var_21_7) / 25)) > 0 and var_21_5 < var_21_9 then
					arg_18_1.talkMaxDuration = var_21_9

					if var_21_9 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_9 + var_21_4
					end
				end

				arg_18_1.text_.text = var_21_7
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061005", "story_v_out_120061.awb") ~= 0 then
					local var_21_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061005", "story_v_out_120061.awb") / 1000

					if var_21_10 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_4
					end

					if var_21_6.prefab_name ~= "" and arg_18_1.actors_[var_21_6.prefab_name] ~= nil then
						local var_21_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_6.prefab_name].transform, "story_v_out_120061", "120061005", "story_v_out_120061.awb")

						arg_18_1:RecordAudio("120061005", var_21_11)
						arg_18_1:RecordAudio("120061005", var_21_11)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_120061", "120061005", "story_v_out_120061.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_120061", "120061005", "story_v_out_120061.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_12 = math.max(var_21_5, arg_18_1.talkMaxDuration)

			if var_21_4 <= arg_18_1.time_ and arg_18_1.time_ < var_21_4 + var_21_12 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_4) / var_21_12

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_4 + var_21_12 and arg_18_1.time_ < var_21_4 + var_21_12 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play120061006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 120061006
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play120061007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1071ui_story = arg_22_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_25_0 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 then
				arg_22_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_22_1.time_ - 0) / var_25_0)
				arg_22_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1071ui_story"].transform.position).z)
				arg_22_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["1071ui_story"].transform.localEulerAngles = arg_22_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 then
				arg_22_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1071ui_story"].transform.position).z)
				arg_22_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["1071ui_story"].transform.localEulerAngles = arg_22_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_25_1 = arg_22_1.actors_["1069ui_story"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1069ui_story = var_25_1.localPosition
			end

			local var_25_2 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_2 then
				var_25_1.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_22_1.time_ - 0) / var_25_2)
				var_25_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_1.position).x, (manager.ui.mainCamera.transform.position - var_25_1.position).y, (manager.ui.mainCamera.transform.position - var_25_1.position).z)
				var_25_1.localEulerAngles.z = 0
				var_25_1.localEulerAngles.x = 0
				var_25_1.localEulerAngles = var_25_1.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_2 and arg_22_1.time_ < 0 + var_25_2 + arg_25_0 then
				var_25_1.localPosition = Vector3.New(0, 100, 0)
				var_25_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_1.position).x, (manager.ui.mainCamera.transform.position - var_25_1.position).y, (manager.ui.mainCamera.transform.position - var_25_1.position).z)
				var_25_1.localEulerAngles.z = 0
				var_25_1.localEulerAngles.x = 0
				var_25_1.localEulerAngles = var_25_1.localEulerAngles
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_25_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_5 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_5

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_5
						arg_22_1.bgmTxt2_.text = var_25_5
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_22_1.time_ and arg_22_1.time_ <= 0.166666666666667 + arg_25_0 then
				arg_22_1:AudioAction("play", "music", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_25_8 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if "" ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_8 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_8

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_8
						arg_22_1.bgmTxt2_.text = var_25_8
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_25_9 = 0
			local var_25_10 = 0.775

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_11 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(120061006).content)

				arg_22_1.text_.text = var_25_11

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 31 <= 0 and var_25_10 or var_25_10 * (utf8.len(var_25_11) / 31)

				if (31 <= 0 and var_25_10 or var_25_10 * (utf8.len(var_25_11) / 31)) > 0 and var_25_10 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_9 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_9
					end
				end

				arg_22_1.text_.text = var_25_11
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_14 = math.max(var_25_10, arg_22_1.talkMaxDuration)

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_14 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_9) / var_25_14

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_9 + var_25_14 and arg_22_1.time_ < var_25_9 + var_25_14 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play120061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 120061007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play120061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.25

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(120061007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 50 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 50)

				if (50 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 50)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play120061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 120061008
		arg_32_1.duration_ = 13.4

		local var_32_0 = {
			zh = 7.3,
			ja = 13.4
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
				arg_32_0:Play120061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1071ui_story = arg_32_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1071ui_story"].transform.position).z)
				arg_32_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1071ui_story"].transform.localEulerAngles = arg_32_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_32_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1071ui_story"].transform.position).z)
				arg_32_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1071ui_story"].transform.localEulerAngles = arg_32_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1069ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1069ui_story = var_35_1.localPosition
			end

			local var_35_2 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 then
				var_35_1.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_32_1.time_ - 0) / var_35_2)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 then
				var_35_1.localPosition = Vector3.New(0.7, -1, -6)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			local var_35_3 = arg_32_1.actors_["1071ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1071ui_story == nil then
				arg_32_1.var_.characterEffect1071ui_story = var_35_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_4 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 and not isNil(var_35_3) then
				if arg_32_1.var_.characterEffect1071ui_story and not isNil(var_35_3) then
					arg_32_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1071ui_story then
				arg_32_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_35_6 = 0
			local var_35_7 = 0.8

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(120061008)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 32 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 32)

				if (32 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 32)) > 0 and var_35_7 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061008", "story_v_out_120061.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_out_120061", "120061008", "story_v_out_120061.awb") / 1000

					if var_35_12 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_6
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_out_120061", "120061008", "story_v_out_120061.awb")

						arg_32_1:RecordAudio("120061008", var_35_13)
						arg_32_1:RecordAudio("120061008", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_120061", "120061008", "story_v_out_120061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_120061", "120061008", "story_v_out_120061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play120061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 120061009
		arg_36_1.duration_ = 9.6

		local var_36_0 = {
			zh = 6.5,
			ja = 9.6
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
				arg_36_0:Play120061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_39_0 = 0
			local var_39_1 = 0.725

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(120061009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 29 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 29)

				if (29 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 29)) > 0 and var_39_1 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061009", "story_v_out_120061.awb") ~= 0 then
					local var_39_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061009", "story_v_out_120061.awb") / 1000

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end

					if var_39_2.prefab_name ~= "" and arg_36_1.actors_[var_39_2.prefab_name] ~= nil then
						local var_39_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_2.prefab_name].transform, "story_v_out_120061", "120061009", "story_v_out_120061.awb")

						arg_36_1:RecordAudio("120061009", var_39_7)
						arg_36_1:RecordAudio("120061009", var_39_7)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_120061", "120061009", "story_v_out_120061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_120061", "120061009", "story_v_out_120061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play120061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 120061010
		arg_40_1.duration_ = 6.4

		local var_40_0 = {
			zh = 6.4,
			ja = 4.9
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
				arg_40_0:Play120061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "1075ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1075ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["1075ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["1075ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["1075ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1075ui_story = var_43_3.localPosition
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_40_1.time_ - 0) / var_43_4)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			local var_43_5 = arg_40_1.actors_["1071ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1071ui_story == nil then
				arg_40_1.var_.characterEffect1071ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 and not isNil(var_43_5) then
				if arg_40_1.var_.characterEffect1071ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_6)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1071ui_story then
				arg_40_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_43_7 = arg_40_1.actors_["1075ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1075ui_story == nil then
				arg_40_1.var_.characterEffect1075ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1075ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1075ui_story then
				arg_40_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_43_10 = arg_40_1.actors_["1069ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1069ui_story = var_43_10.localPosition
			end

			local var_43_11 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_11 then
				var_43_10.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_11)
				var_43_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_10.position).x, (manager.ui.mainCamera.transform.position - var_43_10.position).y, (manager.ui.mainCamera.transform.position - var_43_10.position).z)
				var_43_10.localEulerAngles.z = 0
				var_43_10.localEulerAngles.x = 0
				var_43_10.localEulerAngles = var_43_10.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_11 and arg_40_1.time_ < 0 + var_43_11 + arg_43_0 then
				var_43_10.localPosition = Vector3.New(0, 100, 0)
				var_43_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_10.position).x, (manager.ui.mainCamera.transform.position - var_43_10.position).y, (manager.ui.mainCamera.transform.position - var_43_10.position).z)
				var_43_10.localEulerAngles.z = 0
				var_43_10.localEulerAngles.x = 0
				var_43_10.localEulerAngles = var_43_10.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_43_12 = 0
			local var_43_13 = 0.725

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_14 = arg_40_1:GetWordFromCfg(120061010)
				local var_43_15 = arg_40_1:FormatText(var_43_14.content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 29 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 29)

				if (29 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 29)) > 0 and var_43_13 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17

					if var_43_17 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061010", "story_v_out_120061.awb") ~= 0 then
					local var_43_18 = manager.audio:GetVoiceLength("story_v_out_120061", "120061010", "story_v_out_120061.awb") / 1000

					if var_43_18 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_12
					end

					if var_43_14.prefab_name ~= "" and arg_40_1.actors_[var_43_14.prefab_name] ~= nil then
						local var_43_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_14.prefab_name].transform, "story_v_out_120061", "120061010", "story_v_out_120061.awb")

						arg_40_1:RecordAudio("120061010", var_43_19)
						arg_40_1:RecordAudio("120061010", var_43_19)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_120061", "120061010", "story_v_out_120061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_120061", "120061010", "story_v_out_120061.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_20 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_20 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_20

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_20 and arg_40_1.time_ < var_43_12 + var_43_20 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play120061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 120061011
		arg_44_1.duration_ = 12

		local var_44_0 = {
			zh = 7.533,
			ja = 12
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
				arg_44_0:Play120061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1071ui_story"]) and arg_44_1.var_.characterEffect1071ui_story == nil then
				arg_44_1.var_.characterEffect1071ui_story = arg_44_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1071ui_story"]) then
				if arg_44_1.var_.characterEffect1071ui_story and not isNil(arg_44_1.actors_["1071ui_story"]) then
					arg_44_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1071ui_story"]) and arg_44_1.var_.characterEffect1071ui_story then
				arg_44_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1075ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1075ui_story == nil then
				arg_44_1.var_.characterEffect1075ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1075ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1075ui_story then
				arg_44_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_47_4 = 0
			local var_47_5 = 0.725

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(120061011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 29 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 29)

				if (29 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 29)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061011", "story_v_out_120061.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061011", "story_v_out_120061.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_120061", "120061011", "story_v_out_120061.awb")

						arg_44_1:RecordAudio("120061011", var_47_11)
						arg_44_1:RecordAudio("120061011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_120061", "120061011", "story_v_out_120061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_120061", "120061011", "story_v_out_120061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play120061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 120061012
		arg_48_1.duration_ = 4.87

		local var_48_0 = {
			zh = 3.366,
			ja = 4.866
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
				arg_48_0:Play120061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1071ui_story"]) and arg_48_1.var_.characterEffect1071ui_story == nil then
				arg_48_1.var_.characterEffect1071ui_story = arg_48_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1071ui_story"]) then
				if arg_48_1.var_.characterEffect1071ui_story and not isNil(arg_48_1.actors_["1071ui_story"]) then
					arg_48_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1071ui_story"]) and arg_48_1.var_.characterEffect1071ui_story then
				arg_48_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_51_1 = arg_48_1.actors_["1075ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1075ui_story == nil then
				arg_48_1.var_.characterEffect1075ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1075ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1075ui_story then
				arg_48_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_51_4 = 0
			local var_51_5 = 0.275

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(120061012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 11 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 11)

				if (11 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 11)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061012", "story_v_out_120061.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061012", "story_v_out_120061.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_120061", "120061012", "story_v_out_120061.awb")

						arg_48_1:RecordAudio("120061012", var_51_11)
						arg_48_1:RecordAudio("120061012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_120061", "120061012", "story_v_out_120061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_120061", "120061012", "story_v_out_120061.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play120061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 120061013
		arg_52_1.duration_ = 9.53

		local var_52_0 = {
			zh = 9.533,
			ja = 8
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
				arg_52_0:Play120061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_55_0 = 0
			local var_55_1 = 1.075

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(120061013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 43 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 43)

				if (43 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 43)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061013", "story_v_out_120061.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061013", "story_v_out_120061.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_120061", "120061013", "story_v_out_120061.awb")

						arg_52_1:RecordAudio("120061013", var_55_7)
						arg_52_1:RecordAudio("120061013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_120061", "120061013", "story_v_out_120061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_120061", "120061013", "story_v_out_120061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play120061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 120061014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play120061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1075ui_story"]) and arg_56_1.var_.characterEffect1075ui_story == nil then
				arg_56_1.var_.characterEffect1075ui_story = arg_56_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1075ui_story"]) then
				if arg_56_1.var_.characterEffect1075ui_story and not isNil(arg_56_1.actors_["1075ui_story"]) then
					arg_56_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1075ui_story"]) and arg_56_1.var_.characterEffect1075ui_story then
				arg_56_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.55

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(120061014).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 22 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 22)

				if (22 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 22)) > 0 and var_59_2 < var_59_5 then
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
	Play120061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 120061015
		arg_60_1.duration_ = 7.13

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play120061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1071ui_story"]) and arg_60_1.var_.characterEffect1071ui_story == nil then
				arg_60_1.var_.characterEffect1071ui_story = arg_60_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1071ui_story"]) then
				if arg_60_1.var_.characterEffect1071ui_story and not isNil(arg_60_1.actors_["1071ui_story"]) then
					arg_60_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1071ui_story"]) and arg_60_1.var_.characterEffect1071ui_story then
				arg_60_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_63_2 = 0
			local var_63_3 = 0.875

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(120061015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 35 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 35)

				if (35 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 35)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061015", "story_v_out_120061.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_120061", "120061015", "story_v_out_120061.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_120061", "120061015", "story_v_out_120061.awb")

						arg_60_1:RecordAudio("120061015", var_63_9)
						arg_60_1:RecordAudio("120061015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_120061", "120061015", "story_v_out_120061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_120061", "120061015", "story_v_out_120061.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play120061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 120061016
		arg_64_1.duration_ = 9.37

		local var_64_0 = {
			zh = 6.633,
			ja = 9.366
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
				arg_64_0:Play120061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_67_0 = 0
			local var_67_1 = 0.8

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(120061016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 32 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 32)

				if (32 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 32)) > 0 and var_67_1 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061016", "story_v_out_120061.awb") ~= 0 then
					local var_67_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061016", "story_v_out_120061.awb") / 1000

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end

					if var_67_2.prefab_name ~= "" and arg_64_1.actors_[var_67_2.prefab_name] ~= nil then
						local var_67_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_2.prefab_name].transform, "story_v_out_120061", "120061016", "story_v_out_120061.awb")

						arg_64_1:RecordAudio("120061016", var_67_7)
						arg_64_1:RecordAudio("120061016", var_67_7)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_120061", "120061016", "story_v_out_120061.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_120061", "120061016", "story_v_out_120061.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play120061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 120061017
		arg_68_1.duration_ = 2.43

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play120061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1071ui_story = arg_68_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1071ui_story"].transform.position).z)
				arg_68_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1071ui_story"].transform.localEulerAngles = arg_68_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1071ui_story"].transform.position).z)
				arg_68_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1071ui_story"].transform.localEulerAngles = arg_68_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_71_1 = arg_68_1.actors_["1075ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1075ui_story = var_71_1.localPosition
			end

			local var_71_2 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 then
				var_71_1.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_2)
				var_71_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_1.position).x, (manager.ui.mainCamera.transform.position - var_71_1.position).y, (manager.ui.mainCamera.transform.position - var_71_1.position).z)
				var_71_1.localEulerAngles.z = 0
				var_71_1.localEulerAngles.x = 0
				var_71_1.localEulerAngles = var_71_1.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 then
				var_71_1.localPosition = Vector3.New(0, 100, 0)
				var_71_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_1.position).x, (manager.ui.mainCamera.transform.position - var_71_1.position).y, (manager.ui.mainCamera.transform.position - var_71_1.position).z)
				var_71_1.localEulerAngles.z = 0
				var_71_1.localEulerAngles.x = 0
				var_71_1.localEulerAngles = var_71_1.localEulerAngles
			end

			local var_71_3 = arg_68_1.actors_["1069ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1069ui_story = var_71_3.localPosition
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_3.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_68_1.time_ - 0) / var_71_4)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_3.localPosition = Vector3.New(0, -1, -6)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			local var_71_5 = arg_68_1.actors_["1069ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1069ui_story == nil then
				arg_68_1.var_.characterEffect1069ui_story = var_71_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_6 and not isNil(var_71_5) then
				if arg_68_1.var_.characterEffect1069ui_story and not isNil(var_71_5) then
					arg_68_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_6 and arg_68_1.time_ < 0 + var_71_6 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1069ui_story then
				arg_68_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action424")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_71_8 = 0
			local var_71_9 = 0.175

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(120061017)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 7 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 7)

				if (7 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 7)) > 0 and var_71_9 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061017", "story_v_out_120061.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_120061", "120061017", "story_v_out_120061.awb") / 1000

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end

					if var_71_10.prefab_name ~= "" and arg_68_1.actors_[var_71_10.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_10.prefab_name].transform, "story_v_out_120061", "120061017", "story_v_out_120061.awb")

						arg_68_1:RecordAudio("120061017", var_71_15)
						arg_68_1:RecordAudio("120061017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_120061", "120061017", "story_v_out_120061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_120061", "120061017", "story_v_out_120061.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_16 and arg_68_1.time_ < var_71_8 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play120061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 120061018
		arg_72_1.duration_ = 11.73

		local var_72_0 = {
			zh = 6.533,
			ja = 11.733
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play120061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1071ui_story = arg_72_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1071ui_story"].transform.position).z)
				arg_72_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1071ui_story"].transform.localEulerAngles = arg_72_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_72_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1071ui_story"].transform.position).z)
				arg_72_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1071ui_story"].transform.localEulerAngles = arg_72_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["1069ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1069ui_story = var_75_1.localPosition
			end

			local var_75_2 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 then
				var_75_1.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_2)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 then
				var_75_1.localPosition = Vector3.New(0, 100, 0)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			local var_75_3 = arg_72_1.actors_["1071ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1071ui_story == nil then
				arg_72_1.var_.characterEffect1071ui_story = var_75_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 and not isNil(var_75_3) then
				if arg_72_1.var_.characterEffect1071ui_story and not isNil(var_75_3) then
					arg_72_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1071ui_story then
				arg_72_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_75_6 = 0
			local var_75_7 = 0.75

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(120061018)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 30 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 30)

				if (30 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 30)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061018", "story_v_out_120061.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_120061", "120061018", "story_v_out_120061.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_120061", "120061018", "story_v_out_120061.awb")

						arg_72_1:RecordAudio("120061018", var_75_13)
						arg_72_1:RecordAudio("120061018", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_120061", "120061018", "story_v_out_120061.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_120061", "120061018", "story_v_out_120061.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play120061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 120061019
		arg_76_1.duration_ = 10.83

		local var_76_0 = {
			zh = 8.433,
			ja = 10.833
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
				arg_76_0:Play120061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.05

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(120061019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 42 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 42)

				if (42 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 42)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061019", "story_v_out_120061.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061019", "story_v_out_120061.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_120061", "120061019", "story_v_out_120061.awb")

						arg_76_1:RecordAudio("120061019", var_79_6)
						arg_76_1:RecordAudio("120061019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_120061", "120061019", "story_v_out_120061.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_120061", "120061019", "story_v_out_120061.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play120061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 120061020
		arg_80_1.duration_ = 13.93

		local var_80_0 = {
			zh = 13.933,
			ja = 12.433
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play120061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 1.275

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(120061020)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 51 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 51)

				if (51 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 51)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061020", "story_v_out_120061.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061020", "story_v_out_120061.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_120061", "120061020", "story_v_out_120061.awb")

						arg_80_1:RecordAudio("120061020", var_83_6)
						arg_80_1:RecordAudio("120061020", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_120061", "120061020", "story_v_out_120061.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_120061", "120061020", "story_v_out_120061.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play120061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 120061021
		arg_84_1.duration_ = 10.67

		local var_84_0 = {
			zh = 7.2,
			ja = 10.666
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
				arg_84_0:Play120061022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.925

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:GetWordFromCfg(120061021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 37 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 37)

				if (37 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 37)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061021", "story_v_out_120061.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061021", "story_v_out_120061.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_120061", "120061021", "story_v_out_120061.awb")

						arg_84_1:RecordAudio("120061021", var_87_6)
						arg_84_1:RecordAudio("120061021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_120061", "120061021", "story_v_out_120061.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_120061", "120061021", "story_v_out_120061.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play120061022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 120061022
		arg_88_1.duration_ = 13.93

		local var_88_0 = {
			zh = 13,
			ja = 13.933
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
				arg_88_0:Play120061023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_91_0 = 0
			local var_91_1 = 1.375

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(120061022)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 53 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 53)

				if (53 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 53)) > 0 and var_91_1 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061022", "story_v_out_120061.awb") ~= 0 then
					local var_91_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061022", "story_v_out_120061.awb") / 1000

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end

					if var_91_2.prefab_name ~= "" and arg_88_1.actors_[var_91_2.prefab_name] ~= nil then
						local var_91_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_2.prefab_name].transform, "story_v_out_120061", "120061022", "story_v_out_120061.awb")

						arg_88_1:RecordAudio("120061022", var_91_7)
						arg_88_1:RecordAudio("120061022", var_91_7)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_120061", "120061022", "story_v_out_120061.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_120061", "120061022", "story_v_out_120061.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play120061023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 120061023
		arg_92_1.duration_ = 5.83

		local var_92_0 = {
			zh = 4.2,
			ja = 5.833
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
				arg_92_0:Play120061024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.375

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:GetWordFromCfg(120061023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 15 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 15)

				if (15 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 15)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061023", "story_v_out_120061.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061023", "story_v_out_120061.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_120061", "120061023", "story_v_out_120061.awb")

						arg_92_1:RecordAudio("120061023", var_95_6)
						arg_92_1:RecordAudio("120061023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_120061", "120061023", "story_v_out_120061.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_120061", "120061023", "story_v_out_120061.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play120061024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 120061024
		arg_96_1.duration_ = 17.1

		local var_96_0 = {
			zh = 11.566,
			ja = 17.1
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
				arg_96_0:Play120061025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_99_0 = 0
			local var_99_1 = 1.15

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(120061024)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 46 <= 0 and var_99_1 or var_99_1 * (utf8.len(var_99_3) / 46)

				if (46 <= 0 and var_99_1 or var_99_1 * (utf8.len(var_99_3) / 46)) > 0 and var_99_1 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061024", "story_v_out_120061.awb") ~= 0 then
					local var_99_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061024", "story_v_out_120061.awb") / 1000

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end

					if var_99_2.prefab_name ~= "" and arg_96_1.actors_[var_99_2.prefab_name] ~= nil then
						local var_99_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_2.prefab_name].transform, "story_v_out_120061", "120061024", "story_v_out_120061.awb")

						arg_96_1:RecordAudio("120061024", var_99_7)
						arg_96_1:RecordAudio("120061024", var_99_7)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_120061", "120061024", "story_v_out_120061.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_120061", "120061024", "story_v_out_120061.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_8 and arg_96_1.time_ < var_99_0 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play120061025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 120061025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play120061026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1071ui_story"]) and arg_100_1.var_.characterEffect1071ui_story == nil then
				arg_100_1.var_.characterEffect1071ui_story = arg_100_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1071ui_story"]) then
				if arg_100_1.var_.characterEffect1071ui_story and not isNil(arg_100_1.actors_["1071ui_story"]) then
					arg_100_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1071ui_story"]) and arg_100_1.var_.characterEffect1071ui_story then
				arg_100_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.875

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

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(120061025).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 35 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 35)

				if (35 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 35)) > 0 and var_103_2 < var_103_5 then
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
	Play120061026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 120061026
		arg_104_1.duration_ = 9.97

		local var_104_0 = {
			zh = 5.533,
			ja = 9.966
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
				arg_104_0:Play120061027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1071ui_story"]) and arg_104_1.var_.characterEffect1071ui_story == nil then
				arg_104_1.var_.characterEffect1071ui_story = arg_104_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1071ui_story"]) then
				if arg_104_1.var_.characterEffect1071ui_story and not isNil(arg_104_1.actors_["1071ui_story"]) then
					arg_104_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1071ui_story"]) and arg_104_1.var_.characterEffect1071ui_story then
				arg_104_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_107_2 = 0
			local var_107_3 = 0.625

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(120061026)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 25 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 25)

				if (25 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 25)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061026", "story_v_out_120061.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_120061", "120061026", "story_v_out_120061.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_120061", "120061026", "story_v_out_120061.awb")

						arg_104_1:RecordAudio("120061026", var_107_9)
						arg_104_1:RecordAudio("120061026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_120061", "120061026", "story_v_out_120061.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_120061", "120061026", "story_v_out_120061.awb")
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
	Play120061027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 120061027
		arg_108_1.duration_ = 3.1

		local var_108_0 = {
			zh = 2.633,
			ja = 3.1
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
				arg_108_0:Play120061028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1069ui_story = arg_108_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1069ui_story"].transform.position).z)
				arg_108_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1069ui_story"].transform.localEulerAngles = arg_108_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_108_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1069ui_story"].transform.position).z)
				arg_108_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1069ui_story"].transform.localEulerAngles = arg_108_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1069ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1069ui_story == nil then
				arg_108_1.var_.characterEffect1069ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1069ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1069ui_story then
				arg_108_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_111_4 = arg_108_1.actors_["1071ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1071ui_story = var_111_4.localPosition
			end

			local var_111_5 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 then
				var_111_4.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_5)
				var_111_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_4.position).x, (manager.ui.mainCamera.transform.position - var_111_4.position).y, (manager.ui.mainCamera.transform.position - var_111_4.position).z)
				var_111_4.localEulerAngles.z = 0
				var_111_4.localEulerAngles.x = 0
				var_111_4.localEulerAngles = var_111_4.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 then
				var_111_4.localPosition = Vector3.New(0, 100, 0)
				var_111_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_4.position).x, (manager.ui.mainCamera.transform.position - var_111_4.position).y, (manager.ui.mainCamera.transform.position - var_111_4.position).z)
				var_111_4.localEulerAngles.z = 0
				var_111_4.localEulerAngles.x = 0
				var_111_4.localEulerAngles = var_111_4.localEulerAngles
			end

			local var_111_6 = 0
			local var_111_7 = 0.175

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(120061027)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 7 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 7)

				if (7 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 7)) > 0 and var_111_7 < var_111_11 then
					arg_108_1.talkMaxDuration = var_111_11

					if var_111_11 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061027", "story_v_out_120061.awb") ~= 0 then
					local var_111_12 = manager.audio:GetVoiceLength("story_v_out_120061", "120061027", "story_v_out_120061.awb") / 1000

					if var_111_12 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_6
					end

					if var_111_8.prefab_name ~= "" and arg_108_1.actors_[var_111_8.prefab_name] ~= nil then
						local var_111_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_8.prefab_name].transform, "story_v_out_120061", "120061027", "story_v_out_120061.awb")

						arg_108_1:RecordAudio("120061027", var_111_13)
						arg_108_1:RecordAudio("120061027", var_111_13)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_120061", "120061027", "story_v_out_120061.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_120061", "120061027", "story_v_out_120061.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_14 and arg_108_1.time_ < var_111_6 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play120061028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 120061028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play120061029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1069ui_story = arg_112_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1069ui_story"].transform.position).z)
				arg_112_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1069ui_story"].transform.localEulerAngles = arg_112_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1069ui_story"].transform.position).z)
				arg_112_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1069ui_story"].transform.localEulerAngles = arg_112_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_115_1 = 0
			local var_115_2 = 1.075

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(120061028).content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 43 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 43)

				if (43 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 43)) > 0 and var_115_2 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_6 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_6 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_6

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_6 and arg_112_1.time_ < var_115_1 + var_115_6 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play120061029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 120061029
		arg_116_1.duration_ = 2.53

		local var_116_0 = {
			zh = 2.533,
			ja = 2.1
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
				arg_116_0:Play120061030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1069ui_story = arg_116_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1069ui_story"].transform.position).z)
				arg_116_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1069ui_story"].transform.localEulerAngles = arg_116_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_116_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1069ui_story"].transform.position).z)
				arg_116_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1069ui_story"].transform.localEulerAngles = arg_116_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1069ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1069ui_story == nil then
				arg_116_1.var_.characterEffect1069ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1069ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1069ui_story then
				arg_116_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_119_4 = 0
			local var_119_5 = 0.275

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(120061029)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)

				if (11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061029", "story_v_out_120061.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061029", "story_v_out_120061.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_120061", "120061029", "story_v_out_120061.awb")

						arg_116_1:RecordAudio("120061029", var_119_11)
						arg_116_1:RecordAudio("120061029", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_120061", "120061029", "story_v_out_120061.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_120061", "120061029", "story_v_out_120061.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play120061030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 120061030
		arg_120_1.duration_ = 1.23

		local var_120_0 = {
			zh = 0.999999999999,
			ja = 1.233
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
				arg_120_0:Play120061031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1069ui_story"]) and arg_120_1.var_.characterEffect1069ui_story == nil then
				arg_120_1.var_.characterEffect1069ui_story = arg_120_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1069ui_story"]) then
				if arg_120_1.var_.characterEffect1069ui_story and not isNil(arg_120_1.actors_["1069ui_story"]) then
					arg_120_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1069ui_story"]) and arg_120_1.var_.characterEffect1069ui_story then
				arg_120_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_123_1 = arg_120_1.actors_["1069ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1069ui_story = var_123_1.localPosition
			end

			local var_123_2 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 then
				var_123_1.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_2)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 then
				var_123_1.localPosition = Vector3.New(0, 100, 0)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			local var_123_3 = arg_120_1.actors_["1071ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1071ui_story = var_123_3.localPosition
			end

			local var_123_4 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				var_123_3.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_4)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				var_123_3.localPosition = Vector3.New(0, 100, 0)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			local var_123_5 = manager.ui.mainCamera.transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.shakeOldPos = var_123_5.localPosition
			end

			local var_123_6 = 0.6

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_6 then
				local var_123_7, var_123_8 = math.modf((arg_120_1.time_ - 0) / 0.066)

				var_123_5.localPosition = Vector3.New(var_123_8 * 0.13, var_123_8 * 0.13, var_123_8 * 0.13) + arg_120_1.var_.shakeOldPos
			end

			if arg_120_1.time_ >= 0 + var_123_6 and arg_120_1.time_ < 0 + var_123_6 + arg_123_0 then
				var_123_5.localPosition = arg_120_1.var_.shakeOldPos
			end

			local var_123_9 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= var_123_9 + 0.6 and arg_120_1.time_ < var_123_9 + 0.6 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end

			local var_123_10 = 0
			local var_123_11 = 0.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_12 = arg_120_1:GetWordFromCfg(120061030)
				local var_123_13 = arg_120_1:FormatText(var_123_12.content)

				arg_120_1.text_.text = var_123_13

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_15 = 4 <= 0 and var_123_11 or var_123_11 * (utf8.len(var_123_13) / 4)

				if (4 <= 0 and var_123_11 or var_123_11 * (utf8.len(var_123_13) / 4)) > 0 and var_123_11 < var_123_15 then
					arg_120_1.talkMaxDuration = var_123_15

					if var_123_15 + var_123_10 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_15 + var_123_10
					end
				end

				arg_120_1.text_.text = var_123_13
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061030", "story_v_out_120061.awb") ~= 0 then
					local var_123_16 = manager.audio:GetVoiceLength("story_v_out_120061", "120061030", "story_v_out_120061.awb") / 1000

					if var_123_16 + var_123_10 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_16 + var_123_10
					end

					if var_123_12.prefab_name ~= "" and arg_120_1.actors_[var_123_12.prefab_name] ~= nil then
						local var_123_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_12.prefab_name].transform, "story_v_out_120061", "120061030", "story_v_out_120061.awb")

						arg_120_1:RecordAudio("120061030", var_123_17)
						arg_120_1:RecordAudio("120061030", var_123_17)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_120061", "120061030", "story_v_out_120061.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_120061", "120061030", "story_v_out_120061.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_18 = math.max(var_123_11, arg_120_1.talkMaxDuration)

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_18 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_10) / var_123_18

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_10 + var_123_18 and arg_120_1.time_ < var_123_10 + var_123_18 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play120061031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 120061031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play120061032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				local var_127_0 = arg_124_1.bgs_.J03h

				arg_124_1.bgs_.J03h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_127_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_1 = var_127_0:GetComponent("SpriteRenderer")

				if var_127_1 and var_127_1.sprite then
					local var_127_2 = 2 * (var_127_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_127_0.transform.localScale = Vector3.New(var_127_2 / var_127_1.sprite.bounds.size.y < var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x and var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x or var_127_2 / var_127_1.sprite.bounds.size.y, var_127_2 / var_127_1.sprite.bounds.size.y < var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x and var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x or var_127_2 / var_127_1.sprite.bounds.size.y, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "J03h" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_3 = "J03h_blur"

			if arg_124_1.bgs_.J03h_blur == nil then
				local var_127_4 = Object.Instantiate(arg_124_1.blurPaintGo_)

				var_127_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_127_3)
				var_127_4.name = var_127_3
				var_127_4.transform.parent = arg_124_1.stage_.transform
				var_127_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.bgs_[var_127_3] = var_127_4
			end

			local var_127_5 = 0.1
			local var_127_6 = arg_124_1.bgs_[var_127_3]

			if 0.1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				var_127_6.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_127_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_7 = var_127_6:GetComponent("SpriteRenderer")

				if var_127_7 and var_127_7.sprite then
					local var_127_8 = 2 * (var_127_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_127_6.transform.localScale = Vector3.New(var_127_8 / var_127_7.sprite.bounds.size.y < var_127_8 * manager.ui.mainCameraCom_.aspect / var_127_7.sprite.bounds.size.x and var_127_8 * manager.ui.mainCameraCom_.aspect / var_127_7.sprite.bounds.size.x or var_127_8 / var_127_7.sprite.bounds.size.y, var_127_8 / var_127_7.sprite.bounds.size.y < var_127_8 * manager.ui.mainCameraCom_.aspect / var_127_7.sprite.bounds.size.x and var_127_8 * manager.ui.mainCameraCom_.aspect / var_127_7.sprite.bounds.size.x or var_127_8 / var_127_7.sprite.bounds.size.y, 0)
				end
			end

			local var_127_9 = 2

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_9 then
				local var_127_10 = Color.New(1, 1, 1)

				var_127_10.a = Mathf.Lerp(0, 1, (arg_124_1.time_ - var_127_5) / var_127_9)

				var_127_6:GetComponent("SpriteRenderer").material:SetColor("_Color", var_127_10)
			end

			local var_127_11 = 0
			local var_127_12 = 0.925

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_13 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(120061031).content)

				arg_124_1.text_.text = var_127_13

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_15 = 37 <= 0 and var_127_12 or var_127_12 * (utf8.len(var_127_13) / 37)

				if (37 <= 0 and var_127_12 or var_127_12 * (utf8.len(var_127_13) / 37)) > 0 and var_127_12 < var_127_15 then
					arg_124_1.talkMaxDuration = var_127_15

					if var_127_15 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_15 + var_127_11
					end
				end

				arg_124_1.text_.text = var_127_13
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_12, arg_124_1.talkMaxDuration)

			if var_127_11 <= arg_124_1.time_ and arg_124_1.time_ < var_127_11 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_11) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_11 + var_127_16 and arg_124_1.time_ < var_127_11 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play120061032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 120061032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play120061033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 1.175

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(120061032).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 47 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 47)

				if (47 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 47)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play120061033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 120061033
		arg_132_1.duration_ = 5.3

		local var_132_0 = {
			zh = 2.566,
			ja = 5.3
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
				arg_132_0:Play120061034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1075ui_story = arg_132_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1075ui_story"].transform.position).z)
				arg_132_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1075ui_story"].transform.localEulerAngles = arg_132_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_132_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1075ui_story"].transform.position).z)
				arg_132_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1075ui_story"].transform.localEulerAngles = arg_132_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["1075ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1075ui_story == nil then
				arg_132_1.var_.characterEffect1075ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1075ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1075ui_story then
				arg_132_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_135_4 = 0
			local var_135_5 = 0.325

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(120061033)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 13 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 13)

				if (13 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 13)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061033", "story_v_out_120061.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061033", "story_v_out_120061.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_120061", "120061033", "story_v_out_120061.awb")

						arg_132_1:RecordAudio("120061033", var_135_11)
						arg_132_1:RecordAudio("120061033", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_120061", "120061033", "story_v_out_120061.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_120061", "120061033", "story_v_out_120061.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play120061034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 120061034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play120061035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1069ui_story = arg_136_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1069ui_story"].transform.position).z)
				arg_136_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1069ui_story"].transform.localEulerAngles = arg_136_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1069ui_story"].transform.position).z)
				arg_136_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1069ui_story"].transform.localEulerAngles = arg_136_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1075ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1075ui_story = var_139_1.localPosition
			end

			local var_139_2 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 then
				var_139_1.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_2)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 then
				var_139_1.localPosition = Vector3.New(0, 100, 0)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			local var_139_3 = 0
			local var_139_4 = 0.625

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_3 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_5 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(120061034).content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 25 <= 0 and var_139_4 or var_139_4 * (utf8.len(var_139_5) / 25)

				if (25 <= 0 and var_139_4 or var_139_4 * (utf8.len(var_139_5) / 25)) > 0 and var_139_4 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_3 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_3
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_4, arg_136_1.talkMaxDuration)

			if var_139_3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_3 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_3) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_3 + var_139_8 and arg_136_1.time_ < var_139_3 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play120061035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 120061035
		arg_140_1.duration_ = 7

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play120061036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_0 = 2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				local var_143_1 = Color.New(1, 1, 1)

				var_143_1.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.mask_.color = var_143_1
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				local var_143_2 = Color.New(1, 1, 1)

				arg_140_1.mask_.enabled = false
				var_143_2.a = 0
				arg_140_1.mask_.color = var_143_2
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:AudioAction("play", "effect", "se_story_9", "se_story_9_shock02_loop", "")
			end

			local var_143_4 = arg_140_1.bgs_.J03h.transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPosJ03h = var_143_4.localPosition
			end

			local var_143_5 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_5 then
				var_143_4.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPosJ03h, Vector3.New(0, 1, 8), (arg_140_1.time_ - 0) / var_143_5)
			end

			if arg_140_1.time_ >= 0 + var_143_5 and arg_140_1.time_ < 0 + var_143_5 + arg_143_0 then
				var_143_4.localPosition = Vector3.New(0, 1, 8)
			end

			local var_143_6 = arg_140_1.bgs_.J03h.transform

			if 0.034 < arg_140_1.time_ and arg_140_1.time_ <= 0.034 + arg_143_0 then
				arg_140_1.var_.moveOldPosJ03h = var_143_6.localPosition
			end

			local var_143_7 = 3.5

			if 0.034 <= arg_140_1.time_ and arg_140_1.time_ < 0.034 + var_143_7 then
				var_143_6.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPosJ03h, Vector3.New(0, 1, 9), (arg_140_1.time_ - 0.034) / var_143_7)
			end

			if arg_140_1.time_ >= 0.034 + var_143_7 and arg_140_1.time_ < 0.034 + var_143_7 + arg_143_0 then
				var_143_6.localPosition = Vector3.New(0, 1, 9)
			end

			local var_143_8 = manager.ui.mainCamera.transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.shakeOldPos = var_143_8.localPosition
			end

			local var_143_9 = 1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_9 then
				local var_143_10, var_143_11 = math.modf((arg_140_1.time_ - 0) / 0.066)

				var_143_8.localPosition = Vector3.New(var_143_11 * 0.13, var_143_11 * 0.13, var_143_11 * 0.13) + arg_140_1.var_.shakeOldPos
			end

			if arg_140_1.time_ >= 0 + var_143_9 and arg_140_1.time_ < 0 + var_143_9 + arg_143_0 then
				var_143_8.localPosition = arg_140_1.var_.shakeOldPos
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_12 = 2
			local var_143_13 = 1.275

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
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

				local var_143_15 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(120061035).content)

				arg_140_1.text_.text = var_143_15

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 51 <= 0 and var_143_13 or var_143_13 * (utf8.len(var_143_15) / 51)

				if (51 <= 0 and var_143_13 or var_143_13 * (utf8.len(var_143_15) / 51)) > 0 and var_143_13 < var_143_17 then
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

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "J03h",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "J03h",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play120061036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 120061036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play120061037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPosJ03h = arg_146_1.bgs_.J03h.transform.localPosition
			end

			local var_149_0 = 3.5

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.bgs_.J03h.transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPosJ03h, Vector3.New(0, 1, 9.5), (arg_146_1.time_ - 0) / var_149_0)
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.bgs_.J03h.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_149_1 = 0

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.allBtn_.enabled = false
			end

			if arg_146_1.time_ >= var_149_1 + 3.5 and arg_146_1.time_ < var_149_1 + 3.5 + arg_149_0 then
				arg_146_1.allBtn_.enabled = true
			end

			local var_149_2 = 0
			local var_149_3 = 0.25

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_4 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(120061036).content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_6 = 10 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 10)

				if (10 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 10)) > 0 and var_149_3 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_7 and arg_146_1.time_ < var_149_2 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "J03h",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play120061037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 120061037
		arg_150_1.duration_ = 2.8

		local var_150_0 = {
			zh = 2.8,
			ja = 2.3
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
				arg_150_0:Play120061038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_153_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_150_1.stage_.transform)

				var_153_0.name = "1184ui_story"
				var_153_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1184ui_story"] = var_153_0

				local var_153_1 = var_153_0:GetComponentInChildren(typeof(CharacterEffect))

				var_153_1.enabled = true

				local var_153_2 = GameObjectTools.GetOrAddComponent(var_153_0, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(false)
				end

				arg_150_1:ShowWeapon(var_153_1.transform, false)

				arg_150_1.var_["1184ui_story" .. "Animator"] = var_153_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_150_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_150_1.var_["1184ui_story" .. "LipSync"] = var_153_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_153_3 = arg_150_1.actors_["1184ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1184ui_story = var_153_3.localPosition

				arg_150_1:ShowWeapon(arg_150_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_153_4 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				var_153_3.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_150_1.time_ - 0) / var_153_4)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				var_153_3.localPosition = Vector3.New(0, -0.97, -6)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			local var_153_5 = arg_150_1.actors_["1184ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1184ui_story == nil then
				arg_150_1.var_.characterEffect1184ui_story = var_153_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_6 and not isNil(var_153_5) then
				if arg_150_1.var_.characterEffect1184ui_story and not isNil(var_153_5) then
					arg_150_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_6 and arg_150_1.time_ < 0 + var_153_6 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1184ui_story then
				arg_150_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_153_8 = 0
			local var_153_9 = 0.25

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:GetWordFromCfg(120061037)
				local var_153_11 = arg_150_1:FormatText(var_153_10.content)

				arg_150_1.text_.text = var_153_11

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 10 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 10)

				if (10 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 10)) > 0 and var_153_9 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_11
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061037", "story_v_out_120061.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_out_120061", "120061037", "story_v_out_120061.awb") / 1000

					if var_153_14 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_8
					end

					if var_153_10.prefab_name ~= "" and arg_150_1.actors_[var_153_10.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_10.prefab_name].transform, "story_v_out_120061", "120061037", "story_v_out_120061.awb")

						arg_150_1:RecordAudio("120061037", var_153_15)
						arg_150_1:RecordAudio("120061037", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_120061", "120061037", "story_v_out_120061.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_120061", "120061037", "story_v_out_120061.awb")
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
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play120061038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 120061038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play120061039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1184ui_story = arg_154_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1184ui_story"].transform.position).z)
				arg_154_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1184ui_story"].transform.localEulerAngles = arg_154_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1184ui_story"].transform.position).z)
				arg_154_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1184ui_story"].transform.localEulerAngles = arg_154_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_157_1 = 0
			local var_157_2 = 1.325

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(120061038).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 53 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 53)

				if (53 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 53)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play120061039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 120061039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play120061040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 1.2

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(120061039).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 48 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 48)

				if (48 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 48)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play120061040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 120061040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play120061041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.2

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(120061040).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 8 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 8)

				if (8 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 8)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play120061041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 120061041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play120061042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.675

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(120061041).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 27 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 27)

				if (27 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 27)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play120061042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 120061042
		arg_170_1.duration_ = 9

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play120061043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if arg_170_1.bgs_.J03g == nil then
				local var_173_0 = Object.Instantiate(arg_170_1.paintGo_)

				var_173_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03g")
				var_173_0.name = "J03g"
				var_173_0.transform.parent = arg_170_1.stage_.transform
				var_173_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.bgs_.J03g = var_173_0
			end

			if 2 < arg_170_1.time_ and arg_170_1.time_ <= 2 + arg_173_0 then
				local var_173_1 = arg_170_1.bgs_.J03g

				arg_170_1.bgs_.J03g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_173_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_173_2 = var_173_1:GetComponent("SpriteRenderer")

				if var_173_2 and var_173_2.sprite then
					local var_173_3 = 2 * (var_173_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_173_1.transform.localScale = Vector3.New(var_173_3 / var_173_2.sprite.bounds.size.y < var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x and var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x or var_173_3 / var_173_2.sprite.bounds.size.y, var_173_3 / var_173_2.sprite.bounds.size.y < var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x and var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x or var_173_3 / var_173_2.sprite.bounds.size.y, 0)
				end

				for iter_173_0, iter_173_1 in pairs(arg_170_1.bgs_) do
					if iter_173_0 ~= "J03g" then
						iter_173_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_173_4 = 0

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_5 = 2

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_5 then
				local var_173_6 = Color.New(0, 0, 0)

				var_173_6.a = Mathf.Lerp(0, 1, (arg_170_1.time_ - var_173_4) / var_173_5)
				arg_170_1.mask_.color = var_173_6
			end

			if arg_170_1.time_ >= var_173_4 + var_173_5 and arg_170_1.time_ < var_173_4 + var_173_5 + arg_173_0 then
				local var_173_7 = Color.New(0, 0, 0)

				var_173_7.a = 1
				arg_170_1.mask_.color = var_173_7
			end

			local var_173_8 = 2

			if 2 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_9 = 2

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_9 then
				local var_173_10 = Color.New(0, 0, 0)

				var_173_10.a = Mathf.Lerp(1, 0, (arg_170_1.time_ - var_173_8) / var_173_9)
				arg_170_1.mask_.color = var_173_10
			end

			if arg_170_1.time_ >= var_173_8 + var_173_9 and arg_170_1.time_ < var_173_8 + var_173_9 + arg_173_0 then
				local var_173_11 = Color.New(0, 0, 0)

				arg_170_1.mask_.enabled = false
				var_173_11.a = 0
				arg_170_1.mask_.color = var_173_11
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_12 = 4
			local var_173_13 = 0.475

			if 4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_14 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_14:setOnUpdate(LuaHelper.FloatAction(function(arg_174_0)
					arg_170_1.dialogCg_.alpha = arg_174_0
				end))
				var_173_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_15 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(120061042).content)

				arg_170_1.text_.text = var_173_15

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_17 = 19 <= 0 and var_173_13 or var_173_13 * (utf8.len(var_173_15) / 19)

				if (19 <= 0 and var_173_13 or var_173_13 * (utf8.len(var_173_15) / 19)) > 0 and var_173_13 < var_173_17 then
					arg_170_1.talkMaxDuration = var_173_17
					var_173_12 = var_173_12 + 0.3

					if var_173_17 + var_173_12 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_17 + var_173_12
					end
				end

				arg_170_1.text_.text = var_173_15
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_18 = var_173_12 + 0.3
			local var_173_19 = math.max(var_173_13, arg_170_1.talkMaxDuration)

			if var_173_12 + 0.3 <= arg_170_1.time_ and arg_170_1.time_ < var_173_18 + var_173_19 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_18) / var_173_19

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_18 + var_173_19 and arg_170_1.time_ < var_173_18 + var_173_19 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play120061043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 120061043
		arg_176_1.duration_ = 1.43

		local var_176_0 = {
			zh = 1.166,
			ja = 1.433
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play120061044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.125

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:GetWordFromCfg(120061043)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 5 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 5)

				if (5 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 5)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061043", "story_v_out_120061.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061043", "story_v_out_120061.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_120061", "120061043", "story_v_out_120061.awb")

						arg_176_1:RecordAudio("120061043", var_179_6)
						arg_176_1:RecordAudio("120061043", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_120061", "120061043", "story_v_out_120061.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_120061", "120061043", "story_v_out_120061.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play120061044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 120061044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play120061045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_183_0 = 2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				local var_183_1, var_183_2 = math.modf((arg_180_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_183_2 * 0.13, var_183_2 * 0.13, var_183_2 * 0.13) + arg_180_1.var_.shakeOldPos
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				manager.ui.mainCamera.transform.localPosition = arg_180_1.var_.shakeOldPos
			end

			local var_183_3 = arg_180_1.actors_["1184ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1184ui_story = var_183_3.localPosition

				arg_180_1:ShowWeapon(arg_180_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_183_4 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				var_183_3.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_4)
				var_183_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_3.position).x, (manager.ui.mainCamera.transform.position - var_183_3.position).y, (manager.ui.mainCamera.transform.position - var_183_3.position).z)
				var_183_3.localEulerAngles.z = 0
				var_183_3.localEulerAngles.x = 0
				var_183_3.localEulerAngles = var_183_3.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				var_183_3.localPosition = Vector3.New(0, 100, 0)
				var_183_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_3.position).x, (manager.ui.mainCamera.transform.position - var_183_3.position).y, (manager.ui.mainCamera.transform.position - var_183_3.position).z)
				var_183_3.localEulerAngles.z = 0
				var_183_3.localEulerAngles.x = 0
				var_183_3.localEulerAngles = var_183_3.localEulerAngles
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:AudioAction("stop", "effect", "se_story_9", "se_story_9_shock02_loop", "")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_11", "se_story_11_blast02", "")
			end

			local var_183_7 = 0
			local var_183_8 = 1.375

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_7 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_9 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(120061044).content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 55 <= 0 and var_183_8 or var_183_8 * (utf8.len(var_183_9) / 55)

				if (55 <= 0 and var_183_8 or var_183_8 * (utf8.len(var_183_9) / 55)) > 0 and var_183_8 < var_183_11 then
					arg_180_1.talkMaxDuration = var_183_11

					if var_183_11 + var_183_7 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_7
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_8, arg_180_1.talkMaxDuration)

			if var_183_7 <= arg_180_1.time_ and arg_180_1.time_ < var_183_7 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_7) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_7 + var_183_12 and arg_180_1.time_ < var_183_7 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play120061045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 120061045
		arg_184_1.duration_ = 3.17

		local var_184_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_184_0:Play120061046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1184ui_story = arg_184_1.actors_["1184ui_story"].transform.localPosition

				arg_184_1:ShowWeapon(arg_184_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1184ui_story"].transform.position).z)
				arg_184_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1184ui_story"].transform.localEulerAngles = arg_184_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_184_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1184ui_story"].transform.position).z)
				arg_184_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1184ui_story"].transform.localEulerAngles = arg_184_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["1184ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1184ui_story == nil then
				arg_184_1.var_.characterEffect1184ui_story = var_187_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 and not isNil(var_187_1) then
				if arg_184_1.var_.characterEffect1184ui_story and not isNil(var_187_1) then
					arg_184_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1184ui_story then
				arg_184_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_187_4 = 0
			local var_187_5 = 0.275

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:GetWordFromCfg(120061045)
				local var_187_7 = arg_184_1:FormatText(var_187_6.content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 11 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 11)

				if (11 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 11)) > 0 and var_187_5 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061045", "story_v_out_120061.awb") ~= 0 then
					local var_187_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061045", "story_v_out_120061.awb") / 1000

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end

					if var_187_6.prefab_name ~= "" and arg_184_1.actors_[var_187_6.prefab_name] ~= nil then
						local var_187_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_6.prefab_name].transform, "story_v_out_120061", "120061045", "story_v_out_120061.awb")

						arg_184_1:RecordAudio("120061045", var_187_11)
						arg_184_1:RecordAudio("120061045", var_187_11)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_120061", "120061045", "story_v_out_120061.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_120061", "120061045", "story_v_out_120061.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_12 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_12 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_12

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_12 and arg_184_1.time_ < var_187_4 + var_187_12 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play120061046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 120061046
		arg_188_1.duration_ = 3.67

		local var_188_0 = {
			zh = 3.566,
			ja = 3.666
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
				arg_188_0:Play120061047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_191_0 = 0
			local var_191_1 = 0.525

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(120061046)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 21 <= 0 and var_191_1 or var_191_1 * (utf8.len(var_191_3) / 21)

				if (21 <= 0 and var_191_1 or var_191_1 * (utf8.len(var_191_3) / 21)) > 0 and var_191_1 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061046", "story_v_out_120061.awb") ~= 0 then
					local var_191_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061046", "story_v_out_120061.awb") / 1000

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end

					if var_191_2.prefab_name ~= "" and arg_188_1.actors_[var_191_2.prefab_name] ~= nil then
						local var_191_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_2.prefab_name].transform, "story_v_out_120061", "120061046", "story_v_out_120061.awb")

						arg_188_1:RecordAudio("120061046", var_191_7)
						arg_188_1:RecordAudio("120061046", var_191_7)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_120061", "120061046", "story_v_out_120061.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_120061", "120061046", "story_v_out_120061.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_8 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_8 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_8

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_8 and arg_188_1.time_ < var_191_0 + var_191_8 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play120061047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 120061047
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play120061048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1184ui_story = arg_192_1.actors_["1184ui_story"].transform.localPosition

				arg_192_1:ShowWeapon(arg_192_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_195_0 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 then
				arg_192_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_0)
				arg_192_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1184ui_story"].transform.position).z)
				arg_192_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1184ui_story"].transform.localEulerAngles = arg_192_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 then
				arg_192_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1184ui_story"].transform.position).z)
				arg_192_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1184ui_story"].transform.localEulerAngles = arg_192_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_195_1 = 0
			local var_195_2 = 0.95

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(120061047).content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 38 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 38)

				if (38 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 38)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_6 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_6 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_6

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_6 and arg_192_1.time_ < var_195_1 + var_195_6 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play120061048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 120061048
		arg_196_1.duration_ = 2.47

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_196_0:Play120061049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_199_0 = arg_196_1.actors_["1184ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1184ui_story = var_199_0.localPosition
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_196_1.time_ - 0) / var_199_1)
				var_199_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_0.position).x, (manager.ui.mainCamera.transform.position - var_199_0.position).y, (manager.ui.mainCamera.transform.position - var_199_0.position).z)
				var_199_0.localEulerAngles.z = 0
				var_199_0.localEulerAngles.x = 0
				var_199_0.localEulerAngles = var_199_0.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_199_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_0.position).x, (manager.ui.mainCamera.transform.position - var_199_0.position).y, (manager.ui.mainCamera.transform.position - var_199_0.position).z)
				var_199_0.localEulerAngles.z = 0
				var_199_0.localEulerAngles.x = 0
				var_199_0.localEulerAngles = var_199_0.localEulerAngles
			end

			local var_199_2 = "10044ui_story"

			if arg_196_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_199_3 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_196_1.stage_.transform)

				var_199_3.name = var_199_2
				var_199_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.actors_[var_199_2] = var_199_3

				local var_199_4 = var_199_3:GetComponentInChildren(typeof(CharacterEffect))

				var_199_4.enabled = true

				local var_199_5 = GameObjectTools.GetOrAddComponent(var_199_3, typeof(DynamicBoneHelper))

				if var_199_5 then
					var_199_5:EnableDynamicBone(false)
				end

				arg_196_1:ShowWeapon(var_199_4.transform, false)

				arg_196_1.var_[var_199_2 .. "Animator"] = var_199_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_196_1.var_[var_199_2 .. "Animator"].applyRootMotion = true
				arg_196_1.var_[var_199_2 .. "LipSync"] = var_199_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_199_6 = arg_196_1.actors_["10044ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10044ui_story = var_199_6.localPosition
			end

			local var_199_7 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				var_199_6.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_196_1.time_ - 0) / var_199_7)
				var_199_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_6.position).x, (manager.ui.mainCamera.transform.position - var_199_6.position).y, (manager.ui.mainCamera.transform.position - var_199_6.position).z)
				var_199_6.localEulerAngles.z = 0
				var_199_6.localEulerAngles.x = 0
				var_199_6.localEulerAngles = var_199_6.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				var_199_6.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_199_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_6.position).x, (manager.ui.mainCamera.transform.position - var_199_6.position).y, (manager.ui.mainCamera.transform.position - var_199_6.position).z)
				var_199_6.localEulerAngles.z = 0
				var_199_6.localEulerAngles.x = 0
				var_199_6.localEulerAngles = var_199_6.localEulerAngles
			end

			local var_199_8 = arg_196_1.actors_["1184ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.characterEffect1184ui_story == nil then
				arg_196_1.var_.characterEffect1184ui_story = var_199_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_9 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_9 and not isNil(var_199_8) then
				if arg_196_1.var_.characterEffect1184ui_story and not isNil(var_199_8) then
					arg_196_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_9 and arg_196_1.time_ < 0 + var_199_9 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.characterEffect1184ui_story then
				arg_196_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_199_11 = arg_196_1.actors_["10044ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_11) and arg_196_1.var_.characterEffect10044ui_story == nil then
				arg_196_1.var_.characterEffect10044ui_story = var_199_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_12 = 0.034

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_12 and not isNil(var_199_11) then
				if arg_196_1.var_.characterEffect10044ui_story and not isNil(var_199_11) then
					arg_196_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_196_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_12)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_12 and arg_196_1.time_ < 0 + var_199_12 + arg_199_0 and not isNil(var_199_11) and arg_196_1.var_.characterEffect10044ui_story then
				arg_196_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_196_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_199_13 = 0
			local var_199_14 = 0.2

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_13 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_15 = arg_196_1:GetWordFromCfg(120061048)
				local var_199_16 = arg_196_1:FormatText(var_199_15.content)

				arg_196_1.text_.text = var_199_16

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_18 = 8 <= 0 and var_199_14 or var_199_14 * (utf8.len(var_199_16) / 8)

				if (8 <= 0 and var_199_14 or var_199_14 * (utf8.len(var_199_16) / 8)) > 0 and var_199_14 < var_199_18 then
					arg_196_1.talkMaxDuration = var_199_18

					if var_199_18 + var_199_13 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_13
					end
				end

				arg_196_1.text_.text = var_199_16
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061048", "story_v_out_120061.awb") ~= 0 then
					local var_199_19 = manager.audio:GetVoiceLength("story_v_out_120061", "120061048", "story_v_out_120061.awb") / 1000

					if var_199_19 + var_199_13 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_19 + var_199_13
					end

					if var_199_15.prefab_name ~= "" and arg_196_1.actors_[var_199_15.prefab_name] ~= nil then
						local var_199_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_15.prefab_name].transform, "story_v_out_120061", "120061048", "story_v_out_120061.awb")

						arg_196_1:RecordAudio("120061048", var_199_20)
						arg_196_1:RecordAudio("120061048", var_199_20)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_120061", "120061048", "story_v_out_120061.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_120061", "120061048", "story_v_out_120061.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_21 = math.max(var_199_14, arg_196_1.talkMaxDuration)

			if var_199_13 <= arg_196_1.time_ and arg_196_1.time_ < var_199_13 + var_199_21 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_13) / var_199_21

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_13 + var_199_21 and arg_196_1.time_ < var_199_13 + var_199_21 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play120061049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 120061049
		arg_200_1.duration_ = 8.9

		local var_200_0 = {
			zh = 3.9,
			ja = 8.9
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play120061050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1184ui_story"]) and arg_200_1.var_.characterEffect1184ui_story == nil then
				arg_200_1.var_.characterEffect1184ui_story = arg_200_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1184ui_story"]) then
				if arg_200_1.var_.characterEffect1184ui_story and not isNil(arg_200_1.actors_["1184ui_story"]) then
					arg_200_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1184ui_story"]) and arg_200_1.var_.characterEffect1184ui_story then
				arg_200_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_203_1 = arg_200_1.actors_["10044ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect10044ui_story == nil then
				arg_200_1.var_.characterEffect10044ui_story = var_203_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_2 and not isNil(var_203_1) then
				if arg_200_1.var_.characterEffect10044ui_story and not isNil(var_203_1) then
					arg_200_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_2 and arg_200_1.time_ < 0 + var_203_2 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect10044ui_story then
				arg_200_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_203_4 = 0
			local var_203_5 = 0.4

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(120061049)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 16 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 16)

				if (16 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 16)) > 0 and var_203_5 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061049", "story_v_out_120061.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061049", "story_v_out_120061.awb") / 1000

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end

					if var_203_6.prefab_name ~= "" and arg_200_1.actors_[var_203_6.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_6.prefab_name].transform, "story_v_out_120061", "120061049", "story_v_out_120061.awb")

						arg_200_1:RecordAudio("120061049", var_203_11)
						arg_200_1:RecordAudio("120061049", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_120061", "120061049", "story_v_out_120061.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_120061", "120061049", "story_v_out_120061.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_12 and arg_200_1.time_ < var_203_4 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play120061050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 120061050
		arg_204_1.duration_ = 4.37

		local var_204_0 = {
			zh = 2.433,
			ja = 4.366
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
				arg_204_0:Play120061051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_207_0 = arg_204_1.actors_["1184ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1184ui_story == nil then
				arg_204_1.var_.characterEffect1184ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_1 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_1 and not isNil(var_207_0) then
				if arg_204_1.var_.characterEffect1184ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_1 and arg_204_1.time_ < 0 + var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1184ui_story then
				arg_204_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_207_3 = arg_204_1.actors_["10044ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_3) and arg_204_1.var_.characterEffect10044ui_story == nil then
				arg_204_1.var_.characterEffect10044ui_story = var_207_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_4 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 and not isNil(var_207_3) then
				if arg_204_1.var_.characterEffect10044ui_story and not isNil(var_207_3) then
					arg_204_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_204_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_4)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 and not isNil(var_207_3) and arg_204_1.var_.characterEffect10044ui_story then
				arg_204_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_204_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_207_5 = 0
			local var_207_6 = 0.2

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_7 = arg_204_1:GetWordFromCfg(120061050)
				local var_207_8 = arg_204_1:FormatText(var_207_7.content)

				arg_204_1.text_.text = var_207_8

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_10 = 8 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 8)

				if (8 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 8)) > 0 and var_207_6 < var_207_10 then
					arg_204_1.talkMaxDuration = var_207_10

					if var_207_10 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_5
					end
				end

				arg_204_1.text_.text = var_207_8
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061050", "story_v_out_120061.awb") ~= 0 then
					local var_207_11 = manager.audio:GetVoiceLength("story_v_out_120061", "120061050", "story_v_out_120061.awb") / 1000

					if var_207_11 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_5
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_out_120061", "120061050", "story_v_out_120061.awb")

						arg_204_1:RecordAudio("120061050", var_207_12)
						arg_204_1:RecordAudio("120061050", var_207_12)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_120061", "120061050", "story_v_out_120061.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_120061", "120061050", "story_v_out_120061.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_13 = math.max(var_207_6, arg_204_1.talkMaxDuration)

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_13 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_5) / var_207_13

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_5 + var_207_13 and arg_204_1.time_ < var_207_5 + var_207_13 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play120061051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 120061051
		arg_208_1.duration_ = 8.47

		local var_208_0 = {
			zh = 8.466,
			ja = 5.4
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
				arg_208_0:Play120061052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1184ui_story"]) and arg_208_1.var_.characterEffect1184ui_story == nil then
				arg_208_1.var_.characterEffect1184ui_story = arg_208_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1184ui_story"]) then
				if arg_208_1.var_.characterEffect1184ui_story and not isNil(arg_208_1.actors_["1184ui_story"]) then
					arg_208_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1184ui_story"]) and arg_208_1.var_.characterEffect1184ui_story then
				arg_208_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_211_1 = arg_208_1.actors_["10044ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect10044ui_story == nil then
				arg_208_1.var_.characterEffect10044ui_story = var_211_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_2 and not isNil(var_211_1) then
				if arg_208_1.var_.characterEffect10044ui_story and not isNil(var_211_1) then
					arg_208_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_2 and arg_208_1.time_ < 0 + var_211_2 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect10044ui_story then
				arg_208_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_211_4 = 0
			local var_211_5 = 0.9

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_6 = arg_208_1:GetWordFromCfg(120061051)
				local var_211_7 = arg_208_1:FormatText(var_211_6.content)

				arg_208_1.text_.text = var_211_7

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_9 = 36 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 36)

				if (36 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 36)) > 0 and var_211_5 < var_211_9 then
					arg_208_1.talkMaxDuration = var_211_9

					if var_211_9 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_4
					end
				end

				arg_208_1.text_.text = var_211_7
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061051", "story_v_out_120061.awb") ~= 0 then
					local var_211_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061051", "story_v_out_120061.awb") / 1000

					if var_211_10 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_4
					end

					if var_211_6.prefab_name ~= "" and arg_208_1.actors_[var_211_6.prefab_name] ~= nil then
						local var_211_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_6.prefab_name].transform, "story_v_out_120061", "120061051", "story_v_out_120061.awb")

						arg_208_1:RecordAudio("120061051", var_211_11)
						arg_208_1:RecordAudio("120061051", var_211_11)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_120061", "120061051", "story_v_out_120061.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_120061", "120061051", "story_v_out_120061.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_12 = math.max(var_211_5, arg_208_1.talkMaxDuration)

			if var_211_4 <= arg_208_1.time_ and arg_208_1.time_ < var_211_4 + var_211_12 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_4) / var_211_12

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_4 + var_211_12 and arg_208_1.time_ < var_211_4 + var_211_12 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play120061052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 120061052
		arg_212_1.duration_ = 5.5

		local var_212_0 = {
			zh = 3.3,
			ja = 5.5
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
				arg_212_0:Play120061053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.375

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(120061052)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 15 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 15)

				if (15 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 15)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061052", "story_v_out_120061.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061052", "story_v_out_120061.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_120061", "120061052", "story_v_out_120061.awb")

						arg_212_1:RecordAudio("120061052", var_215_6)
						arg_212_1:RecordAudio("120061052", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_120061", "120061052", "story_v_out_120061.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_120061", "120061052", "story_v_out_120061.awb")
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
	Play120061053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 120061053
		arg_216_1.duration_ = 2

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play120061054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_219_0 = arg_216_1.actors_["1184ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1184ui_story == nil then
				arg_216_1.var_.characterEffect1184ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_1 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 and not isNil(var_219_0) then
				if arg_216_1.var_.characterEffect1184ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1184ui_story then
				arg_216_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_219_3 = arg_216_1.actors_["10044ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10044ui_story == nil then
				arg_216_1.var_.characterEffect10044ui_story = var_219_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_4 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 and not isNil(var_219_3) then
				if arg_216_1.var_.characterEffect10044ui_story and not isNil(var_219_3) then
					arg_216_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_4)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10044ui_story then
				arg_216_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_219_5 = 0
			local var_219_6 = 0.175

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_7 = arg_216_1:GetWordFromCfg(120061053)
				local var_219_8 = arg_216_1:FormatText(var_219_7.content)

				arg_216_1.text_.text = var_219_8

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_10 = 7 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_8) / 7)

				if (7 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_8) / 7)) > 0 and var_219_6 < var_219_10 then
					arg_216_1.talkMaxDuration = var_219_10

					if var_219_10 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_5
					end
				end

				arg_216_1.text_.text = var_219_8
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061053", "story_v_out_120061.awb") ~= 0 then
					local var_219_11 = manager.audio:GetVoiceLength("story_v_out_120061", "120061053", "story_v_out_120061.awb") / 1000

					if var_219_11 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_11 + var_219_5
					end

					if var_219_7.prefab_name ~= "" and arg_216_1.actors_[var_219_7.prefab_name] ~= nil then
						local var_219_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_7.prefab_name].transform, "story_v_out_120061", "120061053", "story_v_out_120061.awb")

						arg_216_1:RecordAudio("120061053", var_219_12)
						arg_216_1:RecordAudio("120061053", var_219_12)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_120061", "120061053", "story_v_out_120061.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_120061", "120061053", "story_v_out_120061.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_13 = math.max(var_219_6, arg_216_1.talkMaxDuration)

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_13 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_5) / var_219_13

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_5 + var_219_13 and arg_216_1.time_ < var_219_5 + var_219_13 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play120061054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 120061054
		arg_220_1.duration_ = 9.1

		local var_220_0 = {
			zh = 6.933,
			ja = 9.1
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
				arg_220_0:Play120061055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_223_0 = 0
			local var_223_1 = 0.9

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_2 = arg_220_1:GetWordFromCfg(120061054)
				local var_223_3 = arg_220_1:FormatText(var_223_2.content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 36 <= 0 and var_223_1 or var_223_1 * (utf8.len(var_223_3) / 36)

				if (36 <= 0 and var_223_1 or var_223_1 * (utf8.len(var_223_3) / 36)) > 0 and var_223_1 < var_223_5 then
					arg_220_1.talkMaxDuration = var_223_5

					if var_223_5 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061054", "story_v_out_120061.awb") ~= 0 then
					local var_223_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061054", "story_v_out_120061.awb") / 1000

					if var_223_6 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_0
					end

					if var_223_2.prefab_name ~= "" and arg_220_1.actors_[var_223_2.prefab_name] ~= nil then
						local var_223_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_2.prefab_name].transform, "story_v_out_120061", "120061054", "story_v_out_120061.awb")

						arg_220_1:RecordAudio("120061054", var_223_7)
						arg_220_1:RecordAudio("120061054", var_223_7)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_120061", "120061054", "story_v_out_120061.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_120061", "120061054", "story_v_out_120061.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_8 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_8 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_8

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_8 and arg_220_1.time_ < var_223_0 + var_223_8 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play120061055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 120061055
		arg_224_1.duration_ = 2.6

		local var_224_0 = {
			zh = 2.6,
			ja = 2.2
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
				arg_224_0:Play120061056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1184ui_story"]) and arg_224_1.var_.characterEffect1184ui_story == nil then
				arg_224_1.var_.characterEffect1184ui_story = arg_224_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1184ui_story"]) then
				if arg_224_1.var_.characterEffect1184ui_story and not isNil(arg_224_1.actors_["1184ui_story"]) then
					arg_224_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1184ui_story"]) and arg_224_1.var_.characterEffect1184ui_story then
				arg_224_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_227_1 = arg_224_1.actors_["10044ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect10044ui_story == nil then
				arg_224_1.var_.characterEffect10044ui_story = var_227_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 and not isNil(var_227_1) then
				if arg_224_1.var_.characterEffect10044ui_story and not isNil(var_227_1) then
					arg_224_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect10044ui_story then
				arg_224_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_227_4 = 0
			local var_227_5 = 0.15

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(120061055)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 6 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 6)

				if (6 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 6)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061055", "story_v_out_120061.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061055", "story_v_out_120061.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_120061", "120061055", "story_v_out_120061.awb")

						arg_224_1:RecordAudio("120061055", var_227_11)
						arg_224_1:RecordAudio("120061055", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_120061", "120061055", "story_v_out_120061.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_120061", "120061055", "story_v_out_120061.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play120061056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 120061056
		arg_228_1.duration_ = 11.87

		local var_228_0 = {
			zh = 11.266,
			ja = 11.866
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
				arg_228_0:Play120061057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1.35

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(120061056)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 54 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 54)

				if (54 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 54)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061056", "story_v_out_120061.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061056", "story_v_out_120061.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_120061", "120061056", "story_v_out_120061.awb")

						arg_228_1:RecordAudio("120061056", var_231_6)
						arg_228_1:RecordAudio("120061056", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_120061", "120061056", "story_v_out_120061.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_120061", "120061056", "story_v_out_120061.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play120061057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 120061057
		arg_232_1.duration_ = 6.97

		local var_232_0 = {
			zh = 5.366,
			ja = 6.966
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
				arg_232_0:Play120061058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.525

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:GetWordFromCfg(120061057)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 21 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 21)

				if (21 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 21)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061057", "story_v_out_120061.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061057", "story_v_out_120061.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_120061", "120061057", "story_v_out_120061.awb")

						arg_232_1:RecordAudio("120061057", var_235_6)
						arg_232_1:RecordAudio("120061057", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_120061", "120061057", "story_v_out_120061.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_120061", "120061057", "story_v_out_120061.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play120061058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 120061058
		arg_236_1.duration_ = 4.17

		local var_236_0 = {
			zh = 4.166,
			ja = 3.066
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
				arg_236_0:Play120061059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_239_0 = arg_236_1.actors_["1184ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1184ui_story == nil then
				arg_236_1.var_.characterEffect1184ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_1 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 and not isNil(var_239_0) then
				if arg_236_1.var_.characterEffect1184ui_story and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1184ui_story then
				arg_236_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_239_3 = arg_236_1.actors_["10044ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect10044ui_story == nil then
				arg_236_1.var_.characterEffect10044ui_story = var_239_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_4 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 and not isNil(var_239_3) then
				if arg_236_1.var_.characterEffect10044ui_story and not isNil(var_239_3) then
					arg_236_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_4)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect10044ui_story then
				arg_236_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_239_5 = 0
			local var_239_6 = 0.375

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_7 = arg_236_1:GetWordFromCfg(120061058)
				local var_239_8 = arg_236_1:FormatText(var_239_7.content)

				arg_236_1.text_.text = var_239_8

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_10 = 16 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 16)

				if (16 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 16)) > 0 and var_239_6 < var_239_10 then
					arg_236_1.talkMaxDuration = var_239_10

					if var_239_10 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_5
					end
				end

				arg_236_1.text_.text = var_239_8
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061058", "story_v_out_120061.awb") ~= 0 then
					local var_239_11 = manager.audio:GetVoiceLength("story_v_out_120061", "120061058", "story_v_out_120061.awb") / 1000

					if var_239_11 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_11 + var_239_5
					end

					if var_239_7.prefab_name ~= "" and arg_236_1.actors_[var_239_7.prefab_name] ~= nil then
						local var_239_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_7.prefab_name].transform, "story_v_out_120061", "120061058", "story_v_out_120061.awb")

						arg_236_1:RecordAudio("120061058", var_239_12)
						arg_236_1:RecordAudio("120061058", var_239_12)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_120061", "120061058", "story_v_out_120061.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_120061", "120061058", "story_v_out_120061.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_13 = math.max(var_239_6, arg_236_1.talkMaxDuration)

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_13 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_5) / var_239_13

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_5 + var_239_13 and arg_236_1.time_ < var_239_5 + var_239_13 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play120061059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 120061059
		arg_240_1.duration_ = 6.8

		local var_240_0 = {
			zh = 3.2,
			ja = 6.8
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
				arg_240_0:Play120061060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_243_0 = 0
			local var_243_1 = 0.425

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(120061059)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 17 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 17)

				if (17 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 17)) > 0 and var_243_1 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061059", "story_v_out_120061.awb") ~= 0 then
					local var_243_6 = manager.audio:GetVoiceLength("story_v_out_120061", "120061059", "story_v_out_120061.awb") / 1000

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end

					if var_243_2.prefab_name ~= "" and arg_240_1.actors_[var_243_2.prefab_name] ~= nil then
						local var_243_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_2.prefab_name].transform, "story_v_out_120061", "120061059", "story_v_out_120061.awb")

						arg_240_1:RecordAudio("120061059", var_243_7)
						arg_240_1:RecordAudio("120061059", var_243_7)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_120061", "120061059", "story_v_out_120061.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_120061", "120061059", "story_v_out_120061.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_8 and arg_240_1.time_ < var_243_0 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play120061060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 120061060
		arg_244_1.duration_ = 10.3

		local var_244_0 = {
			zh = 10.3,
			ja = 9.7
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
				arg_244_0:Play120061061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_247_0 = arg_244_1.actors_["1184ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1184ui_story == nil then
				arg_244_1.var_.characterEffect1184ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_1 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_1 and not isNil(var_247_0) then
				if arg_244_1.var_.characterEffect1184ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_1)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_1 and arg_244_1.time_ < 0 + var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1184ui_story then
				arg_244_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_247_2 = arg_244_1.actors_["10044ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect10044ui_story == nil then
				arg_244_1.var_.characterEffect10044ui_story = var_247_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_3 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.characterEffect10044ui_story and not isNil(var_247_2) then
					arg_244_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect10044ui_story then
				arg_244_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_247_5 = 0
			local var_247_6 = 1.1

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:GetWordFromCfg(120061060)
				local var_247_8 = arg_244_1:FormatText(var_247_7.content)

				arg_244_1.text_.text = var_247_8

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_10 = 44 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 44)

				if (44 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 44)) > 0 and var_247_6 < var_247_10 then
					arg_244_1.talkMaxDuration = var_247_10

					if var_247_10 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_8
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061060", "story_v_out_120061.awb") ~= 0 then
					local var_247_11 = manager.audio:GetVoiceLength("story_v_out_120061", "120061060", "story_v_out_120061.awb") / 1000

					if var_247_11 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_5
					end

					if var_247_7.prefab_name ~= "" and arg_244_1.actors_[var_247_7.prefab_name] ~= nil then
						local var_247_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_7.prefab_name].transform, "story_v_out_120061", "120061060", "story_v_out_120061.awb")

						arg_244_1:RecordAudio("120061060", var_247_12)
						arg_244_1:RecordAudio("120061060", var_247_12)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_120061", "120061060", "story_v_out_120061.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_120061", "120061060", "story_v_out_120061.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_13 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_13 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_13

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_13 and arg_244_1.time_ < var_247_5 + var_247_13 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play120061061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 120061061
		arg_248_1.duration_ = 11.7

		local var_248_0 = {
			zh = 9.1,
			ja = 11.7
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
				arg_248_0:Play120061062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 1.1

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(120061061)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 44 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 44)

				if (44 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 44)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061061", "story_v_out_120061.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_120061", "120061061", "story_v_out_120061.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_120061", "120061061", "story_v_out_120061.awb")

						arg_248_1:RecordAudio("120061061", var_251_6)
						arg_248_1:RecordAudio("120061061", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_120061", "120061061", "story_v_out_120061.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_120061", "120061061", "story_v_out_120061.awb")
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
	Play120061062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 120061062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play120061063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10044ui_story = arg_252_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10044ui_story"].transform.position).z)
				arg_252_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10044ui_story"].transform.localEulerAngles = arg_252_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10044ui_story"].transform.position).z)
				arg_252_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10044ui_story"].transform.localEulerAngles = arg_252_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_rock", "")
			end

			local var_255_2 = arg_252_1.actors_["1184ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1184ui_story = var_255_2.localPosition
			end

			local var_255_3 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 then
				var_255_2.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_3)
				var_255_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_2.position).x, (manager.ui.mainCamera.transform.position - var_255_2.position).y, (manager.ui.mainCamera.transform.position - var_255_2.position).z)
				var_255_2.localEulerAngles.z = 0
				var_255_2.localEulerAngles.x = 0
				var_255_2.localEulerAngles = var_255_2.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 then
				var_255_2.localPosition = Vector3.New(0, 100, 0)
				var_255_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_2.position).x, (manager.ui.mainCamera.transform.position - var_255_2.position).y, (manager.ui.mainCamera.transform.position - var_255_2.position).z)
				var_255_2.localEulerAngles.z = 0
				var_255_2.localEulerAngles.x = 0
				var_255_2.localEulerAngles = var_255_2.localEulerAngles
			end

			local var_255_4 = 0
			local var_255_5 = 0.85

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_6 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(120061062).content)

				arg_252_1.text_.text = var_255_6

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_8 = 34 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_6) / 34)

				if (34 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_6) / 34)) > 0 and var_255_5 < var_255_8 then
					arg_252_1.talkMaxDuration = var_255_8

					if var_255_8 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_6
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_9 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_9 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_9

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_9 and arg_252_1.time_ < var_255_4 + var_255_9 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play120061063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 120061063
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play120061064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.725

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(120061063).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 29 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 29)

				if (29 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 29)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play120061064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 120061064
		arg_260_1.duration_ = 10.97

		local var_260_0 = {
			zh = 5.666,
			ja = 10.966
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
				arg_260_0:Play120061065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["10044ui_story"]) and arg_260_1.var_.characterEffect10044ui_story == nil then
				arg_260_1.var_.characterEffect10044ui_story = arg_260_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["10044ui_story"]) then
				if arg_260_1.var_.characterEffect10044ui_story and not isNil(arg_260_1.actors_["10044ui_story"]) then
					arg_260_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["10044ui_story"]) and arg_260_1.var_.characterEffect10044ui_story then
				arg_260_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_263_2 = arg_260_1.actors_["10044ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10044ui_story = var_263_2.localPosition
			end

			local var_263_3 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_3 then
				var_263_2.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10044ui_story, Vector3.New(-0.7, -0.72, -6.3), (arg_260_1.time_ - 0) / var_263_3)
				var_263_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_2.position).x, (manager.ui.mainCamera.transform.position - var_263_2.position).y, (manager.ui.mainCamera.transform.position - var_263_2.position).z)
				var_263_2.localEulerAngles.z = 0
				var_263_2.localEulerAngles.x = 0
				var_263_2.localEulerAngles = var_263_2.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_3 and arg_260_1.time_ < 0 + var_263_3 + arg_263_0 then
				var_263_2.localPosition = Vector3.New(-0.7, -0.72, -6.3)
				var_263_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_2.position).x, (manager.ui.mainCamera.transform.position - var_263_2.position).y, (manager.ui.mainCamera.transform.position - var_263_2.position).z)
				var_263_2.localEulerAngles.z = 0
				var_263_2.localEulerAngles.x = 0
				var_263_2.localEulerAngles = var_263_2.localEulerAngles
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_263_4 = arg_260_1.actors_["1184ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1184ui_story = var_263_4.localPosition

				arg_260_1:ShowWeapon(arg_260_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_263_5 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_5 then
				var_263_4.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_260_1.time_ - 0) / var_263_5)
				var_263_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_4.position).x, (manager.ui.mainCamera.transform.position - var_263_4.position).y, (manager.ui.mainCamera.transform.position - var_263_4.position).z)
				var_263_4.localEulerAngles.z = 0
				var_263_4.localEulerAngles.x = 0
				var_263_4.localEulerAngles = var_263_4.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_5 and arg_260_1.time_ < 0 + var_263_5 + arg_263_0 then
				var_263_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_263_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_4.position).x, (manager.ui.mainCamera.transform.position - var_263_4.position).y, (manager.ui.mainCamera.transform.position - var_263_4.position).z)
				var_263_4.localEulerAngles.z = 0
				var_263_4.localEulerAngles.x = 0
				var_263_4.localEulerAngles = var_263_4.localEulerAngles
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_263_6 = 0
			local var_263_7 = 0.55

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_8 = arg_260_1:GetWordFromCfg(120061064)
				local var_263_9 = arg_260_1:FormatText(var_263_8.content)

				arg_260_1.text_.text = var_263_9

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 22 <= 0 and var_263_7 or var_263_7 * (utf8.len(var_263_9) / 22)

				if (22 <= 0 and var_263_7 or var_263_7 * (utf8.len(var_263_9) / 22)) > 0 and var_263_7 < var_263_11 then
					arg_260_1.talkMaxDuration = var_263_11

					if var_263_11 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_11 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_9
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061064", "story_v_out_120061.awb") ~= 0 then
					local var_263_12 = manager.audio:GetVoiceLength("story_v_out_120061", "120061064", "story_v_out_120061.awb") / 1000

					if var_263_12 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_12 + var_263_6
					end

					if var_263_8.prefab_name ~= "" and arg_260_1.actors_[var_263_8.prefab_name] ~= nil then
						local var_263_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_8.prefab_name].transform, "story_v_out_120061", "120061064", "story_v_out_120061.awb")

						arg_260_1:RecordAudio("120061064", var_263_13)
						arg_260_1:RecordAudio("120061064", var_263_13)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_120061", "120061064", "story_v_out_120061.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_120061", "120061064", "story_v_out_120061.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_14 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_14 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_14

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_14 and arg_260_1.time_ < var_263_6 + var_263_14 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play120061065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 120061065
		arg_264_1.duration_ = 5.33

		local var_264_0 = {
			zh = 2.733,
			ja = 5.333
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
				arg_264_0:Play120061066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_267_0 = arg_264_1.actors_["1184ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1184ui_story == nil then
				arg_264_1.var_.characterEffect1184ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_1 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 and not isNil(var_267_0) then
				if arg_264_1.var_.characterEffect1184ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1184ui_story then
				arg_264_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_267_3 = arg_264_1.actors_["10044ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect10044ui_story == nil then
				arg_264_1.var_.characterEffect10044ui_story = var_267_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_4 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 and not isNil(var_267_3) then
				if arg_264_1.var_.characterEffect10044ui_story and not isNil(var_267_3) then
					arg_264_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_264_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_4)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect10044ui_story then
				arg_264_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_264_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_267_5 = 0
			local var_267_6 = 0.35

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_7 = arg_264_1:GetWordFromCfg(120061065)
				local var_267_8 = arg_264_1:FormatText(var_267_7.content)

				arg_264_1.text_.text = var_267_8

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_10 = 14 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 14)

				if (14 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 14)) > 0 and var_267_6 < var_267_10 then
					arg_264_1.talkMaxDuration = var_267_10

					if var_267_10 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_5
					end
				end

				arg_264_1.text_.text = var_267_8
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061065", "story_v_out_120061.awb") ~= 0 then
					local var_267_11 = manager.audio:GetVoiceLength("story_v_out_120061", "120061065", "story_v_out_120061.awb") / 1000

					if var_267_11 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_5
					end

					if var_267_7.prefab_name ~= "" and arg_264_1.actors_[var_267_7.prefab_name] ~= nil then
						local var_267_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_7.prefab_name].transform, "story_v_out_120061", "120061065", "story_v_out_120061.awb")

						arg_264_1:RecordAudio("120061065", var_267_12)
						arg_264_1:RecordAudio("120061065", var_267_12)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_120061", "120061065", "story_v_out_120061.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_120061", "120061065", "story_v_out_120061.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_13 = math.max(var_267_6, arg_264_1.talkMaxDuration)

			if var_267_5 <= arg_264_1.time_ and arg_264_1.time_ < var_267_5 + var_267_13 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_5) / var_267_13

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_5 + var_267_13 and arg_264_1.time_ < var_267_5 + var_267_13 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play120061066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 120061066
		arg_268_1.duration_ = 2.97

		local var_268_0 = {
			zh = 2.966,
			ja = 2.133
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
			arg_268_1.auto_ = false
		end

		function arg_268_1.playNext_(arg_270_0)
			arg_268_1.onStoryFinished_()
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1184ui_story"]) and arg_268_1.var_.characterEffect1184ui_story == nil then
				arg_268_1.var_.characterEffect1184ui_story = arg_268_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1184ui_story"]) then
				if arg_268_1.var_.characterEffect1184ui_story and not isNil(arg_268_1.actors_["1184ui_story"]) then
					arg_268_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1184ui_story"]) and arg_268_1.var_.characterEffect1184ui_story then
				arg_268_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_271_1 = arg_268_1.actors_["10044ui_story"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect10044ui_story == nil then
				arg_268_1.var_.characterEffect10044ui_story = var_271_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_2 and not isNil(var_271_1) then
				if arg_268_1.var_.characterEffect10044ui_story and not isNil(var_271_1) then
					arg_268_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_2 and arg_268_1.time_ < 0 + var_271_2 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect10044ui_story then
				arg_268_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_271_4 = 0
			local var_271_5 = 0.325

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_6 = arg_268_1:GetWordFromCfg(120061066)
				local var_271_7 = arg_268_1:FormatText(var_271_6.content)

				arg_268_1.text_.text = var_271_7

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_9 = 13 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 13)

				if (13 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 13)) > 0 and var_271_5 < var_271_9 then
					arg_268_1.talkMaxDuration = var_271_9

					if var_271_9 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_9 + var_271_4
					end
				end

				arg_268_1.text_.text = var_271_7
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120061", "120061066", "story_v_out_120061.awb") ~= 0 then
					local var_271_10 = manager.audio:GetVoiceLength("story_v_out_120061", "120061066", "story_v_out_120061.awb") / 1000

					if var_271_10 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_4
					end

					if var_271_6.prefab_name ~= "" and arg_268_1.actors_[var_271_6.prefab_name] ~= nil then
						local var_271_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_6.prefab_name].transform, "story_v_out_120061", "120061066", "story_v_out_120061.awb")

						arg_268_1:RecordAudio("120061066", var_271_11)
						arg_268_1:RecordAudio("120061066", var_271_11)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_120061", "120061066", "story_v_out_120061.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_120061", "120061066", "story_v_out_120061.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_12 = math.max(var_271_5, arg_268_1.talkMaxDuration)

			if var_271_4 <= arg_268_1.time_ and arg_268_1.time_ < var_271_4 + var_271_12 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_4) / var_271_12

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_4 + var_271_12 and arg_268_1.time_ < var_271_4 + var_271_12 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J03h",
		"TextureConfig/Background/J03g"
	},
	voices = {
		"story_v_out_120061.awb"
	}
}
