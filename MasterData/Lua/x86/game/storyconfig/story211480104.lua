return {
	Play114804001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114804001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114804002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13a")
				var_4_0.name = "B13a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13a

				arg_1_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.B13a:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueB13a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueB13a = var_4_4
				end

				arg_1_1.var_.alphaOldValueB13a = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueB13a then
					arg_1_1.var_.alphaMatValueB13a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13a, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueB13a.color = arg_1_1.var_.alphaMatValueB13a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueB13a then
				arg_1_1.var_.alphaMatValueB13a.color.a = 1
				arg_1_1.var_.alphaMatValueB13a.color = arg_1_1.var_.alphaMatValueB13a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			local var_4_12 = 2
			local var_4_13 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(114804001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 32 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 32)

				if (32 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 32)) > 0 and var_4_13 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_12 = var_4_12 + 0.3

					if var_4_17 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_18 = var_4_12 + 0.3
			local var_4_19 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114804002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114804002
		arg_9_1.duration_ = 5.27

		local var_9_0 = {
			ja = 4.233,
			ko = 5.266,
			zh = 4.4,
			en = 3.733
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
				arg_9_0:Play114804003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1019ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1019ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1019ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1019ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1019ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1019ui_story = var_12_3.localPosition

				arg_9_1:ShowWeapon(arg_9_1.var_["1019ui_story" .. "Animator"].transform, false)
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1019ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1019ui_story == nil then
				arg_9_1.var_.characterEffect1019ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1019ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1019ui_story then
				arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_9_1.time_ and arg_9_1.time_ <= 0.0166666666666667 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0.0166666666666667 < arg_9_1.time_ and arg_9_1.time_ <= 0.0166666666666667 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.475

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(114804002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 19 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 19)

				if (19 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 19)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb")

						arg_9_1:RecordAudio("114804002", var_12_15)
						arg_9_1:RecordAudio("114804002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114804003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114804003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114804004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1019ui_story"]) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = arg_13_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1019ui_story"]) then
				if arg_13_1.var_.characterEffect1019ui_story and not isNil(arg_13_1.actors_["1019ui_story"]) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1019ui_story"]) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_16_1 = 0
			local var_16_2 = 0.35

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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(114804003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 14 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 14)

				if (14 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 14)) > 0 and var_16_2 < var_16_5 then
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
	Play114804004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114804004
		arg_17_1.duration_ = 3.77

		local var_17_0 = {
			ja = 3.766,
			ko = 3.266,
			zh = 2.633,
			en = 2.4
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
				arg_17_0:Play114804005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1019ui_story"]) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = arg_17_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1019ui_story"]) then
				if arg_17_1.var_.characterEffect1019ui_story and not isNil(arg_17_1.actors_["1019ui_story"]) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1019ui_story"]) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(114804004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 11 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 11)

				if (11 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 11)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb")

						arg_17_1:RecordAudio("114804004", var_20_9)
						arg_17_1:RecordAudio("114804004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114804005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114804005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114804006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) and arg_21_1.var_.characterEffect1019ui_story == nil then
				arg_21_1.var_.characterEffect1019ui_story = arg_21_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) then
				if arg_21_1.var_.characterEffect1019ui_story and not isNil(arg_21_1.actors_["1019ui_story"]) then
					arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) and arg_21_1.var_.characterEffect1019ui_story then
				arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_24_1 = 0
			local var_24_2 = 1.575

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(114804005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 63 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 63)

				if (63 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 63)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114804006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114804006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114804007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_28_0 = 0
			local var_28_1 = 0.6

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(114804006).content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 24 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_2) / 24)

				if (24 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_2) / 24)) > 0 and var_28_1 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_5 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_5 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_5

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_5 and arg_25_1.time_ < var_28_0 + var_28_5 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114804007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114804007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play114804008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_32_0 = 0
			local var_32_1 = 0.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
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

				local var_32_2 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(114804007).content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 9 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_2) / 9)

				if (9 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_2) / 9)) > 0 and var_32_1 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_5 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_5 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_5

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_5 and arg_29_1.time_ < var_32_0 + var_32_5 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114804008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114804008
		arg_33_1.duration_ = 7.77

		local var_33_0 = {
			ja = 7.766,
			ko = 6.033,
			zh = 5.7,
			en = 4.733
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
				arg_33_0:Play114804009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1019ui_story"]) and arg_33_1.var_.characterEffect1019ui_story == nil then
				arg_33_1.var_.characterEffect1019ui_story = arg_33_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1019ui_story"]) then
				if arg_33_1.var_.characterEffect1019ui_story and not isNil(arg_33_1.actors_["1019ui_story"]) then
					arg_33_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1019ui_story"]) and arg_33_1.var_.characterEffect1019ui_story then
				arg_33_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action454")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_36_2 = 0
			local var_36_3 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(114804008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 21 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 21)

				if (21 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 21)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb")

						arg_33_1:RecordAudio("114804008", var_36_9)
						arg_33_1:RecordAudio("114804008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114804009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114804009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play114804010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1019ui_story"]) and arg_37_1.var_.characterEffect1019ui_story == nil then
				arg_37_1.var_.characterEffect1019ui_story = arg_37_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1019ui_story"]) then
				if arg_37_1.var_.characterEffect1019ui_story and not isNil(arg_37_1.actors_["1019ui_story"]) then
					arg_37_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1019ui_story"]) and arg_37_1.var_.characterEffect1019ui_story then
				arg_37_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_40_1 = 0
			local var_40_2 = 0.35

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

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(114804009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 14 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 14)

				if (14 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 14)) > 0 and var_40_2 < var_40_5 then
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114804010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114804010
		arg_41_1.duration_ = 10.43

		local var_41_0 = {
			ja = 10.433,
			ko = 7.6,
			zh = 6.2,
			en = 7.966
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
				arg_41_0:Play114804011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story == nil then
				arg_41_1.var_.characterEffect1019ui_story = arg_41_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) then
				if arg_41_1.var_.characterEffect1019ui_story and not isNil(arg_41_1.actors_["1019ui_story"]) then
					arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story then
				arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action442")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_2 = 0
			local var_44_3 = 0.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(114804010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 29 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 29)

				if (29 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 29)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb")

						arg_41_1:RecordAudio("114804010", var_44_9)
						arg_41_1:RecordAudio("114804010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb")
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
	Play114804011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114804011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114804012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1019ui_story"]) and arg_45_1.var_.characterEffect1019ui_story == nil then
				arg_45_1.var_.characterEffect1019ui_story = arg_45_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1019ui_story"]) then
				if arg_45_1.var_.characterEffect1019ui_story and not isNil(arg_45_1.actors_["1019ui_story"]) then
					arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1019ui_story"]) and arg_45_1.var_.characterEffect1019ui_story then
				arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_48_1 = 0
			local var_48_2 = 0.275

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

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(114804011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)

				if (11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)) > 0 and var_48_2 < var_48_5 then
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
	Play114804012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114804012
		arg_49_1.duration_ = 4.2

		local var_49_0 = {
			ja = 4.2,
			ko = 3.266,
			zh = 3.366,
			en = 3.3
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
				arg_49_0:Play114804013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1019ui_story"]) and arg_49_1.var_.characterEffect1019ui_story == nil then
				arg_49_1.var_.characterEffect1019ui_story = arg_49_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1019ui_story"]) then
				if arg_49_1.var_.characterEffect1019ui_story and not isNil(arg_49_1.actors_["1019ui_story"]) then
					arg_49_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1019ui_story"]) and arg_49_1.var_.characterEffect1019ui_story then
				arg_49_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action426")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.325

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(114804012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 13 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 13)

				if (13 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 13)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb")

						arg_49_1:RecordAudio("114804012", var_52_9)
						arg_49_1:RecordAudio("114804012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114804013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114804013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114804014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1019ui_story"]) and arg_53_1.var_.characterEffect1019ui_story == nil then
				arg_53_1.var_.characterEffect1019ui_story = arg_53_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1019ui_story"]) then
				if arg_53_1.var_.characterEffect1019ui_story and not isNil(arg_53_1.actors_["1019ui_story"]) then
					arg_53_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1019ui_story"]) and arg_53_1.var_.characterEffect1019ui_story then
				arg_53_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_56_1 = 0
			local var_56_2 = 0.75

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(114804013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 30 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 30)

				if (30 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 30)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114804014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114804014
		arg_57_1.duration_ = 5.73

		local var_57_0 = {
			ja = 5.733,
			ko = 4.033,
			zh = 3.533,
			en = 4.2
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
				arg_57_0:Play114804015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1019ui_story"]) and arg_57_1.var_.characterEffect1019ui_story == nil then
				arg_57_1.var_.characterEffect1019ui_story = arg_57_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1019ui_story"]) then
				if arg_57_1.var_.characterEffect1019ui_story and not isNil(arg_57_1.actors_["1019ui_story"]) then
					arg_57_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1019ui_story"]) and arg_57_1.var_.characterEffect1019ui_story then
				arg_57_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_60_2 = 0
			local var_60_3 = 0.475

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(114804014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 19 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 19)

				if (19 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 19)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb")

						arg_57_1:RecordAudio("114804014", var_60_9)
						arg_57_1:RecordAudio("114804014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114804015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114804015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114804016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1019ui_story"]) and arg_61_1.var_.characterEffect1019ui_story == nil then
				arg_61_1.var_.characterEffect1019ui_story = arg_61_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1019ui_story"]) then
				if arg_61_1.var_.characterEffect1019ui_story and not isNil(arg_61_1.actors_["1019ui_story"]) then
					arg_61_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1019ui_story"]) and arg_61_1.var_.characterEffect1019ui_story then
				arg_61_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_64_1 = 0
			local var_64_2 = 0.05

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(114804015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 2 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 2)

				if (2 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 2)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114804016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114804016
		arg_65_1.duration_ = 13.73

		local var_65_0 = {
			ja = 13.733,
			ko = 9.833,
			zh = 8.766,
			en = 9.933
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
				arg_65_0:Play114804017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1019ui_story"]) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = arg_65_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1019ui_story"]) then
				if arg_65_1.var_.characterEffect1019ui_story and not isNil(arg_65_1.actors_["1019ui_story"]) then
					arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1019ui_story"]) and arg_65_1.var_.characterEffect1019ui_story then
				arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action453")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_2 = 0
			local var_68_3 = 1.025

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
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

				local var_68_4 = arg_65_1:GetWordFromCfg(114804016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 41 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 41)

				if (41 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 41)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb")

						arg_65_1:RecordAudio("114804016", var_68_9)
						arg_65_1:RecordAudio("114804016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114804017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114804017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114804018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) and arg_69_1.var_.characterEffect1019ui_story == nil then
				arg_69_1.var_.characterEffect1019ui_story = arg_69_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) then
				if arg_69_1.var_.characterEffect1019ui_story and not isNil(arg_69_1.actors_["1019ui_story"]) then
					arg_69_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) and arg_69_1.var_.characterEffect1019ui_story then
				arg_69_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_1 = 0
			local var_72_2 = 0.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(114804017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 6 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 6)

				if (6 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 6)) > 0 and var_72_2 < var_72_5 then
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
	Play114804018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114804018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114804019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action435")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_76_0 = 0
			local var_76_1 = 0.875

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(114804018).content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 35 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_2) / 35)

				if (35 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_2) / 35)) > 0 and var_76_1 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_5 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_5 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_5

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_5 and arg_73_1.time_ < var_76_0 + var_76_5 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114804019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114804019
		arg_77_1.duration_ = 6.03

		local var_77_0 = {
			ja = 6.033,
			ko = 4.366,
			zh = 5.666,
			en = 5.133
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
				arg_77_0:Play114804020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) and arg_77_1.var_.characterEffect1019ui_story == nil then
				arg_77_1.var_.characterEffect1019ui_story = arg_77_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) then
				if arg_77_1.var_.characterEffect1019ui_story and not isNil(arg_77_1.actors_["1019ui_story"]) then
					arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) and arg_77_1.var_.characterEffect1019ui_story then
				arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_80_2 = 0
			local var_80_3 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(114804019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 17 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 17)

				if (17 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 17)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb")

						arg_77_1:RecordAudio("114804019", var_80_9)
						arg_77_1:RecordAudio("114804019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114804020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114804020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114804021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1019ui_story = arg_81_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1019ui_story"].transform.position).z)
				arg_81_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1019ui_story"].transform.localEulerAngles = arg_81_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1019ui_story"].transform.position).z)
				arg_81_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1019ui_story"].transform.localEulerAngles = arg_81_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_84_1 = 0
			local var_84_2 = 1.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(114804020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 55 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 55)

				if (55 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 55)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play114804021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114804021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114804022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_88_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_85_1.stage_.transform)

				var_88_0.name = "1148ui_story"
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1148ui_story"] = var_88_0

				local var_88_1 = var_88_0:GetComponentInChildren(typeof(CharacterEffect))

				var_88_1.enabled = true

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_0, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end

				arg_85_1:ShowWeapon(var_88_1.transform, false)

				arg_85_1.var_["1148ui_story" .. "Animator"] = var_88_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_85_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_85_1.var_["1148ui_story" .. "LipSync"] = var_88_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_88_3 = arg_85_1.actors_["1148ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1148ui_story = var_88_3.localPosition

				arg_85_1:ShowWeapon(arg_85_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_85_1.time_ - 0) / var_88_4)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(0, -0.8, -6.2)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if 0.0166666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 0.0166666666666667 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0.0166666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 0.0166666666666667 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_88_5 = 0
			local var_88_6 = 0.725

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(114804021).content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 29 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_7) / 29)

				if (29 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_7) / 29)) > 0 and var_88_6 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_10 and arg_85_1.time_ < var_88_5 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play114804022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114804022
		arg_89_1.duration_ = 9.07

		local var_89_0 = {
			ja = 9.066,
			ko = 7.233,
			zh = 6.266,
			en = 8.366
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
				arg_89_0:Play114804023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1148ui_story"]) and arg_89_1.var_.characterEffect1148ui_story == nil then
				arg_89_1.var_.characterEffect1148ui_story = arg_89_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1148ui_story"]) then
				if arg_89_1.var_.characterEffect1148ui_story and not isNil(arg_89_1.actors_["1148ui_story"]) then
					arg_89_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1148ui_story"]) and arg_89_1.var_.characterEffect1148ui_story then
				arg_89_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_92_2 = 0
			local var_92_3 = 0.775

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(114804022)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 31 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 31)

				if (31 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 31)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb")

						arg_89_1:RecordAudio("114804022", var_92_9)
						arg_89_1:RecordAudio("114804022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114804023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114804023
		arg_93_1.duration_ = 6.33

		local var_93_0 = {
			ja = 4.733,
			ko = 4,
			zh = 4.1,
			en = 6.333
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
				arg_93_0:Play114804024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_96_0 = 0
			local var_96_1 = 0.45

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(114804023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 18 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 18)

				if (18 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 18)) > 0 and var_96_1 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb") ~= 0 then
					local var_96_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb") / 1000

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end

					if var_96_2.prefab_name ~= "" and arg_93_1.actors_[var_96_2.prefab_name] ~= nil then
						local var_96_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_2.prefab_name].transform, "story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb")

						arg_93_1:RecordAudio("114804023", var_96_7)
						arg_93_1:RecordAudio("114804023", var_96_7)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114804024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114804024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114804025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1148ui_story"]) and arg_97_1.var_.characterEffect1148ui_story == nil then
				arg_97_1.var_.characterEffect1148ui_story = arg_97_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1148ui_story"]) then
				if arg_97_1.var_.characterEffect1148ui_story and not isNil(arg_97_1.actors_["1148ui_story"]) then
					arg_97_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1148ui_story"]) and arg_97_1.var_.characterEffect1148ui_story then
				arg_97_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_100_1 = 0
			local var_100_2 = 0.65

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(114804024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 26 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 26)

				if (26 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 26)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114804025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114804025
		arg_101_1.duration_ = 8.5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114804026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.bgs_.ST02 == nil then
				local var_104_0 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_104_0.name = "ST02"
				var_104_0.transform.parent = arg_101_1.stage_.transform
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_.ST02 = var_104_0
			end

			if 1.5 < arg_101_1.time_ and arg_101_1.time_ <= 1.5 + arg_104_0 then
				local var_104_1 = arg_101_1.bgs_.ST02

				arg_101_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_2 = var_104_1:GetComponent("SpriteRenderer")

				if var_104_2 and var_104_2.sprite then
					local var_104_3 = 2 * (var_104_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_1.transform.localScale = Vector3.New(var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST02" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_4 = arg_101_1.actors_["1148ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1148ui_story = var_104_4.localPosition
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_5)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0, 100, 0)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_6 = arg_101_1.bgs_.B13a:GetComponent("SpriteRenderer")

				if var_104_6 then
					arg_101_1.var_.alphaOldValueB13a = var_104_6.color.a
					arg_101_1.var_.alphaMatValueB13a = var_104_6
				end

				arg_101_1.var_.alphaOldValueB13a = 1
			end

			local var_104_7 = 1.5

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				if arg_101_1.var_.alphaMatValueB13a then
					arg_101_1.var_.alphaMatValueB13a.color.a = Mathf.Lerp(arg_101_1.var_.alphaOldValueB13a, 0, (arg_101_1.time_ - 0) / var_104_7)
					arg_101_1.var_.alphaMatValueB13a.color = arg_101_1.var_.alphaMatValueB13a.color
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and arg_101_1.var_.alphaMatValueB13a then
				arg_101_1.var_.alphaMatValueB13a.color.a = 0
				arg_101_1.var_.alphaMatValueB13a.color = arg_101_1.var_.alphaMatValueB13a.color
			end

			if 1.5 < arg_101_1.time_ and arg_101_1.time_ <= 1.5 + arg_104_0 then
				local var_104_8 = arg_101_1.bgs_.ST02:GetComponent("SpriteRenderer")

				if var_104_8 then
					arg_101_1.var_.alphaOldValueST02 = var_104_8.color.a
					arg_101_1.var_.alphaMatValueST02 = var_104_8
				end

				arg_101_1.var_.alphaOldValueST02 = 0
			end

			local var_104_9 = 1.5

			if 1.5 <= arg_101_1.time_ and arg_101_1.time_ < 1.5 + var_104_9 then
				if arg_101_1.var_.alphaMatValueST02 then
					arg_101_1.var_.alphaMatValueST02.color.a = Mathf.Lerp(arg_101_1.var_.alphaOldValueST02, 1, (arg_101_1.time_ - 1.5) / var_104_9)
					arg_101_1.var_.alphaMatValueST02.color = arg_101_1.var_.alphaMatValueST02.color
				end
			end

			if arg_101_1.time_ >= 1.5 + var_104_9 and arg_101_1.time_ < 1.5 + var_104_9 + arg_104_0 and arg_101_1.var_.alphaMatValueST02 then
				arg_101_1.var_.alphaMatValueST02.color.a = 1
				arg_101_1.var_.alphaMatValueST02.color = arg_101_1.var_.alphaMatValueST02.color
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_10 = 3.5
			local var_104_11 = 1.025

			if 3.5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_12 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_12:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_13 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(114804025).content)

				arg_101_1.text_.text = var_104_13

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_15 = 41 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 41)

				if (41 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 41)) > 0 and var_104_11 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15
					var_104_10 = var_104_10 + 0.3

					if var_104_15 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_10
					end
				end

				arg_101_1.text_.text = var_104_13
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = var_104_10 + 0.3
			local var_104_17 = math.max(var_104_11, arg_101_1.talkMaxDuration)

			if var_104_10 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_16) / var_104_17

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play114804026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114804026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play114804027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.7

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(114804026).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 28 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 28)

				if (28 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 28)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114804027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114804027
		arg_111_1.duration_ = 6.3

		local var_111_0 = {
			ja = 5.133,
			ko = 5.7,
			zh = 6.3,
			en = 5.4
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play114804028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1148ui_story = arg_111_1.actors_["1148ui_story"].transform.localPosition

				arg_111_1:ShowWeapon(arg_111_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).z)
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles = arg_111_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_111_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).z)
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles = arg_111_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["1148ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1148ui_story == nil then
				arg_111_1.var_.characterEffect1148ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect1148ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1148ui_story then
				arg_111_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 0.0166666666666667 + arg_114_0 then
				arg_111_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			if 0.0166666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 0.0166666666666667 + arg_114_0 then
				arg_111_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_114_4 = 0
			local var_114_5 = 0.7

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(114804027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 28 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 28)

				if (28 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 28)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb")

						arg_111_1:RecordAudio("114804027", var_114_11)
						arg_111_1:RecordAudio("114804027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play114804028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114804028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play114804029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_118_0 = 0
			local var_118_1 = 0.325

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(114804028).content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 13 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_2) / 13)

				if (13 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_2) / 13)) > 0 and var_118_1 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_5 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_5 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_5

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_5 and arg_115_1.time_ < var_118_0 + var_118_5 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play114804029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114804029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play114804030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1148ui_story"]) and arg_119_1.var_.characterEffect1148ui_story == nil then
				arg_119_1.var_.characterEffect1148ui_story = arg_119_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1148ui_story"]) then
				if arg_119_1.var_.characterEffect1148ui_story and not isNil(arg_119_1.actors_["1148ui_story"]) then
					arg_119_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1148ui_story"]) and arg_119_1.var_.characterEffect1148ui_story then
				arg_119_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_122_1 = 0
			local var_122_2 = 0.175

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(114804029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 7 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 7)

				if (7 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 7)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114804030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114804030
		arg_123_1.duration_ = 3.8

		local var_123_0 = {
			ja = 1.999999999999,
			ko = 3.8,
			zh = 3.266,
			en = 3.166
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114804031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1148ui_story"]) and arg_123_1.var_.characterEffect1148ui_story == nil then
				arg_123_1.var_.characterEffect1148ui_story = arg_123_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1148ui_story"]) then
				if arg_123_1.var_.characterEffect1148ui_story and not isNil(arg_123_1.actors_["1148ui_story"]) then
					arg_123_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1148ui_story"]) and arg_123_1.var_.characterEffect1148ui_story then
				arg_123_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_126_2 = 0
			local var_126_3 = 0.225

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(114804030)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 9 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 9)

				if (9 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 9)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb")

						arg_123_1:RecordAudio("114804030", var_126_9)
						arg_123_1:RecordAudio("114804030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114804031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114804031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play114804032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1148ui_story"]) and arg_127_1.var_.characterEffect1148ui_story == nil then
				arg_127_1.var_.characterEffect1148ui_story = arg_127_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1148ui_story"]) then
				if arg_127_1.var_.characterEffect1148ui_story and not isNil(arg_127_1.actors_["1148ui_story"]) then
					arg_127_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1148ui_story"]) and arg_127_1.var_.characterEffect1148ui_story then
				arg_127_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_130_1 = 0
			local var_130_2 = 0.325

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(114804031).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 13 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 13)

				if (13 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 13)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114804032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114804032
		arg_131_1.duration_ = 10

		local var_131_0 = {
			ja = 10,
			ko = 5.5,
			zh = 4,
			en = 4.6
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114804033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1148ui_story"]) and arg_131_1.var_.characterEffect1148ui_story == nil then
				arg_131_1.var_.characterEffect1148ui_story = arg_131_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1148ui_story"]) then
				if arg_131_1.var_.characterEffect1148ui_story and not isNil(arg_131_1.actors_["1148ui_story"]) then
					arg_131_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1148ui_story"]) and arg_131_1.var_.characterEffect1148ui_story then
				arg_131_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_134_2 = 0
			local var_134_3 = 0.5

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(114804032)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 20 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 20)

				if (20 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 20)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb")

						arg_131_1:RecordAudio("114804032", var_134_9)
						arg_131_1:RecordAudio("114804032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114804033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114804033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play114804034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1148ui_story"]) and arg_135_1.var_.characterEffect1148ui_story == nil then
				arg_135_1.var_.characterEffect1148ui_story = arg_135_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1148ui_story"]) then
				if arg_135_1.var_.characterEffect1148ui_story and not isNil(arg_135_1.actors_["1148ui_story"]) then
					arg_135_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1148ui_story"]) and arg_135_1.var_.characterEffect1148ui_story then
				arg_135_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_138_1 = 0
			local var_138_2 = 0.6

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(114804033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 24 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 24)

				if (24 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 24)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play114804034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114804034
		arg_139_1.duration_ = 4.87

		local var_139_0 = {
			ja = 4.166,
			ko = 4.866,
			zh = 3.266,
			en = 3.833
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play114804035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1148ui_story"]) and arg_139_1.var_.characterEffect1148ui_story == nil then
				arg_139_1.var_.characterEffect1148ui_story = arg_139_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1148ui_story"]) then
				if arg_139_1.var_.characterEffect1148ui_story and not isNil(arg_139_1.actors_["1148ui_story"]) then
					arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1148ui_story"]) and arg_139_1.var_.characterEffect1148ui_story then
				arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_142_2 = 0
			local var_142_3 = 0.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:GetWordFromCfg(114804034)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 16 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 16)

				if (16 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 16)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb")

						arg_139_1:RecordAudio("114804034", var_142_9)
						arg_139_1:RecordAudio("114804034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114804035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114804035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114804036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1148ui_story"]) and arg_143_1.var_.characterEffect1148ui_story == nil then
				arg_143_1.var_.characterEffect1148ui_story = arg_143_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1148ui_story"]) then
				if arg_143_1.var_.characterEffect1148ui_story and not isNil(arg_143_1.actors_["1148ui_story"]) then
					arg_143_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1148ui_story"]) and arg_143_1.var_.characterEffect1148ui_story then
				arg_143_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_146_1 = 0
			local var_146_2 = 0.9

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(114804035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 36 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 36)

				if (36 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 36)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114804036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114804036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114804037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_150_0 = 0
			local var_150_1 = 0.725

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(114804036).content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 29 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_2) / 29)

				if (29 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_2) / 29)) > 0 and var_150_1 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_5 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_5 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_5

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_5 and arg_147_1.time_ < var_150_0 + var_150_5 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114804037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114804037
		arg_151_1.duration_ = 4.87

		local var_151_0 = {
			ja = 4.866,
			ko = 4.3,
			zh = 4.233,
			en = 4.6
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play114804038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1148ui_story"]) and arg_151_1.var_.characterEffect1148ui_story == nil then
				arg_151_1.var_.characterEffect1148ui_story = arg_151_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1148ui_story"]) then
				if arg_151_1.var_.characterEffect1148ui_story and not isNil(arg_151_1.actors_["1148ui_story"]) then
					arg_151_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1148ui_story"]) and arg_151_1.var_.characterEffect1148ui_story then
				arg_151_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_154_2 = 0
			local var_154_3 = 0.525

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:GetWordFromCfg(114804037)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 21 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 21)

				if (21 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 21)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb")

						arg_151_1:RecordAudio("114804037", var_154_9)
						arg_151_1:RecordAudio("114804037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114804038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114804038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play114804039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1148ui_story = arg_155_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1148ui_story"].transform.position).z)
				arg_155_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1148ui_story"].transform.localEulerAngles = arg_155_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1148ui_story"].transform.position).z)
				arg_155_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1148ui_story"].transform.localEulerAngles = arg_155_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_lamp", "")
			end

			local var_158_2 = 0
			local var_158_3 = 1.25

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(114804038).content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 50 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_4) / 50)

				if (50 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_4) / 50)) > 0 and var_158_3 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_7 and arg_155_1.time_ < var_158_2 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play114804039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114804039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114804040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.125

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(114804039).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 45 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 45)

				if (45 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 45)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114804040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114804040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play114804041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 1.425

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(114804040).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 57 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 57)

				if (57 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 57)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114804041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114804041
		arg_167_1.duration_ = 4.37

		local var_167_0 = {
			ja = 3.366,
			ko = 4.3,
			zh = 3.9,
			en = 4.366
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play114804042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.225

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(114804041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 9 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 9)

				if (9 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 9)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb")

						arg_167_1:RecordAudio("114804041", var_170_6)
						arg_167_1:RecordAudio("114804041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play114804042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114804042
		arg_171_1.duration_ = 2

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play114804043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1148ui_story = arg_171_1.actors_["1148ui_story"].transform.localPosition

				arg_171_1:ShowWeapon(arg_171_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1148ui_story"].transform.position).z)
				arg_171_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1148ui_story"].transform.localEulerAngles = arg_171_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_171_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1148ui_story"].transform.position).z)
				arg_171_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1148ui_story"].transform.localEulerAngles = arg_171_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if 0.0166666666666667 < arg_171_1.time_ and arg_171_1.time_ <= 0.0166666666666667 + arg_174_0 then
				arg_171_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_174_1 = arg_171_1.actors_["1148ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1148ui_story == nil then
				arg_171_1.var_.characterEffect1148ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1148ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1148ui_story then
				arg_171_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_171_1.time_ and arg_171_1.time_ <= 0.0166666666666667 + arg_174_0 then
				arg_171_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.075

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(114804042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 3 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 3)

				if (3 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 3)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb")

						arg_171_1:RecordAudio("114804042", var_174_11)
						arg_171_1:RecordAudio("114804042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play114804043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 114804043
		arg_175_1.duration_ = 10

		local var_175_0 = {
			ja = 10,
			ko = 4.766,
			zh = 7.166,
			en = 7.166
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play114804044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1148ui_story"]) and arg_175_1.var_.characterEffect1148ui_story == nil then
				arg_175_1.var_.characterEffect1148ui_story = arg_175_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1148ui_story"]) then
				if arg_175_1.var_.characterEffect1148ui_story and not isNil(arg_175_1.actors_["1148ui_story"]) then
					arg_175_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1148ui_story"]) and arg_175_1.var_.characterEffect1148ui_story then
				arg_175_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_178_1 = 0
			local var_178_2 = 0.35

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(114804043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_6 = 14 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 14)

				if (14 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 14)) > 0 and var_178_2 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb") ~= 0 then
					local var_178_7 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb") / 1000

					if var_178_7 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_1
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb")

						arg_175_1:RecordAudio("114804043", var_178_8)
						arg_175_1:RecordAudio("114804043", var_178_8)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_9 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_9 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_9

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_9 and arg_175_1.time_ < var_178_1 + var_178_9 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play114804044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 114804044
		arg_179_1.duration_ = 6.1

		local var_179_0 = {
			ja = 6.1,
			ko = 5.166,
			zh = 3.533,
			en = 3.466
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play114804045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1148ui_story"]) and arg_179_1.var_.characterEffect1148ui_story == nil then
				arg_179_1.var_.characterEffect1148ui_story = arg_179_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1148ui_story"]) then
				if arg_179_1.var_.characterEffect1148ui_story and not isNil(arg_179_1.actors_["1148ui_story"]) then
					arg_179_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1148ui_story"]) and arg_179_1.var_.characterEffect1148ui_story then
				arg_179_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_182_2 = 0
			local var_182_3 = 0.325

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(114804044)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 13 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 13)

				if (13 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 13)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb")

						arg_179_1:RecordAudio("114804044", var_182_9)
						arg_179_1:RecordAudio("114804044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play114804045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 114804045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play114804046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1148ui_story"]) and arg_183_1.var_.characterEffect1148ui_story == nil then
				arg_183_1.var_.characterEffect1148ui_story = arg_183_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1148ui_story"]) then
				if arg_183_1.var_.characterEffect1148ui_story and not isNil(arg_183_1.actors_["1148ui_story"]) then
					arg_183_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1148ui_story"]) and arg_183_1.var_.characterEffect1148ui_story then
				arg_183_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_186_1 = 0
			local var_186_2 = 0.775

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(114804045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 31 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 31)

				if (31 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 31)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play114804046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 114804046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play114804047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_190_0 = 0
			local var_190_1 = 1

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(114804046).content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 40 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_2) / 40)

				if (40 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_2) / 40)) > 0 and var_190_1 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_5 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_5 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_5

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_5 and arg_187_1.time_ < var_190_0 + var_190_5 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play114804047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 114804047
		arg_191_1.duration_ = 13.63

		local var_191_0 = {
			ja = 3.066,
			ko = 9.766,
			zh = 11.133,
			en = 13.633
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play114804048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_194_0 = 0
			local var_194_1 = 0.525

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(114804047)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 21 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 21)

				if (21 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 21)) > 0 and var_194_1 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb") ~= 0 then
					local var_194_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb") / 1000

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end

					if var_194_2.prefab_name ~= "" and arg_191_1.actors_[var_194_2.prefab_name] ~= nil then
						local var_194_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_2.prefab_name].transform, "story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb")

						arg_191_1:RecordAudio("114804047", var_194_7)
						arg_191_1:RecordAudio("114804047", var_194_7)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play114804048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114804048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play114804049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_198_0 = 0
			local var_198_1 = 1.275

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(114804048).content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 51 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_2) / 51)

				if (51 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_2) / 51)) > 0 and var_198_1 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_5 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_5 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_5

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_5 and arg_195_1.time_ < var_198_0 + var_198_5 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play114804049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114804049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play114804050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_202_0 = 0
			local var_202_1 = 0.725

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(114804049).content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 29 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_2) / 29)

				if (29 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_2) / 29)) > 0 and var_202_1 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_5 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_5 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_5

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_5 and arg_199_1.time_ < var_202_0 + var_202_5 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play114804050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114804050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play114804051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_206_0 = 0
			local var_206_1 = 0.6

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(114804050).content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 24 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_2) / 24)

				if (24 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_2) / 24)) > 0 and var_206_1 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_5 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_5 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_5

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_5 and arg_203_1.time_ < var_206_0 + var_206_5 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114804051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114804051
		arg_207_1.duration_ = 12

		local var_207_0 = {
			ja = 12,
			ko = 11.933,
			zh = 9.4,
			en = 9.733
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play114804052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1148ui_story = arg_207_1.actors_["1148ui_story"].transform.localPosition

				arg_207_1:ShowWeapon(arg_207_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1148ui_story"].transform.position).z)
				arg_207_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1148ui_story"].transform.localEulerAngles = arg_207_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1148ui_story"].transform.position).z)
				arg_207_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1148ui_story"].transform.localEulerAngles = arg_207_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1019ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1019ui_story = var_210_1.localPosition

				arg_207_1:ShowWeapon(arg_207_1.var_["1019ui_story" .. "Animator"].transform, false)
			end

			local var_210_2 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 then
				var_210_1.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_207_1.time_ - 0) / var_210_2)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 then
				var_210_1.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			local var_210_3 = arg_207_1.actors_["1019ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1019ui_story == nil then
				arg_207_1.var_.characterEffect1019ui_story = var_210_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_4 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 and not isNil(var_210_3) then
				if arg_207_1.var_.characterEffect1019ui_story and not isNil(var_210_3) then
					arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1019ui_story then
				arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_207_1.time_ and arg_207_1.time_ <= 0.0166666666666667 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action3_1")
			end

			if 0.0166666666666667 < arg_207_1.time_ and arg_207_1.time_ <= 0.0166666666666667 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_210_6 = 0
			local var_210_7 = 1.075

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(114804051)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 43 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 43)

				if (43 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 43)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb")

						arg_207_1:RecordAudio("114804051", var_210_13)
						arg_207_1:RecordAudio("114804051", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play114804052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114804052
		arg_211_1.duration_ = 7.47

		local var_211_0 = {
			ja = 7.466,
			ko = 6.333,
			zh = 5,
			en = 5.066
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play114804053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1019ui_story = arg_211_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1019ui_story"].transform.position).z)
				arg_211_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1019ui_story"].transform.localEulerAngles = arg_211_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1019ui_story"].transform.position).z)
				arg_211_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1019ui_story"].transform.localEulerAngles = arg_211_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_214_1 = "1066ui_story"

			if arg_211_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_214_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_211_1.stage_.transform)

				var_214_2.name = var_214_1
				var_214_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_[var_214_1] = var_214_2

				local var_214_3 = var_214_2:GetComponentInChildren(typeof(CharacterEffect))

				var_214_3.enabled = true

				local var_214_4 = GameObjectTools.GetOrAddComponent(var_214_2, typeof(DynamicBoneHelper))

				if var_214_4 then
					var_214_4:EnableDynamicBone(false)
				end

				arg_211_1:ShowWeapon(var_214_3.transform, false)

				arg_211_1.var_[var_214_1 .. "Animator"] = var_214_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_211_1.var_[var_214_1 .. "Animator"].applyRootMotion = true
				arg_211_1.var_[var_214_1 .. "LipSync"] = var_214_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_214_5 = arg_211_1.actors_["1066ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1066ui_story = var_214_5.localPosition

				arg_211_1:ShowWeapon(arg_211_1.var_["1066ui_story" .. "Animator"].transform, false)
			end

			local var_214_6 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 then
				var_214_5.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_211_1.time_ - 0) / var_214_6)
				var_214_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_5.position).x, (manager.ui.mainCamera.transform.position - var_214_5.position).y, (manager.ui.mainCamera.transform.position - var_214_5.position).z)
				var_214_5.localEulerAngles.z = 0
				var_214_5.localEulerAngles.x = 0
				var_214_5.localEulerAngles = var_214_5.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 then
				var_214_5.localPosition = Vector3.New(0, -0.77, -6.1)
				var_214_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_5.position).x, (manager.ui.mainCamera.transform.position - var_214_5.position).y, (manager.ui.mainCamera.transform.position - var_214_5.position).z)
				var_214_5.localEulerAngles.z = 0
				var_214_5.localEulerAngles.x = 0
				var_214_5.localEulerAngles = var_214_5.localEulerAngles
			end

			local var_214_7 = arg_211_1.actors_["1066ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.characterEffect1066ui_story == nil then
				arg_211_1.var_.characterEffect1066ui_story = var_214_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_8 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_8 and not isNil(var_214_7) then
				if arg_211_1.var_.characterEffect1066ui_story and not isNil(var_214_7) then
					arg_211_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_8 and arg_211_1.time_ < 0 + var_214_8 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.characterEffect1066ui_story then
				arg_211_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_211_1.time_ and arg_211_1.time_ <= 0.0166666666666667 + arg_214_0 then
				arg_211_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0.0166666666666667 < arg_211_1.time_ and arg_211_1.time_ <= 0.0166666666666667 + arg_214_0 then
				arg_211_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_214_10 = 0
			local var_214_11 = 0.625

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_12 = arg_211_1:GetWordFromCfg(114804052)
				local var_214_13 = arg_211_1:FormatText(var_214_12.content)

				arg_211_1.text_.text = var_214_13

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_15 = 25 <= 0 and var_214_11 or var_214_11 * (utf8.len(var_214_13) / 25)

				if (25 <= 0 and var_214_11 or var_214_11 * (utf8.len(var_214_13) / 25)) > 0 and var_214_11 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15

					if var_214_15 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_15 + var_214_10
					end
				end

				arg_211_1.text_.text = var_214_13
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb") ~= 0 then
					local var_214_16 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb") / 1000

					if var_214_16 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_16 + var_214_10
					end

					if var_214_12.prefab_name ~= "" and arg_211_1.actors_[var_214_12.prefab_name] ~= nil then
						local var_214_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_12.prefab_name].transform, "story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb")

						arg_211_1:RecordAudio("114804052", var_214_17)
						arg_211_1:RecordAudio("114804052", var_214_17)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_18 = math.max(var_214_11, arg_211_1.talkMaxDuration)

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_18 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_10) / var_214_18

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_10 + var_214_18 and arg_211_1.time_ < var_214_10 + var_214_18 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play114804053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114804053
		arg_215_1.duration_ = 8.37

		local var_215_0 = {
			ja = 8.366,
			ko = 6.6,
			zh = 5.466,
			en = 5.9
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114804054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1066ui_story = arg_215_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).z)
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles = arg_215_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).z)
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles = arg_215_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_218_1 = "1039ui_story"

			if arg_215_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_218_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_215_1.stage_.transform)

				var_218_2.name = var_218_1
				var_218_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.actors_[var_218_1] = var_218_2

				local var_218_3 = var_218_2:GetComponentInChildren(typeof(CharacterEffect))

				var_218_3.enabled = true

				local var_218_4 = GameObjectTools.GetOrAddComponent(var_218_2, typeof(DynamicBoneHelper))

				if var_218_4 then
					var_218_4:EnableDynamicBone(false)
				end

				arg_215_1:ShowWeapon(var_218_3.transform, false)

				arg_215_1.var_[var_218_1 .. "Animator"] = var_218_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_215_1.var_[var_218_1 .. "Animator"].applyRootMotion = true
				arg_215_1.var_[var_218_1 .. "LipSync"] = var_218_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_218_5 = arg_215_1.actors_["1039ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1039ui_story = var_218_5.localPosition

				arg_215_1:ShowWeapon(arg_215_1.var_["1039ui_story" .. "Animator"].transform, false)
			end

			local var_218_6 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 then
				var_218_5.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_215_1.time_ - 0) / var_218_6)
				var_218_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_5.position).x, (manager.ui.mainCamera.transform.position - var_218_5.position).y, (manager.ui.mainCamera.transform.position - var_218_5.position).z)
				var_218_5.localEulerAngles.z = 0
				var_218_5.localEulerAngles.x = 0
				var_218_5.localEulerAngles = var_218_5.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 then
				var_218_5.localPosition = Vector3.New(0, -1.01, -5.9)
				var_218_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_5.position).x, (manager.ui.mainCamera.transform.position - var_218_5.position).y, (manager.ui.mainCamera.transform.position - var_218_5.position).z)
				var_218_5.localEulerAngles.z = 0
				var_218_5.localEulerAngles.x = 0
				var_218_5.localEulerAngles = var_218_5.localEulerAngles
			end

			local var_218_7 = arg_215_1.actors_["1039ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.characterEffect1039ui_story == nil then
				arg_215_1.var_.characterEffect1039ui_story = var_218_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_8 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_8 and not isNil(var_218_7) then
				if arg_215_1.var_.characterEffect1039ui_story and not isNil(var_218_7) then
					arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_8 and arg_215_1.time_ < 0 + var_218_8 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.characterEffect1039ui_story then
				arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_215_1.time_ and arg_215_1.time_ <= 0.0166666666666667 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0.0166666666666667 < arg_215_1.time_ and arg_215_1.time_ <= 0.0166666666666667 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_218_10 = 0
			local var_218_11 = 0.675

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_12 = arg_215_1:GetWordFromCfg(114804053)
				local var_218_13 = arg_215_1:FormatText(var_218_12.content)

				arg_215_1.text_.text = var_218_13

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_15 = 27 <= 0 and var_218_11 or var_218_11 * (utf8.len(var_218_13) / 27)

				if (27 <= 0 and var_218_11 or var_218_11 * (utf8.len(var_218_13) / 27)) > 0 and var_218_11 < var_218_15 then
					arg_215_1.talkMaxDuration = var_218_15

					if var_218_15 + var_218_10 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_15 + var_218_10
					end
				end

				arg_215_1.text_.text = var_218_13
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb") ~= 0 then
					local var_218_16 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb") / 1000

					if var_218_16 + var_218_10 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_16 + var_218_10
					end

					if var_218_12.prefab_name ~= "" and arg_215_1.actors_[var_218_12.prefab_name] ~= nil then
						local var_218_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_12.prefab_name].transform, "story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb")

						arg_215_1:RecordAudio("114804053", var_218_17)
						arg_215_1:RecordAudio("114804053", var_218_17)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_18 = math.max(var_218_11, arg_215_1.talkMaxDuration)

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_18 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_10) / var_218_18

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_10 + var_218_18 and arg_215_1.time_ < var_218_10 + var_218_18 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play114804054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114804054
		arg_219_1.duration_ = 4.2

		local var_219_0 = {
			ja = 4.2,
			ko = 2.9,
			zh = 2.6,
			en = 4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play114804055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1039ui_story = arg_219_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).z)
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles = arg_219_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).z)
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles = arg_219_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_222_1 = "1084ui_story"

			if arg_219_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_222_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_219_1.stage_.transform)

				var_222_2.name = var_222_1
				var_222_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_[var_222_1] = var_222_2

				local var_222_3 = var_222_2:GetComponentInChildren(typeof(CharacterEffect))

				var_222_3.enabled = true

				local var_222_4 = GameObjectTools.GetOrAddComponent(var_222_2, typeof(DynamicBoneHelper))

				if var_222_4 then
					var_222_4:EnableDynamicBone(false)
				end

				arg_219_1:ShowWeapon(var_222_3.transform, false)

				arg_219_1.var_[var_222_1 .. "Animator"] = var_222_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_219_1.var_[var_222_1 .. "Animator"].applyRootMotion = true
				arg_219_1.var_[var_222_1 .. "LipSync"] = var_222_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_222_5 = arg_219_1.actors_["1084ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_5.localPosition

				arg_219_1:ShowWeapon(arg_219_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_222_6 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 then
				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_219_1.time_ - 0) / var_222_6)
				var_222_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_5.position).x, (manager.ui.mainCamera.transform.position - var_222_5.position).y, (manager.ui.mainCamera.transform.position - var_222_5.position).z)
				var_222_5.localEulerAngles.z = 0
				var_222_5.localEulerAngles.x = 0
				var_222_5.localEulerAngles = var_222_5.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(0, -0.97, -6)
				var_222_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_5.position).x, (manager.ui.mainCamera.transform.position - var_222_5.position).y, (manager.ui.mainCamera.transform.position - var_222_5.position).z)
				var_222_5.localEulerAngles.z = 0
				var_222_5.localEulerAngles.x = 0
				var_222_5.localEulerAngles = var_222_5.localEulerAngles
			end

			local var_222_7 = arg_219_1.actors_["1084ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_7) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_8 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_8 and not isNil(var_222_7) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_7) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_8 and arg_219_1.time_ < 0 + var_222_8 + arg_222_0 and not isNil(var_222_7) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_219_1.time_ and arg_219_1.time_ <= 0.0166666666666667 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0.0166666666666667 < arg_219_1.time_ and arg_219_1.time_ <= 0.0166666666666667 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:AudioAction("play", "music", "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_222_12 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if "" ~= "" then
					if arg_219_1.bgmTxt_.text ~= var_222_12 and arg_219_1.bgmTxt_.text ~= "" then
						if arg_219_1.bgmTxt2_.text ~= "" then
							arg_219_1.bgmTxt_.text = arg_219_1.bgmTxt2_.text
						end

						arg_219_1.bgmTxt2_.text = var_222_12

						arg_219_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_219_1.bgmTxt_.text = var_222_12
						arg_219_1.bgmTxt2_.text = var_222_12
					end

					if arg_219_1.bgmTimer then
						arg_219_1.bgmTimer:Stop()

						arg_219_1.bgmTimer = nil
					end

					if arg_219_1.settingData.show_music_name == 1 then
						arg_219_1.musicController:SetSelectedState("show")
						arg_219_1.musicAnimator_:Play("open", 0, 0)

						if arg_219_1.settingData.music_time ~= 0 then
							arg_219_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_219_1.settingData.music_time), function()
								if arg_219_1 == nil or isNil(arg_219_1.bgmTxt_) then
									return
								end

								arg_219_1.musicController:SetSelectedState("hide")
								arg_219_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_222_13 = 0
			local var_222_14 = 0.3

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_15 = arg_219_1:GetWordFromCfg(114804054)
				local var_222_16 = arg_219_1:FormatText(var_222_15.content)

				arg_219_1.text_.text = var_222_16

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_18 = 12 <= 0 and var_222_14 or var_222_14 * (utf8.len(var_222_16) / 12)

				if (12 <= 0 and var_222_14 or var_222_14 * (utf8.len(var_222_16) / 12)) > 0 and var_222_14 < var_222_18 then
					arg_219_1.talkMaxDuration = var_222_18

					if var_222_18 + var_222_13 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_18 + var_222_13
					end
				end

				arg_219_1.text_.text = var_222_16
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb") ~= 0 then
					local var_222_19 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb") / 1000

					if var_222_19 + var_222_13 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_19 + var_222_13
					end

					if var_222_15.prefab_name ~= "" and arg_219_1.actors_[var_222_15.prefab_name] ~= nil then
						local var_222_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_15.prefab_name].transform, "story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb")

						arg_219_1:RecordAudio("114804054", var_222_20)
						arg_219_1:RecordAudio("114804054", var_222_20)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_21 = math.max(var_222_14, arg_219_1.talkMaxDuration)

			if var_222_13 <= arg_219_1.time_ and arg_219_1.time_ < var_222_13 + var_222_21 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_13) / var_222_21

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_13 + var_222_21 and arg_219_1.time_ < var_222_13 + var_222_21 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play114804055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 114804055
		arg_224_1.duration_ = 5.9

		local var_224_0 = {
			ja = 5.9,
			ko = 5.9,
			zh = 5.1,
			en = 5.366
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
				arg_224_0:Play114804056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1084ui_story = arg_224_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_227_0 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 then
				arg_224_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_224_1.time_ - 0) / var_227_0)
				arg_224_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).z)
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles = arg_224_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 then
				arg_224_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).z)
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles = arg_224_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_227_1 = "1027ui_story"

			if arg_224_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_227_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_224_1.stage_.transform)

				var_227_2.name = var_227_1
				var_227_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_[var_227_1] = var_227_2

				local var_227_3 = var_227_2:GetComponentInChildren(typeof(CharacterEffect))

				var_227_3.enabled = true

				local var_227_4 = GameObjectTools.GetOrAddComponent(var_227_2, typeof(DynamicBoneHelper))

				if var_227_4 then
					var_227_4:EnableDynamicBone(false)
				end

				arg_224_1:ShowWeapon(var_227_3.transform, false)

				arg_224_1.var_[var_227_1 .. "Animator"] = var_227_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_224_1.var_[var_227_1 .. "Animator"].applyRootMotion = true
				arg_224_1.var_[var_227_1 .. "LipSync"] = var_227_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_227_5 = arg_224_1.actors_["1027ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1027ui_story = var_227_5.localPosition

				arg_224_1:ShowWeapon(arg_224_1.var_["1027ui_story" .. "Animator"].transform, false)
			end

			local var_227_6 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 then
				var_227_5.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_224_1.time_ - 0) / var_227_6)
				var_227_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_5.position).x, (manager.ui.mainCamera.transform.position - var_227_5.position).y, (manager.ui.mainCamera.transform.position - var_227_5.position).z)
				var_227_5.localEulerAngles.z = 0
				var_227_5.localEulerAngles.x = 0
				var_227_5.localEulerAngles = var_227_5.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 then
				var_227_5.localPosition = Vector3.New(0, -0.81, -5.8)
				var_227_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_5.position).x, (manager.ui.mainCamera.transform.position - var_227_5.position).y, (manager.ui.mainCamera.transform.position - var_227_5.position).z)
				var_227_5.localEulerAngles.z = 0
				var_227_5.localEulerAngles.x = 0
				var_227_5.localEulerAngles = var_227_5.localEulerAngles
			end

			local var_227_7 = arg_224_1.actors_["1027ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.characterEffect1027ui_story == nil then
				arg_224_1.var_.characterEffect1027ui_story = var_227_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_8 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_8 and not isNil(var_227_7) then
				if arg_224_1.var_.characterEffect1027ui_story and not isNil(var_227_7) then
					arg_224_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_8 and arg_224_1.time_ < 0 + var_227_8 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.characterEffect1027ui_story then
				arg_224_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_224_1.time_ and arg_224_1.time_ <= 0.0166666666666667 + arg_227_0 then
				arg_224_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0.0166666666666667 < arg_224_1.time_ and arg_224_1.time_ <= 0.0166666666666667 + arg_227_0 then
				arg_224_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_227_10 = 0
			local var_227_11 = 0.675

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_12 = arg_224_1:GetWordFromCfg(114804055)
				local var_227_13 = arg_224_1:FormatText(var_227_12.content)

				arg_224_1.text_.text = var_227_13

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_15 = 27 <= 0 and var_227_11 or var_227_11 * (utf8.len(var_227_13) / 27)

				if (27 <= 0 and var_227_11 or var_227_11 * (utf8.len(var_227_13) / 27)) > 0 and var_227_11 < var_227_15 then
					arg_224_1.talkMaxDuration = var_227_15

					if var_227_15 + var_227_10 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_15 + var_227_10
					end
				end

				arg_224_1.text_.text = var_227_13
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb") ~= 0 then
					local var_227_16 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb") / 1000

					if var_227_16 + var_227_10 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_16 + var_227_10
					end

					if var_227_12.prefab_name ~= "" and arg_224_1.actors_[var_227_12.prefab_name] ~= nil then
						local var_227_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_12.prefab_name].transform, "story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb")

						arg_224_1:RecordAudio("114804055", var_227_17)
						arg_224_1:RecordAudio("114804055", var_227_17)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_18 = math.max(var_227_11, arg_224_1.talkMaxDuration)

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_18 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_10) / var_227_18

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_10 + var_227_18 and arg_224_1.time_ < var_227_10 + var_227_18 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play114804056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 114804056
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play114804057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1027ui_story = arg_228_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1027ui_story"].transform.position).z)
				arg_228_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1027ui_story"].transform.localEulerAngles = arg_228_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1027ui_story"].transform.position).z)
				arg_228_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1027ui_story"].transform.localEulerAngles = arg_228_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_231_1 = 0
			local var_231_2 = 1.35

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_3 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(114804056).content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 54 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 54)

				if (54 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 54)) > 0 and var_231_2 < var_231_5 then
					arg_228_1.talkMaxDuration = var_231_5

					if var_231_5 + var_231_1 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + var_231_1
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_6 = math.max(var_231_2, arg_228_1.talkMaxDuration)

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_6 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_1) / var_231_6

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_1 + var_231_6 and arg_228_1.time_ < var_231_1 + var_231_6 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play114804057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 114804057
		arg_232_1.duration_ = 7.97

		local var_232_0 = {
			ja = 7.966,
			ko = 5.833,
			zh = 4.833,
			en = 6.266
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
				arg_232_0:Play114804058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1148ui_story = arg_232_1.actors_["1148ui_story"].transform.localPosition

				arg_232_1:ShowWeapon(arg_232_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).z)
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles = arg_232_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_232_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).z)
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles = arg_232_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1148ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1148ui_story == nil then
				arg_232_1.var_.characterEffect1148ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect1148ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1148ui_story then
				arg_232_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_232_1.time_ and arg_232_1.time_ <= 0.0166666666666667 + arg_235_0 then
				arg_232_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0.0166666666666667 < arg_232_1.time_ and arg_232_1.time_ <= 0.0166666666666667 + arg_235_0 then
				arg_232_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_235_4 = 0
			local var_235_5 = 0.425

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_6 = arg_232_1:GetWordFromCfg(114804057)
				local var_235_7 = arg_232_1:FormatText(var_235_6.content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 17 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 17)

				if (17 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 17)) > 0 and var_235_5 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb") ~= 0 then
					local var_235_10 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb") / 1000

					if var_235_10 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_4
					end

					if var_235_6.prefab_name ~= "" and arg_232_1.actors_[var_235_6.prefab_name] ~= nil then
						local var_235_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_6.prefab_name].transform, "story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb")

						arg_232_1:RecordAudio("114804057", var_235_11)
						arg_232_1:RecordAudio("114804057", var_235_11)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_12 and arg_232_1.time_ < var_235_4 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play114804058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 114804058
		arg_236_1.duration_ = 9.5

		local var_236_0 = {
			ja = 9.5,
			ko = 2.5,
			zh = 2.066,
			en = 2.1
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
				arg_236_0:Play114804059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_239_0 = 0
			local var_239_1 = 0.125

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_2 = arg_236_1:GetWordFromCfg(114804058)
				local var_239_3 = arg_236_1:FormatText(var_239_2.content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 5 <= 0 and var_239_1 or var_239_1 * (utf8.len(var_239_3) / 5)

				if (5 <= 0 and var_239_1 or var_239_1 * (utf8.len(var_239_3) / 5)) > 0 and var_239_1 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb") ~= 0 then
					local var_239_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb") / 1000

					if var_239_6 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_0
					end

					if var_239_2.prefab_name ~= "" and arg_236_1.actors_[var_239_2.prefab_name] ~= nil then
						local var_239_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_2.prefab_name].transform, "story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb")

						arg_236_1:RecordAudio("114804058", var_239_7)
						arg_236_1:RecordAudio("114804058", var_239_7)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_8 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_8 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_8

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_8 and arg_236_1.time_ < var_239_0 + var_239_8 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play114804059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 114804059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play114804060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1148ui_story"]) and arg_240_1.var_.characterEffect1148ui_story == nil then
				arg_240_1.var_.characterEffect1148ui_story = arg_240_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1148ui_story"]) then
				if arg_240_1.var_.characterEffect1148ui_story and not isNil(arg_240_1.actors_["1148ui_story"]) then
					arg_240_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1148ui_story"]) and arg_240_1.var_.characterEffect1148ui_story then
				arg_240_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_243_1 = 0
			local var_243_2 = 1.025

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(114804059).content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 41 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 41)

				if (41 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 41)) > 0 and var_243_2 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_6 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_6 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_6

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_6 and arg_240_1.time_ < var_243_1 + var_243_6 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play114804060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 114804060
		arg_244_1.duration_ = 5.6

		local var_244_0 = {
			ja = 5.366,
			ko = 3.833,
			zh = 5.6,
			en = 3.6
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
				arg_244_0:Play114804061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1148ui_story = arg_244_1.actors_["1148ui_story"].transform.localPosition

				arg_244_1:ShowWeapon(arg_244_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1148ui_story"].transform.position).z)
				arg_244_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1148ui_story"].transform.localEulerAngles = arg_244_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				arg_244_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1148ui_story"].transform.position).z)
				arg_244_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1148ui_story"].transform.localEulerAngles = arg_244_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1019ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1019ui_story = var_247_1.localPosition

				arg_244_1:ShowWeapon(arg_244_1.var_["1019ui_story" .. "Animator"].transform, false)
			end

			local var_247_2 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 then
				var_247_1.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_244_1.time_ - 0) / var_247_2)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 then
				var_247_1.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles
			end

			local var_247_3 = arg_244_1.actors_["1019ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect1019ui_story == nil then
				arg_244_1.var_.characterEffect1019ui_story = var_247_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_4 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 and not isNil(var_247_3) then
				if arg_244_1.var_.characterEffect1019ui_story and not isNil(var_247_3) then
					arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect1019ui_story then
				arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_244_1.time_ and arg_244_1.time_ <= 0.0166666666666667 + arg_247_0 then
				arg_244_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0.0166666666666667 < arg_244_1.time_ and arg_244_1.time_ <= 0.0166666666666667 + arg_247_0 then
				arg_244_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0.0166666666666667 < arg_244_1.time_ and arg_244_1.time_ <= 0.0166666666666667 + arg_247_0 then
				arg_244_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_247_6 = 0
			local var_247_7 = 0.4

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_8 = arg_244_1:GetWordFromCfg(114804060)
				local var_247_9 = arg_244_1:FormatText(var_247_8.content)

				arg_244_1.text_.text = var_247_9

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 16 <= 0 and var_247_7 or var_247_7 * (utf8.len(var_247_9) / 16)

				if (16 <= 0 and var_247_7 or var_247_7 * (utf8.len(var_247_9) / 16)) > 0 and var_247_7 < var_247_11 then
					arg_244_1.talkMaxDuration = var_247_11

					if var_247_11 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_9
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb") ~= 0 then
					local var_247_12 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb") / 1000

					if var_247_12 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_12 + var_247_6
					end

					if var_247_8.prefab_name ~= "" and arg_244_1.actors_[var_247_8.prefab_name] ~= nil then
						local var_247_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_8.prefab_name].transform, "story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb")

						arg_244_1:RecordAudio("114804060", var_247_13)
						arg_244_1:RecordAudio("114804060", var_247_13)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play114804061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 114804061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play114804062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1019ui_story"]) and arg_248_1.var_.characterEffect1019ui_story == nil then
				arg_248_1.var_.characterEffect1019ui_story = arg_248_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1019ui_story"]) then
				if arg_248_1.var_.characterEffect1019ui_story and not isNil(arg_248_1.actors_["1019ui_story"]) then
					arg_248_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_0)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1019ui_story"]) and arg_248_1.var_.characterEffect1019ui_story then
				arg_248_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_251_1 = 0
			local var_251_2 = 0.725

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(114804061).content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 29 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 29)

				if (29 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 29)) > 0 and var_251_2 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_6 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_6 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_6

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_6 and arg_248_1.time_ < var_251_1 + var_251_6 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play114804062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 114804062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play114804063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_255_0 = 0
			local var_255_1 = 0.925

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_2 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(114804062).content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 37 <= 0 and var_255_1 or var_255_1 * (utf8.len(var_255_2) / 37)

				if (37 <= 0 and var_255_1 or var_255_1 * (utf8.len(var_255_2) / 37)) > 0 and var_255_1 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_5 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_5 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_5

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_5 and arg_252_1.time_ < var_255_0 + var_255_5 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play114804063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 114804063
		arg_256_1.duration_ = 6.47

		local var_256_0 = {
			ja = 6.466,
			ko = 4.8,
			zh = 3.933,
			en = 5.133
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
				arg_256_0:Play114804064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1148ui_story"]) and arg_256_1.var_.characterEffect1148ui_story == nil then
				arg_256_1.var_.characterEffect1148ui_story = arg_256_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1148ui_story"]) then
				if arg_256_1.var_.characterEffect1148ui_story and not isNil(arg_256_1.actors_["1148ui_story"]) then
					arg_256_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1148ui_story"]) and arg_256_1.var_.characterEffect1148ui_story then
				arg_256_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_259_2 = 0
			local var_259_3 = 0.425

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(114804063)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 17 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 17)

				if (17 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 17)) > 0 and var_259_3 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb") / 1000

					if var_259_8 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_2
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb")

						arg_256_1:RecordAudio("114804063", var_259_9)
						arg_256_1:RecordAudio("114804063", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_10 and arg_256_1.time_ < var_259_2 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play114804064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 114804064
		arg_260_1.duration_ = 9.3

		local var_260_0 = {
			ja = 9.3,
			ko = 7.033,
			zh = 6.466,
			en = 7.733
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
				arg_260_0:Play114804065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if arg_260_1.bgs_.R4801 == nil then
				local var_263_0 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R4801")
				var_263_0.name = "R4801"
				var_263_0.transform.parent = arg_260_1.stage_.transform
				var_263_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_.R4801 = var_263_0
			end

			if 1.5 < arg_260_1.time_ and arg_260_1.time_ <= 1.5 + arg_263_0 then
				local var_263_1 = arg_260_1.bgs_.R4801

				arg_260_1.bgs_.R4801.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_263_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_2 = var_263_1:GetComponent("SpriteRenderer")

				if var_263_2 and var_263_2.sprite then
					local var_263_3 = 2 * (var_263_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_263_1.transform.localScale = Vector3.New(var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "R4801" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_4 = arg_260_1.actors_["1019ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1019ui_story = var_263_4.localPosition
			end

			local var_263_5 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_5 then
				var_263_4.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_5)
				var_263_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_4.position).x, (manager.ui.mainCamera.transform.position - var_263_4.position).y, (manager.ui.mainCamera.transform.position - var_263_4.position).z)
				var_263_4.localEulerAngles.z = 0
				var_263_4.localEulerAngles.x = 0
				var_263_4.localEulerAngles = var_263_4.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_5 and arg_260_1.time_ < 0 + var_263_5 + arg_263_0 then
				var_263_4.localPosition = Vector3.New(0, 100, 0)
				var_263_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_4.position).x, (manager.ui.mainCamera.transform.position - var_263_4.position).y, (manager.ui.mainCamera.transform.position - var_263_4.position).z)
				var_263_4.localEulerAngles.z = 0
				var_263_4.localEulerAngles.x = 0
				var_263_4.localEulerAngles = var_263_4.localEulerAngles
			end

			local var_263_6 = arg_260_1.actors_["1148ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1148ui_story = var_263_6.localPosition
			end

			local var_263_7 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				var_263_6.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_7)
				var_263_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_6.position).x, (manager.ui.mainCamera.transform.position - var_263_6.position).y, (manager.ui.mainCamera.transform.position - var_263_6.position).z)
				var_263_6.localEulerAngles.z = 0
				var_263_6.localEulerAngles.x = 0
				var_263_6.localEulerAngles = var_263_6.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				var_263_6.localPosition = Vector3.New(0, 100, 0)
				var_263_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_6.position).x, (manager.ui.mainCamera.transform.position - var_263_6.position).y, (manager.ui.mainCamera.transform.position - var_263_6.position).z)
				var_263_6.localEulerAngles.z = 0
				var_263_6.localEulerAngles.x = 0
				var_263_6.localEulerAngles = var_263_6.localEulerAngles
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				local var_263_8 = arg_260_1.bgs_.ST02:GetComponent("SpriteRenderer")

				if var_263_8 then
					arg_260_1.var_.alphaOldValueST02 = var_263_8.color.a
					arg_260_1.var_.alphaMatValueST02 = var_263_8
				end

				arg_260_1.var_.alphaOldValueST02 = 1
			end

			local var_263_9 = 1.5

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_9 then
				if arg_260_1.var_.alphaMatValueST02 then
					arg_260_1.var_.alphaMatValueST02.color.a = Mathf.Lerp(arg_260_1.var_.alphaOldValueST02, 0, (arg_260_1.time_ - 0) / var_263_9)
					arg_260_1.var_.alphaMatValueST02.color = arg_260_1.var_.alphaMatValueST02.color
				end
			end

			if arg_260_1.time_ >= 0 + var_263_9 and arg_260_1.time_ < 0 + var_263_9 + arg_263_0 and arg_260_1.var_.alphaMatValueST02 then
				arg_260_1.var_.alphaMatValueST02.color.a = 0
				arg_260_1.var_.alphaMatValueST02.color = arg_260_1.var_.alphaMatValueST02.color
			end

			if 1.5 < arg_260_1.time_ and arg_260_1.time_ <= 1.5 + arg_263_0 then
				local var_263_10 = arg_260_1.bgs_.R4801:GetComponent("SpriteRenderer")

				if var_263_10 then
					arg_260_1.var_.alphaOldValueR4801 = var_263_10.color.a
					arg_260_1.var_.alphaMatValueR4801 = var_263_10
				end

				arg_260_1.var_.alphaOldValueR4801 = 0
			end

			local var_263_11 = 1.5

			if 1.5 <= arg_260_1.time_ and arg_260_1.time_ < 1.5 + var_263_11 then
				if arg_260_1.var_.alphaMatValueR4801 then
					arg_260_1.var_.alphaMatValueR4801.color.a = Mathf.Lerp(arg_260_1.var_.alphaOldValueR4801, 1, (arg_260_1.time_ - 1.5) / var_263_11)
					arg_260_1.var_.alphaMatValueR4801.color = arg_260_1.var_.alphaMatValueR4801.color
				end
			end

			if arg_260_1.time_ >= 1.5 + var_263_11 and arg_260_1.time_ < 1.5 + var_263_11 + arg_263_0 and arg_260_1.var_.alphaMatValueR4801 then
				arg_260_1.var_.alphaMatValueR4801.color.a = 1
				arg_260_1.var_.alphaMatValueR4801.color = arg_260_1.var_.alphaMatValueR4801.color
			end

			local var_263_12 = 0
			local var_263_13 = 0.575

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_12 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_14 = arg_260_1:GetWordFromCfg(114804064)
				local var_263_15 = arg_260_1:FormatText(var_263_14.content)

				arg_260_1.text_.text = var_263_15

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_17 = 23 <= 0 and var_263_13 or var_263_13 * (utf8.len(var_263_15) / 23)

				if (23 <= 0 and var_263_13 or var_263_13 * (utf8.len(var_263_15) / 23)) > 0 and var_263_13 < var_263_17 then
					arg_260_1.talkMaxDuration = var_263_17

					if var_263_17 + var_263_12 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_17 + var_263_12
					end
				end

				arg_260_1.text_.text = var_263_15
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb") ~= 0 then
					local var_263_18 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb") / 1000

					if var_263_18 + var_263_12 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_18 + var_263_12
					end

					if var_263_14.prefab_name ~= "" and arg_260_1.actors_[var_263_14.prefab_name] ~= nil then
						local var_263_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_14.prefab_name].transform, "story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb")

						arg_260_1:RecordAudio("114804064", var_263_19)
						arg_260_1:RecordAudio("114804064", var_263_19)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_20 = math.max(var_263_13, arg_260_1.talkMaxDuration)

			if var_263_12 <= arg_260_1.time_ and arg_260_1.time_ < var_263_12 + var_263_20 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_12) / var_263_20

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_12 + var_263_20 and arg_260_1.time_ < var_263_12 + var_263_20 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play114804065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 114804065
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play114804066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.25

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(114804065).content)

				arg_264_1.text_.text = var_267_1

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_3 = 10 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 10)

				if (10 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 10)) > 0 and var_267_0 < var_267_3 then
					arg_264_1.talkMaxDuration = var_267_3

					if var_267_3 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_3 + 0
					end
				end

				arg_264_1.text_.text = var_267_1
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_4 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_4

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play114804066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 114804066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play114804067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 1.05

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(114804066).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 42 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 42)

				if (42 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 42)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play114804067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 114804067
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play114804068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 1.275

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(114804067).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 51 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 51)

				if (51 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 51)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play114804068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 114804068
		arg_276_1.duration_ = 8.5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play114804069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 1.5 < arg_276_1.time_ and arg_276_1.time_ <= 1.5 + arg_279_0 then
				local var_279_0 = arg_276_1.bgs_.ST02

				arg_276_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_279_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_279_1 = var_279_0:GetComponent("SpriteRenderer")

				if var_279_1 and var_279_1.sprite then
					local var_279_2 = 2 * (var_279_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_279_0.transform.localScale = Vector3.New(var_279_2 / var_279_1.sprite.bounds.size.y < var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x and var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x or var_279_2 / var_279_1.sprite.bounds.size.y, var_279_2 / var_279_1.sprite.bounds.size.y < var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x and var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x or var_279_2 / var_279_1.sprite.bounds.size.y, 0)
				end

				for iter_279_0, iter_279_1 in pairs(arg_276_1.bgs_) do
					if iter_279_0 ~= "ST02" then
						iter_279_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				local var_279_3 = arg_276_1.bgs_.R4801:GetComponent("SpriteRenderer")

				if var_279_3 then
					arg_276_1.var_.alphaOldValueR4801 = var_279_3.color.a
					arg_276_1.var_.alphaMatValueR4801 = var_279_3
				end

				arg_276_1.var_.alphaOldValueR4801 = 1
			end

			local var_279_4 = 1.5

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				if arg_276_1.var_.alphaMatValueR4801 then
					arg_276_1.var_.alphaMatValueR4801.color.a = Mathf.Lerp(arg_276_1.var_.alphaOldValueR4801, 0, (arg_276_1.time_ - 0) / var_279_4)
					arg_276_1.var_.alphaMatValueR4801.color = arg_276_1.var_.alphaMatValueR4801.color
				end
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 and arg_276_1.var_.alphaMatValueR4801 then
				arg_276_1.var_.alphaMatValueR4801.color.a = 0
				arg_276_1.var_.alphaMatValueR4801.color = arg_276_1.var_.alphaMatValueR4801.color
			end

			if 1.5 < arg_276_1.time_ and arg_276_1.time_ <= 1.5 + arg_279_0 then
				local var_279_5 = arg_276_1.bgs_.ST02:GetComponent("SpriteRenderer")

				if var_279_5 then
					arg_276_1.var_.alphaOldValueST02 = var_279_5.color.a
					arg_276_1.var_.alphaMatValueST02 = var_279_5
				end

				arg_276_1.var_.alphaOldValueST02 = 0
			end

			local var_279_6 = 1.5

			if 1.5 <= arg_276_1.time_ and arg_276_1.time_ < 1.5 + var_279_6 then
				if arg_276_1.var_.alphaMatValueST02 then
					arg_276_1.var_.alphaMatValueST02.color.a = Mathf.Lerp(arg_276_1.var_.alphaOldValueST02, 1, (arg_276_1.time_ - 1.5) / var_279_6)
					arg_276_1.var_.alphaMatValueST02.color = arg_276_1.var_.alphaMatValueST02.color
				end
			end

			if arg_276_1.time_ >= 1.5 + var_279_6 and arg_276_1.time_ < 1.5 + var_279_6 + arg_279_0 and arg_276_1.var_.alphaMatValueST02 then
				arg_276_1.var_.alphaMatValueST02.color.a = 1
				arg_276_1.var_.alphaMatValueST02.color = arg_276_1.var_.alphaMatValueST02.color
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_7 = 3.5
			local var_279_8 = 0.475

			if 3.5 < arg_276_1.time_ and arg_276_1.time_ <= var_279_7 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_9 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_9:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_10 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(114804068).content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_12 = 19 <= 0 and var_279_8 or var_279_8 * (utf8.len(var_279_10) / 19)

				if (19 <= 0 and var_279_8 or var_279_8 * (utf8.len(var_279_10) / 19)) > 0 and var_279_8 < var_279_12 then
					arg_276_1.talkMaxDuration = var_279_12
					var_279_7 = var_279_7 + 0.3

					if var_279_12 + var_279_7 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_12 + var_279_7
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_13 = var_279_7 + 0.3
			local var_279_14 = math.max(var_279_8, arg_276_1.talkMaxDuration)

			if var_279_7 + 0.3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_13 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_13) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_13 + var_279_14 and arg_276_1.time_ < var_279_13 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play114804069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 114804069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play114804070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 1.325

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(114804069).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 53 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 53)

				if (53 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 53)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play114804070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 114804070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play114804071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.425

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(114804070).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 17 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 17)

				if (17 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 17)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play114804071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 114804071
		arg_290_1.duration_ = 3.73

		local var_290_0 = {
			ja = 3.733,
			ko = 2.466,
			zh = 2,
			en = 2.7
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play114804072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1019ui_story = arg_290_1.actors_["1019ui_story"].transform.localPosition

				arg_290_1:ShowWeapon(arg_290_1.var_["1019ui_story" .. "Animator"].transform, false)
			end

			local var_293_0 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				arg_290_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1019ui_story"].transform.position).z)
				arg_290_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1019ui_story"].transform.localEulerAngles = arg_290_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				arg_290_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_290_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1019ui_story"].transform.position).z)
				arg_290_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1019ui_story"].transform.localEulerAngles = arg_290_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_293_1 = arg_290_1.actors_["1019ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect1019ui_story == nil then
				arg_290_1.var_.characterEffect1019ui_story = var_293_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_2 and not isNil(var_293_1) then
				if arg_290_1.var_.characterEffect1019ui_story and not isNil(var_293_1) then
					arg_290_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_2 and arg_290_1.time_ < 0 + var_293_2 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect1019ui_story then
				arg_290_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_290_1.time_ and arg_290_1.time_ <= 0.0166666666666667 + arg_293_0 then
				arg_290_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0.0166666666666667 < arg_290_1.time_ and arg_290_1.time_ <= 0.0166666666666667 + arg_293_0 then
				arg_290_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_4 = 0
			local var_293_5 = 0.25

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_6 = arg_290_1:GetWordFromCfg(114804071)
				local var_293_7 = arg_290_1:FormatText(var_293_6.content)

				arg_290_1.text_.text = var_293_7

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_9 = 10 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 10)

				if (10 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 10)) > 0 and var_293_5 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_4
					end
				end

				arg_290_1.text_.text = var_293_7
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb") / 1000

					if var_293_10 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_4
					end

					if var_293_6.prefab_name ~= "" and arg_290_1.actors_[var_293_6.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_6.prefab_name].transform, "story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb")

						arg_290_1:RecordAudio("114804071", var_293_11)
						arg_290_1:RecordAudio("114804071", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_5, arg_290_1.talkMaxDuration)

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_4) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_4 + var_293_12 and arg_290_1.time_ < var_293_4 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play114804072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 114804072
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play114804073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1019ui_story"]) and arg_294_1.var_.characterEffect1019ui_story == nil then
				arg_294_1.var_.characterEffect1019ui_story = arg_294_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1019ui_story"]) then
				if arg_294_1.var_.characterEffect1019ui_story and not isNil(arg_294_1.actors_["1019ui_story"]) then
					arg_294_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1019ui_story"]) and arg_294_1.var_.characterEffect1019ui_story then
				arg_294_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_297_1 = 0
			local var_297_2 = 0.225

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
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

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(114804072).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 9 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 9)

				if (9 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 9)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play114804073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 114804073
		arg_298_1.duration_ = 9.17

		local var_298_0 = {
			ja = 7.9,
			ko = 9.166,
			zh = 7.266,
			en = 6.066
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play114804074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1019ui_story"]) and arg_298_1.var_.characterEffect1019ui_story == nil then
				arg_298_1.var_.characterEffect1019ui_story = arg_298_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1019ui_story"]) then
				if arg_298_1.var_.characterEffect1019ui_story and not isNil(arg_298_1.actors_["1019ui_story"]) then
					arg_298_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1019ui_story"]) and arg_298_1.var_.characterEffect1019ui_story then
				arg_298_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_301_2 = 0
			local var_301_3 = 1

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_4 = arg_298_1:GetWordFromCfg(114804073)
				local var_301_5 = arg_298_1:FormatText(var_301_4.content)

				arg_298_1.text_.text = var_301_5

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_7 = 40 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_5) / 40)

				if (40 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_5) / 40)) > 0 and var_301_3 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_2
					end
				end

				arg_298_1.text_.text = var_301_5
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb") ~= 0 then
					local var_301_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb") / 1000

					if var_301_8 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_2
					end

					if var_301_4.prefab_name ~= "" and arg_298_1.actors_[var_301_4.prefab_name] ~= nil then
						local var_301_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_4.prefab_name].transform, "story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb")

						arg_298_1:RecordAudio("114804073", var_301_9)
						arg_298_1:RecordAudio("114804073", var_301_9)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_3, arg_298_1.talkMaxDuration)

			if var_301_2 <= arg_298_1.time_ and arg_298_1.time_ < var_301_2 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_2) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_2 + var_301_10 and arg_298_1.time_ < var_301_2 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play114804074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 114804074
		arg_302_1.duration_ = 5.17

		local var_302_0 = {
			ja = 5.166,
			ko = 3.566,
			zh = 2.8,
			en = 4.666
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
				arg_302_0:Play114804075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_305_0 = 0
			local var_305_1 = 0.325

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_2 = arg_302_1:GetWordFromCfg(114804074)
				local var_305_3 = arg_302_1:FormatText(var_305_2.content)

				arg_302_1.text_.text = var_305_3

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 13 <= 0 and var_305_1 or var_305_1 * (utf8.len(var_305_3) / 13)

				if (13 <= 0 and var_305_1 or var_305_1 * (utf8.len(var_305_3) / 13)) > 0 and var_305_1 < var_305_5 then
					arg_302_1.talkMaxDuration = var_305_5

					if var_305_5 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_3
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb") ~= 0 then
					local var_305_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb") / 1000

					if var_305_6 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_0
					end

					if var_305_2.prefab_name ~= "" and arg_302_1.actors_[var_305_2.prefab_name] ~= nil then
						local var_305_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_2.prefab_name].transform, "story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb")

						arg_302_1:RecordAudio("114804074", var_305_7)
						arg_302_1:RecordAudio("114804074", var_305_7)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_8 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_8 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_8

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_8 and arg_302_1.time_ < var_305_0 + var_305_8 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play114804075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 114804075
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play114804076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1019ui_story"]) and arg_306_1.var_.characterEffect1019ui_story == nil then
				arg_306_1.var_.characterEffect1019ui_story = arg_306_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1019ui_story"]) then
				if arg_306_1.var_.characterEffect1019ui_story and not isNil(arg_306_1.actors_["1019ui_story"]) then
					arg_306_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1019ui_story"]) and arg_306_1.var_.characterEffect1019ui_story then
				arg_306_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_309_1 = 0
			local var_309_2 = 0.15

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

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(114804075).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 6 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 6)

				if (6 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 6)) > 0 and var_309_2 < var_309_5 then
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
	Play114804076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 114804076
		arg_310_1.duration_ = 12.07

		local var_310_0 = {
			ja = 12.066,
			ko = 10.6,
			zh = 10.233,
			en = 6.3
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
				arg_310_0:Play114804077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1019ui_story"]) and arg_310_1.var_.characterEffect1019ui_story == nil then
				arg_310_1.var_.characterEffect1019ui_story = arg_310_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1019ui_story"]) then
				if arg_310_1.var_.characterEffect1019ui_story and not isNil(arg_310_1.actors_["1019ui_story"]) then
					arg_310_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1019ui_story"]) and arg_310_1.var_.characterEffect1019ui_story then
				arg_310_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_313_2 = 0
			local var_313_3 = 1.25

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_4 = arg_310_1:GetWordFromCfg(114804076)
				local var_313_5 = arg_310_1:FormatText(var_313_4.content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_7 = 50 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 50)

				if (50 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 50)) > 0 and var_313_3 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb") / 1000

					if var_313_8 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_2
					end

					if var_313_4.prefab_name ~= "" and arg_310_1.actors_[var_313_4.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_4.prefab_name].transform, "story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb")

						arg_310_1:RecordAudio("114804076", var_313_9)
						arg_310_1:RecordAudio("114804076", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_10 and arg_310_1.time_ < var_313_2 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play114804077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 114804077
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play114804078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1019ui_story"]) and arg_314_1.var_.characterEffect1019ui_story == nil then
				arg_314_1.var_.characterEffect1019ui_story = arg_314_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1019ui_story"]) then
				if arg_314_1.var_.characterEffect1019ui_story and not isNil(arg_314_1.actors_["1019ui_story"]) then
					arg_314_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_0)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1019ui_story"]) and arg_314_1.var_.characterEffect1019ui_story then
				arg_314_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_317_1 = 0
			local var_317_2 = 0.225

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(114804077).content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 9 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 9)

				if (9 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 9)) > 0 and var_317_2 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_1
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_6 = math.max(var_317_2, arg_314_1.talkMaxDuration)

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_6 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_1) / var_317_6

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_1 + var_317_6 and arg_314_1.time_ < var_317_1 + var_317_6 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play114804078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 114804078
		arg_318_1.duration_ = 5.67

		local var_318_0 = {
			ja = 2.7,
			ko = 5.666,
			zh = 4.266,
			en = 4.066
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
				arg_318_0:Play114804079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1019ui_story"]) and arg_318_1.var_.characterEffect1019ui_story == nil then
				arg_318_1.var_.characterEffect1019ui_story = arg_318_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1019ui_story"]) then
				if arg_318_1.var_.characterEffect1019ui_story and not isNil(arg_318_1.actors_["1019ui_story"]) then
					arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1019ui_story"]) and arg_318_1.var_.characterEffect1019ui_story then
				arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action457")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_321_2 = 0
			local var_321_3 = 0.55

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_4 = arg_318_1:GetWordFromCfg(114804078)
				local var_321_5 = arg_318_1:FormatText(var_321_4.content)

				arg_318_1.text_.text = var_321_5

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_7 = 22 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 22)

				if (22 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 22)) > 0 and var_321_3 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_2
					end
				end

				arg_318_1.text_.text = var_321_5
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb") / 1000

					if var_321_8 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_2
					end

					if var_321_4.prefab_name ~= "" and arg_318_1.actors_[var_321_4.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_4.prefab_name].transform, "story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb")

						arg_318_1:RecordAudio("114804078", var_321_9)
						arg_318_1:RecordAudio("114804078", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_3, arg_318_1.talkMaxDuration)

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_2) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_2 + var_321_10 and arg_318_1.time_ < var_321_2 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play114804079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 114804079
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play114804080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1019ui_story"]) and arg_322_1.var_.characterEffect1019ui_story == nil then
				arg_322_1.var_.characterEffect1019ui_story = arg_322_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1019ui_story"]) then
				if arg_322_1.var_.characterEffect1019ui_story and not isNil(arg_322_1.actors_["1019ui_story"]) then
					arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_0)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1019ui_story"]) and arg_322_1.var_.characterEffect1019ui_story then
				arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_325_1 = 0
			local var_325_2 = 1.075

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(114804079).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 43 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 43)

				if (43 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 43)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play114804080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 114804080
		arg_326_1.duration_ = 13.8

		local var_326_0 = {
			ja = 11.666,
			ko = 13.8,
			zh = 11.2,
			en = 9.5
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play114804081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1019ui_story"]) and arg_326_1.var_.characterEffect1019ui_story == nil then
				arg_326_1.var_.characterEffect1019ui_story = arg_326_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1019ui_story"]) then
				if arg_326_1.var_.characterEffect1019ui_story and not isNil(arg_326_1.actors_["1019ui_story"]) then
					arg_326_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1019ui_story"]) and arg_326_1.var_.characterEffect1019ui_story then
				arg_326_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action472")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_329_2 = 0
			local var_329_3 = 1.45

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_4 = arg_326_1:GetWordFromCfg(114804080)
				local var_329_5 = arg_326_1:FormatText(var_329_4.content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 58 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 58)

				if (58 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 58)) > 0 and var_329_3 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb") / 1000

					if var_329_8 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_2
					end

					if var_329_4.prefab_name ~= "" and arg_326_1.actors_[var_329_4.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_4.prefab_name].transform, "story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb")

						arg_326_1:RecordAudio("114804080", var_329_9)
						arg_326_1:RecordAudio("114804080", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_10 and arg_326_1.time_ < var_329_2 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play114804081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 114804081
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play114804082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1019ui_story"]) and arg_330_1.var_.characterEffect1019ui_story == nil then
				arg_330_1.var_.characterEffect1019ui_story = arg_330_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1019ui_story"]) then
				if arg_330_1.var_.characterEffect1019ui_story and not isNil(arg_330_1.actors_["1019ui_story"]) then
					arg_330_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1019ui_story"]) and arg_330_1.var_.characterEffect1019ui_story then
				arg_330_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_333_1 = 0
			local var_333_2 = 0.05

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(114804081).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 2 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 2)

				if (2 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 2)) > 0 and var_333_2 < var_333_5 then
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
	Play114804082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 114804082
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play114804083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_337_0 = 0
			local var_337_1 = 0.6

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_2 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(114804082).content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 24 <= 0 and var_337_1 or var_337_1 * (utf8.len(var_337_2) / 24)

				if (24 <= 0 and var_337_1 or var_337_1 * (utf8.len(var_337_2) / 24)) > 0 and var_337_1 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_5 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_5 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_5

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_5 and arg_334_1.time_ < var_337_0 + var_337_5 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play114804083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 114804083
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play114804084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_341_0 = 0
			local var_341_1 = 1.225

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_2 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(114804083).content)

				arg_338_1.text_.text = var_341_2

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 49 <= 0 and var_341_1 or var_341_1 * (utf8.len(var_341_2) / 49)

				if (49 <= 0 and var_341_1 or var_341_1 * (utf8.len(var_341_2) / 49)) > 0 and var_341_1 < var_341_4 then
					arg_338_1.talkMaxDuration = var_341_4

					if var_341_4 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_4 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_2
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_5 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_5 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_5

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_5 and arg_338_1.time_ < var_341_0 + var_341_5 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play114804084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 114804084
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play114804085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_345_0 = 0
			local var_345_1 = 0.3

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(114804084).content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 12 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_2) / 12)

				if (12 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_2) / 12)) > 0 and var_345_1 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_5 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_5 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_5

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_5 and arg_342_1.time_ < var_345_0 + var_345_5 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play114804085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 114804085
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play114804086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_349_0 = 0
			local var_349_1 = 0.125

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_2 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(114804085).content)

				arg_346_1.text_.text = var_349_2

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_4 = 5 <= 0 and var_349_1 or var_349_1 * (utf8.len(var_349_2) / 5)

				if (5 <= 0 and var_349_1 or var_349_1 * (utf8.len(var_349_2) / 5)) > 0 and var_349_1 < var_349_4 then
					arg_346_1.talkMaxDuration = var_349_4

					if var_349_4 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_4 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_2
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_5 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_5 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_5

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_5 and arg_346_1.time_ < var_349_0 + var_349_5 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play114804086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 114804086
		arg_350_1.duration_ = 15.8

		local var_350_0 = {
			ja = 9.3,
			ko = 15.8,
			zh = 11.566,
			en = 12.6
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
				arg_350_0:Play114804087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1019ui_story"]) and arg_350_1.var_.characterEffect1019ui_story == nil then
				arg_350_1.var_.characterEffect1019ui_story = arg_350_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1019ui_story"]) then
				if arg_350_1.var_.characterEffect1019ui_story and not isNil(arg_350_1.actors_["1019ui_story"]) then
					arg_350_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1019ui_story"]) and arg_350_1.var_.characterEffect1019ui_story then
				arg_350_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_353_2 = 0
			local var_353_3 = 1.55

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_4 = arg_350_1:GetWordFromCfg(114804086)
				local var_353_5 = arg_350_1:FormatText(var_353_4.content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 62 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 62)

				if (62 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 62)) > 0 and var_353_3 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_2
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb") / 1000

					if var_353_8 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_2
					end

					if var_353_4.prefab_name ~= "" and arg_350_1.actors_[var_353_4.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_4.prefab_name].transform, "story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb")

						arg_350_1:RecordAudio("114804086", var_353_9)
						arg_350_1:RecordAudio("114804086", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_3, arg_350_1.talkMaxDuration)

			if var_353_2 <= arg_350_1.time_ and arg_350_1.time_ < var_353_2 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_2) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_2 + var_353_10 and arg_350_1.time_ < var_353_2 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play114804087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 114804087
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play114804088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1019ui_story"]) and arg_354_1.var_.characterEffect1019ui_story == nil then
				arg_354_1.var_.characterEffect1019ui_story = arg_354_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1019ui_story"]) then
				if arg_354_1.var_.characterEffect1019ui_story and not isNil(arg_354_1.actors_["1019ui_story"]) then
					arg_354_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_0)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1019ui_story"]) and arg_354_1.var_.characterEffect1019ui_story then
				arg_354_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_357_1 = 0
			local var_357_2 = 0.2

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
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

				local var_357_3 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(114804087).content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 8 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 8)

				if (8 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 8)) > 0 and var_357_2 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_6 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_6 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_6

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_6 and arg_354_1.time_ < var_357_1 + var_357_6 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play114804088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 114804088
		arg_358_1.duration_ = 6.07

		local var_358_0 = {
			ja = 2.266,
			ko = 6.066,
			zh = 5.2,
			en = 5.866
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play114804089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1019ui_story"]) and arg_358_1.var_.characterEffect1019ui_story == nil then
				arg_358_1.var_.characterEffect1019ui_story = arg_358_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1019ui_story"]) then
				if arg_358_1.var_.characterEffect1019ui_story and not isNil(arg_358_1.actors_["1019ui_story"]) then
					arg_358_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1019ui_story"]) and arg_358_1.var_.characterEffect1019ui_story then
				arg_358_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_361_2 = 0
			local var_361_3 = 0.65

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_2 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_4 = arg_358_1:GetWordFromCfg(114804088)
				local var_361_5 = arg_358_1:FormatText(var_361_4.content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 26 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 26)

				if (26 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 26)) > 0 and var_361_3 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_2
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb") / 1000

					if var_361_8 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_2
					end

					if var_361_4.prefab_name ~= "" and arg_358_1.actors_[var_361_4.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_4.prefab_name].transform, "story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb")

						arg_358_1:RecordAudio("114804088", var_361_9)
						arg_358_1:RecordAudio("114804088", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_3, arg_358_1.talkMaxDuration)

			if var_361_2 <= arg_358_1.time_ and arg_358_1.time_ < var_361_2 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_2) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_2 + var_361_10 and arg_358_1.time_ < var_361_2 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play114804089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 114804089
		arg_362_1.duration_ = 16.17

		local var_362_0 = {
			ja = 16.166,
			ko = 15.8,
			zh = 13.7,
			en = 12.933
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
				arg_362_0:Play114804090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_365_0 = 0
			local var_365_1 = 1.6

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_2 = arg_362_1:GetWordFromCfg(114804089)
				local var_365_3 = arg_362_1:FormatText(var_365_2.content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 64 <= 0 and var_365_1 or var_365_1 * (utf8.len(var_365_3) / 64)

				if (64 <= 0 and var_365_1 or var_365_1 * (utf8.len(var_365_3) / 64)) > 0 and var_365_1 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb") ~= 0 then
					local var_365_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb") / 1000

					if var_365_6 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_6 + var_365_0
					end

					if var_365_2.prefab_name ~= "" and arg_362_1.actors_[var_365_2.prefab_name] ~= nil then
						local var_365_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_2.prefab_name].transform, "story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb")

						arg_362_1:RecordAudio("114804089", var_365_7)
						arg_362_1:RecordAudio("114804089", var_365_7)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_8 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_8 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_8

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_8 and arg_362_1.time_ < var_365_0 + var_365_8 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play114804090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 114804090
		arg_366_1.duration_ = 12.1

		local var_366_0 = {
			ja = 10.766,
			ko = 11,
			zh = 9.033,
			en = 12.1
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
				arg_366_0:Play114804091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_369_0 = 0
			local var_369_1 = 1.1

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_2 = arg_366_1:GetWordFromCfg(114804090)
				local var_369_3 = arg_366_1:FormatText(var_369_2.content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 44 <= 0 and var_369_1 or var_369_1 * (utf8.len(var_369_3) / 44)

				if (44 <= 0 and var_369_1 or var_369_1 * (utf8.len(var_369_3) / 44)) > 0 and var_369_1 < var_369_5 then
					arg_366_1.talkMaxDuration = var_369_5

					if var_369_5 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb") ~= 0 then
					local var_369_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb") / 1000

					if var_369_6 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_6 + var_369_0
					end

					if var_369_2.prefab_name ~= "" and arg_366_1.actors_[var_369_2.prefab_name] ~= nil then
						local var_369_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_2.prefab_name].transform, "story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb")

						arg_366_1:RecordAudio("114804090", var_369_7)
						arg_366_1:RecordAudio("114804090", var_369_7)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_8 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_8 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_8

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_8 and arg_366_1.time_ < var_369_0 + var_369_8 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play114804091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 114804091
		arg_370_1.duration_ = 16

		local var_370_0 = {
			ja = 15.133,
			ko = 16,
			zh = 13.2,
			en = 14.566
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
				arg_370_0:Play114804092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_373_0 = 0
			local var_373_1 = 1.425

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_2 = arg_370_1:GetWordFromCfg(114804091)
				local var_373_3 = arg_370_1:FormatText(var_373_2.content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 57 <= 0 and var_373_1 or var_373_1 * (utf8.len(var_373_3) / 57)

				if (57 <= 0 and var_373_1 or var_373_1 * (utf8.len(var_373_3) / 57)) > 0 and var_373_1 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb") ~= 0 then
					local var_373_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb") / 1000

					if var_373_6 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_6 + var_373_0
					end

					if var_373_2.prefab_name ~= "" and arg_370_1.actors_[var_373_2.prefab_name] ~= nil then
						local var_373_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_2.prefab_name].transform, "story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb")

						arg_370_1:RecordAudio("114804091", var_373_7)
						arg_370_1:RecordAudio("114804091", var_373_7)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb")
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
	Play114804092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 114804092
		arg_374_1.duration_ = 15.93

		local var_374_0 = {
			ja = 15.933,
			ko = 6.7,
			zh = 6.366,
			en = 6.466
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
				arg_374_0:Play114804093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_377_0 = 0
			local var_377_1 = 0.775

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_2 = arg_374_1:GetWordFromCfg(114804092)
				local var_377_3 = arg_374_1:FormatText(var_377_2.content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 31 <= 0 and var_377_1 or var_377_1 * (utf8.len(var_377_3) / 31)

				if (31 <= 0 and var_377_1 or var_377_1 * (utf8.len(var_377_3) / 31)) > 0 and var_377_1 < var_377_5 then
					arg_374_1.talkMaxDuration = var_377_5

					if var_377_5 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb") ~= 0 then
					local var_377_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb") / 1000

					if var_377_6 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_0
					end

					if var_377_2.prefab_name ~= "" and arg_374_1.actors_[var_377_2.prefab_name] ~= nil then
						local var_377_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_2.prefab_name].transform, "story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb")

						arg_374_1:RecordAudio("114804092", var_377_7)
						arg_374_1:RecordAudio("114804092", var_377_7)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_8 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_8 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_8

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_8 and arg_374_1.time_ < var_377_0 + var_377_8 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play114804093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 114804093
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play114804094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_381_0 = arg_378_1.actors_["1019ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1019ui_story == nil then
				arg_378_1.var_.characterEffect1019ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_1 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_1 and not isNil(var_381_0) then
				if arg_378_1.var_.characterEffect1019ui_story and not isNil(var_381_0) then
					arg_378_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_1)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_1 and arg_378_1.time_ < 0 + var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1019ui_story then
				arg_378_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_381_2 = 0
			local var_381_3 = 1.075

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_4 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(114804093).content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_6 = 43 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_4) / 43)

				if (43 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_4) / 43)) > 0 and var_381_3 < var_381_6 then
					arg_378_1.talkMaxDuration = var_381_6

					if var_381_6 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_7 and arg_378_1.time_ < var_381_2 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play114804094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 114804094
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play114804095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_385_0 = 0
			local var_385_1 = 0.575

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_2 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(114804094).content)

				arg_382_1.text_.text = var_385_2

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 24 <= 0 and var_385_1 or var_385_1 * (utf8.len(var_385_2) / 24)

				if (24 <= 0 and var_385_1 or var_385_1 * (utf8.len(var_385_2) / 24)) > 0 and var_385_1 < var_385_4 then
					arg_382_1.talkMaxDuration = var_385_4

					if var_385_4 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_4 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_2
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_5 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_5 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_5

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_5 and arg_382_1.time_ < var_385_0 + var_385_5 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play114804095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 114804095
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play114804096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_389_0 = 0
			local var_389_1 = 1.15

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_2 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(114804095).content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 46 <= 0 and var_389_1 or var_389_1 * (utf8.len(var_389_2) / 46)

				if (46 <= 0 and var_389_1 or var_389_1 * (utf8.len(var_389_2) / 46)) > 0 and var_389_1 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_5 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_5 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_5

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_5 and arg_386_1.time_ < var_389_0 + var_389_5 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play114804096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 114804096
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play114804097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_393_0 = 0
			local var_393_1 = 0.475

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_2 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(114804096).content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 19 <= 0 and var_393_1 or var_393_1 * (utf8.len(var_393_2) / 19)

				if (19 <= 0 and var_393_1 or var_393_1 * (utf8.len(var_393_2) / 19)) > 0 and var_393_1 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_5 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_5 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_5

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_5 and arg_390_1.time_ < var_393_0 + var_393_5 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play114804097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 114804097
		arg_394_1.duration_ = 7.47

		local var_394_0 = {
			ja = 7.466,
			ko = 4.7,
			zh = 4.033,
			en = 4.8
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play114804098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1019ui_story"]) and arg_394_1.var_.characterEffect1019ui_story == nil then
				arg_394_1.var_.characterEffect1019ui_story = arg_394_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1019ui_story"]) then
				if arg_394_1.var_.characterEffect1019ui_story and not isNil(arg_394_1.actors_["1019ui_story"]) then
					arg_394_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1019ui_story"]) and arg_394_1.var_.characterEffect1019ui_story then
				arg_394_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action3_1")
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_397_2 = 0
			local var_397_3 = 0.45

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_2 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_4 = arg_394_1:GetWordFromCfg(114804097)
				local var_397_5 = arg_394_1:FormatText(var_397_4.content)

				arg_394_1.text_.text = var_397_5

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_7 = 18 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 18)

				if (18 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 18)) > 0 and var_397_3 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_2
					end
				end

				arg_394_1.text_.text = var_397_5
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb") / 1000

					if var_397_8 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_2
					end

					if var_397_4.prefab_name ~= "" and arg_394_1.actors_[var_397_4.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_4.prefab_name].transform, "story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb")

						arg_394_1:RecordAudio("114804097", var_397_9)
						arg_394_1:RecordAudio("114804097", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_3, arg_394_1.talkMaxDuration)

			if var_397_2 <= arg_394_1.time_ and arg_394_1.time_ < var_397_2 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_2) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_2 + var_397_10 and arg_394_1.time_ < var_397_2 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play114804098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 114804098
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play114804099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1019ui_story"]) and arg_398_1.var_.characterEffect1019ui_story == nil then
				arg_398_1.var_.characterEffect1019ui_story = arg_398_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1019ui_story"]) then
				if arg_398_1.var_.characterEffect1019ui_story and not isNil(arg_398_1.actors_["1019ui_story"]) then
					arg_398_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_398_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_398_1.time_ - 0) / var_401_0)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1019ui_story"]) and arg_398_1.var_.characterEffect1019ui_story then
				arg_398_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_398_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_401_1 = 0
			local var_401_2 = 0.85

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(114804098).content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 34 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 34)

				if (34 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 34)) > 0 and var_401_2 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_1 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_1
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_6 = math.max(var_401_2, arg_398_1.talkMaxDuration)

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_6 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_1) / var_401_6

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_1 + var_401_6 and arg_398_1.time_ < var_401_1 + var_401_6 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play114804099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 114804099
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play114804100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_405_0 = 0
			local var_405_1 = 1.175

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_2 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(114804099).content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 47 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_2) / 47)

				if (47 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_2) / 47)) > 0 and var_405_1 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_5 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_5 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_5

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_5 and arg_402_1.time_ < var_405_0 + var_405_5 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play114804100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 114804100
		arg_406_1.duration_ = 4.7

		local var_406_0 = {
			ja = 3.7,
			ko = 2,
			zh = 1.999999999999,
			en = 4.7
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
				arg_406_0:Play114804101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1019ui_story"]) and arg_406_1.var_.characterEffect1019ui_story == nil then
				arg_406_1.var_.characterEffect1019ui_story = arg_406_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1019ui_story"]) then
				if arg_406_1.var_.characterEffect1019ui_story and not isNil(arg_406_1.actors_["1019ui_story"]) then
					arg_406_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1019ui_story"]) and arg_406_1.var_.characterEffect1019ui_story then
				arg_406_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action435")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_409_2 = 0
			local var_409_3 = 0.3

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_2 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_4 = arg_406_1:GetWordFromCfg(114804100)
				local var_409_5 = arg_406_1:FormatText(var_409_4.content)

				arg_406_1.text_.text = var_409_5

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_7 = 12 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 12)

				if (12 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 12)) > 0 and var_409_3 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_2
					end
				end

				arg_406_1.text_.text = var_409_5
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb") / 1000

					if var_409_8 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_2
					end

					if var_409_4.prefab_name ~= "" and arg_406_1.actors_[var_409_4.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_4.prefab_name].transform, "story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb")

						arg_406_1:RecordAudio("114804100", var_409_9)
						arg_406_1:RecordAudio("114804100", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb")
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
	Play114804101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 114804101
		arg_410_1.duration_ = 13.37

		local var_410_0 = {
			ja = 13.366,
			ko = 12.433,
			zh = 11.8,
			en = 8.966
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play114804102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_413_0 = 0
			local var_413_1 = 1.575

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_2 = arg_410_1:GetWordFromCfg(114804101)
				local var_413_3 = arg_410_1:FormatText(var_413_2.content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 63 <= 0 and var_413_1 or var_413_1 * (utf8.len(var_413_3) / 63)

				if (63 <= 0 and var_413_1 or var_413_1 * (utf8.len(var_413_3) / 63)) > 0 and var_413_1 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb") ~= 0 then
					local var_413_6 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb") / 1000

					if var_413_6 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_6 + var_413_0
					end

					if var_413_2.prefab_name ~= "" and arg_410_1.actors_[var_413_2.prefab_name] ~= nil then
						local var_413_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_2.prefab_name].transform, "story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb")

						arg_410_1:RecordAudio("114804101", var_413_7)
						arg_410_1:RecordAudio("114804101", var_413_7)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_8 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_8 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_8

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_8 and arg_410_1.time_ < var_413_0 + var_413_8 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play114804102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 114804102
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play114804103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["1019ui_story"]) and arg_414_1.var_.characterEffect1019ui_story == nil then
				arg_414_1.var_.characterEffect1019ui_story = arg_414_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_0 = 0.2

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["1019ui_story"]) then
				if arg_414_1.var_.characterEffect1019ui_story and not isNil(arg_414_1.actors_["1019ui_story"]) then
					arg_414_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_414_1.time_ - 0) / var_417_0)
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["1019ui_story"]) and arg_414_1.var_.characterEffect1019ui_story then
				arg_414_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_417_1 = 0
			local var_417_2 = 0.075

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(114804102).content)

				arg_414_1.text_.text = var_417_3

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 3 <= 0 and var_417_2 or var_417_2 * (utf8.len(var_417_3) / 3)

				if (3 <= 0 and var_417_2 or var_417_2 * (utf8.len(var_417_3) / 3)) > 0 and var_417_2 < var_417_5 then
					arg_414_1.talkMaxDuration = var_417_5

					if var_417_5 + var_417_1 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + var_417_1
					end
				end

				arg_414_1.text_.text = var_417_3
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_6 = math.max(var_417_2, arg_414_1.talkMaxDuration)

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_6 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_1) / var_417_6

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_1 + var_417_6 and arg_414_1.time_ < var_417_1 + var_417_6 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play114804103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 114804103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play114804104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_421_0 = 0
			local var_421_1 = 0.7

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(114804103).content)

				arg_418_1.text_.text = var_421_2

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 28 <= 0 and var_421_1 or var_421_1 * (utf8.len(var_421_2) / 28)

				if (28 <= 0 and var_421_1 or var_421_1 * (utf8.len(var_421_2) / 28)) > 0 and var_421_1 < var_421_4 then
					arg_418_1.talkMaxDuration = var_421_4

					if var_421_4 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_4 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_2
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_5 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_5 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_5

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_5 and arg_418_1.time_ < var_421_0 + var_421_5 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play114804104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 114804104
		arg_422_1.duration_ = 8.9

		local var_422_0 = {
			ja = 5.8,
			ko = 7.166,
			zh = 8.9,
			en = 5.8
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
				arg_422_0:Play114804105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1019ui_story"]) and arg_422_1.var_.characterEffect1019ui_story == nil then
				arg_422_1.var_.characterEffect1019ui_story = arg_422_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1019ui_story"]) then
				if arg_422_1.var_.characterEffect1019ui_story and not isNil(arg_422_1.actors_["1019ui_story"]) then
					arg_422_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1019ui_story"]) and arg_422_1.var_.characterEffect1019ui_story then
				arg_422_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_425_2 = 0
			local var_425_3 = 0.875

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_2 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_4 = arg_422_1:GetWordFromCfg(114804104)
				local var_425_5 = arg_422_1:FormatText(var_425_4.content)

				arg_422_1.text_.text = var_425_5

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_7 = 35 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 35)

				if (35 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 35)) > 0 and var_425_3 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_2
					end
				end

				arg_422_1.text_.text = var_425_5
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb") / 1000

					if var_425_8 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_2
					end

					if var_425_4.prefab_name ~= "" and arg_422_1.actors_[var_425_4.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_4.prefab_name].transform, "story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb")

						arg_422_1:RecordAudio("114804104", var_425_9)
						arg_422_1:RecordAudio("114804104", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_3, arg_422_1.talkMaxDuration)

			if var_425_2 <= arg_422_1.time_ and arg_422_1.time_ < var_425_2 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_2) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_2 + var_425_10 and arg_422_1.time_ < var_425_2 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play114804105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 114804105
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play114804106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1019ui_story = arg_426_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_429_0 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				arg_426_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_426_1.time_ - 0) / var_429_0)
				arg_426_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1019ui_story"].transform.position).z)
				arg_426_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1019ui_story"].transform.localEulerAngles = arg_426_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				arg_426_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_426_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1019ui_story"].transform.position).z)
				arg_426_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1019ui_story"].transform.localEulerAngles = arg_426_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_429_1 = 0
			local var_429_2 = 0.575

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_3 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(114804105).content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 23 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 23)

				if (23 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 23)) > 0 and var_429_2 < var_429_5 then
					arg_426_1.talkMaxDuration = var_429_5

					if var_429_5 + var_429_1 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + var_429_1
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_6 = math.max(var_429_2, arg_426_1.talkMaxDuration)

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_6 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_1) / var_429_6

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_1 + var_429_6 and arg_426_1.time_ < var_429_1 + var_429_6 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play114804106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 114804106
		arg_430_1.duration_ = 7.5

		local var_430_0 = {
			ja = 7.5,
			ko = 6.5,
			zh = 5.166,
			en = 5.6
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
				arg_430_0:Play114804107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1148ui_story = arg_430_1.actors_["1148ui_story"].transform.localPosition

				arg_430_1:ShowWeapon(arg_430_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1148ui_story"].transform.position).z)
				arg_430_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1148ui_story"].transform.localEulerAngles = arg_430_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_430_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1148ui_story"].transform.position).z)
				arg_430_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1148ui_story"].transform.localEulerAngles = arg_430_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["1148ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1148ui_story == nil then
				arg_430_1.var_.characterEffect1148ui_story = var_433_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 and not isNil(var_433_1) then
				if arg_430_1.var_.characterEffect1148ui_story and not isNil(var_433_1) then
					arg_430_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1148ui_story then
				arg_430_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0.0166666666666667 < arg_430_1.time_ and arg_430_1.time_ <= 0.0166666666666667 + arg_433_0 then
				arg_430_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0.0166666666666667 < arg_430_1.time_ and arg_430_1.time_ <= 0.0166666666666667 + arg_433_0 then
				arg_430_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_433_4 = 0
			local var_433_5 = 0.5

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_6 = arg_430_1:GetWordFromCfg(114804106)
				local var_433_7 = arg_430_1:FormatText(var_433_6.content)

				arg_430_1.text_.text = var_433_7

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_9 = 20 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 20)

				if (20 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 20)) > 0 and var_433_5 < var_433_9 then
					arg_430_1.talkMaxDuration = var_433_9

					if var_433_9 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_9 + var_433_4
					end
				end

				arg_430_1.text_.text = var_433_7
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb") ~= 0 then
					local var_433_10 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb") / 1000

					if var_433_10 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_4
					end

					if var_433_6.prefab_name ~= "" and arg_430_1.actors_[var_433_6.prefab_name] ~= nil then
						local var_433_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_6.prefab_name].transform, "story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb")

						arg_430_1:RecordAudio("114804106", var_433_11)
						arg_430_1:RecordAudio("114804106", var_433_11)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_12 = math.max(var_433_5, arg_430_1.talkMaxDuration)

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_12 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_4) / var_433_12

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_4 + var_433_12 and arg_430_1.time_ < var_433_4 + var_433_12 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play114804107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 114804107
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
			arg_434_1.auto_ = false
		end

		function arg_434_1.playNext_(arg_436_0)
			arg_434_1.onStoryFinished_()
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_437_0 = 0
			local var_437_1 = 0.4

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_2 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(114804107).content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 16 <= 0 and var_437_1 or var_437_1 * (utf8.len(var_437_2) / 16)

				if (16 <= 0 and var_437_1 or var_437_1 * (utf8.len(var_437_2) / 16)) > 0 and var_437_1 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_5 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_5 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_5

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_5 and arg_434_1.time_ < var_437_0 + var_437_5 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/R4801"
	},
	voices = {
		"story_v_side_old_114804.awb"
	}
}
