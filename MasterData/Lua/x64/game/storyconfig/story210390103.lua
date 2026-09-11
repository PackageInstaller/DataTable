return {
	Play103903001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103903001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103903002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "ST03"

			if arg_1_1.bgs_.ST03 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.ST03

				arg_1_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_8 = 0
			local var_4_9 = 0.9

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_10 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_10:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(103903001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 36 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 36)

				if (36 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 36)) > 0 and var_4_9 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13
					var_4_8 = var_4_8 + 0.3

					if var_4_13 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_8
					end
				end

				arg_1_1.text_.text = var_4_11
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_14 = var_4_8 + 0.3
			local var_4_15 = math.max(var_4_9, arg_1_1.talkMaxDuration)

			if var_4_8 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_15

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play103903002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103903002
		arg_8_1.duration_ = 3.7

		local var_8_0 = {
			ja = 3.7,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_8_0:Play103903003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "bgm_story_mood_daily", "bgm_story_mood_daily", "bgm_story_mood_daily")

				local var_11_2 = manager.audio:GetAudioName("bgm_story_mood_daily", "bgm_story_mood_daily")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_2 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_2

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_2
						arg_8_1.bgmTxt2_.text = var_11_2
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

			local var_11_3 = "1039ui_story"

			if arg_8_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_11_4 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_8_1.stage_.transform)

				var_11_4.name = var_11_3
				var_11_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_3] = var_11_4

				local var_11_5 = var_11_4:GetComponentInChildren(typeof(CharacterEffect))

				var_11_5.enabled = true

				local var_11_6 = GameObjectTools.GetOrAddComponent(var_11_4, typeof(DynamicBoneHelper))

				if var_11_6 then
					var_11_6:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_5.transform, false)

				arg_8_1.var_[var_11_3 .. "Animator"] = var_11_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_3 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_3 .. "LipSync"] = var_11_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_7 = arg_8_1.actors_["1039ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1039ui_story == nil then
				arg_8_1.var_.characterEffect1039ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect1039ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1039ui_story then
				arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_11_10 = arg_8_1.actors_["1039ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1039ui_story = var_11_10.localPosition
			end

			local var_11_11 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_11 then
				var_11_10.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_8_1.time_ - 0) / var_11_11)
				var_11_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_10.position).x, (manager.ui.mainCamera.transform.position - var_11_10.position).y, (manager.ui.mainCamera.transform.position - var_11_10.position).z)
				var_11_10.localEulerAngles.z = 0
				var_11_10.localEulerAngles.x = 0
				var_11_10.localEulerAngles = var_11_10.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_11 and arg_8_1.time_ < 0 + var_11_11 + arg_11_0 then
				var_11_10.localPosition = Vector3.New(0, -1.06, -5.3)
				var_11_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_10.position).x, (manager.ui.mainCamera.transform.position - var_11_10.position).y, (manager.ui.mainCamera.transform.position - var_11_10.position).z)
				var_11_10.localEulerAngles.z = 0
				var_11_10.localEulerAngles.x = 0
				var_11_10.localEulerAngles = var_11_10.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_11_12 = 0
			local var_11_13 = 0.175

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_14 = arg_8_1:GetWordFromCfg(103903002)
				local var_11_15 = arg_8_1:FormatText(var_11_14.content)

				arg_8_1.text_.text = var_11_15

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_17 = 7 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 7)

				if (7 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 7)) > 0 and var_11_13 < var_11_17 then
					arg_8_1.talkMaxDuration = var_11_17

					if var_11_17 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_12
					end
				end

				arg_8_1.text_.text = var_11_15
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb") ~= 0 then
					local var_11_18 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb") / 1000

					if var_11_18 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_12
					end

					if var_11_14.prefab_name ~= "" and arg_8_1.actors_[var_11_14.prefab_name] ~= nil then
						local var_11_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_14.prefab_name].transform, "story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")

						arg_8_1:RecordAudio("103903002", var_11_19)
						arg_8_1:RecordAudio("103903002", var_11_19)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play103903003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103903003
		arg_13_1.duration_ = 4.6

		local var_13_0 = {
			ja = 4.6,
			ko = 3.366,
			zh = 3.366,
			en = 4.066
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
				arg_13_0:Play103903004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_16_0 = 0
			local var_16_1 = 0.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(103903003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 16 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 16)

				if (16 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 16)) > 0 and var_16_1 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb") ~= 0 then
					local var_16_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb") / 1000

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end

					if var_16_2.prefab_name ~= "" and arg_13_1.actors_[var_16_2.prefab_name] ~= nil then
						local var_16_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_2.prefab_name].transform, "story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")

						arg_13_1:RecordAudio("103903003", var_16_7)
						arg_13_1:RecordAudio("103903003", var_16_7)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play103903004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 103903004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play103903005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1039ui_story"]) and arg_17_1.var_.characterEffect1039ui_story == nil then
				arg_17_1.var_.characterEffect1039ui_story = arg_17_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.1

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1039ui_story"]) then
				if arg_17_1.var_.characterEffect1039ui_story and not isNil(arg_17_1.actors_["1039ui_story"]) then
					arg_17_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1039ui_story"]) and arg_17_1.var_.characterEffect1039ui_story then
				arg_17_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.95

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(103903004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 38 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 38)

				if (38 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 38)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play103903005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 103903005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play103903006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.7

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(103903005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 28 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 28)

				if (28 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 28)) > 0 and var_24_0 < var_24_3 then
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
	Play103903006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 103903006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play103903007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(103903006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 12 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 12)

				if (12 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 12)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play103903007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 103903007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play103903008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(103903007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 21)

				if (21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 21)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play103903008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 103903008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play103903009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.175

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

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(103903008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 47 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 47)

				if (47 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 47)) > 0 and var_36_0 < var_36_3 then
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
	Play103903009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 103903009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play103903010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.825

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
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

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(103903009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 32 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 32)

				if (32 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 32)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play103903010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 103903010
		arg_41_1.duration_ = 7.9

		local var_41_0 = {
			ja = 7.9,
			ko = 7.866,
			zh = 7.866,
			en = 5.666
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
				arg_41_0:Play103903011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1039ui_story"]) and arg_41_1.var_.characterEffect1039ui_story == nil then
				arg_41_1.var_.characterEffect1039ui_story = arg_41_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1039ui_story"]) then
				if arg_41_1.var_.characterEffect1039ui_story and not isNil(arg_41_1.actors_["1039ui_story"]) then
					arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1039ui_story"]) and arg_41_1.var_.characterEffect1039ui_story then
				arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_44_2 = 0
			local var_44_3 = 0.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(103903010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)

				if (28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")

						arg_41_1:RecordAudio("103903010", var_44_9)
						arg_41_1:RecordAudio("103903010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play103903011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 103903011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play103903012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1039ui_story"]) and arg_45_1.var_.characterEffect1039ui_story == nil then
				arg_45_1.var_.characterEffect1039ui_story = arg_45_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1039ui_story"]) then
				if arg_45_1.var_.characterEffect1039ui_story and not isNil(arg_45_1.actors_["1039ui_story"]) then
					arg_45_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1039ui_story"]) and arg_45_1.var_.characterEffect1039ui_story then
				arg_45_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.15

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(103903011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 6 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 6)

				if (6 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 6)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play103903012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 103903012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play103903013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1039ui_story = arg_49_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).z)
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles = arg_49_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(10, -1.06, -5.3)
				arg_49_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).z)
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles = arg_49_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_52_1 = 0
			local var_52_2 = 0.7

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(103903012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 28 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 28)

				if (28 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 28)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play103903013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 103903013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play103903014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPosST03 = arg_53_1.bgs_.ST03.transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.bgs_.ST03.transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPosST03, Vector3.New(0, -100, 10), (arg_53_1.time_ - 0) / var_56_0)
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.bgs_.ST03.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_56_1 = "ST02"

			if arg_53_1.bgs_.ST02 == nil then
				local var_56_2 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_1)
				var_56_2.name = var_56_1
				var_56_2.transform.parent = arg_53_1.stage_.transform
				var_56_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_1] = var_56_2
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_3 = arg_53_1.bgs_.ST02

				arg_53_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_4 = var_56_3:GetComponent("SpriteRenderer")

				if var_56_4 and var_56_4.sprite then
					local var_56_5 = 2 * (var_56_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_3.transform.localScale = Vector3.New(var_56_5 / var_56_4.sprite.bounds.size.y < var_56_5 * manager.ui.mainCameraCom_.aspect / var_56_4.sprite.bounds.size.x and var_56_5 * manager.ui.mainCameraCom_.aspect / var_56_4.sprite.bounds.size.x or var_56_5 / var_56_4.sprite.bounds.size.y, var_56_5 / var_56_4.sprite.bounds.size.y < var_56_5 * manager.ui.mainCameraCom_.aspect / var_56_4.sprite.bounds.size.x and var_56_5 * manager.ui.mainCameraCom_.aspect / var_56_4.sprite.bounds.size.x or var_56_5 / var_56_4.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "ST02" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_6 = 0
			local var_56_7 = 0.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(103903013).content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 7 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_8) / 7)

				if (7 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_8) / 7)) > 0 and var_56_7 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_11 and arg_53_1.time_ < var_56_6 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play103903014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 103903014
		arg_57_1.duration_ = 4.93

		local var_57_0 = {
			ja = 4.933,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_57_0:Play103903015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_60_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_57_1.stage_.transform)

				var_60_0.name = "1027ui_story"
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1027ui_story"] = var_60_0

				local var_60_1 = var_60_0:GetComponentInChildren(typeof(CharacterEffect))

				var_60_1.enabled = true

				local var_60_2 = GameObjectTools.GetOrAddComponent(var_60_0, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(false)
				end

				arg_57_1:ShowWeapon(var_60_1.transform, false)

				arg_57_1.var_["1027ui_story" .. "Animator"] = var_60_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_57_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_57_1.var_["1027ui_story" .. "LipSync"] = var_60_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_60_3 = arg_57_1.actors_["1027ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1027ui_story == nil then
				arg_57_1.var_.characterEffect1027ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1027ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1027ui_story then
				arg_57_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_60_6 = arg_57_1.actors_["1027ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1027ui_story = var_60_6.localPosition
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_6.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_57_1.time_ - 0) / var_60_7)
				var_60_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_6.position).x, (manager.ui.mainCamera.transform.position - var_60_6.position).y, (manager.ui.mainCamera.transform.position - var_60_6.position).z)
				var_60_6.localEulerAngles.z = 0
				var_60_6.localEulerAngles.x = 0
				var_60_6.localEulerAngles = var_60_6.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_6.localPosition = Vector3.New(0, -0.922, -5.1)
				var_60_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_6.position).x, (manager.ui.mainCamera.transform.position - var_60_6.position).y, (manager.ui.mainCamera.transform.position - var_60_6.position).z)
				var_60_6.localEulerAngles.z = 0
				var_60_6.localEulerAngles.x = 0
				var_60_6.localEulerAngles = var_60_6.localEulerAngles
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_60_8 = 0
			local var_60_9 = 0.2

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(103903014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 8 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 8)

				if (8 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 8)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")

						arg_57_1:RecordAudio("103903014", var_60_15)
						arg_57_1:RecordAudio("103903014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play103903015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 103903015
		arg_61_1.duration_ = 4.03

		local var_61_0 = {
			ja = 3.466,
			ko = 4.033,
			zh = 4.033,
			en = 3.3
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
				arg_61_0:Play103903016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_64_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_61_1.stage_.transform)

				var_64_0.name = "1148ui_story"
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1148ui_story"] = var_64_0

				local var_64_1 = var_64_0:GetComponentInChildren(typeof(CharacterEffect))

				var_64_1.enabled = true

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end

				arg_61_1:ShowWeapon(var_64_1.transform, false)

				arg_61_1.var_["1148ui_story" .. "Animator"] = var_64_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_61_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_61_1.var_["1148ui_story" .. "LipSync"] = var_64_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_64_3 = arg_61_1.actors_["1148ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1148ui_story == nil then
				arg_61_1.var_.characterEffect1148ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.1

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect1148ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1148ui_story then
				arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_64_6 = arg_61_1.actors_["1027ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1027ui_story == nil then
				arg_61_1.var_.characterEffect1027ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.1

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 and not isNil(var_64_6) then
				if arg_61_1.var_.characterEffect1027ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_7)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1027ui_story then
				arg_61_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_64_8 = arg_61_1.actors_["1027ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1027ui_story = var_64_8.localPosition
			end

			local var_64_9 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 then
				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_61_1.time_ - 0) / var_64_9)
				var_64_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_8.position).x, (manager.ui.mainCamera.transform.position - var_64_8.position).y, (manager.ui.mainCamera.transform.position - var_64_8.position).z)
				var_64_8.localEulerAngles.z = 0
				var_64_8.localEulerAngles.x = 0
				var_64_8.localEulerAngles = var_64_8.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(0, -0.922, -5.1)
				var_64_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_8.position).x, (manager.ui.mainCamera.transform.position - var_64_8.position).y, (manager.ui.mainCamera.transform.position - var_64_8.position).z)
				var_64_8.localEulerAngles.z = 0
				var_64_8.localEulerAngles.x = 0
				var_64_8.localEulerAngles = var_64_8.localEulerAngles
			end

			local var_64_10 = arg_61_1.actors_["1027ui_story"].transform

			if 0.033 < arg_61_1.time_ and arg_61_1.time_ <= 0.033 + arg_64_0 then
				arg_61_1.var_.moveOldPos1027ui_story = var_64_10.localPosition
			end

			local var_64_11 = 0.5

			if 0.033 <= arg_61_1.time_ and arg_61_1.time_ < 0.033 + var_64_11 then
				var_64_10.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (arg_61_1.time_ - 0.033) / var_64_11)
				var_64_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_10.position).x, (manager.ui.mainCamera.transform.position - var_64_10.position).y, (manager.ui.mainCamera.transform.position - var_64_10.position).z)
				var_64_10.localEulerAngles.z = 0
				var_64_10.localEulerAngles.x = 0
				var_64_10.localEulerAngles = var_64_10.localEulerAngles
			end

			if arg_61_1.time_ >= 0.033 + var_64_11 and arg_61_1.time_ < 0.033 + var_64_11 + arg_64_0 then
				var_64_10.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				var_64_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_10.position).x, (manager.ui.mainCamera.transform.position - var_64_10.position).y, (manager.ui.mainCamera.transform.position - var_64_10.position).z)
				var_64_10.localEulerAngles.z = 0
				var_64_10.localEulerAngles.x = 0
				var_64_10.localEulerAngles = var_64_10.localEulerAngles
			end

			local var_64_12 = arg_61_1.actors_["1148ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148ui_story = var_64_12.localPosition
			end

			local var_64_13 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_13 then
				var_64_12.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (arg_61_1.time_ - 0) / var_64_13)
				var_64_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_12.position).x, (manager.ui.mainCamera.transform.position - var_64_12.position).y, (manager.ui.mainCamera.transform.position - var_64_12.position).z)
				var_64_12.localEulerAngles.z = 0
				var_64_12.localEulerAngles.x = 0
				var_64_12.localEulerAngles = var_64_12.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_13 and arg_61_1.time_ < 0 + var_64_13 + arg_64_0 then
				var_64_12.localPosition = Vector3.New(0.83, -0.85, -5.6)
				var_64_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_12.position).x, (manager.ui.mainCamera.transform.position - var_64_12.position).y, (manager.ui.mainCamera.transform.position - var_64_12.position).z)
				var_64_12.localEulerAngles.z = 0
				var_64_12.localEulerAngles.x = 0
				var_64_12.localEulerAngles = var_64_12.localEulerAngles
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_64_14 = 0
			local var_64_15 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_16 = arg_61_1:GetWordFromCfg(103903015)
				local var_64_17 = arg_61_1:FormatText(var_64_16.content)

				arg_61_1.text_.text = var_64_17

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_19 = 16 <= 0 and var_64_15 or var_64_15 * (utf8.len(var_64_17) / 16)

				if (16 <= 0 and var_64_15 or var_64_15 * (utf8.len(var_64_17) / 16)) > 0 and var_64_15 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_14
					end
				end

				arg_61_1.text_.text = var_64_17
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb") / 1000

					if var_64_20 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_14
					end

					if var_64_16.prefab_name ~= "" and arg_61_1.actors_[var_64_16.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_16.prefab_name].transform, "story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")

						arg_61_1:RecordAudio("103903015", var_64_21)
						arg_61_1:RecordAudio("103903015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_15, arg_61_1.talkMaxDuration)

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_14) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_14 + var_64_22 and arg_61_1.time_ < var_64_14 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play103903016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 103903016
		arg_65_1.duration_ = 4.6

		local var_65_0 = {
			ja = 4.6,
			ko = 3.7,
			zh = 3.7,
			en = 3.533
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
				arg_65_0:Play103903017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1027ui_story"]) and arg_65_1.var_.characterEffect1027ui_story == nil then
				arg_65_1.var_.characterEffect1027ui_story = arg_65_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1027ui_story"]) then
				if arg_65_1.var_.characterEffect1027ui_story and not isNil(arg_65_1.actors_["1027ui_story"]) then
					arg_65_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1027ui_story"]) and arg_65_1.var_.characterEffect1027ui_story then
				arg_65_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1148ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1148ui_story == nil then
				arg_65_1.var_.characterEffect1148ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1148ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1148ui_story then
				arg_65_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action424")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.275

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(103903016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 11 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 11)

				if (11 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 11)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")

						arg_65_1:RecordAudio("103903016", var_68_11)
						arg_65_1:RecordAudio("103903016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play103903017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 103903017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play103903018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1027ui_story"]) and arg_69_1.var_.characterEffect1027ui_story == nil then
				arg_69_1.var_.characterEffect1027ui_story = arg_69_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.1

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1027ui_story"]) then
				if arg_69_1.var_.characterEffect1027ui_story and not isNil(arg_69_1.actors_["1027ui_story"]) then
					arg_69_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1027ui_story"]) and arg_69_1.var_.characterEffect1027ui_story then
				arg_69_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.075

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(103903017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 3 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 3)

				if (3 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 3)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play103903018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 103903018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play103903019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.125

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(103903018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 5 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 5)

				if (5 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 5)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play103903019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 103903019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play103903020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.6

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(103903019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 24 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 24)

				if (24 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 24)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play103903020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 103903020
		arg_81_1.duration_ = 8.8

		local var_81_0 = {
			ja = 8.8,
			ko = 6,
			zh = 6,
			en = 7.766
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
				arg_81_0:Play103903021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1039ui_story"]) and arg_81_1.var_.characterEffect1039ui_story == nil then
				arg_81_1.var_.characterEffect1039ui_story = arg_81_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.1

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1039ui_story"]) then
				if arg_81_1.var_.characterEffect1039ui_story and not isNil(arg_81_1.actors_["1039ui_story"]) then
					arg_81_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1039ui_story"]) and arg_81_1.var_.characterEffect1039ui_story then
				arg_81_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["1027ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1027ui_story = var_84_2.localPosition
			end

			local var_84_3 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_81_1.time_ - 0) / var_84_3)
				var_84_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_2.position).x, (manager.ui.mainCamera.transform.position - var_84_2.position).y, (manager.ui.mainCamera.transform.position - var_84_2.position).z)
				var_84_2.localEulerAngles.z = 0
				var_84_2.localEulerAngles.x = 0
				var_84_2.localEulerAngles = var_84_2.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(10, -0.922, -5.1)
				var_84_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_2.position).x, (manager.ui.mainCamera.transform.position - var_84_2.position).y, (manager.ui.mainCamera.transform.position - var_84_2.position).z)
				var_84_2.localEulerAngles.z = 0
				var_84_2.localEulerAngles.x = 0
				var_84_2.localEulerAngles = var_84_2.localEulerAngles
			end

			local var_84_4 = arg_81_1.actors_["1148ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1148ui_story = var_84_4.localPosition
			end

			local var_84_5 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 then
				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_81_1.time_ - 0) / var_84_5)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(10, -0.85, -5.6)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			local var_84_6 = arg_81_1.actors_["1039ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1039ui_story = var_84_6.localPosition
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_81_1.time_ - 0) / var_84_7)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(0, -1.06, -5.3)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_84_8 = 0
			local var_84_9 = 0.55

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(103903020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 22 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 22)

				if (22 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 22)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")

						arg_81_1:RecordAudio("103903020", var_84_15)
						arg_81_1:RecordAudio("103903020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play103903021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 103903021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play103903022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.45

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(103903021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 18 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 18)

				if (18 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 18)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play103903022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 103903022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play103903023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1039ui_story"]) and arg_89_1.var_.characterEffect1039ui_story == nil then
				arg_89_1.var_.characterEffect1039ui_story = arg_89_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.1

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1039ui_story"]) then
				if arg_89_1.var_.characterEffect1039ui_story and not isNil(arg_89_1.actors_["1039ui_story"]) then
					arg_89_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1039ui_story"]) and arg_89_1.var_.characterEffect1039ui_story then
				arg_89_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["1039ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1039ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(10, -1.06, -5.3)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			local var_92_3 = 0
			local var_92_4 = 0.525

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(103903022).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 21 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 21)

				if (21 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 21)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play103903023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 103903023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play103903024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.875

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(103903023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 35 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 35)

				if (35 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 35)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play103903024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 103903024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play103903025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.675

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(103903024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 27 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 27)

				if (27 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 27)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play103903025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 103903025
		arg_101_1.duration_ = 7.03

		local var_101_0 = {
			ja = 2.333,
			ko = 7.033,
			zh = 7.033,
			en = 5.533
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play103903026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1027ui_story"]) and arg_101_1.var_.characterEffect1027ui_story == nil then
				arg_101_1.var_.characterEffect1027ui_story = arg_101_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.1

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1027ui_story"]) then
				if arg_101_1.var_.characterEffect1027ui_story and not isNil(arg_101_1.actors_["1027ui_story"]) then
					arg_101_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1027ui_story"]) and arg_101_1.var_.characterEffect1027ui_story then
				arg_101_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_104_2 = arg_101_1.actors_["1027ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1027ui_story = var_104_2.localPosition
			end

			local var_104_3 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_101_1.time_ - 0) / var_104_3)
				var_104_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_2.position).x, (manager.ui.mainCamera.transform.position - var_104_2.position).y, (manager.ui.mainCamera.transform.position - var_104_2.position).z)
				var_104_2.localEulerAngles.z = 0
				var_104_2.localEulerAngles.x = 0
				var_104_2.localEulerAngles = var_104_2.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(0, -0.922, -5.1)
				var_104_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_2.position).x, (manager.ui.mainCamera.transform.position - var_104_2.position).y, (manager.ui.mainCamera.transform.position - var_104_2.position).z)
				var_104_2.localEulerAngles.z = 0
				var_104_2.localEulerAngles.x = 0
				var_104_2.localEulerAngles = var_104_2.localEulerAngles
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.1

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(103903025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 4 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 4)

				if (4 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 4)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")

						arg_101_1:RecordAudio("103903025", var_104_11)
						arg_101_1:RecordAudio("103903025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play103903026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 103903026
		arg_105_1.duration_ = 2.77

		local var_105_0 = {
			ja = 2.533,
			ko = 2.433,
			zh = 2.433,
			en = 2.766
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play103903027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1148ui_story"]) and arg_105_1.var_.characterEffect1148ui_story == nil then
				arg_105_1.var_.characterEffect1148ui_story = arg_105_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.1

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1148ui_story"]) then
				if arg_105_1.var_.characterEffect1148ui_story and not isNil(arg_105_1.actors_["1148ui_story"]) then
					arg_105_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1148ui_story"]) and arg_105_1.var_.characterEffect1148ui_story then
				arg_105_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["1027ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1027ui_story == nil then
				arg_105_1.var_.characterEffect1027ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.1

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect1027ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1027ui_story then
				arg_105_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_108_4 = arg_105_1.actors_["1027ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1027ui_story = var_108_4.localPosition
			end

			local var_108_5 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 then
				var_108_4.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_105_1.time_ - 0) / var_108_5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = Vector3.New(10, -0.922, -5.1)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			local var_108_6 = arg_105_1.actors_["1148ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1148ui_story = var_108_6.localPosition
			end

			local var_108_7 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				var_108_6.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.85, -5.6), (arg_105_1.time_ - 0) / var_108_7)
				var_108_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_6.position).x, (manager.ui.mainCamera.transform.position - var_108_6.position).y, (manager.ui.mainCamera.transform.position - var_108_6.position).z)
				var_108_6.localEulerAngles.z = 0
				var_108_6.localEulerAngles.x = 0
				var_108_6.localEulerAngles = var_108_6.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				var_108_6.localPosition = Vector3.New(0, -0.85, -5.6)
				var_108_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_6.position).x, (manager.ui.mainCamera.transform.position - var_108_6.position).y, (manager.ui.mainCamera.transform.position - var_108_6.position).z)
				var_108_6.localEulerAngles.z = 0
				var_108_6.localEulerAngles.x = 0
				var_108_6.localEulerAngles = var_108_6.localEulerAngles
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_108_8 = 0
			local var_108_9 = 0.25

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(103903026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 10 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 10)

				if (10 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 10)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")

						arg_105_1:RecordAudio("103903026", var_108_15)
						arg_105_1:RecordAudio("103903026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play103903027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 103903027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play103903028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1148ui_story"]) and arg_109_1.var_.characterEffect1148ui_story == nil then
				arg_109_1.var_.characterEffect1148ui_story = arg_109_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.1

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1148ui_story"]) then
				if arg_109_1.var_.characterEffect1148ui_story and not isNil(arg_109_1.actors_["1148ui_story"]) then
					arg_109_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1148ui_story"]) and arg_109_1.var_.characterEffect1148ui_story then
				arg_109_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.875

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

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(103903027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 35 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 35)

				if (35 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 35)) > 0 and var_112_2 < var_112_5 then
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

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play103903028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 103903028
		arg_113_1.duration_ = 7.83

		local var_113_0 = {
			ja = 7.833,
			ko = 4.9,
			zh = 4.9,
			en = 4.833
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
				arg_113_0:Play103903029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1039ui_story"]) and arg_113_1.var_.characterEffect1039ui_story == nil then
				arg_113_1.var_.characterEffect1039ui_story = arg_113_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.1

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1039ui_story"]) then
				if arg_113_1.var_.characterEffect1039ui_story and not isNil(arg_113_1.actors_["1039ui_story"]) then
					arg_113_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1039ui_story"]) and arg_113_1.var_.characterEffect1039ui_story then
				arg_113_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["1148ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1148ui_story = var_116_2.localPosition
			end

			local var_116_3 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_113_1.time_ - 0) / var_116_3)
				var_116_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_2.position).x, (manager.ui.mainCamera.transform.position - var_116_2.position).y, (manager.ui.mainCamera.transform.position - var_116_2.position).z)
				var_116_2.localEulerAngles.z = 0
				var_116_2.localEulerAngles.x = 0
				var_116_2.localEulerAngles = var_116_2.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(10, -0.85, -5.6)
				var_116_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_2.position).x, (manager.ui.mainCamera.transform.position - var_116_2.position).y, (manager.ui.mainCamera.transform.position - var_116_2.position).z)
				var_116_2.localEulerAngles.z = 0
				var_116_2.localEulerAngles.x = 0
				var_116_2.localEulerAngles = var_116_2.localEulerAngles
			end

			local var_116_4 = arg_113_1.actors_["1039ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1039ui_story = var_116_4.localPosition
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_113_1.time_ - 0) / var_116_5)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(0, -1.06, -5.3)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_116_6 = 0
			local var_116_7 = 0.525

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(103903028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 21 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 21)

				if (21 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 21)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")

						arg_113_1:RecordAudio("103903028", var_116_13)
						arg_113_1:RecordAudio("103903028", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play103903029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 103903029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play103903030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1039ui_story"]) and arg_117_1.var_.characterEffect1039ui_story == nil then
				arg_117_1.var_.characterEffect1039ui_story = arg_117_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.1

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1039ui_story"]) then
				if arg_117_1.var_.characterEffect1039ui_story and not isNil(arg_117_1.actors_["1039ui_story"]) then
					arg_117_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1039ui_story"]) and arg_117_1.var_.characterEffect1039ui_story then
				arg_117_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.65

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(103903029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 26 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 26)

				if (26 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 26)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play103903030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 103903030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play103903031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1039ui_story = arg_121_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1039ui_story"].transform.position).z)
				arg_121_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1039ui_story"].transform.localEulerAngles = arg_121_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(10, -1.06, -5.3)
				arg_121_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1039ui_story"].transform.position).z)
				arg_121_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1039ui_story"].transform.localEulerAngles = arg_121_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_124_1 = 0
			local var_124_2 = 0.425

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(103903030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 17 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 17)

				if (17 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 17)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
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
	Play103903031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 103903031
		arg_125_1.duration_ = 5.27

		local var_125_0 = {
			ja = 5.266,
			ko = 4.9,
			zh = 4.9,
			en = 4.733
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play103903032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1027ui_story"]) and arg_125_1.var_.characterEffect1027ui_story == nil then
				arg_125_1.var_.characterEffect1027ui_story = arg_125_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.1

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1027ui_story"]) then
				if arg_125_1.var_.characterEffect1027ui_story and not isNil(arg_125_1.actors_["1027ui_story"]) then
					arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1027ui_story"]) and arg_125_1.var_.characterEffect1027ui_story then
				arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["1027ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1027ui_story = var_128_2.localPosition
			end

			local var_128_3 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 then
				var_128_2.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (arg_125_1.time_ - 0) / var_128_3)
				var_128_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_2.position).x, (manager.ui.mainCamera.transform.position - var_128_2.position).y, (manager.ui.mainCamera.transform.position - var_128_2.position).z)
				var_128_2.localEulerAngles.z = 0
				var_128_2.localEulerAngles.x = 0
				var_128_2.localEulerAngles = var_128_2.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 then
				var_128_2.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				var_128_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_2.position).x, (manager.ui.mainCamera.transform.position - var_128_2.position).y, (manager.ui.mainCamera.transform.position - var_128_2.position).z)
				var_128_2.localEulerAngles.z = 0
				var_128_2.localEulerAngles.x = 0
				var_128_2.localEulerAngles = var_128_2.localEulerAngles
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.5

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(103903031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 20 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 20)

				if (20 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 20)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")

						arg_125_1:RecordAudio("103903031", var_128_11)
						arg_125_1:RecordAudio("103903031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play103903032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103903032
		arg_129_1.duration_ = 9.9

		local var_129_0 = {
			ja = 8.833,
			ko = 8.233,
			zh = 8.233,
			en = 9.9
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
				arg_129_0:Play103903033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1148ui_story"]) and arg_129_1.var_.characterEffect1148ui_story == nil then
				arg_129_1.var_.characterEffect1148ui_story = arg_129_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.1

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1148ui_story"]) then
				if arg_129_1.var_.characterEffect1148ui_story and not isNil(arg_129_1.actors_["1148ui_story"]) then
					arg_129_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1148ui_story"]) and arg_129_1.var_.characterEffect1148ui_story then
				arg_129_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_132_2 = arg_129_1.actors_["1027ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1027ui_story == nil then
				arg_129_1.var_.characterEffect1027ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.1

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1027ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1027ui_story then
				arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_132_4 = arg_129_1.actors_["1148ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1148ui_story = var_132_4.localPosition
			end

			local var_132_5 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				var_132_4.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (arg_129_1.time_ - 0) / var_132_5)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				var_132_4.localPosition = Vector3.New(0.83, -0.85, -5.6)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_132_6 = 0
			local var_132_7 = 1.125

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(103903032)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 45 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 45)

				if (45 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 45)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")

						arg_129_1:RecordAudio("103903032", var_132_13)
						arg_129_1:RecordAudio("103903032", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play103903033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103903033
		arg_133_1.duration_ = 3.6

		local var_133_0 = {
			ja = 3.6,
			ko = 2.2,
			zh = 2.2,
			en = 3.066
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
				arg_133_0:Play103903034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1027ui_story"]) and arg_133_1.var_.characterEffect1027ui_story == nil then
				arg_133_1.var_.characterEffect1027ui_story = arg_133_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.1

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1027ui_story"]) then
				if arg_133_1.var_.characterEffect1027ui_story and not isNil(arg_133_1.actors_["1027ui_story"]) then
					arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1027ui_story"]) and arg_133_1.var_.characterEffect1027ui_story then
				arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["1148ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1148ui_story == nil then
				arg_133_1.var_.characterEffect1148ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.1

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect1148ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1148ui_story then
				arg_133_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action442")
			end

			local var_136_4 = 0
			local var_136_5 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(103903033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)

				if (10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")

						arg_133_1:RecordAudio("103903033", var_136_11)
						arg_133_1:RecordAudio("103903033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play103903034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103903034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play103903035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1148ui_story"]) and arg_137_1.var_.characterEffect1148ui_story == nil then
				arg_137_1.var_.characterEffect1148ui_story = arg_137_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.1

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1148ui_story"]) then
				if arg_137_1.var_.characterEffect1148ui_story and not isNil(arg_137_1.actors_["1148ui_story"]) then
					arg_137_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1148ui_story"]) and arg_137_1.var_.characterEffect1148ui_story then
				arg_137_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_140_2 = 0
			local var_140_3 = 0.85

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(103903034).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 34 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 34)

				if (34 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 34)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play103903035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103903035
		arg_141_1.duration_ = 2.5

		local var_141_0 = {
			ja = 1.999999999999,
			ko = 2.5,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play103903036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1039ui_story"]) and arg_141_1.var_.characterEffect1039ui_story == nil then
				arg_141_1.var_.characterEffect1039ui_story = arg_141_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.1

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1039ui_story"]) then
				if arg_141_1.var_.characterEffect1039ui_story and not isNil(arg_141_1.actors_["1039ui_story"]) then
					arg_141_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1039ui_story"]) and arg_141_1.var_.characterEffect1039ui_story then
				arg_141_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_144_2 = arg_141_1.actors_["1027ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1027ui_story == nil then
				arg_141_1.var_.characterEffect1027ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.1

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect1027ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1027ui_story then
				arg_141_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_144_4 = arg_141_1.actors_["1148ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1148ui_story == nil then
				arg_141_1.var_.characterEffect1148ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.1

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect1148ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1148ui_story then
				arg_141_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_144_6 = arg_141_1.actors_["1027ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1027ui_story = var_144_6.localPosition
			end

			local var_144_7 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				var_144_6.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_141_1.time_ - 0) / var_144_7)
				var_144_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_6.position).x, (manager.ui.mainCamera.transform.position - var_144_6.position).y, (manager.ui.mainCamera.transform.position - var_144_6.position).z)
				var_144_6.localEulerAngles.z = 0
				var_144_6.localEulerAngles.x = 0
				var_144_6.localEulerAngles = var_144_6.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				var_144_6.localPosition = Vector3.New(10, -0.922, -5.1)
				var_144_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_6.position).x, (manager.ui.mainCamera.transform.position - var_144_6.position).y, (manager.ui.mainCamera.transform.position - var_144_6.position).z)
				var_144_6.localEulerAngles.z = 0
				var_144_6.localEulerAngles.x = 0
				var_144_6.localEulerAngles = var_144_6.localEulerAngles
			end

			local var_144_8 = arg_141_1.actors_["1148ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148ui_story = var_144_8.localPosition
			end

			local var_144_9 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 then
				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_141_1.time_ - 0) / var_144_9)
				var_144_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_8.position).x, (manager.ui.mainCamera.transform.position - var_144_8.position).y, (manager.ui.mainCamera.transform.position - var_144_8.position).z)
				var_144_8.localEulerAngles.z = 0
				var_144_8.localEulerAngles.x = 0
				var_144_8.localEulerAngles = var_144_8.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(10, -0.85, -5.6)
				var_144_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_8.position).x, (manager.ui.mainCamera.transform.position - var_144_8.position).y, (manager.ui.mainCamera.transform.position - var_144_8.position).z)
				var_144_8.localEulerAngles.z = 0
				var_144_8.localEulerAngles.x = 0
				var_144_8.localEulerAngles = var_144_8.localEulerAngles
			end

			local var_144_10 = arg_141_1.actors_["1039ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1039ui_story = var_144_10.localPosition
			end

			local var_144_11 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_11 then
				var_144_10.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_141_1.time_ - 0) / var_144_11)
				var_144_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_10.position).x, (manager.ui.mainCamera.transform.position - var_144_10.position).y, (manager.ui.mainCamera.transform.position - var_144_10.position).z)
				var_144_10.localEulerAngles.z = 0
				var_144_10.localEulerAngles.x = 0
				var_144_10.localEulerAngles = var_144_10.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_11 and arg_141_1.time_ < 0 + var_144_11 + arg_144_0 then
				var_144_10.localPosition = Vector3.New(0, -1.06, -5.3)
				var_144_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_10.position).x, (manager.ui.mainCamera.transform.position - var_144_10.position).y, (manager.ui.mainCamera.transform.position - var_144_10.position).z)
				var_144_10.localEulerAngles.z = 0
				var_144_10.localEulerAngles.x = 0
				var_144_10.localEulerAngles = var_144_10.localEulerAngles
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_144_12 = 0
			local var_144_13 = 0.125

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_14 = arg_141_1:GetWordFromCfg(103903035)
				local var_144_15 = arg_141_1:FormatText(var_144_14.content)

				arg_141_1.text_.text = var_144_15

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 5 <= 0 and var_144_13 or var_144_13 * (utf8.len(var_144_15) / 5)

				if (5 <= 0 and var_144_13 or var_144_13 * (utf8.len(var_144_15) / 5)) > 0 and var_144_13 < var_144_17 then
					arg_141_1.talkMaxDuration = var_144_17

					if var_144_17 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_15
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb") ~= 0 then
					local var_144_18 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb") / 1000

					if var_144_18 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_12
					end

					if var_144_14.prefab_name ~= "" and arg_141_1.actors_[var_144_14.prefab_name] ~= nil then
						local var_144_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_14.prefab_name].transform, "story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")

						arg_141_1:RecordAudio("103903035", var_144_19)
						arg_141_1:RecordAudio("103903035", var_144_19)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_20 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_20 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_20

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_20 and arg_141_1.time_ < var_144_12 + var_144_20 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play103903036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 103903036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play103903037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.525

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(103903036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 21 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 21)

				if (21 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 21)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play103903037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 103903037
		arg_149_1.duration_ = 7.9

		local var_149_0 = {
			ja = 7.9,
			ko = 4.233,
			zh = 4.233,
			en = 4.466
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
				arg_149_0:Play103903038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_152_0 = 0
			local var_152_1 = 0.6

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(103903037)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 24 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 24)

				if (24 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 24)) > 0 and var_152_1 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb") ~= 0 then
					local var_152_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb") / 1000

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end

					if var_152_2.prefab_name ~= "" and arg_149_1.actors_[var_152_2.prefab_name] ~= nil then
						local var_152_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_2.prefab_name].transform, "story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")

						arg_149_1:RecordAudio("103903037", var_152_7)
						arg_149_1:RecordAudio("103903037", var_152_7)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play103903038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 103903038
		arg_153_1.duration_ = 10.47

		local var_153_0 = {
			ja = 10.466,
			ko = 6.6,
			zh = 6.6,
			en = 10.2
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
				arg_153_0:Play103903039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_156_0 = 0
			local var_156_1 = 0.7

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(103903038)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 28 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 28)

				if (28 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 28)) > 0 and var_156_1 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb") ~= 0 then
					local var_156_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb") / 1000

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end

					if var_156_2.prefab_name ~= "" and arg_153_1.actors_[var_156_2.prefab_name] ~= nil then
						local var_156_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_2.prefab_name].transform, "story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")

						arg_153_1:RecordAudio("103903038", var_156_7)
						arg_153_1:RecordAudio("103903038", var_156_7)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play103903039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 103903039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play103903040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) and arg_157_1.var_.characterEffect1039ui_story == nil then
				arg_157_1.var_.characterEffect1039ui_story = arg_157_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.1

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) then
				if arg_157_1.var_.characterEffect1039ui_story and not isNil(arg_157_1.actors_["1039ui_story"]) then
					arg_157_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) and arg_157_1.var_.characterEffect1039ui_story then
				arg_157_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_160_1 = arg_157_1.actors_["1039ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1039ui_story = var_160_1.localPosition
			end

			local var_160_2 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 then
				var_160_1.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_157_1.time_ - 0) / var_160_2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 then
				var_160_1.localPosition = Vector3.New(10, -1.06, -5.3)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			local var_160_3 = 0
			local var_160_4 = 0.325

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_5 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(103903039).content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 13 <= 0 and var_160_4 or var_160_4 * (utf8.len(var_160_5) / 13)

				if (13 <= 0 and var_160_4 or var_160_4 * (utf8.len(var_160_5) / 13)) > 0 and var_160_4 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_3 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_3
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_4, arg_157_1.talkMaxDuration)

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_3) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_3 + var_160_8 and arg_157_1.time_ < var_160_3 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play103903040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 103903040
		arg_161_1.duration_ = 4.2

		local var_161_0 = {
			ja = 4.2,
			ko = 2.866,
			zh = 2.866,
			en = 3.833
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
				arg_161_0:Play103903041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1027ui_story"]) and arg_161_1.var_.characterEffect1027ui_story == nil then
				arg_161_1.var_.characterEffect1027ui_story = arg_161_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.1

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1027ui_story"]) then
				if arg_161_1.var_.characterEffect1027ui_story and not isNil(arg_161_1.actors_["1027ui_story"]) then
					arg_161_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1027ui_story"]) and arg_161_1.var_.characterEffect1027ui_story then
				arg_161_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_164_2 = arg_161_1.actors_["1027ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1027ui_story = var_164_2.localPosition
			end

			local var_164_3 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 then
				var_164_2.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_161_1.time_ - 0) / var_164_3)
				var_164_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_2.position).x, (manager.ui.mainCamera.transform.position - var_164_2.position).y, (manager.ui.mainCamera.transform.position - var_164_2.position).z)
				var_164_2.localEulerAngles.z = 0
				var_164_2.localEulerAngles.x = 0
				var_164_2.localEulerAngles = var_164_2.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 then
				var_164_2.localPosition = Vector3.New(0, -0.922, -5.1)
				var_164_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_2.position).x, (manager.ui.mainCamera.transform.position - var_164_2.position).y, (manager.ui.mainCamera.transform.position - var_164_2.position).z)
				var_164_2.localEulerAngles.z = 0
				var_164_2.localEulerAngles.x = 0
				var_164_2.localEulerAngles = var_164_2.localEulerAngles
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_164_4 = 0
			local var_164_5 = 0.225

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(103903040)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 9 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 9)

				if (9 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 9)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")

						arg_161_1:RecordAudio("103903040", var_164_11)
						arg_161_1:RecordAudio("103903040", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play103903041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 103903041
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			ja = 4.3,
			ko = 4.233,
			zh = 4.233,
			en = 3.6
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
				arg_165_0:Play103903042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1148ui_story"]) and arg_165_1.var_.characterEffect1148ui_story == nil then
				arg_165_1.var_.characterEffect1148ui_story = arg_165_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.1

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1148ui_story"]) then
				if arg_165_1.var_.characterEffect1148ui_story and not isNil(arg_165_1.actors_["1148ui_story"]) then
					arg_165_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1148ui_story"]) and arg_165_1.var_.characterEffect1148ui_story then
				arg_165_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_168_2 = arg_165_1.actors_["1027ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1027ui_story == nil then
				arg_165_1.var_.characterEffect1027ui_story = var_168_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.1

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.characterEffect1027ui_story and not isNil(var_168_2) then
					arg_165_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_3)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1027ui_story then
				arg_165_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_168_4 = arg_165_1.actors_["1027ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1027ui_story = var_168_4.localPosition
			end

			local var_168_5 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				var_168_4.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_165_1.time_ - 0) / var_168_5)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				var_168_4.localPosition = Vector3.New(10, -0.922, -5.1)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			local var_168_6 = arg_165_1.actors_["1148ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1148ui_story = var_168_6.localPosition
			end

			local var_168_7 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				var_168_6.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.85, -5.6), (arg_165_1.time_ - 0) / var_168_7)
				var_168_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_6.position).x, (manager.ui.mainCamera.transform.position - var_168_6.position).y, (manager.ui.mainCamera.transform.position - var_168_6.position).z)
				var_168_6.localEulerAngles.z = 0
				var_168_6.localEulerAngles.x = 0
				var_168_6.localEulerAngles = var_168_6.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				var_168_6.localPosition = Vector3.New(0, -0.85, -5.6)
				var_168_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_6.position).x, (manager.ui.mainCamera.transform.position - var_168_6.position).y, (manager.ui.mainCamera.transform.position - var_168_6.position).z)
				var_168_6.localEulerAngles.z = 0
				var_168_6.localEulerAngles.x = 0
				var_168_6.localEulerAngles = var_168_6.localEulerAngles
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_168_8 = 0
			local var_168_9 = 0.475

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(103903041)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 19 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 19)

				if (19 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 19)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")

						arg_165_1:RecordAudio("103903041", var_168_15)
						arg_165_1:RecordAudio("103903041", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play103903042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 103903042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play103903043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1148ui_story"]) and arg_169_1.var_.characterEffect1148ui_story == nil then
				arg_169_1.var_.characterEffect1148ui_story = arg_169_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.1

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1148ui_story"]) then
				if arg_169_1.var_.characterEffect1148ui_story and not isNil(arg_169_1.actors_["1148ui_story"]) then
					arg_169_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1148ui_story"]) and arg_169_1.var_.characterEffect1148ui_story then
				arg_169_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_172_1 = arg_169_1.actors_["1148ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1148ui_story = var_172_1.localPosition
			end

			local var_172_2 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 then
				var_172_1.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_169_1.time_ - 0) / var_172_2)
				var_172_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_1.position).x, (manager.ui.mainCamera.transform.position - var_172_1.position).y, (manager.ui.mainCamera.transform.position - var_172_1.position).z)
				var_172_1.localEulerAngles.z = 0
				var_172_1.localEulerAngles.x = 0
				var_172_1.localEulerAngles = var_172_1.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 then
				var_172_1.localPosition = Vector3.New(10, -0.85, -5.6)
				var_172_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_1.position).x, (manager.ui.mainCamera.transform.position - var_172_1.position).y, (manager.ui.mainCamera.transform.position - var_172_1.position).z)
				var_172_1.localEulerAngles.z = 0
				var_172_1.localEulerAngles.x = 0
				var_172_1.localEulerAngles = var_172_1.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_172_3 = 0
			local var_172_4 = 0.8

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_5 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(103903042).content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 32 <= 0 and var_172_4 or var_172_4 * (utf8.len(var_172_5) / 32)

				if (32 <= 0 and var_172_4 or var_172_4 * (utf8.len(var_172_5) / 32)) > 0 and var_172_4 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_3 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_3
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_4, arg_169_1.talkMaxDuration)

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_3) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_3 + var_172_8 and arg_169_1.time_ < var_172_3 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play103903043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 103903043
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play103903044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1027ui_story"]) and arg_173_1.var_.characterEffect1027ui_story == nil then
				arg_173_1.var_.characterEffect1027ui_story = arg_173_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.1

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1027ui_story"]) then
				if arg_173_1.var_.characterEffect1027ui_story and not isNil(arg_173_1.actors_["1027ui_story"]) then
					arg_173_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1027ui_story"]) and arg_173_1.var_.characterEffect1027ui_story then
				arg_173_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_176_2 = arg_173_1.actors_["1148ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1148ui_story == nil then
				arg_173_1.var_.characterEffect1148ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.1

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect1148ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1148ui_story then
				arg_173_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_176_5 = arg_173_1.actors_["1027ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1027ui_story = var_176_5.localPosition
			end

			local var_176_6 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 then
				var_176_5.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (arg_173_1.time_ - 0) / var_176_6)
				var_176_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_5.position).x, (manager.ui.mainCamera.transform.position - var_176_5.position).y, (manager.ui.mainCamera.transform.position - var_176_5.position).z)
				var_176_5.localEulerAngles.z = 0
				var_176_5.localEulerAngles.x = 0
				var_176_5.localEulerAngles = var_176_5.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 then
				var_176_5.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				var_176_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_5.position).x, (manager.ui.mainCamera.transform.position - var_176_5.position).y, (manager.ui.mainCamera.transform.position - var_176_5.position).z)
				var_176_5.localEulerAngles.z = 0
				var_176_5.localEulerAngles.x = 0
				var_176_5.localEulerAngles = var_176_5.localEulerAngles
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_176_7 = arg_173_1.actors_["1148ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1148ui_story = var_176_7.localPosition
			end

			local var_176_8 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_8 then
				var_176_7.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (arg_173_1.time_ - 0) / var_176_8)
				var_176_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_7.position).x, (manager.ui.mainCamera.transform.position - var_176_7.position).y, (manager.ui.mainCamera.transform.position - var_176_7.position).z)
				var_176_7.localEulerAngles.z = 0
				var_176_7.localEulerAngles.x = 0
				var_176_7.localEulerAngles = var_176_7.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_8 and arg_173_1.time_ < 0 + var_176_8 + arg_176_0 then
				var_176_7.localPosition = Vector3.New(0.83, -0.85, -5.6)
				var_176_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_7.position).x, (manager.ui.mainCamera.transform.position - var_176_7.position).y, (manager.ui.mainCamera.transform.position - var_176_7.position).z)
				var_176_7.localEulerAngles.z = 0
				var_176_7.localEulerAngles.x = 0
				var_176_7.localEulerAngles = var_176_7.localEulerAngles
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_176_9 = 0
			local var_176_10 = 0.05

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_11 = arg_173_1:GetWordFromCfg(103903043)
				local var_176_12 = arg_173_1:FormatText(var_176_11.content)

				arg_173_1.text_.text = var_176_12

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_14 = 2 <= 0 and var_176_10 or var_176_10 * (utf8.len(var_176_12) / 2)

				if (2 <= 0 and var_176_10 or var_176_10 * (utf8.len(var_176_12) / 2)) > 0 and var_176_10 < var_176_14 then
					arg_173_1.talkMaxDuration = var_176_14

					if var_176_14 + var_176_9 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_9
					end
				end

				arg_173_1.text_.text = var_176_12
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb") ~= 0 then
					local var_176_15 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb") / 1000

					if var_176_15 + var_176_9 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_9
					end

					if var_176_11.prefab_name ~= "" and arg_173_1.actors_[var_176_11.prefab_name] ~= nil then
						local var_176_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_11.prefab_name].transform, "story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")

						arg_173_1:RecordAudio("103903043", var_176_16)
						arg_173_1:RecordAudio("103903043", var_176_16)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_17 = math.max(var_176_10, arg_173_1.talkMaxDuration)

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_17 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_9) / var_176_17

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_9 + var_176_17 and arg_173_1.time_ < var_176_9 + var_176_17 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play103903044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 103903044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play103903045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.75

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(103903044).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 30 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 30)

				if (30 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 30)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play103903045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 103903045
		arg_181_1.duration_ = 4.1

		local var_181_0 = {
			ja = 4.1,
			ko = 3.566,
			zh = 3.566,
			en = 3.3
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play103903046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) and arg_181_1.var_.characterEffect1039ui_story == nil then
				arg_181_1.var_.characterEffect1039ui_story = arg_181_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.1

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) then
				if arg_181_1.var_.characterEffect1039ui_story and not isNil(arg_181_1.actors_["1039ui_story"]) then
					arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) and arg_181_1.var_.characterEffect1039ui_story then
				arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["1027ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1027ui_story == nil then
				arg_181_1.var_.characterEffect1027ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.1

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect1027ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1027ui_story then
				arg_181_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_184_4 = arg_181_1.actors_["1148ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1148ui_story == nil then
				arg_181_1.var_.characterEffect1148ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_5 = 0.1

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 and not isNil(var_184_4) then
				if arg_181_1.var_.characterEffect1148ui_story and not isNil(var_184_4) then
					arg_181_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_5)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1148ui_story then
				arg_181_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_184_6 = arg_181_1.actors_["1027ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1027ui_story = var_184_6.localPosition
			end

			local var_184_7 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				var_184_6.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_181_1.time_ - 0) / var_184_7)
				var_184_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_6.position).x, (manager.ui.mainCamera.transform.position - var_184_6.position).y, (manager.ui.mainCamera.transform.position - var_184_6.position).z)
				var_184_6.localEulerAngles.z = 0
				var_184_6.localEulerAngles.x = 0
				var_184_6.localEulerAngles = var_184_6.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				var_184_6.localPosition = Vector3.New(10, -0.922, -5.1)
				var_184_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_6.position).x, (manager.ui.mainCamera.transform.position - var_184_6.position).y, (manager.ui.mainCamera.transform.position - var_184_6.position).z)
				var_184_6.localEulerAngles.z = 0
				var_184_6.localEulerAngles.x = 0
				var_184_6.localEulerAngles = var_184_6.localEulerAngles
			end

			local var_184_8 = arg_181_1.actors_["1148ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1148ui_story = var_184_8.localPosition
			end

			local var_184_9 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_9 then
				var_184_8.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_181_1.time_ - 0) / var_184_9)
				var_184_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_8.position).x, (manager.ui.mainCamera.transform.position - var_184_8.position).y, (manager.ui.mainCamera.transform.position - var_184_8.position).z)
				var_184_8.localEulerAngles.z = 0
				var_184_8.localEulerAngles.x = 0
				var_184_8.localEulerAngles = var_184_8.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_9 and arg_181_1.time_ < 0 + var_184_9 + arg_184_0 then
				var_184_8.localPosition = Vector3.New(10, -0.85, -5.6)
				var_184_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_8.position).x, (manager.ui.mainCamera.transform.position - var_184_8.position).y, (manager.ui.mainCamera.transform.position - var_184_8.position).z)
				var_184_8.localEulerAngles.z = 0
				var_184_8.localEulerAngles.x = 0
				var_184_8.localEulerAngles = var_184_8.localEulerAngles
			end

			local var_184_10 = arg_181_1.actors_["1039ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1039ui_story = var_184_10.localPosition
			end

			local var_184_11 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_11 then
				var_184_10.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_181_1.time_ - 0) / var_184_11)
				var_184_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_10.position).x, (manager.ui.mainCamera.transform.position - var_184_10.position).y, (manager.ui.mainCamera.transform.position - var_184_10.position).z)
				var_184_10.localEulerAngles.z = 0
				var_184_10.localEulerAngles.x = 0
				var_184_10.localEulerAngles = var_184_10.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_11 and arg_181_1.time_ < 0 + var_184_11 + arg_184_0 then
				var_184_10.localPosition = Vector3.New(0, -1.06, -5.3)
				var_184_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_10.position).x, (manager.ui.mainCamera.transform.position - var_184_10.position).y, (manager.ui.mainCamera.transform.position - var_184_10.position).z)
				var_184_10.localEulerAngles.z = 0
				var_184_10.localEulerAngles.x = 0
				var_184_10.localEulerAngles = var_184_10.localEulerAngles
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_184_12 = 0
			local var_184_13 = 0.35

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_14 = arg_181_1:GetWordFromCfg(103903045)
				local var_184_15 = arg_181_1:FormatText(var_184_14.content)

				arg_181_1.text_.text = var_184_15

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_17 = 14 <= 0 and var_184_13 or var_184_13 * (utf8.len(var_184_15) / 14)

				if (14 <= 0 and var_184_13 or var_184_13 * (utf8.len(var_184_15) / 14)) > 0 and var_184_13 < var_184_17 then
					arg_181_1.talkMaxDuration = var_184_17

					if var_184_17 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_12
					end
				end

				arg_181_1.text_.text = var_184_15
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb") ~= 0 then
					local var_184_18 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb") / 1000

					if var_184_18 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_12
					end

					if var_184_14.prefab_name ~= "" and arg_181_1.actors_[var_184_14.prefab_name] ~= nil then
						local var_184_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_14.prefab_name].transform, "story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")

						arg_181_1:RecordAudio("103903045", var_184_19)
						arg_181_1:RecordAudio("103903045", var_184_19)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_20 = math.max(var_184_13, arg_181_1.talkMaxDuration)

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_20 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_12) / var_184_20

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_12 + var_184_20 and arg_181_1.time_ < var_184_12 + var_184_20 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play103903046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 103903046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play103903047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1039ui_story = arg_185_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1039ui_story"].transform.position).z)
				arg_185_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1039ui_story"].transform.localEulerAngles = arg_185_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(10, -1.06, -5.3)
				arg_185_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1039ui_story"].transform.position).z)
				arg_185_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1039ui_story"].transform.localEulerAngles = arg_185_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_188_1 = 0
			local var_188_2 = 0.65

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(103903046).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 26 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 26)

				if (26 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 26)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play103903047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 103903047
		arg_189_1.duration_ = 3

		local var_189_0 = {
			ja = 2.766,
			ko = 3,
			zh = 3,
			en = 1.999999999999
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play103903048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1027ui_story"]) and arg_189_1.var_.characterEffect1027ui_story == nil then
				arg_189_1.var_.characterEffect1027ui_story = arg_189_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.1

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1027ui_story"]) then
				if arg_189_1.var_.characterEffect1027ui_story and not isNil(arg_189_1.actors_["1027ui_story"]) then
					arg_189_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1027ui_story"]) and arg_189_1.var_.characterEffect1027ui_story then
				arg_189_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["1148ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1148ui_story == nil then
				arg_189_1.var_.characterEffect1148ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.1

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect1148ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1148ui_story then
				arg_189_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_192_5 = arg_189_1.actors_["1027ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1027ui_story = var_192_5.localPosition
			end

			local var_192_6 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 then
				var_192_5.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (arg_189_1.time_ - 0) / var_192_6)
				var_192_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_5.position).x, (manager.ui.mainCamera.transform.position - var_192_5.position).y, (manager.ui.mainCamera.transform.position - var_192_5.position).z)
				var_192_5.localEulerAngles.z = 0
				var_192_5.localEulerAngles.x = 0
				var_192_5.localEulerAngles = var_192_5.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 then
				var_192_5.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				var_192_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_5.position).x, (manager.ui.mainCamera.transform.position - var_192_5.position).y, (manager.ui.mainCamera.transform.position - var_192_5.position).z)
				var_192_5.localEulerAngles.z = 0
				var_192_5.localEulerAngles.x = 0
				var_192_5.localEulerAngles = var_192_5.localEulerAngles
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_192_7 = arg_189_1.actors_["1148ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1148ui_story = var_192_7.localPosition
			end

			local var_192_8 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_8 then
				var_192_7.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (arg_189_1.time_ - 0) / var_192_8)
				var_192_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_7.position).x, (manager.ui.mainCamera.transform.position - var_192_7.position).y, (manager.ui.mainCamera.transform.position - var_192_7.position).z)
				var_192_7.localEulerAngles.z = 0
				var_192_7.localEulerAngles.x = 0
				var_192_7.localEulerAngles = var_192_7.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_8 and arg_189_1.time_ < 0 + var_192_8 + arg_192_0 then
				var_192_7.localPosition = Vector3.New(0.83, -0.85, -5.6)
				var_192_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_7.position).x, (manager.ui.mainCamera.transform.position - var_192_7.position).y, (manager.ui.mainCamera.transform.position - var_192_7.position).z)
				var_192_7.localEulerAngles.z = 0
				var_192_7.localEulerAngles.x = 0
				var_192_7.localEulerAngles = var_192_7.localEulerAngles
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_192_9 = 0
			local var_192_10 = 0.075

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:GetWordFromCfg(103903047)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_14 = 3 <= 0 and var_192_10 or var_192_10 * (utf8.len(var_192_12) / 3)

				if (3 <= 0 and var_192_10 or var_192_10 * (utf8.len(var_192_12) / 3)) > 0 and var_192_10 < var_192_14 then
					arg_189_1.talkMaxDuration = var_192_14

					if var_192_14 + var_192_9 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_9
					end
				end

				arg_189_1.text_.text = var_192_12
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb") ~= 0 then
					local var_192_15 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb") / 1000

					if var_192_15 + var_192_9 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_9
					end

					if var_192_11.prefab_name ~= "" and arg_189_1.actors_[var_192_11.prefab_name] ~= nil then
						local var_192_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_11.prefab_name].transform, "story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")

						arg_189_1:RecordAudio("103903047", var_192_16)
						arg_189_1:RecordAudio("103903047", var_192_16)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_17 = math.max(var_192_10, arg_189_1.talkMaxDuration)

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_17 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_9) / var_192_17

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_9 + var_192_17 and arg_189_1.time_ < var_192_9 + var_192_17 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play103903048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 103903048
		arg_193_1.duration_ = 1.2

		local var_193_0 = {
			ja = 1.133,
			ko = 1.033,
			zh = 1.033,
			en = 1.2
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play103903049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_196_0 = 0
			local var_196_1 = 0.025

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(103903048)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 1 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 1)

				if (1 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 1)) > 0 and var_196_1 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb") ~= 0 then
					local var_196_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb") / 1000

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end

					if var_196_2.prefab_name ~= "" and arg_193_1.actors_[var_196_2.prefab_name] ~= nil then
						local var_196_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_2.prefab_name].transform, "story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")

						arg_193_1:RecordAudio("103903048", var_196_7)
						arg_193_1:RecordAudio("103903048", var_196_7)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play103903049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 103903049
		arg_197_1.duration_ = 3.87

		local var_197_0 = {
			ja = 3.7,
			ko = 3.166,
			zh = 3.166,
			en = 3.866
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
				arg_197_0:Play103903050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1148ui_story"]) and arg_197_1.var_.characterEffect1148ui_story == nil then
				arg_197_1.var_.characterEffect1148ui_story = arg_197_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.1

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1148ui_story"]) then
				if arg_197_1.var_.characterEffect1148ui_story and not isNil(arg_197_1.actors_["1148ui_story"]) then
					arg_197_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1148ui_story"]) and arg_197_1.var_.characterEffect1148ui_story then
				arg_197_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action423")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_200_1 = 0
			local var_200_2 = 0.225

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(103903049)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_6 = 9 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 9)

				if (9 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 9)) > 0 and var_200_2 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb") ~= 0 then
					local var_200_7 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb") / 1000

					if var_200_7 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_1
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")

						arg_197_1:RecordAudio("103903049", var_200_8)
						arg_197_1:RecordAudio("103903049", var_200_8)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_9 and arg_197_1.time_ < var_200_1 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play103903050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 103903050
		arg_201_1.duration_ = 5.97

		local var_201_0 = {
			ja = 5.233,
			ko = 5.4,
			zh = 5.4,
			en = 5.966
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play103903051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1148ui_story"]) and arg_201_1.var_.characterEffect1148ui_story == nil then
				arg_201_1.var_.characterEffect1148ui_story = arg_201_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.1

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1148ui_story"]) then
				if arg_201_1.var_.characterEffect1148ui_story and not isNil(arg_201_1.actors_["1148ui_story"]) then
					arg_201_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1148ui_story"]) and arg_201_1.var_.characterEffect1148ui_story then
				arg_201_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_204_2 = arg_201_1.actors_["1027ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1027ui_story == nil then
				arg_201_1.var_.characterEffect1027ui_story = var_204_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_3 = 0.1

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.characterEffect1027ui_story and not isNil(var_204_2) then
					arg_201_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_3)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1027ui_story then
				arg_201_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_204_4 = 0
			local var_204_5 = 0.525

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(103903050)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 21 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 21)

				if (21 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 21)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")

						arg_201_1:RecordAudio("103903050", var_204_11)
						arg_201_1:RecordAudio("103903050", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play103903051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 103903051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play103903052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1027ui_story = arg_205_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1027ui_story"].transform.position).z)
				arg_205_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1027ui_story"].transform.localEulerAngles = arg_205_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(10, -0.922, -5.1)
				arg_205_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1027ui_story"].transform.position).z)
				arg_205_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1027ui_story"].transform.localEulerAngles = arg_205_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1148ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1148ui_story = var_208_1.localPosition
			end

			local var_208_2 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 then
				var_208_1.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_205_1.time_ - 0) / var_208_2)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 then
				var_208_1.localPosition = Vector3.New(10, -0.85, -5.6)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			local var_208_3 = 0
			local var_208_4 = 0.45

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_5 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(103903051).content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 18 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 18)

				if (18 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 18)) > 0 and var_208_4 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_3 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_3
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_4, arg_205_1.talkMaxDuration)

			if var_208_3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_3 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_3) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_3 + var_208_8 and arg_205_1.time_ < var_208_3 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play103903052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 103903052
		arg_209_1.duration_ = 6.17

		local var_209_0 = {
			ja = 6.166,
			ko = 2.1,
			zh = 2.1,
			en = 2.2
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play103903053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1039ui_story"]) and arg_209_1.var_.characterEffect1039ui_story == nil then
				arg_209_1.var_.characterEffect1039ui_story = arg_209_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.1

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1039ui_story"]) then
				if arg_209_1.var_.characterEffect1039ui_story and not isNil(arg_209_1.actors_["1039ui_story"]) then
					arg_209_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1039ui_story"]) and arg_209_1.var_.characterEffect1039ui_story then
				arg_209_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_212_2 = arg_209_1.bgs_.ST02.transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPosST02 = var_212_2.localPosition
			end

			local var_212_3 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosST02, Vector3.New(0, -100, 10), (arg_209_1.time_ - 0) / var_212_3)
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				local var_212_4 = arg_209_1.bgs_.ST03

				arg_209_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_5 = var_212_4:GetComponent("SpriteRenderer")

				if var_212_5 and var_212_5.sprite then
					local var_212_6 = 2 * (var_212_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_4.transform.localScale = Vector3.New(var_212_6 / var_212_5.sprite.bounds.size.y < var_212_6 * manager.ui.mainCameraCom_.aspect / var_212_5.sprite.bounds.size.x and var_212_6 * manager.ui.mainCameraCom_.aspect / var_212_5.sprite.bounds.size.x or var_212_6 / var_212_5.sprite.bounds.size.y, var_212_6 / var_212_5.sprite.bounds.size.y < var_212_6 * manager.ui.mainCameraCom_.aspect / var_212_5.sprite.bounds.size.x and var_212_6 * manager.ui.mainCameraCom_.aspect / var_212_5.sprite.bounds.size.x or var_212_6 / var_212_5.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "ST03" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_7 = arg_209_1.actors_["1039ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1039ui_story = var_212_7.localPosition
			end

			local var_212_8 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_8 then
				var_212_7.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_209_1.time_ - 0) / var_212_8)
				var_212_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_7.position).x, (manager.ui.mainCamera.transform.position - var_212_7.position).y, (manager.ui.mainCamera.transform.position - var_212_7.position).z)
				var_212_7.localEulerAngles.z = 0
				var_212_7.localEulerAngles.x = 0
				var_212_7.localEulerAngles = var_212_7.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_8 and arg_209_1.time_ < 0 + var_212_8 + arg_212_0 then
				var_212_7.localPosition = Vector3.New(0, -1.06, -5.3)
				var_212_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_7.position).x, (manager.ui.mainCamera.transform.position - var_212_7.position).y, (manager.ui.mainCamera.transform.position - var_212_7.position).z)
				var_212_7.localEulerAngles.z = 0
				var_212_7.localEulerAngles.x = 0
				var_212_7.localEulerAngles = var_212_7.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_212_9 = 0
			local var_212_10 = 0.25

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_11 = arg_209_1:GetWordFromCfg(103903052)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_14 = 10 <= 0 and var_212_10 or var_212_10 * (utf8.len(var_212_12) / 10)

				if (10 <= 0 and var_212_10 or var_212_10 * (utf8.len(var_212_12) / 10)) > 0 and var_212_10 < var_212_14 then
					arg_209_1.talkMaxDuration = var_212_14

					if var_212_14 + var_212_9 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_9
					end
				end

				arg_209_1.text_.text = var_212_12
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb") ~= 0 then
					local var_212_15 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb") / 1000

					if var_212_15 + var_212_9 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_9
					end

					if var_212_11.prefab_name ~= "" and arg_209_1.actors_[var_212_11.prefab_name] ~= nil then
						local var_212_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_11.prefab_name].transform, "story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")

						arg_209_1:RecordAudio("103903052", var_212_16)
						arg_209_1:RecordAudio("103903052", var_212_16)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_17 = math.max(var_212_10, arg_209_1.talkMaxDuration)

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_17 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_9) / var_212_17

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_9 + var_212_17 and arg_209_1.time_ < var_212_9 + var_212_17 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST02",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play103903053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 103903053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play103903054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1039ui_story"]) and arg_213_1.var_.characterEffect1039ui_story == nil then
				arg_213_1.var_.characterEffect1039ui_story = arg_213_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.1

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1039ui_story"]) then
				if arg_213_1.var_.characterEffect1039ui_story and not isNil(arg_213_1.actors_["1039ui_story"]) then
					arg_213_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1039ui_story"]) and arg_213_1.var_.characterEffect1039ui_story then
				arg_213_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.6

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(103903053).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 24 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 24)

				if (24 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 24)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play103903054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 103903054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play103903055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_run", "")
			end

			local var_220_1 = 0
			local var_220_2 = 0.7

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(103903054).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 28 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 28)

				if (28 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 28)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play103903055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 103903055
		arg_221_1.duration_ = 3.7

		local var_221_0 = {
			ja = 3.7,
			ko = 3.666,
			zh = 3.666,
			en = 2.033
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play103903056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1027ui_story"]) and arg_221_1.var_.characterEffect1027ui_story == nil then
				arg_221_1.var_.characterEffect1027ui_story = arg_221_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.1

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1027ui_story"]) then
				if arg_221_1.var_.characterEffect1027ui_story and not isNil(arg_221_1.actors_["1027ui_story"]) then
					arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1027ui_story"]) and arg_221_1.var_.characterEffect1027ui_story then
				arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_224_2 = arg_221_1.actors_["1039ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1039ui_story = var_224_2.localPosition
			end

			local var_224_3 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 then
				var_224_2.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_221_1.time_ - 0) / var_224_3)
				var_224_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_2.position).x, (manager.ui.mainCamera.transform.position - var_224_2.position).y, (manager.ui.mainCamera.transform.position - var_224_2.position).z)
				var_224_2.localEulerAngles.z = 0
				var_224_2.localEulerAngles.x = 0
				var_224_2.localEulerAngles = var_224_2.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 then
				var_224_2.localPosition = Vector3.New(10, -1.06, -5.3)
				var_224_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_2.position).x, (manager.ui.mainCamera.transform.position - var_224_2.position).y, (manager.ui.mainCamera.transform.position - var_224_2.position).z)
				var_224_2.localEulerAngles.z = 0
				var_224_2.localEulerAngles.x = 0
				var_224_2.localEulerAngles = var_224_2.localEulerAngles
			end

			local var_224_4 = arg_221_1.actors_["1027ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1027ui_story = var_224_4.localPosition
			end

			local var_224_5 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_5 then
				var_224_4.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_221_1.time_ - 0) / var_224_5)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_5 and arg_221_1.time_ < 0 + var_224_5 + arg_224_0 then
				var_224_4.localPosition = Vector3.New(0, -0.922, -5.1)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_224_6 = 0
			local var_224_7 = 0.175

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(103903055)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 7 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 7)

				if (7 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 7)) > 0 and var_224_7 < var_224_11 then
					arg_221_1.talkMaxDuration = var_224_11

					if var_224_11 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb") ~= 0 then
					local var_224_12 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb") / 1000

					if var_224_12 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_6
					end

					if var_224_8.prefab_name ~= "" and arg_221_1.actors_[var_224_8.prefab_name] ~= nil then
						local var_224_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_8.prefab_name].transform, "story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")

						arg_221_1:RecordAudio("103903055", var_224_13)
						arg_221_1:RecordAudio("103903055", var_224_13)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_14 and arg_221_1.time_ < var_224_6 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play103903056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 103903056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play103903057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.325

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(103903056).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 13 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 13)

				if (13 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 13)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play103903057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 103903057
		arg_229_1.duration_ = 7.63

		local var_229_0 = {
			ja = 7.633,
			ko = 4.366,
			zh = 4.366,
			en = 3.166
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play103903058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action426")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_232_0 = 0
			local var_232_1 = 0.3

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(103903057)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 12 <= 0 and var_232_1 or var_232_1 * (utf8.len(var_232_3) / 12)

				if (12 <= 0 and var_232_1 or var_232_1 * (utf8.len(var_232_3) / 12)) > 0 and var_232_1 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb") ~= 0 then
					local var_232_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb") / 1000

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end

					if var_232_2.prefab_name ~= "" and arg_229_1.actors_[var_232_2.prefab_name] ~= nil then
						local var_232_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_2.prefab_name].transform, "story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")

						arg_229_1:RecordAudio("103903057", var_232_7)
						arg_229_1:RecordAudio("103903057", var_232_7)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play103903058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 103903058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play103903059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1027ui_story"]) and arg_233_1.var_.characterEffect1027ui_story == nil then
				arg_233_1.var_.characterEffect1027ui_story = arg_233_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.1

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1027ui_story"]) then
				if arg_233_1.var_.characterEffect1027ui_story and not isNil(arg_233_1.actors_["1027ui_story"]) then
					arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1027ui_story"]) and arg_233_1.var_.characterEffect1027ui_story then
				arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.575

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(103903058).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 23 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 23)

				if (23 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 23)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play103903059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 103903059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play103903060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.7

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(103903059).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 28 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 28)

				if (28 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 28)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play103903060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 103903060
		arg_241_1.duration_ = 5.7

		local var_241_0 = {
			ja = 5.7,
			ko = 5.233,
			zh = 5.233,
			en = 4.266
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play103903061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:AudioAction("play", "music", "ui_battle", "ui_battle_pausebgm", "")

				local var_244_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_pausebgm")

				if "" ~= "" then
					if arg_241_1.bgmTxt_.text ~= var_244_2 and arg_241_1.bgmTxt_.text ~= "" then
						if arg_241_1.bgmTxt2_.text ~= "" then
							arg_241_1.bgmTxt_.text = arg_241_1.bgmTxt2_.text
						end

						arg_241_1.bgmTxt2_.text = var_244_2

						arg_241_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_241_1.bgmTxt_.text = var_244_2
						arg_241_1.bgmTxt2_.text = var_244_2
					end

					if arg_241_1.bgmTimer then
						arg_241_1.bgmTimer:Stop()

						arg_241_1.bgmTimer = nil
					end

					if arg_241_1.settingData.show_music_name == 1 then
						arg_241_1.musicController:SetSelectedState("show")
						arg_241_1.musicAnimator_:Play("open", 0, 0)

						if arg_241_1.settingData.music_time ~= 0 then
							arg_241_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_241_1.settingData.music_time), function()
								if arg_241_1 == nil or isNil(arg_241_1.bgmTxt_) then
									return
								end

								arg_241_1.musicController:SetSelectedState("hide")
								arg_241_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_244_3 = arg_241_1.actors_["1027ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1027ui_story == nil then
				arg_241_1.var_.characterEffect1027ui_story = var_244_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_4 = 0.1

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 and not isNil(var_244_3) then
				if arg_241_1.var_.characterEffect1027ui_story and not isNil(var_244_3) then
					arg_241_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1027ui_story then
				arg_241_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action463")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_244_6 = 0
			local var_244_7 = 0.175

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_8 = arg_241_1:GetWordFromCfg(103903060)
				local var_244_9 = arg_241_1:FormatText(var_244_8.content)

				arg_241_1.text_.text = var_244_9

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 7 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_9) / 7)

				if (7 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_9) / 7)) > 0 and var_244_7 < var_244_11 then
					arg_241_1.talkMaxDuration = var_244_11

					if var_244_11 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_9
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb") ~= 0 then
					local var_244_12 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb") / 1000

					if var_244_12 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_6
					end

					if var_244_8.prefab_name ~= "" and arg_241_1.actors_[var_244_8.prefab_name] ~= nil then
						local var_244_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_8.prefab_name].transform, "story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")

						arg_241_1:RecordAudio("103903060", var_244_13)
						arg_241_1:RecordAudio("103903060", var_244_13)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play103903061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 103903061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play103903062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.425

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(103903061).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 17 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 17)

				if (17 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 17)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play103903062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 103903062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play103903063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1027ui_story"]) and arg_250_1.var_.characterEffect1027ui_story == nil then
				arg_250_1.var_.characterEffect1027ui_story = arg_250_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.1

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1027ui_story"]) then
				if arg_250_1.var_.characterEffect1027ui_story and not isNil(arg_250_1.actors_["1027ui_story"]) then
					arg_250_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1027ui_story"]) and arg_250_1.var_.characterEffect1027ui_story then
				arg_250_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_253_1 = 0
			local var_253_2 = 0.225

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(103903062).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 9 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 9)

				if (9 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 9)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play103903063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 103903063
		arg_254_1.duration_ = 8

		local var_254_0 = {
			ja = 1.8,
			ko = 3.6,
			zh = 3.6,
			en = 8
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
				arg_254_0:Play103903064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1027ui_story"]) and arg_254_1.var_.characterEffect1027ui_story == nil then
				arg_254_1.var_.characterEffect1027ui_story = arg_254_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.1

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1027ui_story"]) then
				if arg_254_1.var_.characterEffect1027ui_story and not isNil(arg_254_1.actors_["1027ui_story"]) then
					arg_254_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1027ui_story"]) and arg_254_1.var_.characterEffect1027ui_story then
				arg_254_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_257_2 = 0
			local var_257_3 = 0.1

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_4 = arg_254_1:GetWordFromCfg(103903063)
				local var_257_5 = arg_254_1:FormatText(var_257_4.content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 4 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 4)

				if (4 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 4)) > 0 and var_257_3 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb") / 1000

					if var_257_8 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_2
					end

					if var_257_4.prefab_name ~= "" and arg_254_1.actors_[var_257_4.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_4.prefab_name].transform, "story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")

						arg_254_1:RecordAudio("103903063", var_257_9)
						arg_254_1:RecordAudio("103903063", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_10 and arg_254_1.time_ < var_257_2 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play103903064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 103903064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play103903065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1027ui_story"]) and arg_258_1.var_.characterEffect1027ui_story == nil then
				arg_258_1.var_.characterEffect1027ui_story = arg_258_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.1

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1027ui_story"]) then
				if arg_258_1.var_.characterEffect1027ui_story and not isNil(arg_258_1.actors_["1027ui_story"]) then
					arg_258_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1027ui_story"]) and arg_258_1.var_.characterEffect1027ui_story then
				arg_258_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_261_1 = 0
			local var_261_2 = 0.25

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

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(103903064).content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 10 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 10)

				if (10 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 10)) > 0 and var_261_2 < var_261_5 then
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
	Play103903065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 103903065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play103903066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.975

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(103903065).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 39 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 39)

				if (39 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 39)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play103903066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 103903066
		arg_266_1.duration_ = 3.1

		local var_266_0 = {
			ja = 2.666,
			ko = 2.533,
			zh = 2.533,
			en = 3.1
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
				arg_266_0:Play103903067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1039ui_story"]) and arg_266_1.var_.characterEffect1039ui_story == nil then
				arg_266_1.var_.characterEffect1039ui_story = arg_266_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.1

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1039ui_story"]) then
				if arg_266_1.var_.characterEffect1039ui_story and not isNil(arg_266_1.actors_["1039ui_story"]) then
					arg_266_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1039ui_story"]) and arg_266_1.var_.characterEffect1039ui_story then
				arg_266_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_269_2 = arg_266_1.actors_["1027ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1027ui_story = var_269_2.localPosition
			end

			local var_269_3 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 then
				var_269_2.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_266_1.time_ - 0) / var_269_3)
				var_269_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_2.position).x, (manager.ui.mainCamera.transform.position - var_269_2.position).y, (manager.ui.mainCamera.transform.position - var_269_2.position).z)
				var_269_2.localEulerAngles.z = 0
				var_269_2.localEulerAngles.x = 0
				var_269_2.localEulerAngles = var_269_2.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 then
				var_269_2.localPosition = Vector3.New(10, -0.922, -5.1)
				var_269_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_2.position).x, (manager.ui.mainCamera.transform.position - var_269_2.position).y, (manager.ui.mainCamera.transform.position - var_269_2.position).z)
				var_269_2.localEulerAngles.z = 0
				var_269_2.localEulerAngles.x = 0
				var_269_2.localEulerAngles = var_269_2.localEulerAngles
			end

			local var_269_4 = arg_266_1.actors_["1039ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1039ui_story = var_269_4.localPosition
			end

			local var_269_5 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_5 then
				var_269_4.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_266_1.time_ - 0) / var_269_5)
				var_269_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_4.position).x, (manager.ui.mainCamera.transform.position - var_269_4.position).y, (manager.ui.mainCamera.transform.position - var_269_4.position).z)
				var_269_4.localEulerAngles.z = 0
				var_269_4.localEulerAngles.x = 0
				var_269_4.localEulerAngles = var_269_4.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_5 and arg_266_1.time_ < 0 + var_269_5 + arg_269_0 then
				var_269_4.localPosition = Vector3.New(0, -1.06, -5.3)
				var_269_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_4.position).x, (manager.ui.mainCamera.transform.position - var_269_4.position).y, (manager.ui.mainCamera.transform.position - var_269_4.position).z)
				var_269_4.localEulerAngles.z = 0
				var_269_4.localEulerAngles.x = 0
				var_269_4.localEulerAngles = var_269_4.localEulerAngles
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_269_6 = 0
			local var_269_7 = 0.2

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_8 = arg_266_1:GetWordFromCfg(103903066)
				local var_269_9 = arg_266_1:FormatText(var_269_8.content)

				arg_266_1.text_.text = var_269_9

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 8 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_9) / 8)

				if (8 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_9) / 8)) > 0 and var_269_7 < var_269_11 then
					arg_266_1.talkMaxDuration = var_269_11

					if var_269_11 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_11 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_9
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb") ~= 0 then
					local var_269_12 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb") / 1000

					if var_269_12 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_12 + var_269_6
					end

					if var_269_8.prefab_name ~= "" and arg_266_1.actors_[var_269_8.prefab_name] ~= nil then
						local var_269_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_8.prefab_name].transform, "story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")

						arg_266_1:RecordAudio("103903066", var_269_13)
						arg_266_1:RecordAudio("103903066", var_269_13)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_14 and arg_266_1.time_ < var_269_6 + var_269_14 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play103903067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 103903067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play103903068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.35

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(103903067).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 14 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 14)

				if (14 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 14)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play103903068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 103903068
		arg_274_1.duration_ = 6.2

		local var_274_0 = {
			ja = 4.933,
			ko = 6.2,
			zh = 6.2,
			en = 5.966
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play103903069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_277_0 = 0
			local var_277_1 = 0.775

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(103903068)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 31 <= 0 and var_277_1 or var_277_1 * (utf8.len(var_277_3) / 31)

				if (31 <= 0 and var_277_1 or var_277_1 * (utf8.len(var_277_3) / 31)) > 0 and var_277_1 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb") ~= 0 then
					local var_277_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb") / 1000

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end

					if var_277_2.prefab_name ~= "" and arg_274_1.actors_[var_277_2.prefab_name] ~= nil then
						local var_277_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_2.prefab_name].transform, "story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")

						arg_274_1:RecordAudio("103903068", var_277_7)
						arg_274_1:RecordAudio("103903068", var_277_7)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play103903069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 103903069
		arg_278_1.duration_ = 6.27

		local var_278_0 = {
			ja = 6.266,
			ko = 4.7,
			zh = 4.7,
			en = 5.766
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
				arg_278_0:Play103903070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1027ui_story"]) and arg_278_1.var_.characterEffect1027ui_story == nil then
				arg_278_1.var_.characterEffect1027ui_story = arg_278_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.1

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1027ui_story"]) then
				if arg_278_1.var_.characterEffect1027ui_story and not isNil(arg_278_1.actors_["1027ui_story"]) then
					arg_278_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1027ui_story"]) and arg_278_1.var_.characterEffect1027ui_story then
				arg_278_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_281_2 = arg_278_1.actors_["1039ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.characterEffect1039ui_story == nil then
				arg_278_1.var_.characterEffect1039ui_story = var_281_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_3 = 0.1

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 and not isNil(var_281_2) then
				if arg_278_1.var_.characterEffect1039ui_story and not isNil(var_281_2) then
					arg_278_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_3)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.characterEffect1039ui_story then
				arg_278_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_281_4 = arg_278_1.actors_["1039ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1039ui_story = var_281_4.localPosition
			end

			local var_281_5 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_5 then
				var_281_4.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_278_1.time_ - 0) / var_281_5)
				var_281_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_4.position).x, (manager.ui.mainCamera.transform.position - var_281_4.position).y, (manager.ui.mainCamera.transform.position - var_281_4.position).z)
				var_281_4.localEulerAngles.z = 0
				var_281_4.localEulerAngles.x = 0
				var_281_4.localEulerAngles = var_281_4.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_5 and arg_278_1.time_ < 0 + var_281_5 + arg_281_0 then
				var_281_4.localPosition = Vector3.New(0, -1.06, -5.3)
				var_281_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_4.position).x, (manager.ui.mainCamera.transform.position - var_281_4.position).y, (manager.ui.mainCamera.transform.position - var_281_4.position).z)
				var_281_4.localEulerAngles.z = 0
				var_281_4.localEulerAngles.x = 0
				var_281_4.localEulerAngles = var_281_4.localEulerAngles
			end

			local var_281_6 = arg_278_1.actors_["1039ui_story"].transform

			if 0.033 < arg_278_1.time_ and arg_278_1.time_ <= 0.033 + arg_281_0 then
				arg_278_1.var_.moveOldPos1039ui_story = var_281_6.localPosition
			end

			local var_281_7 = 0.5

			if 0.033 <= arg_278_1.time_ and arg_278_1.time_ < 0.033 + var_281_7 then
				var_281_6.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1039ui_story, Vector3.New(-0.85, -1.06, -5.3), (arg_278_1.time_ - 0.033) / var_281_7)
				var_281_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_6.position).x, (manager.ui.mainCamera.transform.position - var_281_6.position).y, (manager.ui.mainCamera.transform.position - var_281_6.position).z)
				var_281_6.localEulerAngles.z = 0
				var_281_6.localEulerAngles.x = 0
				var_281_6.localEulerAngles = var_281_6.localEulerAngles
			end

			if arg_278_1.time_ >= 0.033 + var_281_7 and arg_278_1.time_ < 0.033 + var_281_7 + arg_281_0 then
				var_281_6.localPosition = Vector3.New(-0.85, -1.06, -5.3)
				var_281_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_6.position).x, (manager.ui.mainCamera.transform.position - var_281_6.position).y, (manager.ui.mainCamera.transform.position - var_281_6.position).z)
				var_281_6.localEulerAngles.z = 0
				var_281_6.localEulerAngles.x = 0
				var_281_6.localEulerAngles = var_281_6.localEulerAngles
			end

			local var_281_8 = arg_278_1.actors_["1027ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1027ui_story = var_281_8.localPosition
			end

			local var_281_9 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_9 then
				var_281_8.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1027ui_story, Vector3.New(0.92, -0.922, -5.1), (arg_278_1.time_ - 0) / var_281_9)
				var_281_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_8.position).x, (manager.ui.mainCamera.transform.position - var_281_8.position).y, (manager.ui.mainCamera.transform.position - var_281_8.position).z)
				var_281_8.localEulerAngles.z = 0
				var_281_8.localEulerAngles.x = 0
				var_281_8.localEulerAngles = var_281_8.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_9 and arg_278_1.time_ < 0 + var_281_9 + arg_281_0 then
				var_281_8.localPosition = Vector3.New(0.92, -0.922, -5.1)
				var_281_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_8.position).x, (manager.ui.mainCamera.transform.position - var_281_8.position).y, (manager.ui.mainCamera.transform.position - var_281_8.position).z)
				var_281_8.localEulerAngles.z = 0
				var_281_8.localEulerAngles.x = 0
				var_281_8.localEulerAngles = var_281_8.localEulerAngles
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_281_10 = 0
			local var_281_11 = 0.25

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_10 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_12 = arg_278_1:GetWordFromCfg(103903069)
				local var_281_13 = arg_278_1:FormatText(var_281_12.content)

				arg_278_1.text_.text = var_281_13

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_15 = 10 <= 0 and var_281_11 or var_281_11 * (utf8.len(var_281_13) / 10)

				if (10 <= 0 and var_281_11 or var_281_11 * (utf8.len(var_281_13) / 10)) > 0 and var_281_11 < var_281_15 then
					arg_278_1.talkMaxDuration = var_281_15

					if var_281_15 + var_281_10 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_15 + var_281_10
					end
				end

				arg_278_1.text_.text = var_281_13
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb") ~= 0 then
					local var_281_16 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb") / 1000

					if var_281_16 + var_281_10 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_16 + var_281_10
					end

					if var_281_12.prefab_name ~= "" and arg_278_1.actors_[var_281_12.prefab_name] ~= nil then
						local var_281_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_12.prefab_name].transform, "story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")

						arg_278_1:RecordAudio("103903069", var_281_17)
						arg_278_1:RecordAudio("103903069", var_281_17)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_18 = math.max(var_281_11, arg_278_1.talkMaxDuration)

			if var_281_10 <= arg_278_1.time_ and arg_278_1.time_ < var_281_10 + var_281_18 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_10) / var_281_18

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_10 + var_281_18 and arg_278_1.time_ < var_281_10 + var_281_18 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play103903070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 103903070
		arg_282_1.duration_ = 7.9

		local var_282_0 = {
			ja = 6.066,
			ko = 7.9,
			zh = 7.9,
			en = 4.9
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play103903071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1039ui_story"]) and arg_282_1.var_.characterEffect1039ui_story == nil then
				arg_282_1.var_.characterEffect1039ui_story = arg_282_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.1

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1039ui_story"]) then
				if arg_282_1.var_.characterEffect1039ui_story and not isNil(arg_282_1.actors_["1039ui_story"]) then
					arg_282_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1039ui_story"]) and arg_282_1.var_.characterEffect1039ui_story then
				arg_282_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_285_2 = arg_282_1.actors_["1027ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.characterEffect1027ui_story == nil then
				arg_282_1.var_.characterEffect1027ui_story = var_285_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_3 = 0.1

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 and not isNil(var_285_2) then
				if arg_282_1.var_.characterEffect1027ui_story and not isNil(var_285_2) then
					arg_282_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_3)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.characterEffect1027ui_story then
				arg_282_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_285_4 = 0
			local var_285_5 = 0.75

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_6 = arg_282_1:GetWordFromCfg(103903070)
				local var_285_7 = arg_282_1:FormatText(var_285_6.content)

				arg_282_1.text_.text = var_285_7

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 30 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 30)

				if (30 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 30)) > 0 and var_285_5 < var_285_9 then
					arg_282_1.talkMaxDuration = var_285_9

					if var_285_9 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_9 + var_285_4
					end
				end

				arg_282_1.text_.text = var_285_7
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb") ~= 0 then
					local var_285_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb") / 1000

					if var_285_10 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_4
					end

					if var_285_6.prefab_name ~= "" and arg_282_1.actors_[var_285_6.prefab_name] ~= nil then
						local var_285_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_6.prefab_name].transform, "story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")

						arg_282_1:RecordAudio("103903070", var_285_11)
						arg_282_1:RecordAudio("103903070", var_285_11)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_12 = math.max(var_285_5, arg_282_1.talkMaxDuration)

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_12 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_4) / var_285_12

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_4 + var_285_12 and arg_282_1.time_ < var_285_4 + var_285_12 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play103903071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 103903071
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play103903072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1039ui_story"]) and arg_286_1.var_.characterEffect1039ui_story == nil then
				arg_286_1.var_.characterEffect1039ui_story = arg_286_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.1

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1039ui_story"]) then
				if arg_286_1.var_.characterEffect1039ui_story and not isNil(arg_286_1.actors_["1039ui_story"]) then
					arg_286_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_0)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1039ui_story"]) and arg_286_1.var_.characterEffect1039ui_story then
				arg_286_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_289_1 = 0
			local var_289_2 = 0.5

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(103903071).content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 20 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 20)

				if (20 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 20)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_6 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_6 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_6

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_6 and arg_286_1.time_ < var_289_1 + var_289_6 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play103903072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 103903072
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play103903073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.225

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(103903072).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 9 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 9)

				if (9 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 9)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play103903073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 103903073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play103903074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPosST03 = arg_294_1.bgs_.ST03.transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.bgs_.ST03.transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPosST03, Vector3.New(0, -100, 10), (arg_294_1.time_ - 0) / var_297_0)
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.bgs_.ST03.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_297_1 = "D04a"

			if arg_294_1.bgs_.D04a == nil then
				local var_297_2 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_297_1)
				var_297_2.name = var_297_1
				var_297_2.transform.parent = arg_294_1.stage_.transform
				var_297_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_[var_297_1] = var_297_2
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				local var_297_3 = arg_294_1.bgs_.D04a

				arg_294_1.bgs_.D04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_297_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_4 = var_297_3:GetComponent("SpriteRenderer")

				if var_297_4 and var_297_4.sprite then
					local var_297_5 = 2 * (var_297_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_297_3.transform.localScale = Vector3.New(var_297_5 / var_297_4.sprite.bounds.size.y < var_297_5 * manager.ui.mainCameraCom_.aspect / var_297_4.sprite.bounds.size.x and var_297_5 * manager.ui.mainCameraCom_.aspect / var_297_4.sprite.bounds.size.x or var_297_5 / var_297_4.sprite.bounds.size.y, var_297_5 / var_297_4.sprite.bounds.size.y < var_297_5 * manager.ui.mainCameraCom_.aspect / var_297_4.sprite.bounds.size.x and var_297_5 * manager.ui.mainCameraCom_.aspect / var_297_4.sprite.bounds.size.x or var_297_5 / var_297_4.sprite.bounds.size.y, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "D04a" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_6 = arg_294_1.actors_["1039ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1039ui_story = var_297_6.localPosition
			end

			local var_297_7 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				var_297_6.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_294_1.time_ - 0) / var_297_7)
				var_297_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_6.position).x, (manager.ui.mainCamera.transform.position - var_297_6.position).y, (manager.ui.mainCamera.transform.position - var_297_6.position).z)
				var_297_6.localEulerAngles.z = 0
				var_297_6.localEulerAngles.x = 0
				var_297_6.localEulerAngles = var_297_6.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				var_297_6.localPosition = Vector3.New(10, -1.06, -5.3)
				var_297_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_6.position).x, (manager.ui.mainCamera.transform.position - var_297_6.position).y, (manager.ui.mainCamera.transform.position - var_297_6.position).z)
				var_297_6.localEulerAngles.z = 0
				var_297_6.localEulerAngles.x = 0
				var_297_6.localEulerAngles = var_297_6.localEulerAngles
			end

			local var_297_8 = arg_294_1.actors_["1027ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1027ui_story = var_297_8.localPosition
			end

			local var_297_9 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_9 then
				var_297_8.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_294_1.time_ - 0) / var_297_9)
				var_297_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_8.position).x, (manager.ui.mainCamera.transform.position - var_297_8.position).y, (manager.ui.mainCamera.transform.position - var_297_8.position).z)
				var_297_8.localEulerAngles.z = 0
				var_297_8.localEulerAngles.x = 0
				var_297_8.localEulerAngles = var_297_8.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_9 and arg_294_1.time_ < 0 + var_297_9 + arg_297_0 then
				var_297_8.localPosition = Vector3.New(10, -0.922, -5.1)
				var_297_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_8.position).x, (manager.ui.mainCamera.transform.position - var_297_8.position).y, (manager.ui.mainCamera.transform.position - var_297_8.position).z)
				var_297_8.localEulerAngles.z = 0
				var_297_8.localEulerAngles.x = 0
				var_297_8.localEulerAngles = var_297_8.localEulerAngles
			end

			local var_297_10 = 0
			local var_297_11 = 0.825

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_12 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(103903073).content)

				arg_294_1.text_.text = var_297_12

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_14 = 33 <= 0 and var_297_11 or var_297_11 * (utf8.len(var_297_12) / 33)

				if (33 <= 0 and var_297_11 or var_297_11 * (utf8.len(var_297_12) / 33)) > 0 and var_297_11 < var_297_14 then
					arg_294_1.talkMaxDuration = var_297_14

					if var_297_14 + var_297_10 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_14 + var_297_10
					end
				end

				arg_294_1.text_.text = var_297_12
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_15 = math.max(var_297_11, arg_294_1.talkMaxDuration)

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_15 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_10) / var_297_15

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_10 + var_297_15 and arg_294_1.time_ < var_297_10 + var_297_15 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play103903074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 103903074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play103903075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.325

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

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(103903074).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 13 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 13)

				if (13 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 13)) > 0 and var_301_0 < var_301_3 then
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
	Play103903075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 103903075
		arg_302_1.duration_ = 6.33

		local var_302_0 = {
			ja = 6.233,
			ko = 4.9,
			zh = 4.9,
			en = 6.333
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
				arg_302_0:Play103903076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1027ui_story"]) and arg_302_1.var_.characterEffect1027ui_story == nil then
				arg_302_1.var_.characterEffect1027ui_story = arg_302_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_0 = 0.1

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1027ui_story"]) then
				if arg_302_1.var_.characterEffect1027ui_story and not isNil(arg_302_1.actors_["1027ui_story"]) then
					arg_302_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1027ui_story"]) and arg_302_1.var_.characterEffect1027ui_story then
				arg_302_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_305_2 = arg_302_1.actors_["1027ui_story"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1027ui_story = var_305_2.localPosition
			end

			local var_305_3 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_3 then
				var_305_2.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_302_1.time_ - 0) / var_305_3)
				var_305_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_2.position).x, (manager.ui.mainCamera.transform.position - var_305_2.position).y, (manager.ui.mainCamera.transform.position - var_305_2.position).z)
				var_305_2.localEulerAngles.z = 0
				var_305_2.localEulerAngles.x = 0
				var_305_2.localEulerAngles = var_305_2.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_3 and arg_302_1.time_ < 0 + var_305_3 + arg_305_0 then
				var_305_2.localPosition = Vector3.New(0, -0.922, -5.1)
				var_305_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_2.position).x, (manager.ui.mainCamera.transform.position - var_305_2.position).y, (manager.ui.mainCamera.transform.position - var_305_2.position).z)
				var_305_2.localEulerAngles.z = 0
				var_305_2.localEulerAngles.x = 0
				var_305_2.localEulerAngles = var_305_2.localEulerAngles
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_305_4 = 0
			local var_305_5 = 0.475

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(103903075)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 19 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 19)

				if (19 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 19)) > 0 and var_305_5 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb") / 1000

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end

					if var_305_6.prefab_name ~= "" and arg_302_1.actors_[var_305_6.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_6.prefab_name].transform, "story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")

						arg_302_1:RecordAudio("103903075", var_305_11)
						arg_302_1:RecordAudio("103903075", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play103903076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 103903076
		arg_306_1.duration_ = 10.27

		local var_306_0 = {
			ja = 10.266,
			ko = 6.666,
			zh = 6.666,
			en = 7.5
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
				arg_306_0:Play103903077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_309_0 = 0
			local var_309_1 = 0.7

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_2 = arg_306_1:GetWordFromCfg(103903076)
				local var_309_3 = arg_306_1:FormatText(var_309_2.content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 28 <= 0 and var_309_1 or var_309_1 * (utf8.len(var_309_3) / 28)

				if (28 <= 0 and var_309_1 or var_309_1 * (utf8.len(var_309_3) / 28)) > 0 and var_309_1 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb") ~= 0 then
					local var_309_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb") / 1000

					if var_309_6 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_0
					end

					if var_309_2.prefab_name ~= "" and arg_306_1.actors_[var_309_2.prefab_name] ~= nil then
						local var_309_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_2.prefab_name].transform, "story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")

						arg_306_1:RecordAudio("103903076", var_309_7)
						arg_306_1:RecordAudio("103903076", var_309_7)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_8 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_8 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_8

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_8 and arg_306_1.time_ < var_309_0 + var_309_8 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play103903077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 103903077
		arg_310_1.duration_ = 7.87

		local var_310_0 = {
			ja = 7.866,
			ko = 6.6,
			zh = 6.6,
			en = 5.633
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
				arg_310_0:Play103903078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_313_0 = 0
			local var_313_1 = 0.525

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_2 = arg_310_1:GetWordFromCfg(103903077)
				local var_313_3 = arg_310_1:FormatText(var_313_2.content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 21 <= 0 and var_313_1 or var_313_1 * (utf8.len(var_313_3) / 21)

				if (21 <= 0 and var_313_1 or var_313_1 * (utf8.len(var_313_3) / 21)) > 0 and var_313_1 < var_313_5 then
					arg_310_1.talkMaxDuration = var_313_5

					if var_313_5 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb") ~= 0 then
					local var_313_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb") / 1000

					if var_313_6 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_0
					end

					if var_313_2.prefab_name ~= "" and arg_310_1.actors_[var_313_2.prefab_name] ~= nil then
						local var_313_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_2.prefab_name].transform, "story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")

						arg_310_1:RecordAudio("103903077", var_313_7)
						arg_310_1:RecordAudio("103903077", var_313_7)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")
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
	Play103903078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 103903078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play103903079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.5

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

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(103903078).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 20 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 20)

				if (20 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 20)) > 0 and var_317_0 < var_317_3 then
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
	Play103903079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 103903079
		arg_318_1.duration_ = 6.83

		local var_318_0 = {
			ja = 6.833,
			ko = 5.2,
			zh = 5.2,
			en = 6.1
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play103903080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1039ui_story"]) and arg_318_1.var_.characterEffect1039ui_story == nil then
				arg_318_1.var_.characterEffect1039ui_story = arg_318_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.1

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1039ui_story"]) then
				if arg_318_1.var_.characterEffect1039ui_story and not isNil(arg_318_1.actors_["1039ui_story"]) then
					arg_318_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1039ui_story"]) and arg_318_1.var_.characterEffect1039ui_story then
				arg_318_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_321_2 = arg_318_1.actors_["1027ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1027ui_story == nil then
				arg_318_1.var_.characterEffect1027ui_story = var_321_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_3 = 0.1

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.characterEffect1027ui_story and not isNil(var_321_2) then
					arg_318_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_3)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1027ui_story then
				arg_318_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_321_4 = arg_318_1.actors_["1027ui_story"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1027ui_story = var_321_4.localPosition
			end

			local var_321_5 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_5 then
				var_321_4.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_318_1.time_ - 0) / var_321_5)
				var_321_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_4.position).x, (manager.ui.mainCamera.transform.position - var_321_4.position).y, (manager.ui.mainCamera.transform.position - var_321_4.position).z)
				var_321_4.localEulerAngles.z = 0
				var_321_4.localEulerAngles.x = 0
				var_321_4.localEulerAngles = var_321_4.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_5 and arg_318_1.time_ < 0 + var_321_5 + arg_321_0 then
				var_321_4.localPosition = Vector3.New(0, -0.922, -5.1)
				var_321_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_4.position).x, (manager.ui.mainCamera.transform.position - var_321_4.position).y, (manager.ui.mainCamera.transform.position - var_321_4.position).z)
				var_321_4.localEulerAngles.z = 0
				var_321_4.localEulerAngles.x = 0
				var_321_4.localEulerAngles = var_321_4.localEulerAngles
			end

			local var_321_6 = arg_318_1.actors_["1027ui_story"].transform

			if 0.033 < arg_318_1.time_ and arg_318_1.time_ <= 0.033 + arg_321_0 then
				arg_318_1.var_.moveOldPos1027ui_story = var_321_6.localPosition
			end

			local var_321_7 = 0.5

			if 0.033 <= arg_318_1.time_ and arg_318_1.time_ < 0.033 + var_321_7 then
				var_321_6.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (arg_318_1.time_ - 0.033) / var_321_7)
				var_321_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_6.position).x, (manager.ui.mainCamera.transform.position - var_321_6.position).y, (manager.ui.mainCamera.transform.position - var_321_6.position).z)
				var_321_6.localEulerAngles.z = 0
				var_321_6.localEulerAngles.x = 0
				var_321_6.localEulerAngles = var_321_6.localEulerAngles
			end

			if arg_318_1.time_ >= 0.033 + var_321_7 and arg_318_1.time_ < 0.033 + var_321_7 + arg_321_0 then
				var_321_6.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				var_321_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_6.position).x, (manager.ui.mainCamera.transform.position - var_321_6.position).y, (manager.ui.mainCamera.transform.position - var_321_6.position).z)
				var_321_6.localEulerAngles.z = 0
				var_321_6.localEulerAngles.x = 0
				var_321_6.localEulerAngles = var_321_6.localEulerAngles
			end

			local var_321_8 = arg_318_1.actors_["1039ui_story"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1039ui_story = var_321_8.localPosition
			end

			local var_321_9 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_9 then
				var_321_8.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1039ui_story, Vector3.New(0.85, -1.06, -5.3), (arg_318_1.time_ - 0) / var_321_9)
				var_321_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_8.position).x, (manager.ui.mainCamera.transform.position - var_321_8.position).y, (manager.ui.mainCamera.transform.position - var_321_8.position).z)
				var_321_8.localEulerAngles.z = 0
				var_321_8.localEulerAngles.x = 0
				var_321_8.localEulerAngles = var_321_8.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_9 and arg_318_1.time_ < 0 + var_321_9 + arg_321_0 then
				var_321_8.localPosition = Vector3.New(0.85, -1.06, -5.3)
				var_321_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_8.position).x, (manager.ui.mainCamera.transform.position - var_321_8.position).y, (manager.ui.mainCamera.transform.position - var_321_8.position).z)
				var_321_8.localEulerAngles.z = 0
				var_321_8.localEulerAngles.x = 0
				var_321_8.localEulerAngles = var_321_8.localEulerAngles
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_321_10 = 0
			local var_321_11 = 0.55

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_12 = arg_318_1:GetWordFromCfg(103903079)
				local var_321_13 = arg_318_1:FormatText(var_321_12.content)

				arg_318_1.text_.text = var_321_13

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_15 = 22 <= 0 and var_321_11 or var_321_11 * (utf8.len(var_321_13) / 22)

				if (22 <= 0 and var_321_11 or var_321_11 * (utf8.len(var_321_13) / 22)) > 0 and var_321_11 < var_321_15 then
					arg_318_1.talkMaxDuration = var_321_15

					if var_321_15 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_15 + var_321_10
					end
				end

				arg_318_1.text_.text = var_321_13
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb") ~= 0 then
					local var_321_16 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb") / 1000

					if var_321_16 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_16 + var_321_10
					end

					if var_321_12.prefab_name ~= "" and arg_318_1.actors_[var_321_12.prefab_name] ~= nil then
						local var_321_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_12.prefab_name].transform, "story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")

						arg_318_1:RecordAudio("103903079", var_321_17)
						arg_318_1:RecordAudio("103903079", var_321_17)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_18 = math.max(var_321_11, arg_318_1.talkMaxDuration)

			if var_321_10 <= arg_318_1.time_ and arg_318_1.time_ < var_321_10 + var_321_18 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_10) / var_321_18

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_10 + var_321_18 and arg_318_1.time_ < var_321_10 + var_321_18 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play103903080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 103903080
		arg_322_1.duration_ = 9

		local var_322_0 = {
			ja = 9,
			ko = 7.033,
			zh = 7.033,
			en = 6.833
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
				arg_322_0:Play103903081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1027ui_story"]) and arg_322_1.var_.characterEffect1027ui_story == nil then
				arg_322_1.var_.characterEffect1027ui_story = arg_322_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.1

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1027ui_story"]) then
				if arg_322_1.var_.characterEffect1027ui_story and not isNil(arg_322_1.actors_["1027ui_story"]) then
					arg_322_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1027ui_story"]) and arg_322_1.var_.characterEffect1027ui_story then
				arg_322_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_325_2 = arg_322_1.actors_["1039ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.characterEffect1039ui_story == nil then
				arg_322_1.var_.characterEffect1039ui_story = var_325_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_3 = 0.1

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_3 and not isNil(var_325_2) then
				if arg_322_1.var_.characterEffect1039ui_story and not isNil(var_325_2) then
					arg_322_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_3)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_3 and arg_322_1.time_ < 0 + var_325_3 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.characterEffect1039ui_story then
				arg_322_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action432")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_325_4 = 0
			local var_325_5 = 0.575

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_6 = arg_322_1:GetWordFromCfg(103903080)
				local var_325_7 = arg_322_1:FormatText(var_325_6.content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 23 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 23)

				if (23 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 23)) > 0 and var_325_5 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb") ~= 0 then
					local var_325_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb") / 1000

					if var_325_10 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_4
					end

					if var_325_6.prefab_name ~= "" and arg_322_1.actors_[var_325_6.prefab_name] ~= nil then
						local var_325_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_6.prefab_name].transform, "story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")

						arg_322_1:RecordAudio("103903080", var_325_11)
						arg_322_1:RecordAudio("103903080", var_325_11)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")
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

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play103903081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 103903081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play103903082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.525

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(103903081).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 21 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 21)

				if (21 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 21)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play103903082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 103903082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play103903083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1027ui_story"]) and arg_330_1.var_.characterEffect1027ui_story == nil then
				arg_330_1.var_.characterEffect1027ui_story = arg_330_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.1

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1027ui_story"]) then
				if arg_330_1.var_.characterEffect1027ui_story and not isNil(arg_330_1.actors_["1027ui_story"]) then
					arg_330_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1027ui_story"]) and arg_330_1.var_.characterEffect1027ui_story then
				arg_330_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.575

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

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(103903082).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 23 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 23)

				if (23 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 23)) > 0 and var_333_2 < var_333_5 then
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

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play103903083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 103903083
		arg_334_1.duration_ = 7.23

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play103903084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1039ui_story"]) and arg_334_1.var_.characterEffect1039ui_story == nil then
				arg_334_1.var_.characterEffect1039ui_story = arg_334_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.1

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1039ui_story"]) then
				if arg_334_1.var_.characterEffect1039ui_story and not isNil(arg_334_1.actors_["1039ui_story"]) then
					arg_334_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1039ui_story"]) and arg_334_1.var_.characterEffect1039ui_story then
				arg_334_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_337_2 = arg_334_1.actors_["1027ui_story"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1027ui_story = var_337_2.localPosition
			end

			local var_337_3 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_3 then
				var_337_2.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_334_1.time_ - 0) / var_337_3)
				var_337_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_2.position).x, (manager.ui.mainCamera.transform.position - var_337_2.position).y, (manager.ui.mainCamera.transform.position - var_337_2.position).z)
				var_337_2.localEulerAngles.z = 0
				var_337_2.localEulerAngles.x = 0
				var_337_2.localEulerAngles = var_337_2.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_3 and arg_334_1.time_ < 0 + var_337_3 + arg_337_0 then
				var_337_2.localPosition = Vector3.New(10, -0.922, -5.1)
				var_337_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_2.position).x, (manager.ui.mainCamera.transform.position - var_337_2.position).y, (manager.ui.mainCamera.transform.position - var_337_2.position).z)
				var_337_2.localEulerAngles.z = 0
				var_337_2.localEulerAngles.x = 0
				var_337_2.localEulerAngles = var_337_2.localEulerAngles
			end

			local var_337_4 = arg_334_1.actors_["1039ui_story"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1039ui_story = var_337_4.localPosition
			end

			local var_337_5 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_5 then
				var_337_4.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1039ui_story, Vector3.New(0.85, -1.06, -5.3), (arg_334_1.time_ - 0) / var_337_5)
				var_337_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_4.position).x, (manager.ui.mainCamera.transform.position - var_337_4.position).y, (manager.ui.mainCamera.transform.position - var_337_4.position).z)
				var_337_4.localEulerAngles.z = 0
				var_337_4.localEulerAngles.x = 0
				var_337_4.localEulerAngles = var_337_4.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_5 and arg_334_1.time_ < 0 + var_337_5 + arg_337_0 then
				var_337_4.localPosition = Vector3.New(0.85, -1.06, -5.3)
				var_337_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_4.position).x, (manager.ui.mainCamera.transform.position - var_337_4.position).y, (manager.ui.mainCamera.transform.position - var_337_4.position).z)
				var_337_4.localEulerAngles.z = 0
				var_337_4.localEulerAngles.x = 0
				var_337_4.localEulerAngles = var_337_4.localEulerAngles
			end

			local var_337_6 = arg_334_1.actors_["1039ui_story"].transform

			if 0.033 < arg_334_1.time_ and arg_334_1.time_ <= 0.033 + arg_337_0 then
				arg_334_1.var_.moveOldPos1039ui_story = var_337_6.localPosition
			end

			local var_337_7 = 0.5

			if 0.033 <= arg_334_1.time_ and arg_334_1.time_ < 0.033 + var_337_7 then
				var_337_6.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_334_1.time_ - 0.033) / var_337_7)
				var_337_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_6.position).x, (manager.ui.mainCamera.transform.position - var_337_6.position).y, (manager.ui.mainCamera.transform.position - var_337_6.position).z)
				var_337_6.localEulerAngles.z = 0
				var_337_6.localEulerAngles.x = 0
				var_337_6.localEulerAngles = var_337_6.localEulerAngles
			end

			if arg_334_1.time_ >= 0.033 + var_337_7 and arg_334_1.time_ < 0.033 + var_337_7 + arg_337_0 then
				var_337_6.localPosition = Vector3.New(0, -1.06, -5.3)
				var_337_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_6.position).x, (manager.ui.mainCamera.transform.position - var_337_6.position).y, (manager.ui.mainCamera.transform.position - var_337_6.position).z)
				var_337_6.localEulerAngles.z = 0
				var_337_6.localEulerAngles.x = 0
				var_337_6.localEulerAngles = var_337_6.localEulerAngles
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action426")
			end

			local var_337_8 = 0
			local var_337_9 = 0.475

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_10 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(103903083).content)

				arg_334_1.text_.text = var_337_10

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_12 = 19 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_10) / 19)

				if (19 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_10) / 19)) > 0 and var_337_9 < var_337_12 then
					arg_334_1.talkMaxDuration = var_337_12

					if var_337_12 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_8
					end
				end

				arg_334_1.text_.text = var_337_10
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_9, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_13 and arg_334_1.time_ < var_337_8 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play103903084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 103903084
		arg_338_1.duration_ = 7.53

		local var_338_0 = {
			ja = 7.533,
			ko = 4.966,
			zh = 4.966,
			en = 4.133
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
				arg_338_0:Play103903085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action464")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_341_0 = 0
			local var_341_1 = 0.45

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_2 = arg_338_1:GetWordFromCfg(103903084)
				local var_341_3 = arg_338_1:FormatText(var_341_2.content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 18 <= 0 and var_341_1 or var_341_1 * (utf8.len(var_341_3) / 18)

				if (18 <= 0 and var_341_1 or var_341_1 * (utf8.len(var_341_3) / 18)) > 0 and var_341_1 < var_341_5 then
					arg_338_1.talkMaxDuration = var_341_5

					if var_341_5 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb") ~= 0 then
					local var_341_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb") / 1000

					if var_341_6 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_0
					end

					if var_341_2.prefab_name ~= "" and arg_338_1.actors_[var_341_2.prefab_name] ~= nil then
						local var_341_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_2.prefab_name].transform, "story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")

						arg_338_1:RecordAudio("103903084", var_341_7)
						arg_338_1:RecordAudio("103903084", var_341_7)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_8 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_8 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_8

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_8 and arg_338_1.time_ < var_341_0 + var_341_8 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play103903085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 103903085
		arg_342_1.duration_ = 5.9

		local var_342_0 = {
			ja = 5.4,
			ko = 5.9,
			zh = 5.9,
			en = 3.5
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play103903086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_345_0 = 0
			local var_345_1 = 0.65

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:GetWordFromCfg(103903085)
				local var_345_3 = arg_342_1:FormatText(var_345_2.content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 26 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_3) / 26)

				if (26 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_3) / 26)) > 0 and var_345_1 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb") ~= 0 then
					local var_345_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb") / 1000

					if var_345_6 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_0
					end

					if var_345_2.prefab_name ~= "" and arg_342_1.actors_[var_345_2.prefab_name] ~= nil then
						local var_345_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_2.prefab_name].transform, "story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")

						arg_342_1:RecordAudio("103903085", var_345_7)
						arg_342_1:RecordAudio("103903085", var_345_7)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_8 and arg_342_1.time_ < var_345_0 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play103903086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 103903086
		arg_346_1.duration_ = 2

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play103903087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1027ui_story"]) and arg_346_1.var_.characterEffect1027ui_story == nil then
				arg_346_1.var_.characterEffect1027ui_story = arg_346_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.1

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1027ui_story"]) then
				if arg_346_1.var_.characterEffect1027ui_story and not isNil(arg_346_1.actors_["1027ui_story"]) then
					arg_346_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1027ui_story"]) and arg_346_1.var_.characterEffect1027ui_story then
				arg_346_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_349_2 = arg_346_1.actors_["1039ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.characterEffect1039ui_story == nil then
				arg_346_1.var_.characterEffect1039ui_story = var_349_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_3 = 0.1

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_3 and not isNil(var_349_2) then
				if arg_346_1.var_.characterEffect1039ui_story and not isNil(var_349_2) then
					arg_346_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_3)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_3 and arg_346_1.time_ < 0 + var_349_3 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.characterEffect1039ui_story then
				arg_346_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_349_4 = arg_346_1.actors_["1039ui_story"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1039ui_story = var_349_4.localPosition
			end

			local var_349_5 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_5 then
				var_349_4.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_346_1.time_ - 0) / var_349_5)
				var_349_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_4.position).x, (manager.ui.mainCamera.transform.position - var_349_4.position).y, (manager.ui.mainCamera.transform.position - var_349_4.position).z)
				var_349_4.localEulerAngles.z = 0
				var_349_4.localEulerAngles.x = 0
				var_349_4.localEulerAngles = var_349_4.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_5 and arg_346_1.time_ < 0 + var_349_5 + arg_349_0 then
				var_349_4.localPosition = Vector3.New(10, -1.06, -5.3)
				var_349_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_4.position).x, (manager.ui.mainCamera.transform.position - var_349_4.position).y, (manager.ui.mainCamera.transform.position - var_349_4.position).z)
				var_349_4.localEulerAngles.z = 0
				var_349_4.localEulerAngles.x = 0
				var_349_4.localEulerAngles = var_349_4.localEulerAngles
			end

			local var_349_6 = arg_346_1.actors_["1027ui_story"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1027ui_story = var_349_6.localPosition
			end

			local var_349_7 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 then
				var_349_6.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_346_1.time_ - 0) / var_349_7)
				var_349_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_6.position).x, (manager.ui.mainCamera.transform.position - var_349_6.position).y, (manager.ui.mainCamera.transform.position - var_349_6.position).z)
				var_349_6.localEulerAngles.z = 0
				var_349_6.localEulerAngles.x = 0
				var_349_6.localEulerAngles = var_349_6.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 then
				var_349_6.localPosition = Vector3.New(0, -0.922, -5.1)
				var_349_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_6.position).x, (manager.ui.mainCamera.transform.position - var_349_6.position).y, (manager.ui.mainCamera.transform.position - var_349_6.position).z)
				var_349_6.localEulerAngles.z = 0
				var_349_6.localEulerAngles.x = 0
				var_349_6.localEulerAngles = var_349_6.localEulerAngles
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_349_8 = 0
			local var_349_9 = 0.05

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_8 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_10 = arg_346_1:GetWordFromCfg(103903086)
				local var_349_11 = arg_346_1:FormatText(var_349_10.content)

				arg_346_1.text_.text = var_349_11

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_13 = 2 <= 0 and var_349_9 or var_349_9 * (utf8.len(var_349_11) / 2)

				if (2 <= 0 and var_349_9 or var_349_9 * (utf8.len(var_349_11) / 2)) > 0 and var_349_9 < var_349_13 then
					arg_346_1.talkMaxDuration = var_349_13

					if var_349_13 + var_349_8 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_13 + var_349_8
					end
				end

				arg_346_1.text_.text = var_349_11
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb") ~= 0 then
					local var_349_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb") / 1000

					if var_349_14 + var_349_8 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_14 + var_349_8
					end

					if var_349_10.prefab_name ~= "" and arg_346_1.actors_[var_349_10.prefab_name] ~= nil then
						local var_349_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_10.prefab_name].transform, "story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")

						arg_346_1:RecordAudio("103903086", var_349_15)
						arg_346_1:RecordAudio("103903086", var_349_15)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_16 = math.max(var_349_9, arg_346_1.talkMaxDuration)

			if var_349_8 <= arg_346_1.time_ and arg_346_1.time_ < var_349_8 + var_349_16 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_8) / var_349_16

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_8 + var_349_16 and arg_346_1.time_ < var_349_8 + var_349_16 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play103903087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 103903087
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play103903088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1027ui_story"]) and arg_350_1.var_.characterEffect1027ui_story == nil then
				arg_350_1.var_.characterEffect1027ui_story = arg_350_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.1

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1027ui_story"]) then
				if arg_350_1.var_.characterEffect1027ui_story and not isNil(arg_350_1.actors_["1027ui_story"]) then
					arg_350_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_0)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1027ui_story"]) and arg_350_1.var_.characterEffect1027ui_story then
				arg_350_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_353_1 = arg_350_1.actors_["1027ui_story"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1027ui_story = var_353_1.localPosition
			end

			local var_353_2 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 then
				var_353_1.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_350_1.time_ - 0) / var_353_2)
				var_353_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_1.position).x, (manager.ui.mainCamera.transform.position - var_353_1.position).y, (manager.ui.mainCamera.transform.position - var_353_1.position).z)
				var_353_1.localEulerAngles.z = 0
				var_353_1.localEulerAngles.x = 0
				var_353_1.localEulerAngles = var_353_1.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 then
				var_353_1.localPosition = Vector3.New(10, -0.922, -5.1)
				var_353_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_1.position).x, (manager.ui.mainCamera.transform.position - var_353_1.position).y, (manager.ui.mainCamera.transform.position - var_353_1.position).z)
				var_353_1.localEulerAngles.z = 0
				var_353_1.localEulerAngles.x = 0
				var_353_1.localEulerAngles = var_353_1.localEulerAngles
			end

			local var_353_3 = 0
			local var_353_4 = 0.9

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_3 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_5 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(103903087).content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 36 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 36)

				if (36 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 36)) > 0 and var_353_4 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_3 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_3
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_4, arg_350_1.talkMaxDuration)

			if var_353_3 <= arg_350_1.time_ and arg_350_1.time_ < var_353_3 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_3) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_3 + var_353_8 and arg_350_1.time_ < var_353_3 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play103903088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 103903088
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play103903089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 1.175

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(103903088).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 47 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 47)

				if (47 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 47)) > 0 and var_357_0 < var_357_3 then
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
	Play103903089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 103903089
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play103903090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.2

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(103903089).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 8 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 8)

				if (8 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 8)) > 0 and var_361_0 < var_361_3 then
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
	Play103903090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 103903090
		arg_362_1.duration_ = 4.87

		local var_362_0 = {
			ja = 4.866,
			ko = 3.5,
			zh = 3.5,
			en = 4.1
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
				arg_362_0:Play103903091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1039ui_story"]) and arg_362_1.var_.characterEffect1039ui_story == nil then
				arg_362_1.var_.characterEffect1039ui_story = arg_362_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.1

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1039ui_story"]) then
				if arg_362_1.var_.characterEffect1039ui_story and not isNil(arg_362_1.actors_["1039ui_story"]) then
					arg_362_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1039ui_story"]) and arg_362_1.var_.characterEffect1039ui_story then
				arg_362_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_365_2 = arg_362_1.actors_["1039ui_story"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1039ui_story = var_365_2.localPosition
			end

			local var_365_3 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_3 then
				var_365_2.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_362_1.time_ - 0) / var_365_3)
				var_365_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_2.position).x, (manager.ui.mainCamera.transform.position - var_365_2.position).y, (manager.ui.mainCamera.transform.position - var_365_2.position).z)
				var_365_2.localEulerAngles.z = 0
				var_365_2.localEulerAngles.x = 0
				var_365_2.localEulerAngles = var_365_2.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_3 and arg_362_1.time_ < 0 + var_365_3 + arg_365_0 then
				var_365_2.localPosition = Vector3.New(0, -1.06, -5.3)
				var_365_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_2.position).x, (manager.ui.mainCamera.transform.position - var_365_2.position).y, (manager.ui.mainCamera.transform.position - var_365_2.position).z)
				var_365_2.localEulerAngles.z = 0
				var_365_2.localEulerAngles.x = 0
				var_365_2.localEulerAngles = var_365_2.localEulerAngles
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_365_4 = 0
			local var_365_5 = 0.3

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_6 = arg_362_1:GetWordFromCfg(103903090)
				local var_365_7 = arg_362_1:FormatText(var_365_6.content)

				arg_362_1.text_.text = var_365_7

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_9 = 12 <= 0 and var_365_5 or var_365_5 * (utf8.len(var_365_7) / 12)

				if (12 <= 0 and var_365_5 or var_365_5 * (utf8.len(var_365_7) / 12)) > 0 and var_365_5 < var_365_9 then
					arg_362_1.talkMaxDuration = var_365_9

					if var_365_9 + var_365_4 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_9 + var_365_4
					end
				end

				arg_362_1.text_.text = var_365_7
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb") ~= 0 then
					local var_365_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb") / 1000

					if var_365_10 + var_365_4 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_4
					end

					if var_365_6.prefab_name ~= "" and arg_362_1.actors_[var_365_6.prefab_name] ~= nil then
						local var_365_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_6.prefab_name].transform, "story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")

						arg_362_1:RecordAudio("103903090", var_365_11)
						arg_362_1:RecordAudio("103903090", var_365_11)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_12 = math.max(var_365_5, arg_362_1.talkMaxDuration)

			if var_365_4 <= arg_362_1.time_ and arg_362_1.time_ < var_365_4 + var_365_12 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_4) / var_365_12

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_4 + var_365_12 and arg_362_1.time_ < var_365_4 + var_365_12 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play103903091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 103903091
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play103903092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.675

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(103903091).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 27 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 27)

				if (27 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 27)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play103903092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 103903092
		arg_370_1.duration_ = 2.37

		local var_370_0 = {
			ja = 2.366,
			ko = 2.3,
			zh = 2.3,
			en = 1.999999999999
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play103903093(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action432")
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_373_0 = 0
			local var_373_1 = 0.1

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_2 = arg_370_1:GetWordFromCfg(103903092)
				local var_373_3 = arg_370_1:FormatText(var_373_2.content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 4 <= 0 and var_373_1 or var_373_1 * (utf8.len(var_373_3) / 4)

				if (4 <= 0 and var_373_1 or var_373_1 * (utf8.len(var_373_3) / 4)) > 0 and var_373_1 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb") ~= 0 then
					local var_373_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb") / 1000

					if var_373_6 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_6 + var_373_0
					end

					if var_373_2.prefab_name ~= "" and arg_370_1.actors_[var_373_2.prefab_name] ~= nil then
						local var_373_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_2.prefab_name].transform, "story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")

						arg_370_1:RecordAudio("103903092", var_373_7)
						arg_370_1:RecordAudio("103903092", var_373_7)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_8 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_8 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_8

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_8 and arg_370_1.time_ < var_373_0 + var_373_8 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play103903093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 103903093
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play103903094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.5

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(103903093).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 20 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 20)

				if (20 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 20)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play103903094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 103903094
		arg_378_1.duration_ = 2.8

		local var_378_0 = {
			ja = 2.8,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.466
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play103903095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_381_0 = 0
			local var_381_1 = 0.175

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_2 = arg_378_1:GetWordFromCfg(103903094)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 7 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 7)

				if (7 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 7)) > 0 and var_381_1 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb") ~= 0 then
					local var_381_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb") / 1000

					if var_381_6 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_0
					end

					if var_381_2.prefab_name ~= "" and arg_378_1.actors_[var_381_2.prefab_name] ~= nil then
						local var_381_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_2.prefab_name].transform, "story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")

						arg_378_1:RecordAudio("103903094", var_381_7)
						arg_378_1:RecordAudio("103903094", var_381_7)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_8 and arg_378_1.time_ < var_381_0 + var_381_8 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play103903095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 103903095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play103903096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1039ui_story"]) and arg_382_1.var_.characterEffect1039ui_story == nil then
				arg_382_1.var_.characterEffect1039ui_story = arg_382_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.1

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1039ui_story"]) then
				if arg_382_1.var_.characterEffect1039ui_story and not isNil(arg_382_1.actors_["1039ui_story"]) then
					arg_382_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1039ui_story"]) and arg_382_1.var_.characterEffect1039ui_story then
				arg_382_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.725

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

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(103903095).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 29 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 29)

				if (29 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 29)) > 0 and var_385_2 < var_385_5 then
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

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play103903096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 103903096
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play103903097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.475

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(103903096).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 19 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 19)

				if (19 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 19)) > 0 and var_389_0 < var_389_3 then
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
	Play103903097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 103903097
		arg_390_1.duration_ = 4.6

		local var_390_0 = {
			ja = 4.6,
			ko = 2.5,
			zh = 2.5,
			en = 2.066
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
				arg_390_0:Play103903098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1027ui_story"]) and arg_390_1.var_.characterEffect1027ui_story == nil then
				arg_390_1.var_.characterEffect1027ui_story = arg_390_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.1

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1027ui_story"]) then
				if arg_390_1.var_.characterEffect1027ui_story and not isNil(arg_390_1.actors_["1027ui_story"]) then
					arg_390_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1027ui_story"]) and arg_390_1.var_.characterEffect1027ui_story then
				arg_390_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_393_2 = arg_390_1.actors_["1039ui_story"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1039ui_story = var_393_2.localPosition
			end

			local var_393_3 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_3 then
				var_393_2.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_390_1.time_ - 0) / var_393_3)
				var_393_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_2.position).x, (manager.ui.mainCamera.transform.position - var_393_2.position).y, (manager.ui.mainCamera.transform.position - var_393_2.position).z)
				var_393_2.localEulerAngles.z = 0
				var_393_2.localEulerAngles.x = 0
				var_393_2.localEulerAngles = var_393_2.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_3 and arg_390_1.time_ < 0 + var_393_3 + arg_393_0 then
				var_393_2.localPosition = Vector3.New(10, -1.06, -5.3)
				var_393_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_2.position).x, (manager.ui.mainCamera.transform.position - var_393_2.position).y, (manager.ui.mainCamera.transform.position - var_393_2.position).z)
				var_393_2.localEulerAngles.z = 0
				var_393_2.localEulerAngles.x = 0
				var_393_2.localEulerAngles = var_393_2.localEulerAngles
			end

			local var_393_4 = arg_390_1.actors_["1027ui_story"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1027ui_story = var_393_4.localPosition
			end

			local var_393_5 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_5 then
				var_393_4.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (arg_390_1.time_ - 0) / var_393_5)
				var_393_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_4.position).x, (manager.ui.mainCamera.transform.position - var_393_4.position).y, (manager.ui.mainCamera.transform.position - var_393_4.position).z)
				var_393_4.localEulerAngles.z = 0
				var_393_4.localEulerAngles.x = 0
				var_393_4.localEulerAngles = var_393_4.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_5 and arg_390_1.time_ < 0 + var_393_5 + arg_393_0 then
				var_393_4.localPosition = Vector3.New(0, -0.922, -5.1)
				var_393_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_4.position).x, (manager.ui.mainCamera.transform.position - var_393_4.position).y, (manager.ui.mainCamera.transform.position - var_393_4.position).z)
				var_393_4.localEulerAngles.z = 0
				var_393_4.localEulerAngles.x = 0
				var_393_4.localEulerAngles = var_393_4.localEulerAngles
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_393_6 = 0
			local var_393_7 = 0.1

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_6 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_8 = arg_390_1:GetWordFromCfg(103903097)
				local var_393_9 = arg_390_1:FormatText(var_393_8.content)

				arg_390_1.text_.text = var_393_9

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_11 = 4 <= 0 and var_393_7 or var_393_7 * (utf8.len(var_393_9) / 4)

				if (4 <= 0 and var_393_7 or var_393_7 * (utf8.len(var_393_9) / 4)) > 0 and var_393_7 < var_393_11 then
					arg_390_1.talkMaxDuration = var_393_11

					if var_393_11 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_11 + var_393_6
					end
				end

				arg_390_1.text_.text = var_393_9
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb") ~= 0 then
					local var_393_12 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb") / 1000

					if var_393_12 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_12 + var_393_6
					end

					if var_393_8.prefab_name ~= "" and arg_390_1.actors_[var_393_8.prefab_name] ~= nil then
						local var_393_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_8.prefab_name].transform, "story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")

						arg_390_1:RecordAudio("103903097", var_393_13)
						arg_390_1:RecordAudio("103903097", var_393_13)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_14 = math.max(var_393_7, arg_390_1.talkMaxDuration)

			if var_393_6 <= arg_390_1.time_ and arg_390_1.time_ < var_393_6 + var_393_14 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_6) / var_393_14

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_6 + var_393_14 and arg_390_1.time_ < var_393_6 + var_393_14 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play103903098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 103903098
		arg_394_1.duration_ = 6.92

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play103903099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:AudioAction("play", "music", "ui_battle", "ui_battle_resumebgm", "")

				local var_397_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_resumebgm")

				if "" ~= "" then
					if arg_394_1.bgmTxt_.text ~= var_397_2 and arg_394_1.bgmTxt_.text ~= "" then
						if arg_394_1.bgmTxt2_.text ~= "" then
							arg_394_1.bgmTxt_.text = arg_394_1.bgmTxt2_.text
						end

						arg_394_1.bgmTxt2_.text = var_397_2

						arg_394_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_394_1.bgmTxt_.text = var_397_2
						arg_394_1.bgmTxt2_.text = var_397_2
					end

					if arg_394_1.bgmTimer then
						arg_394_1.bgmTimer:Stop()

						arg_394_1.bgmTimer = nil
					end

					if arg_394_1.settingData.show_music_name == 1 then
						arg_394_1.musicController:SetSelectedState("show")
						arg_394_1.musicAnimator_:Play("open", 0, 0)

						if arg_394_1.settingData.music_time ~= 0 then
							arg_394_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_394_1.settingData.music_time), function()
								if arg_394_1 == nil or isNil(arg_394_1.bgmTxt_) then
									return
								end

								arg_394_1.musicController:SetSelectedState("hide")
								arg_394_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action427")
			end

			local var_397_3 = 0
			local var_397_4 = 0.975

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_3 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_5 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(103903098).content)

				arg_394_1.text_.text = var_397_5

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_7 = 39 <= 0 and var_397_4 or var_397_4 * (utf8.len(var_397_5) / 39)

				if (39 <= 0 and var_397_4 or var_397_4 * (utf8.len(var_397_5) / 39)) > 0 and var_397_4 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_3 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_3
					end
				end

				arg_394_1.text_.text = var_397_5
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_8 = math.max(var_397_4, arg_394_1.talkMaxDuration)

			if var_397_3 <= arg_394_1.time_ and arg_394_1.time_ < var_397_3 + var_397_8 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_3) / var_397_8

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_3 + var_397_8 and arg_394_1.time_ < var_397_3 + var_397_8 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play103903099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 103903099
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play103903100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1027ui_story"]) and arg_399_1.var_.characterEffect1027ui_story == nil then
				arg_399_1.var_.characterEffect1027ui_story = arg_399_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.1

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1027ui_story"]) then
				if arg_399_1.var_.characterEffect1027ui_story and not isNil(arg_399_1.actors_["1027ui_story"]) then
					arg_399_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1027ui_story"]) and arg_399_1.var_.characterEffect1027ui_story then
				arg_399_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_402_1 = arg_399_1.actors_["1027ui_story"].transform

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1027ui_story = var_402_1.localPosition
			end

			local var_402_2 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 then
				var_402_1.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (arg_399_1.time_ - 0) / var_402_2)
				var_402_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_1.position).x, (manager.ui.mainCamera.transform.position - var_402_1.position).y, (manager.ui.mainCamera.transform.position - var_402_1.position).z)
				var_402_1.localEulerAngles.z = 0
				var_402_1.localEulerAngles.x = 0
				var_402_1.localEulerAngles = var_402_1.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 then
				var_402_1.localPosition = Vector3.New(10, -0.922, -5.1)
				var_402_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_1.position).x, (manager.ui.mainCamera.transform.position - var_402_1.position).y, (manager.ui.mainCamera.transform.position - var_402_1.position).z)
				var_402_1.localEulerAngles.z = 0
				var_402_1.localEulerAngles.x = 0
				var_402_1.localEulerAngles = var_402_1.localEulerAngles
			end

			local var_402_3 = 0
			local var_402_4 = 0.825

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_3 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_5 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(103903099).content)

				arg_399_1.text_.text = var_402_5

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_7 = 33 <= 0 and var_402_4 or var_402_4 * (utf8.len(var_402_5) / 33)

				if (33 <= 0 and var_402_4 or var_402_4 * (utf8.len(var_402_5) / 33)) > 0 and var_402_4 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_3 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_3
					end
				end

				arg_399_1.text_.text = var_402_5
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_8 = math.max(var_402_4, arg_399_1.talkMaxDuration)

			if var_402_3 <= arg_399_1.time_ and arg_399_1.time_ < var_402_3 + var_402_8 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_3) / var_402_8

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_3 + var_402_8 and arg_399_1.time_ < var_402_3 + var_402_8 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play103903100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 103903100
		arg_403_1.duration_ = 6.23

		local var_403_0 = {
			ja = 6.233,
			ko = 4.6,
			zh = 4.6,
			en = 6
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play103903101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1039ui_story"]) and arg_403_1.var_.characterEffect1039ui_story == nil then
				arg_403_1.var_.characterEffect1039ui_story = arg_403_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.1

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1039ui_story"]) then
				if arg_403_1.var_.characterEffect1039ui_story and not isNil(arg_403_1.actors_["1039ui_story"]) then
					arg_403_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1039ui_story"]) and arg_403_1.var_.characterEffect1039ui_story then
				arg_403_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_406_2 = arg_403_1.actors_["1039ui_story"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1039ui_story = var_406_2.localPosition
			end

			local var_406_3 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 then
				var_406_2.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_403_1.time_ - 0) / var_406_3)
				var_406_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_2.position).x, (manager.ui.mainCamera.transform.position - var_406_2.position).y, (manager.ui.mainCamera.transform.position - var_406_2.position).z)
				var_406_2.localEulerAngles.z = 0
				var_406_2.localEulerAngles.x = 0
				var_406_2.localEulerAngles = var_406_2.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 then
				var_406_2.localPosition = Vector3.New(0, -1.06, -5.3)
				var_406_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_2.position).x, (manager.ui.mainCamera.transform.position - var_406_2.position).y, (manager.ui.mainCamera.transform.position - var_406_2.position).z)
				var_406_2.localEulerAngles.z = 0
				var_406_2.localEulerAngles.x = 0
				var_406_2.localEulerAngles = var_406_2.localEulerAngles
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.55

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(103903100)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 22 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 22)

				if (22 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 22)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")

						arg_403_1:RecordAudio("103903100", var_406_11)
						arg_403_1:RecordAudio("103903100", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play103903101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 103903101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play103903102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1039ui_story"]) and arg_407_1.var_.characterEffect1039ui_story == nil then
				arg_407_1.var_.characterEffect1039ui_story = arg_407_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.1

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1039ui_story"]) then
				if arg_407_1.var_.characterEffect1039ui_story and not isNil(arg_407_1.actors_["1039ui_story"]) then
					arg_407_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1039ui_story"]) and arg_407_1.var_.characterEffect1039ui_story then
				arg_407_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_410_1 = 0
			local var_410_2 = 0.3

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(103903101).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 12 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 12)

				if (12 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 12)) > 0 and var_410_2 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_6 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_6 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_6

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_6 and arg_407_1.time_ < var_410_1 + var_410_6 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play103903102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 103903102
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play103903103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1039ui_story = arg_411_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1039ui_story"].transform.position).z)
				arg_411_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1039ui_story"].transform.localEulerAngles = arg_411_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(10, -1.06, -5.3)
				arg_411_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1039ui_story"].transform.position).z)
				arg_411_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1039ui_story"].transform.localEulerAngles = arg_411_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_414_1 = 0
			local var_414_2 = 0.425

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_3 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(103903102).content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 17 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 17)

				if (17 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 17)) > 0 and var_414_2 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_6 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_6 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_6

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_6 and arg_411_1.time_ < var_414_1 + var_414_6 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play103903103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 103903103
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play103903104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.1

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(103903103).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 4 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 4)

				if (4 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 4)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play103903104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 103903104
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play103903105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.425

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(103903104).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 17 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 17)

				if (17 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 17)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play103903105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 103903105
		arg_423_1.duration_ = 2.3

		local var_423_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play103903106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1039ui_story"]) and arg_423_1.var_.characterEffect1039ui_story == nil then
				arg_423_1.var_.characterEffect1039ui_story = arg_423_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.1

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1039ui_story"]) then
				if arg_423_1.var_.characterEffect1039ui_story and not isNil(arg_423_1.actors_["1039ui_story"]) then
					arg_423_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1039ui_story"]) and arg_423_1.var_.characterEffect1039ui_story then
				arg_423_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_426_2 = arg_423_1.actors_["1039ui_story"].transform

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1039ui_story = var_426_2.localPosition
			end

			local var_426_3 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_3 then
				var_426_2.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_423_1.time_ - 0) / var_426_3)
				var_426_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_2.position).x, (manager.ui.mainCamera.transform.position - var_426_2.position).y, (manager.ui.mainCamera.transform.position - var_426_2.position).z)
				var_426_2.localEulerAngles.z = 0
				var_426_2.localEulerAngles.x = 0
				var_426_2.localEulerAngles = var_426_2.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_3 and arg_423_1.time_ < 0 + var_426_3 + arg_426_0 then
				var_426_2.localPosition = Vector3.New(0, -1.06, -5.3)
				var_426_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_2.position).x, (manager.ui.mainCamera.transform.position - var_426_2.position).y, (manager.ui.mainCamera.transform.position - var_426_2.position).z)
				var_426_2.localEulerAngles.z = 0
				var_426_2.localEulerAngles.x = 0
				var_426_2.localEulerAngles = var_426_2.localEulerAngles
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_426_4 = 0
			local var_426_5 = 0.1

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(103903105)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 4 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 4)

				if (4 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 4)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")

						arg_423_1:RecordAudio("103903105", var_426_11)
						arg_423_1:RecordAudio("103903105", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play103903106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 103903106
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play103903107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.8

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(103903106).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 31 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 31)

				if (31 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 31)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play103903107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 103903107
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play103903108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.3

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(103903107).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 12 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 12)

				if (12 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 12)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play103903108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 103903108
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play103903109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1039ui_story"]) and arg_435_1.var_.characterEffect1039ui_story == nil then
				arg_435_1.var_.characterEffect1039ui_story = arg_435_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.1

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1039ui_story"]) then
				if arg_435_1.var_.characterEffect1039ui_story and not isNil(arg_435_1.actors_["1039ui_story"]) then
					arg_435_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1039ui_story"]) and arg_435_1.var_.characterEffect1039ui_story then
				arg_435_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_438_1 = 0
			local var_438_2 = 0.4

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(103903108).content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 16 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 16)

				if (16 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 16)) > 0 and var_438_2 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_6 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_6 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_6

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_6 and arg_435_1.time_ < var_438_1 + var_438_6 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play103903109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 103903109
		arg_439_1.duration_ = 1.93

		local var_439_0 = {
			ja = 1.8,
			ko = 1.133,
			zh = 1.133,
			en = 1.933
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play103903110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_442_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_439_1.bgmTxt_.text ~= var_442_2 and arg_439_1.bgmTxt_.text ~= "" then
						if arg_439_1.bgmTxt2_.text ~= "" then
							arg_439_1.bgmTxt_.text = arg_439_1.bgmTxt2_.text
						end

						arg_439_1.bgmTxt2_.text = var_442_2

						arg_439_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_439_1.bgmTxt_.text = var_442_2
						arg_439_1.bgmTxt2_.text = var_442_2
					end

					if arg_439_1.bgmTimer then
						arg_439_1.bgmTimer:Stop()

						arg_439_1.bgmTimer = nil
					end

					if arg_439_1.settingData.show_music_name == 1 then
						arg_439_1.musicController:SetSelectedState("show")
						arg_439_1.musicAnimator_:Play("open", 0, 0)

						if arg_439_1.settingData.music_time ~= 0 then
							arg_439_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_439_1.settingData.music_time), function()
								if arg_439_1 == nil or isNil(arg_439_1.bgmTxt_) then
									return
								end

								arg_439_1.musicController:SetSelectedState("hide")
								arg_439_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_442_3 = arg_439_1.actors_["1039ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_3) and arg_439_1.var_.characterEffect1039ui_story == nil then
				arg_439_1.var_.characterEffect1039ui_story = var_442_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_4 = 0.1

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 and not isNil(var_442_3) then
				if arg_439_1.var_.characterEffect1039ui_story and not isNil(var_442_3) then
					arg_439_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 and not isNil(var_442_3) and arg_439_1.var_.characterEffect1039ui_story then
				arg_439_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_442_6 = 0
			local var_442_7 = 0.05

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_8 = arg_439_1:GetWordFromCfg(103903109)
				local var_442_9 = arg_439_1:FormatText(var_442_8.content)

				arg_439_1.text_.text = var_442_9

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 2 <= 0 and var_442_7 or var_442_7 * (utf8.len(var_442_9) / 2)

				if (2 <= 0 and var_442_7 or var_442_7 * (utf8.len(var_442_9) / 2)) > 0 and var_442_7 < var_442_11 then
					arg_439_1.talkMaxDuration = var_442_11

					if var_442_11 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_11 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_9
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb") ~= 0 then
					local var_442_12 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb") / 1000

					if var_442_12 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_12 + var_442_6
					end

					if var_442_8.prefab_name ~= "" and arg_439_1.actors_[var_442_8.prefab_name] ~= nil then
						local var_442_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_8.prefab_name].transform, "story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")

						arg_439_1:RecordAudio("103903109", var_442_13)
						arg_439_1:RecordAudio("103903109", var_442_13)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_14 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_14 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_14

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_14 and arg_439_1.time_ < var_442_6 + var_442_14 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play103903110 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 103903110
		arg_444_1.duration_ = 2.63

		local var_444_0 = {
			ja = 2.333,
			ko = 2.633,
			zh = 2.633,
			en = 2.466
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play103903111(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:AudioAction("play", "music", "bgm_story_mood_warm", "bgm_story_mood_warm", "bgm_story_mood_warm")

				local var_447_2 = manager.audio:GetAudioName("bgm_story_mood_warm", "bgm_story_mood_warm")

				if "" ~= "" then
					if arg_444_1.bgmTxt_.text ~= var_447_2 and arg_444_1.bgmTxt_.text ~= "" then
						if arg_444_1.bgmTxt2_.text ~= "" then
							arg_444_1.bgmTxt_.text = arg_444_1.bgmTxt2_.text
						end

						arg_444_1.bgmTxt2_.text = var_447_2

						arg_444_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_444_1.bgmTxt_.text = var_447_2
						arg_444_1.bgmTxt2_.text = var_447_2
					end

					if arg_444_1.bgmTimer then
						arg_444_1.bgmTimer:Stop()

						arg_444_1.bgmTimer = nil
					end

					if arg_444_1.settingData.show_music_name == 1 then
						arg_444_1.musicController:SetSelectedState("show")
						arg_444_1.musicAnimator_:Play("open", 0, 0)

						if arg_444_1.settingData.music_time ~= 0 then
							arg_444_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_444_1.settingData.music_time), function()
								if arg_444_1 == nil or isNil(arg_444_1.bgmTxt_) then
									return
								end

								arg_444_1.musicController:SetSelectedState("hide")
								arg_444_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action426")
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_447_3 = 0
			local var_447_4 = 0.2

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_3 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_5 = arg_444_1:GetWordFromCfg(103903110)
				local var_447_6 = arg_444_1:FormatText(var_447_5.content)

				arg_444_1.text_.text = var_447_6

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_8 = 8 <= 0 and var_447_4 or var_447_4 * (utf8.len(var_447_6) / 8)

				if (8 <= 0 and var_447_4 or var_447_4 * (utf8.len(var_447_6) / 8)) > 0 and var_447_4 < var_447_8 then
					arg_444_1.talkMaxDuration = var_447_8

					if var_447_8 + var_447_3 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_8 + var_447_3
					end
				end

				arg_444_1.text_.text = var_447_6
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb") ~= 0 then
					local var_447_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb") / 1000

					if var_447_9 + var_447_3 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_9 + var_447_3
					end

					if var_447_5.prefab_name ~= "" and arg_444_1.actors_[var_447_5.prefab_name] ~= nil then
						local var_447_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_5.prefab_name].transform, "story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")

						arg_444_1:RecordAudio("103903110", var_447_10)
						arg_444_1:RecordAudio("103903110", var_447_10)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_11 = math.max(var_447_4, arg_444_1.talkMaxDuration)

			if var_447_3 <= arg_444_1.time_ and arg_444_1.time_ < var_447_3 + var_447_11 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_3) / var_447_11

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_3 + var_447_11 and arg_444_1.time_ < var_447_3 + var_447_11 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play103903111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 103903111
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play103903112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1039ui_story"]) and arg_449_1.var_.characterEffect1039ui_story == nil then
				arg_449_1.var_.characterEffect1039ui_story = arg_449_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.1

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1039ui_story"]) then
				if arg_449_1.var_.characterEffect1039ui_story and not isNil(arg_449_1.actors_["1039ui_story"]) then
					arg_449_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_0)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1039ui_story"]) and arg_449_1.var_.characterEffect1039ui_story then
				arg_449_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_452_1 = 0
			local var_452_2 = 0.275

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(103903111).content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 11 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 11)

				if (11 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 11)) > 0 and var_452_2 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_6 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_6 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_6

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_6 and arg_449_1.time_ < var_452_1 + var_452_6 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play103903112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 103903112
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play103903113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPosD04a = arg_453_1.bgs_.D04a.transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.bgs_.D04a.transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPosD04a, Vector3.New(0, -100, 10), (arg_453_1.time_ - 0) / var_456_0)
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.bgs_.D04a.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_456_1 = "ST01"

			if arg_453_1.bgs_.ST01 == nil then
				local var_456_2 = Object.Instantiate(arg_453_1.paintGo_)

				var_456_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_456_1)
				var_456_2.name = var_456_1
				var_456_2.transform.parent = arg_453_1.stage_.transform
				var_456_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.bgs_[var_456_1] = var_456_2
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				local var_456_3 = arg_453_1.bgs_.ST01

				arg_453_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_456_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_456_4 = var_456_3:GetComponent("SpriteRenderer")

				if var_456_4 and var_456_4.sprite then
					local var_456_5 = 2 * (var_456_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_456_3.transform.localScale = Vector3.New(var_456_5 / var_456_4.sprite.bounds.size.y < var_456_5 * manager.ui.mainCameraCom_.aspect / var_456_4.sprite.bounds.size.x and var_456_5 * manager.ui.mainCameraCom_.aspect / var_456_4.sprite.bounds.size.x or var_456_5 / var_456_4.sprite.bounds.size.y, var_456_5 / var_456_4.sprite.bounds.size.y < var_456_5 * manager.ui.mainCameraCom_.aspect / var_456_4.sprite.bounds.size.x and var_456_5 * manager.ui.mainCameraCom_.aspect / var_456_4.sprite.bounds.size.x or var_456_5 / var_456_4.sprite.bounds.size.y, 0)
				end

				for iter_456_0, iter_456_1 in pairs(arg_453_1.bgs_) do
					if iter_456_0 ~= "ST01" then
						iter_456_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_456_6 = arg_453_1.actors_["1039ui_story"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1039ui_story = var_456_6.localPosition
			end

			local var_456_7 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				var_456_6.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_453_1.time_ - 0) / var_456_7)
				var_456_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_6.position).x, (manager.ui.mainCamera.transform.position - var_456_6.position).y, (manager.ui.mainCamera.transform.position - var_456_6.position).z)
				var_456_6.localEulerAngles.z = 0
				var_456_6.localEulerAngles.x = 0
				var_456_6.localEulerAngles = var_456_6.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				var_456_6.localPosition = Vector3.New(10, -1.06, -5.3)
				var_456_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_6.position).x, (manager.ui.mainCamera.transform.position - var_456_6.position).y, (manager.ui.mainCamera.transform.position - var_456_6.position).z)
				var_456_6.localEulerAngles.z = 0
				var_456_6.localEulerAngles.x = 0
				var_456_6.localEulerAngles = var_456_6.localEulerAngles
			end

			local var_456_8 = 0
			local var_456_9 = 0.125

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_8 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_10 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(103903112).content)

				arg_453_1.text_.text = var_456_10

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_12 = 5 <= 0 and var_456_9 or var_456_9 * (utf8.len(var_456_10) / 5)

				if (5 <= 0 and var_456_9 or var_456_9 * (utf8.len(var_456_10) / 5)) > 0 and var_456_9 < var_456_12 then
					arg_453_1.talkMaxDuration = var_456_12

					if var_456_12 + var_456_8 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_12 + var_456_8
					end
				end

				arg_453_1.text_.text = var_456_10
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_13 = math.max(var_456_9, arg_453_1.talkMaxDuration)

			if var_456_8 <= arg_453_1.time_ and arg_453_1.time_ < var_456_8 + var_456_13 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_8) / var_456_13

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_8 + var_456_13 and arg_453_1.time_ < var_456_8 + var_456_13 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D04a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play103903113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 103903113
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play103903114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 1.25

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(103903113).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 50 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 50)

				if (50 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 50)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play103903114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 103903114
		arg_461_1.duration_ = 6.23

		local var_461_0 = {
			ja = 6.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.333
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play103903115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1039ui_story"]) and arg_461_1.var_.characterEffect1039ui_story == nil then
				arg_461_1.var_.characterEffect1039ui_story = arg_461_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.1

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1039ui_story"]) then
				if arg_461_1.var_.characterEffect1039ui_story and not isNil(arg_461_1.actors_["1039ui_story"]) then
					arg_461_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1039ui_story"]) and arg_461_1.var_.characterEffect1039ui_story then
				arg_461_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_464_2 = arg_461_1.actors_["1039ui_story"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1039ui_story = var_464_2.localPosition
			end

			local var_464_3 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_3 then
				var_464_2.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_461_1.time_ - 0) / var_464_3)
				var_464_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_2.position).x, (manager.ui.mainCamera.transform.position - var_464_2.position).y, (manager.ui.mainCamera.transform.position - var_464_2.position).z)
				var_464_2.localEulerAngles.z = 0
				var_464_2.localEulerAngles.x = 0
				var_464_2.localEulerAngles = var_464_2.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_3 and arg_461_1.time_ < 0 + var_464_3 + arg_464_0 then
				var_464_2.localPosition = Vector3.New(0, -1.06, -5.3)
				var_464_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_2.position).x, (manager.ui.mainCamera.transform.position - var_464_2.position).y, (manager.ui.mainCamera.transform.position - var_464_2.position).z)
				var_464_2.localEulerAngles.z = 0
				var_464_2.localEulerAngles.x = 0
				var_464_2.localEulerAngles = var_464_2.localEulerAngles
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_464_4 = 0
			local var_464_5 = 0.175

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_6 = arg_461_1:GetWordFromCfg(103903114)
				local var_464_7 = arg_461_1:FormatText(var_464_6.content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 7 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 7)

				if (7 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 7)) > 0 and var_464_5 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_4
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb") ~= 0 then
					local var_464_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb") / 1000

					if var_464_10 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_4
					end

					if var_464_6.prefab_name ~= "" and arg_461_1.actors_[var_464_6.prefab_name] ~= nil then
						local var_464_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_6.prefab_name].transform, "story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")

						arg_461_1:RecordAudio("103903114", var_464_11)
						arg_461_1:RecordAudio("103903114", var_464_11)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_12 = math.max(var_464_5, arg_461_1.talkMaxDuration)

			if var_464_4 <= arg_461_1.time_ and arg_461_1.time_ < var_464_4 + var_464_12 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_4) / var_464_12

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_4 + var_464_12 and arg_461_1.time_ < var_464_4 + var_464_12 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play103903115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 103903115
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play103903116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.7

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(103903115).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 28 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 28)

				if (28 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 28)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play103903116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 103903116
		arg_469_1.duration_ = 4.23

		local var_469_0 = {
			ja = 4.033,
			ko = 3.666,
			zh = 3.666,
			en = 4.233
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play103903117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_472_0 = 0
			local var_472_1 = 0.225

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:GetWordFromCfg(103903116)
				local var_472_3 = arg_469_1:FormatText(var_472_2.content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 9 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 9)

				if (9 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 9)) > 0 and var_472_1 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb") ~= 0 then
					local var_472_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb") / 1000

					if var_472_6 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_0
					end

					if var_472_2.prefab_name ~= "" and arg_469_1.actors_[var_472_2.prefab_name] ~= nil then
						local var_472_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_2.prefab_name].transform, "story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")

						arg_469_1:RecordAudio("103903116", var_472_7)
						arg_469_1:RecordAudio("103903116", var_472_7)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play103903117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 103903117
		arg_473_1.duration_ = 17

		local var_473_0 = {
			ja = 14,
			ko = 13.8,
			zh = 13.8,
			en = 17
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play103903118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_476_0 = 0
			local var_476_1 = 1.425

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_2 = arg_473_1:GetWordFromCfg(103903117)
				local var_476_3 = arg_473_1:FormatText(var_476_2.content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 57 <= 0 and var_476_1 or var_476_1 * (utf8.len(var_476_3) / 57)

				if (57 <= 0 and var_476_1 or var_476_1 * (utf8.len(var_476_3) / 57)) > 0 and var_476_1 < var_476_5 then
					arg_473_1.talkMaxDuration = var_476_5

					if var_476_5 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb") ~= 0 then
					local var_476_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb") / 1000

					if var_476_6 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_0
					end

					if var_476_2.prefab_name ~= "" and arg_473_1.actors_[var_476_2.prefab_name] ~= nil then
						local var_476_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_2.prefab_name].transform, "story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")

						arg_473_1:RecordAudio("103903117", var_476_7)
						arg_473_1:RecordAudio("103903117", var_476_7)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play103903118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 103903118
		arg_477_1.duration_ = 10.9

		local var_477_0 = {
			ja = 10.9,
			ko = 8.8,
			zh = 8.8,
			en = 10.233
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play103903119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_480_0 = 0
			local var_480_1 = 1.1

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_2 = arg_477_1:GetWordFromCfg(103903118)
				local var_480_3 = arg_477_1:FormatText(var_480_2.content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 43 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 43)

				if (43 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 43)) > 0 and var_480_1 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb") ~= 0 then
					local var_480_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb") / 1000

					if var_480_6 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_6 + var_480_0
					end

					if var_480_2.prefab_name ~= "" and arg_477_1.actors_[var_480_2.prefab_name] ~= nil then
						local var_480_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_2.prefab_name].transform, "story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")

						arg_477_1:RecordAudio("103903118", var_480_7)
						arg_477_1:RecordAudio("103903118", var_480_7)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play103903119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 103903119
		arg_481_1.duration_ = 8.17

		local var_481_0 = {
			ja = 8.166,
			ko = 7.8,
			zh = 7.8,
			en = 8.066
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play103903120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_484_0 = 0
			local var_484_1 = 0.825

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_2 = arg_481_1:GetWordFromCfg(103903119)
				local var_484_3 = arg_481_1:FormatText(var_484_2.content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 33 <= 0 and var_484_1 or var_484_1 * (utf8.len(var_484_3) / 33)

				if (33 <= 0 and var_484_1 or var_484_1 * (utf8.len(var_484_3) / 33)) > 0 and var_484_1 < var_484_5 then
					arg_481_1.talkMaxDuration = var_484_5

					if var_484_5 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb") ~= 0 then
					local var_484_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb") / 1000

					if var_484_6 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_0
					end

					if var_484_2.prefab_name ~= "" and arg_481_1.actors_[var_484_2.prefab_name] ~= nil then
						local var_484_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_2.prefab_name].transform, "story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")

						arg_481_1:RecordAudio("103903119", var_484_7)
						arg_481_1:RecordAudio("103903119", var_484_7)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_8 and arg_481_1.time_ < var_484_0 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play103903120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 103903120
		arg_485_1.duration_ = 8.53

		local var_485_0 = {
			ja = 8.533,
			ko = 4.366,
			zh = 4.366,
			en = 3.866
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play103903121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action472")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_488_0 = 0
			local var_488_1 = 0.55

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_2 = arg_485_1:GetWordFromCfg(103903120)
				local var_488_3 = arg_485_1:FormatText(var_488_2.content)

				arg_485_1.text_.text = var_488_3

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 22 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_3) / 22)

				if (22 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_3) / 22)) > 0 and var_488_1 < var_488_5 then
					arg_485_1.talkMaxDuration = var_488_5

					if var_488_5 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_3
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb") ~= 0 then
					local var_488_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb") / 1000

					if var_488_6 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_0
					end

					if var_488_2.prefab_name ~= "" and arg_485_1.actors_[var_488_2.prefab_name] ~= nil then
						local var_488_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_2.prefab_name].transform, "story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")

						arg_485_1:RecordAudio("103903120", var_488_7)
						arg_485_1:RecordAudio("103903120", var_488_7)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_8 and arg_485_1.time_ < var_488_0 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play103903121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 103903121
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play103903122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1039ui_story"]) and arg_489_1.var_.characterEffect1039ui_story == nil then
				arg_489_1.var_.characterEffect1039ui_story = arg_489_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.1

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1039ui_story"]) then
				if arg_489_1.var_.characterEffect1039ui_story and not isNil(arg_489_1.actors_["1039ui_story"]) then
					arg_489_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1039ui_story"]) and arg_489_1.var_.characterEffect1039ui_story then
				arg_489_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_492_1 = arg_489_1.bgs_.ST01.transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPosST01 = var_492_1.localPosition
			end

			local var_492_2 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_2 then
				var_492_1.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPosST01, Vector3.New(0, -100, 10), (arg_489_1.time_ - 0) / var_492_2)
			end

			if arg_489_1.time_ >= 0 + var_492_2 and arg_489_1.time_ < 0 + var_492_2 + arg_492_0 then
				var_492_1.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				local var_492_3 = arg_489_1.bgs_.D04a

				arg_489_1.bgs_.D04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_492_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_4 = var_492_3:GetComponent("SpriteRenderer")

				if var_492_4 and var_492_4.sprite then
					local var_492_5 = 2 * (var_492_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_492_3.transform.localScale = Vector3.New(var_492_5 / var_492_4.sprite.bounds.size.y < var_492_5 * manager.ui.mainCameraCom_.aspect / var_492_4.sprite.bounds.size.x and var_492_5 * manager.ui.mainCameraCom_.aspect / var_492_4.sprite.bounds.size.x or var_492_5 / var_492_4.sprite.bounds.size.y, var_492_5 / var_492_4.sprite.bounds.size.y < var_492_5 * manager.ui.mainCameraCom_.aspect / var_492_4.sprite.bounds.size.x and var_492_5 * manager.ui.mainCameraCom_.aspect / var_492_4.sprite.bounds.size.x or var_492_5 / var_492_4.sprite.bounds.size.y, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "D04a" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_6 = arg_489_1.actors_["1039ui_story"].transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos1039ui_story = var_492_6.localPosition
			end

			local var_492_7 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				var_492_6.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_489_1.time_ - 0) / var_492_7)
				var_492_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_6.position).x, (manager.ui.mainCamera.transform.position - var_492_6.position).y, (manager.ui.mainCamera.transform.position - var_492_6.position).z)
				var_492_6.localEulerAngles.z = 0
				var_492_6.localEulerAngles.x = 0
				var_492_6.localEulerAngles = var_492_6.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				var_492_6.localPosition = Vector3.New(10, -1.06, -5.3)
				var_492_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_6.position).x, (manager.ui.mainCamera.transform.position - var_492_6.position).y, (manager.ui.mainCamera.transform.position - var_492_6.position).z)
				var_492_6.localEulerAngles.z = 0
				var_492_6.localEulerAngles.x = 0
				var_492_6.localEulerAngles = var_492_6.localEulerAngles
			end

			local var_492_8 = 0
			local var_492_9 = 0.65

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_8 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_10 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(103903121).content)

				arg_489_1.text_.text = var_492_10

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_12 = 26 <= 0 and var_492_9 or var_492_9 * (utf8.len(var_492_10) / 26)

				if (26 <= 0 and var_492_9 or var_492_9 * (utf8.len(var_492_10) / 26)) > 0 and var_492_9 < var_492_12 then
					arg_489_1.talkMaxDuration = var_492_12

					if var_492_12 + var_492_8 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_12 + var_492_8
					end
				end

				arg_489_1.text_.text = var_492_10
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_13 = math.max(var_492_9, arg_489_1.talkMaxDuration)

			if var_492_8 <= arg_489_1.time_ and arg_489_1.time_ < var_492_8 + var_492_13 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_8) / var_492_13

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_8 + var_492_13 and arg_489_1.time_ < var_492_8 + var_492_13 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST01",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play103903122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 103903122
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play103903123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.575

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(103903122).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 23 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 23)

				if (23 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 23)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play103903123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 103903123
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play103903124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.2

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_1 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(103903123).content)

				arg_497_1.text_.text = var_500_1

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_3 = 8 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 8)

				if (8 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 8)) > 0 and var_500_0 < var_500_3 then
					arg_497_1.talkMaxDuration = var_500_3

					if var_500_3 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_3 + 0
					end
				end

				arg_497_1.text_.text = var_500_1
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_4 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_4 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_4

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_4 and arg_497_1.time_ < 0 + var_500_4 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play103903124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 103903124
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play103903125(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1039ui_story"]) and arg_501_1.var_.characterEffect1039ui_story == nil then
				arg_501_1.var_.characterEffect1039ui_story = arg_501_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.1

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1039ui_story"]) then
				if arg_501_1.var_.characterEffect1039ui_story and not isNil(arg_501_1.actors_["1039ui_story"]) then
					arg_501_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1039ui_story"]) and arg_501_1.var_.characterEffect1039ui_story then
				arg_501_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_504_2 = 0
			local var_504_3 = 0.7

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_2 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_4 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(103903124).content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_6 = 28 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_4) / 28)

				if (28 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_4) / 28)) > 0 and var_504_3 < var_504_6 then
					arg_501_1.talkMaxDuration = var_504_6

					if var_504_6 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_6 + var_504_2
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_7 = math.max(var_504_3, arg_501_1.talkMaxDuration)

			if var_504_2 <= arg_501_1.time_ and arg_501_1.time_ < var_504_2 + var_504_7 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_2) / var_504_7

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_2 + var_504_7 and arg_501_1.time_ < var_504_2 + var_504_7 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play103903125 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 103903125
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play103903126(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1039ui_story"]) and arg_505_1.var_.characterEffect1039ui_story == nil then
				arg_505_1.var_.characterEffect1039ui_story = arg_505_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.1

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1039ui_story"]) then
				if arg_505_1.var_.characterEffect1039ui_story and not isNil(arg_505_1.actors_["1039ui_story"]) then
					arg_505_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_0)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1039ui_story"]) and arg_505_1.var_.characterEffect1039ui_story then
				arg_505_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_508_1 = 0
			local var_508_2 = 0.525

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_3 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(103903125).content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 21 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 21)

				if (21 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 21)) > 0 and var_508_2 < var_508_5 then
					arg_505_1.talkMaxDuration = var_508_5

					if var_508_5 + var_508_1 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + var_508_1
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_6 = math.max(var_508_2, arg_505_1.talkMaxDuration)

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_6 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_1) / var_508_6

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_1 + var_508_6 and arg_505_1.time_ < var_508_1 + var_508_6 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play103903126 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 103903126
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play103903127(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 1.1

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(103903126).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 39 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 39)

				if (39 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 39)) > 0 and var_512_0 < var_512_3 then
					arg_509_1.talkMaxDuration = var_512_3

					if var_512_3 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_3 + 0
					end
				end

				arg_509_1.text_.text = var_512_1
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_4 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_4

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play103903127 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 103903127
		arg_513_1.duration_ = 6.93

		local var_513_0 = {
			ja = 6.933,
			ko = 4.366,
			zh = 4.366,
			en = 4.933
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play103903128(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1039ui_story"]) and arg_513_1.var_.characterEffect1039ui_story == nil then
				arg_513_1.var_.characterEffect1039ui_story = arg_513_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.1

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1039ui_story"]) then
				if arg_513_1.var_.characterEffect1039ui_story and not isNil(arg_513_1.actors_["1039ui_story"]) then
					arg_513_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1039ui_story"]) and arg_513_1.var_.characterEffect1039ui_story then
				arg_513_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_516_2 = arg_513_1.actors_["1039ui_story"].transform

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPos1039ui_story = var_516_2.localPosition
			end

			local var_516_3 = 0.001

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_3 then
				var_516_2.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_513_1.time_ - 0) / var_516_3)
				var_516_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_516_2.position).x, (manager.ui.mainCamera.transform.position - var_516_2.position).y, (manager.ui.mainCamera.transform.position - var_516_2.position).z)
				var_516_2.localEulerAngles.z = 0
				var_516_2.localEulerAngles.x = 0
				var_516_2.localEulerAngles = var_516_2.localEulerAngles
			end

			if arg_513_1.time_ >= 0 + var_516_3 and arg_513_1.time_ < 0 + var_516_3 + arg_516_0 then
				var_516_2.localPosition = Vector3.New(0, -1.06, -5.3)
				var_516_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_516_2.position).x, (manager.ui.mainCamera.transform.position - var_516_2.position).y, (manager.ui.mainCamera.transform.position - var_516_2.position).z)
				var_516_2.localEulerAngles.z = 0
				var_516_2.localEulerAngles.x = 0
				var_516_2.localEulerAngles = var_516_2.localEulerAngles
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_516_4 = 0
			local var_516_5 = 0.575

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_4 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_6 = arg_513_1:GetWordFromCfg(103903127)
				local var_516_7 = arg_513_1:FormatText(var_516_6.content)

				arg_513_1.text_.text = var_516_7

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_9 = 23 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 23)

				if (23 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 23)) > 0 and var_516_5 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9

					if var_516_9 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_4
					end
				end

				arg_513_1.text_.text = var_516_7
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb") ~= 0 then
					local var_516_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb") / 1000

					if var_516_10 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_10 + var_516_4
					end

					if var_516_6.prefab_name ~= "" and arg_513_1.actors_[var_516_6.prefab_name] ~= nil then
						local var_516_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_6.prefab_name].transform, "story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")

						arg_513_1:RecordAudio("103903127", var_516_11)
						arg_513_1:RecordAudio("103903127", var_516_11)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_12 = math.max(var_516_5, arg_513_1.talkMaxDuration)

			if var_516_4 <= arg_513_1.time_ and arg_513_1.time_ < var_516_4 + var_516_12 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_4) / var_516_12

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_4 + var_516_12 and arg_513_1.time_ < var_516_4 + var_516_12 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play103903128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 103903128
		arg_517_1.duration_ = 9.3

		local var_517_0 = {
			ja = 9.3,
			ko = 7.166,
			zh = 7.166,
			en = 5.333
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play103903129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_520_0 = 0
			local var_520_1 = 0.925

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_2 = arg_517_1:GetWordFromCfg(103903128)
				local var_520_3 = arg_517_1:FormatText(var_520_2.content)

				arg_517_1.text_.text = var_520_3

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 37 <= 0 and var_520_1 or var_520_1 * (utf8.len(var_520_3) / 37)

				if (37 <= 0 and var_520_1 or var_520_1 * (utf8.len(var_520_3) / 37)) > 0 and var_520_1 < var_520_5 then
					arg_517_1.talkMaxDuration = var_520_5

					if var_520_5 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_3
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb") ~= 0 then
					local var_520_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb") / 1000

					if var_520_6 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_0
					end

					if var_520_2.prefab_name ~= "" and arg_517_1.actors_[var_520_2.prefab_name] ~= nil then
						local var_520_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_2.prefab_name].transform, "story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")

						arg_517_1:RecordAudio("103903128", var_520_7)
						arg_517_1:RecordAudio("103903128", var_520_7)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_8 and arg_517_1.time_ < var_520_0 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play103903129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 103903129
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play103903130(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1039ui_story"]) and arg_521_1.var_.characterEffect1039ui_story == nil then
				arg_521_1.var_.characterEffect1039ui_story = arg_521_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.1

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1039ui_story"]) then
				if arg_521_1.var_.characterEffect1039ui_story and not isNil(arg_521_1.actors_["1039ui_story"]) then
					arg_521_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1039ui_story"]) and arg_521_1.var_.characterEffect1039ui_story then
				arg_521_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_524_1 = 0
			local var_524_2 = 0.9

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(103903129).content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 36 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 36)

				if (36 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 36)) > 0 and var_524_2 < var_524_5 then
					arg_521_1.talkMaxDuration = var_524_5

					if var_524_5 + var_524_1 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + var_524_1
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_6 = math.max(var_524_2, arg_521_1.talkMaxDuration)

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_6 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_1) / var_524_6

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_1 + var_524_6 and arg_521_1.time_ < var_524_1 + var_524_6 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play103903130 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 103903130
		arg_525_1.duration_ = 7.07

		local var_525_0 = {
			ja = 7.066,
			ko = 4.366,
			zh = 4.366,
			en = 6.166
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play103903131(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["1039ui_story"]) and arg_525_1.var_.characterEffect1039ui_story == nil then
				arg_525_1.var_.characterEffect1039ui_story = arg_525_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.1

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["1039ui_story"]) then
				if arg_525_1.var_.characterEffect1039ui_story and not isNil(arg_525_1.actors_["1039ui_story"]) then
					arg_525_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["1039ui_story"]) and arg_525_1.var_.characterEffect1039ui_story then
				arg_525_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_528_2 = 0
			local var_528_3 = 0.425

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_4 = arg_525_1:GetWordFromCfg(103903130)
				local var_528_5 = arg_525_1:FormatText(var_528_4.content)

				arg_525_1.text_.text = var_528_5

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_7 = 17 <= 0 and var_528_3 or var_528_3 * (utf8.len(var_528_5) / 17)

				if (17 <= 0 and var_528_3 or var_528_3 * (utf8.len(var_528_5) / 17)) > 0 and var_528_3 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_2 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_2
					end
				end

				arg_525_1.text_.text = var_528_5
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb") ~= 0 then
					local var_528_8 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb") / 1000

					if var_528_8 + var_528_2 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_8 + var_528_2
					end

					if var_528_4.prefab_name ~= "" and arg_525_1.actors_[var_528_4.prefab_name] ~= nil then
						local var_528_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_4.prefab_name].transform, "story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")

						arg_525_1:RecordAudio("103903130", var_528_9)
						arg_525_1:RecordAudio("103903130", var_528_9)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_10 = math.max(var_528_3, arg_525_1.talkMaxDuration)

			if var_528_2 <= arg_525_1.time_ and arg_525_1.time_ < var_528_2 + var_528_10 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_2) / var_528_10

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_2 + var_528_10 and arg_525_1.time_ < var_528_2 + var_528_10 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play103903131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 103903131
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play103903132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0.275

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_1 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(103903131).content)

				arg_529_1.text_.text = var_532_1

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_3 = 11 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 11)

				if (11 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 11)) > 0 and var_532_0 < var_532_3 then
					arg_529_1.talkMaxDuration = var_532_3

					if var_532_3 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_3 + 0
					end
				end

				arg_529_1.text_.text = var_532_1
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_4 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_4 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_4

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_4 and arg_529_1.time_ < 0 + var_532_4 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play103903132 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 103903132
		arg_533_1.duration_ = 5.37

		local var_533_0 = {
			ja = 5.366,
			ko = 3.4,
			zh = 3.4,
			en = 1.5
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play103903133(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_536_0 = 0
			local var_536_1 = 0.275

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_2 = arg_533_1:GetWordFromCfg(103903132)
				local var_536_3 = arg_533_1:FormatText(var_536_2.content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 11 <= 0 and var_536_1 or var_536_1 * (utf8.len(var_536_3) / 11)

				if (11 <= 0 and var_536_1 or var_536_1 * (utf8.len(var_536_3) / 11)) > 0 and var_536_1 < var_536_5 then
					arg_533_1.talkMaxDuration = var_536_5

					if var_536_5 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_3
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb") ~= 0 then
					local var_536_6 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb") / 1000

					if var_536_6 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_6 + var_536_0
					end

					if var_536_2.prefab_name ~= "" and arg_533_1.actors_[var_536_2.prefab_name] ~= nil then
						local var_536_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_2.prefab_name].transform, "story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")

						arg_533_1:RecordAudio("103903132", var_536_7)
						arg_533_1:RecordAudio("103903132", var_536_7)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_8 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_8 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_8

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_8 and arg_533_1.time_ < var_536_0 + var_536_8 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play103903133 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 103903133
		arg_537_1.duration_ = 0.1

		SetActive(arg_537_1.tipsGo_, true)

		arg_537_1.tipsText_.text = StoryTipsCfg[103901].name

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"

			SetActive(arg_537_1.choicesGo_, true)

			for iter_538_0, iter_538_1 in ipairs(arg_537_1.choices_) do
				SetActive(iter_538_1.go, iter_538_0 <= 2)
			end

			arg_537_1.choices_[1].txt.text = arg_537_1:FormatText(StoryChoiceCfg[76].name)
			arg_537_1.choices_[2].txt.text = arg_537_1:FormatText(StoryChoiceCfg[77].name)
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				PlayerAction.UseStoryTrigger(1039012, 210390103, 103903133, 1)
				arg_537_0:Play103903134(arg_537_1)
			end

			if arg_539_0 == 2 then
				arg_537_0:Play103903137(arg_537_1)
			end

			arg_537_1:RecordChoiceLog(103903133, 76, 77)
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(arg_537_1.actors_["1039ui_story"]) and arg_537_1.var_.characterEffect1039ui_story == nil then
				arg_537_1.var_.characterEffect1039ui_story = arg_537_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_0 = 0.1

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 and not isNil(arg_537_1.actors_["1039ui_story"]) then
				if arg_537_1.var_.characterEffect1039ui_story and not isNil(arg_537_1.actors_["1039ui_story"]) then
					arg_537_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_537_1.time_ - 0) / var_540_0)
				end
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 and not isNil(arg_537_1.actors_["1039ui_story"]) and arg_537_1.var_.characterEffect1039ui_story then
				arg_537_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play103903134 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 103903134
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play103903135(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1039ui_story = arg_541_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1039ui_story"].transform.position).z)
				arg_541_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1039ui_story"].transform.localEulerAngles = arg_541_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(10, -1.06, -5.3)
				arg_541_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1039ui_story"].transform.position).z)
				arg_541_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1039ui_story"].transform.localEulerAngles = arg_541_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_544_1 = 0
			local var_544_2 = 0.225

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(103903134).content)

				arg_541_1.text_.text = var_544_3

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 9 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 9)

				if (9 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 9)) > 0 and var_544_2 < var_544_5 then
					arg_541_1.talkMaxDuration = var_544_5

					if var_544_5 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_3
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_6 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_6 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_6

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_6 and arg_541_1.time_ < var_544_1 + var_544_6 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play103903135 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 103903135
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play103903136(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0.825

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_1 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(103903135).content)

				arg_545_1.text_.text = var_548_1

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_3 = 33 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 33)

				if (33 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 33)) > 0 and var_548_0 < var_548_3 then
					arg_545_1.talkMaxDuration = var_548_3

					if var_548_3 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_3 + 0
					end
				end

				arg_545_1.text_.text = var_548_1
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_4 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_4

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play103903136 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 103903136
		arg_549_1.duration_ = 7.15

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play103903142(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action468")
			end

			local var_552_0 = 0
			local var_552_1 = 0.325

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_2 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(103903136).content)

				arg_549_1.text_.text = var_552_2

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 13 <= 0 and var_552_1 or var_552_1 * (utf8.len(var_552_2) / 13)

				if (13 <= 0 and var_552_1 or var_552_1 * (utf8.len(var_552_2) / 13)) > 0 and var_552_1 < var_552_4 then
					arg_549_1.talkMaxDuration = var_552_4

					if var_552_4 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_4 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_2
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_5 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_5 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_5

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_5 and arg_549_1.time_ < var_552_0 + var_552_5 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play103903142 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 103903142
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play103903143(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1039ui_story"]) and arg_553_1.var_.characterEffect1039ui_story == nil then
				arg_553_1.var_.characterEffect1039ui_story = arg_553_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.1

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1039ui_story"]) then
				if arg_553_1.var_.characterEffect1039ui_story and not isNil(arg_553_1.actors_["1039ui_story"]) then
					arg_553_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_0)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1039ui_story"]) and arg_553_1.var_.characterEffect1039ui_story then
				arg_553_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_556_1 = 0
			local var_556_2 = 0.7

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_3 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(103903142).content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 28 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 28)

				if (28 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 28)) > 0 and var_556_2 < var_556_5 then
					arg_553_1.talkMaxDuration = var_556_5

					if var_556_5 + var_556_1 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_5 + var_556_1
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_6 = math.max(var_556_2, arg_553_1.talkMaxDuration)

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_6 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_1) / var_556_6

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_1 + var_556_6 and arg_553_1.time_ < var_556_1 + var_556_6 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play103903143 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 103903143
		arg_557_1.duration_ = 7.5

		local var_557_0 = {
			ja = 7.5,
			ko = 3.466,
			zh = 3.466,
			en = 4.133
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play103903144(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1039ui_story"]) and arg_557_1.var_.characterEffect1039ui_story == nil then
				arg_557_1.var_.characterEffect1039ui_story = arg_557_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.1

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1039ui_story"]) then
				if arg_557_1.var_.characterEffect1039ui_story and not isNil(arg_557_1.actors_["1039ui_story"]) then
					arg_557_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1039ui_story"]) and arg_557_1.var_.characterEffect1039ui_story then
				arg_557_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_560_2 = arg_557_1.actors_["1039ui_story"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos1039ui_story = var_560_2.localPosition
			end

			local var_560_3 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_3 then
				var_560_2.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_557_1.time_ - 0) / var_560_3)
				var_560_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_2.position).x, (manager.ui.mainCamera.transform.position - var_560_2.position).y, (manager.ui.mainCamera.transform.position - var_560_2.position).z)
				var_560_2.localEulerAngles.z = 0
				var_560_2.localEulerAngles.x = 0
				var_560_2.localEulerAngles = var_560_2.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_3 and arg_557_1.time_ < 0 + var_560_3 + arg_560_0 then
				var_560_2.localPosition = Vector3.New(0, -1.06, -5.3)
				var_560_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_2.position).x, (manager.ui.mainCamera.transform.position - var_560_2.position).y, (manager.ui.mainCamera.transform.position - var_560_2.position).z)
				var_560_2.localEulerAngles.z = 0
				var_560_2.localEulerAngles.x = 0
				var_560_2.localEulerAngles = var_560_2.localEulerAngles
			end

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action484")
			end

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_560_4 = 0
			local var_560_5 = 0.45

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_4 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_6 = arg_557_1:GetWordFromCfg(103903143)
				local var_560_7 = arg_557_1:FormatText(var_560_6.content)

				arg_557_1.text_.text = var_560_7

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_9 = 18 <= 0 and var_560_5 or var_560_5 * (utf8.len(var_560_7) / 18)

				if (18 <= 0 and var_560_5 or var_560_5 * (utf8.len(var_560_7) / 18)) > 0 and var_560_5 < var_560_9 then
					arg_557_1.talkMaxDuration = var_560_9

					if var_560_9 + var_560_4 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_9 + var_560_4
					end
				end

				arg_557_1.text_.text = var_560_7
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb") ~= 0 then
					local var_560_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb") / 1000

					if var_560_10 + var_560_4 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_10 + var_560_4
					end

					if var_560_6.prefab_name ~= "" and arg_557_1.actors_[var_560_6.prefab_name] ~= nil then
						local var_560_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_6.prefab_name].transform, "story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")

						arg_557_1:RecordAudio("103903143", var_560_11)
						arg_557_1:RecordAudio("103903143", var_560_11)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_12 = math.max(var_560_5, arg_557_1.talkMaxDuration)

			if var_560_4 <= arg_557_1.time_ and arg_557_1.time_ < var_560_4 + var_560_12 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_4) / var_560_12

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_4 + var_560_12 and arg_557_1.time_ < var_560_4 + var_560_12 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play103903144 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 103903144
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play103903145(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.475

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_1 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(103903144).content)

				arg_561_1.text_.text = var_564_1

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_3 = 19 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 19)

				if (19 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 19)) > 0 and var_564_0 < var_564_3 then
					arg_561_1.talkMaxDuration = var_564_3

					if var_564_3 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_3 + 0
					end
				end

				arg_561_1.text_.text = var_564_1
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_4 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_4

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play103903145 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 103903145
		arg_565_1.duration_ = 4.83

		local var_565_0 = {
			ja = 4.833,
			ko = 3.733,
			zh = 3.733,
			en = 4.666
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
			arg_565_1.auto_ = false
		end

		function arg_565_1.playNext_(arg_567_0)
			arg_565_1.onStoryFinished_()
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_568_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_565_1.bgmTxt_.text ~= var_568_2 and arg_565_1.bgmTxt_.text ~= "" then
						if arg_565_1.bgmTxt2_.text ~= "" then
							arg_565_1.bgmTxt_.text = arg_565_1.bgmTxt2_.text
						end

						arg_565_1.bgmTxt2_.text = var_568_2

						arg_565_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_565_1.bgmTxt_.text = var_568_2
						arg_565_1.bgmTxt2_.text = var_568_2
					end

					if arg_565_1.bgmTimer then
						arg_565_1.bgmTimer:Stop()

						arg_565_1.bgmTimer = nil
					end

					if arg_565_1.settingData.show_music_name == 1 then
						arg_565_1.musicController:SetSelectedState("show")
						arg_565_1.musicAnimator_:Play("open", 0, 0)

						if arg_565_1.settingData.music_time ~= 0 then
							arg_565_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_565_1.settingData.music_time), function()
								if arg_565_1 == nil or isNil(arg_565_1.bgmTxt_) then
									return
								end

								arg_565_1.musicController:SetSelectedState("hide")
								arg_565_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action442")
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_568_3 = 0
			local var_568_4 = 0.425

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_3 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_5 = arg_565_1:GetWordFromCfg(103903145)
				local var_568_6 = arg_565_1:FormatText(var_568_5.content)

				arg_565_1.text_.text = var_568_6

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_8 = 17 <= 0 and var_568_4 or var_568_4 * (utf8.len(var_568_6) / 17)

				if (17 <= 0 and var_568_4 or var_568_4 * (utf8.len(var_568_6) / 17)) > 0 and var_568_4 < var_568_8 then
					arg_565_1.talkMaxDuration = var_568_8

					if var_568_8 + var_568_3 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_8 + var_568_3
					end
				end

				arg_565_1.text_.text = var_568_6
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb") ~= 0 then
					local var_568_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb") / 1000

					if var_568_9 + var_568_3 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_9 + var_568_3
					end

					if var_568_5.prefab_name ~= "" and arg_565_1.actors_[var_568_5.prefab_name] ~= nil then
						local var_568_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_5.prefab_name].transform, "story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")

						arg_565_1:RecordAudio("103903145", var_568_10)
						arg_565_1:RecordAudio("103903145", var_568_10)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_11 = math.max(var_568_4, arg_565_1.talkMaxDuration)

			if var_568_3 <= arg_565_1.time_ and arg_565_1.time_ < var_568_3 + var_568_11 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_3) / var_568_11

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_3 + var_568_11 and arg_565_1.time_ < var_568_3 + var_568_11 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play103903137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 103903137
		arg_570_1.duration_ = 3.6

		local var_570_0 = {
			ja = 2.266,
			ko = 2.533,
			zh = 2.533,
			en = 3.6
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play103903138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1039ui_story"]) and arg_570_1.var_.characterEffect1039ui_story == nil then
				arg_570_1.var_.characterEffect1039ui_story = arg_570_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.1

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1039ui_story"]) then
				if arg_570_1.var_.characterEffect1039ui_story and not isNil(arg_570_1.actors_["1039ui_story"]) then
					arg_570_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1039ui_story"]) and arg_570_1.var_.characterEffect1039ui_story then
				arg_570_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_573_2 = "1039ui_story"

			if arg_570_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_573_3 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_570_1.stage_.transform)

				var_573_3.name = var_573_2
				var_573_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_570_1.actors_[var_573_2] = var_573_3

				local var_573_4 = var_573_3:GetComponentInChildren(typeof(CharacterEffect))

				var_573_4.enabled = true

				local var_573_5 = GameObjectTools.GetOrAddComponent(var_573_3, typeof(DynamicBoneHelper))

				if var_573_5 then
					var_573_5:EnableDynamicBone(false)
				end

				arg_570_1:ShowWeapon(var_573_4.transform, false)

				arg_570_1.var_[var_573_2 .. "Animator"] = var_573_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_570_1.var_[var_573_2 .. "Animator"].applyRootMotion = true
				arg_570_1.var_[var_573_2 .. "LipSync"] = var_573_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action463")
			end

			local var_573_6 = "1039ui_story"

			if arg_570_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_573_7 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_570_1.stage_.transform)

				var_573_7.name = var_573_6
				var_573_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_570_1.actors_[var_573_6] = var_573_7

				local var_573_8 = var_573_7:GetComponentInChildren(typeof(CharacterEffect))

				var_573_8.enabled = true

				local var_573_9 = GameObjectTools.GetOrAddComponent(var_573_7, typeof(DynamicBoneHelper))

				if var_573_9 then
					var_573_9:EnableDynamicBone(false)
				end

				arg_570_1:ShowWeapon(var_573_8.transform, false)

				arg_570_1.var_[var_573_6 .. "Animator"] = var_573_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_570_1.var_[var_573_6 .. "Animator"].applyRootMotion = true
				arg_570_1.var_[var_573_6 .. "LipSync"] = var_573_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_573_10 = 0
			local var_573_11 = 0.2

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_10 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_12 = arg_570_1:GetWordFromCfg(103903137)
				local var_573_13 = arg_570_1:FormatText(var_573_12.content)

				arg_570_1.text_.text = var_573_13

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_15 = 8 <= 0 and var_573_11 or var_573_11 * (utf8.len(var_573_13) / 8)

				if (8 <= 0 and var_573_11 or var_573_11 * (utf8.len(var_573_13) / 8)) > 0 and var_573_11 < var_573_15 then
					arg_570_1.talkMaxDuration = var_573_15

					if var_573_15 + var_573_10 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_15 + var_573_10
					end
				end

				arg_570_1.text_.text = var_573_13
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb") ~= 0 then
					local var_573_16 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb") / 1000

					if var_573_16 + var_573_10 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_16 + var_573_10
					end

					if var_573_12.prefab_name ~= "" and arg_570_1.actors_[var_573_12.prefab_name] ~= nil then
						local var_573_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_12.prefab_name].transform, "story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")

						arg_570_1:RecordAudio("103903137", var_573_17)
						arg_570_1:RecordAudio("103903137", var_573_17)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_18 = math.max(var_573_11, arg_570_1.talkMaxDuration)

			if var_573_10 <= arg_570_1.time_ and arg_570_1.time_ < var_573_10 + var_573_18 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_10) / var_573_18

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_10 + var_573_18 and arg_570_1.time_ < var_573_10 + var_573_18 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play103903138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 103903138
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play103903139(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 1.025

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

				local var_577_1 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(103903138).content)

				arg_574_1.text_.text = var_577_1

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_3 = 41 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 41)

				if (41 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 41)) > 0 and var_577_0 < var_577_3 then
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
	Play103903139 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 103903139
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play103903140(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(arg_578_1.actors_["1039ui_story"]) and arg_578_1.var_.characterEffect1039ui_story == nil then
				arg_578_1.var_.characterEffect1039ui_story = arg_578_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_0 = 0.1

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 and not isNil(arg_578_1.actors_["1039ui_story"]) then
				if arg_578_1.var_.characterEffect1039ui_story and not isNil(arg_578_1.actors_["1039ui_story"]) then
					arg_578_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_578_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_578_1.time_ - 0) / var_581_0)
				end
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 and not isNil(arg_578_1.actors_["1039ui_story"]) and arg_578_1.var_.characterEffect1039ui_story then
				arg_578_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_578_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_581_1 = 0
			local var_581_2 = 0.4

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_3 = arg_578_1:FormatText(arg_578_1:GetWordFromCfg(103903139).content)

				arg_578_1.text_.text = var_581_3

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_5 = 16 <= 0 and var_581_2 or var_581_2 * (utf8.len(var_581_3) / 16)

				if (16 <= 0 and var_581_2 or var_581_2 * (utf8.len(var_581_3) / 16)) > 0 and var_581_2 < var_581_5 then
					arg_578_1.talkMaxDuration = var_581_5

					if var_581_5 + var_581_1 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_5 + var_581_1
					end
				end

				arg_578_1.text_.text = var_581_3
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_6 = math.max(var_581_2, arg_578_1.talkMaxDuration)

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_6 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_1) / var_581_6

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_1 + var_581_6 and arg_578_1.time_ < var_581_1 + var_581_6 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play103903140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 103903140
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play103903141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0.275

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_1 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(103903140).content)

				arg_582_1.text_.text = var_585_1

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_3 = 11 <= 0 and var_585_0 or var_585_0 * (utf8.len(var_585_1) / 11)

				if (11 <= 0 and var_585_0 or var_585_0 * (utf8.len(var_585_1) / 11)) > 0 and var_585_0 < var_585_3 then
					arg_582_1.talkMaxDuration = var_585_3

					if var_585_3 + 0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_3 + 0
					end
				end

				arg_582_1.text_.text = var_585_1
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_4 = math.max(var_585_0, arg_582_1.talkMaxDuration)

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_4 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - 0) / var_585_4

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= 0 + var_585_4 and arg_582_1.time_ < 0 + var_585_4 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play103903141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 103903141
		arg_586_1.duration_ = 5.37

		local var_586_0 = {
			ja = 5.366,
			ko = 3.933,
			zh = 3.933,
			en = 3.433
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play103903142(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 and not isNil(arg_586_1.actors_["1039ui_story"]) and arg_586_1.var_.characterEffect1039ui_story == nil then
				arg_586_1.var_.characterEffect1039ui_story = arg_586_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_0 = 0.1

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 and not isNil(arg_586_1.actors_["1039ui_story"]) then
				if arg_586_1.var_.characterEffect1039ui_story and not isNil(arg_586_1.actors_["1039ui_story"]) then
					arg_586_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 and not isNil(arg_586_1.actors_["1039ui_story"]) and arg_586_1.var_.characterEffect1039ui_story then
				arg_586_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action438")
			end

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_589_2 = 0
			local var_589_3 = 0.275

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_2 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_4 = arg_586_1:GetWordFromCfg(103903141)
				local var_589_5 = arg_586_1:FormatText(var_589_4.content)

				arg_586_1.text_.text = var_589_5

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_7 = 11 <= 0 and var_589_3 or var_589_3 * (utf8.len(var_589_5) / 11)

				if (11 <= 0 and var_589_3 or var_589_3 * (utf8.len(var_589_5) / 11)) > 0 and var_589_3 < var_589_7 then
					arg_586_1.talkMaxDuration = var_589_7

					if var_589_7 + var_589_2 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_7 + var_589_2
					end
				end

				arg_586_1.text_.text = var_589_5
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb") ~= 0 then
					local var_589_8 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb") / 1000

					if var_589_8 + var_589_2 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_8 + var_589_2
					end

					if var_589_4.prefab_name ~= "" and arg_586_1.actors_[var_589_4.prefab_name] ~= nil then
						local var_589_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_4.prefab_name].transform, "story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")

						arg_586_1:RecordAudio("103903141", var_589_9)
						arg_586_1:RecordAudio("103903141", var_589_9)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_10 = math.max(var_589_3, arg_586_1.talkMaxDuration)

			if var_589_2 <= arg_586_1.time_ and arg_586_1.time_ < var_589_2 + var_589_10 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_2) / var_589_10

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_2 + var_589_10 and arg_586_1.time_ < var_589_2 + var_589_10 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/D04a",
		"TextureConfig/Background/ST01"
	},
	voices = {
		"story_v_side_old_103903.awb"
	}
}
