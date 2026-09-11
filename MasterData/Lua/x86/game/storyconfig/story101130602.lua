return {
	Play113062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F01 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01")
				var_4_0.name = "F01"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F01 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F01

				arg_1_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F01" then
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

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.96666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

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

			local var_4_14 = 2
			local var_4_15 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(113062001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)

				if (10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)) > 0 and var_4_15 < var_4_19 then
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
	Play113062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113062002
		arg_9_1.duration_ = 8.5

		local var_9_0 = {
			ja = 8.5,
			ko = 7.333,
			zh = 7.6,
			en = 6.033
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
				arg_9_0:Play113062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1084ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1084ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1084ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1084ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1084ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_8 = 0
			local var_12_9 = 0.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
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

				local var_12_10 = arg_9_1:GetWordFromCfg(113062002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 28 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 28)

				if (28 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 28)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062002", "story_v_out_113062.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_113062", "113062002", "story_v_out_113062.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_113062", "113062002", "story_v_out_113062.awb")

						arg_9_1:RecordAudio("113062002", var_12_15)
						arg_9_1:RecordAudio("113062002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113062", "113062002", "story_v_out_113062.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113062", "113062002", "story_v_out_113062.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play113062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113062003
		arg_13_1.duration_ = 7.53

		local var_13_0 = {
			ja = 5.433,
			ko = 4.5,
			zh = 5.033,
			en = 7.533
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
				arg_13_0:Play113062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = arg_13_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

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

			local var_16_1 = "1042ui_story"

			if arg_13_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_13_1.stage_.transform)

				var_16_2.name = var_16_1
				var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_1] = var_16_2

				local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

				var_16_3.enabled = true

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_3.transform, false)

				arg_13_1.var_[var_16_1 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_1 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_1 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_5 = arg_13_1.actors_["1042ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1042ui_story = var_16_5.localPosition
			end

			local var_16_6 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_13_1.time_ - 0) / var_16_6)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_16_7 = arg_13_1.actors_["1042ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1042ui_story == nil then
				arg_13_1.var_.characterEffect1042ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect1042ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1042ui_story then
				arg_13_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_16_10 = 0
			local var_16_11 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(113062003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 18 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 18)

				if (18 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 18)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062003", "story_v_out_113062.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062003", "story_v_out_113062.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_113062", "113062003", "story_v_out_113062.awb")

						arg_13_1:RecordAudio("113062003", var_16_17)
						arg_13_1:RecordAudio("113062003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113062", "113062003", "story_v_out_113062.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113062", "113062003", "story_v_out_113062.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play113062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113062004
		arg_17_1.duration_ = 2.7

		local var_17_0 = {
			ja = 1.999999999999,
			ko = 2.7,
			zh = 1.999999999999,
			en = 2.133
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
				arg_17_0:Play113062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_20_0 = arg_17_1.actors_["1084ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_1 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 and not isNil(var_20_0) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action464")
			end

			local var_20_3 = arg_17_1.actors_["1042ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1042ui_story == nil then
				arg_17_1.var_.characterEffect1042ui_story = var_20_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_4 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 and not isNil(var_20_3) then
				if arg_17_1.var_.characterEffect1042ui_story and not isNil(var_20_3) then
					arg_17_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_4)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1042ui_story then
				arg_17_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_20_5 = 0
			local var_20_6 = 0.175

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(113062004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 7 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 7)

				if (7 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 7)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062004", "story_v_out_113062.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_113062", "113062004", "story_v_out_113062.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_113062", "113062004", "story_v_out_113062.awb")

						arg_17_1:RecordAudio("113062004", var_20_12)
						arg_17_1:RecordAudio("113062004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113062", "113062004", "story_v_out_113062.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113062", "113062004", "story_v_out_113062.awb")
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
	Play113062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113062005
		arg_21_1.duration_ = 0.5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"

			SetActive(arg_21_1.choicesGo_, true)

			for iter_22_0, iter_22_1 in ipairs(arg_21_1.choices_) do
				SetActive(iter_22_1.go, iter_22_0 <= 2)
			end

			arg_21_1.choices_[1].txt.text = arg_21_1:FormatText(StoryChoiceCfg[189].name)
			arg_21_1.choices_[2].txt.text = arg_21_1:FormatText(StoryChoiceCfg[190].name)
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play113062006(arg_21_1)
			end

			if arg_23_0 == 2 then
				arg_21_0:Play113062007(arg_21_1)
			end

			arg_21_1:RecordChoiceLog(113062005, 189, 190)
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = arg_21_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) then
				if arg_21_1.var_.characterEffect1084ui_story and not isNil(arg_21_1.actors_["1084ui_story"]) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_1 + 0.5 and arg_21_1.time_ < var_24_1 + 0.5 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play113062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113062006
		arg_25_1.duration_ = 7.23

		local var_25_0 = {
			ja = 4.733,
			ko = 7.233,
			zh = 7.233,
			en = 7.133
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
				arg_25_0:Play113062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.8

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(113062006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 32 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 32)

				if (32 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 32)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062006", "story_v_out_113062.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_113062", "113062006", "story_v_out_113062.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_113062", "113062006", "story_v_out_113062.awb")

						arg_25_1:RecordAudio("113062006", var_28_6)
						arg_25_1:RecordAudio("113062006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113062", "113062006", "story_v_out_113062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113062", "113062006", "story_v_out_113062.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play113062007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113062007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			ja = 3.133,
			ko = 2.6,
			zh = 3.9,
			en = 3.133
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
				arg_29_0:Play113062008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1042ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1042ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1042ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1042ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action428")
			end

			local var_32_3 = "1042ui_story"

			if arg_29_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_32_4 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_29_1.stage_.transform)

				var_32_4.name = var_32_3
				var_32_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_[var_32_3] = var_32_4

				local var_32_5 = var_32_4:GetComponentInChildren(typeof(CharacterEffect))

				var_32_5.enabled = true

				local var_32_6 = GameObjectTools.GetOrAddComponent(var_32_4, typeof(DynamicBoneHelper))

				if var_32_6 then
					var_32_6:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_5.transform, false)

				arg_29_1.var_[var_32_3 .. "Animator"] = var_32_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_[var_32_3 .. "Animator"].applyRootMotion = true
				arg_29_1.var_[var_32_3 .. "LipSync"] = var_32_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_32_7 = arg_29_1.actors_["1042ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1042ui_story == nil then
				arg_29_1.var_.characterEffect1042ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_8 and not isNil(var_32_7) then
				if arg_29_1.var_.characterEffect1042ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_8 and arg_29_1.time_ < 0 + var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1042ui_story then
				arg_29_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_32_10 = 0
			local var_32_11 = 0.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:GetWordFromCfg(113062007)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 12 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 12)

				if (12 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 12)) > 0 and var_32_11 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062007", "story_v_out_113062.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062007", "story_v_out_113062.awb") / 1000

					if var_32_16 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_10
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_113062", "113062007", "story_v_out_113062.awb")

						arg_29_1:RecordAudio("113062007", var_32_17)
						arg_29_1:RecordAudio("113062007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113062", "113062007", "story_v_out_113062.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113062", "113062007", "story_v_out_113062.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_18 and arg_29_1.time_ < var_32_10 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113062008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113062008
		arg_33_1.duration_ = 15

		local var_33_0 = {
			ja = 15,
			ko = 12.866,
			zh = 10.9,
			en = 12.933
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
				arg_33_0:Play113062009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action482")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_36_0 = 0
			local var_36_1 = 1.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(113062008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 54 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 54)

				if (54 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 54)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062008", "story_v_out_113062.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_113062", "113062008", "story_v_out_113062.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_113062", "113062008", "story_v_out_113062.awb")

						arg_33_1:RecordAudio("113062008", var_36_7)
						arg_33_1:RecordAudio("113062008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113062", "113062008", "story_v_out_113062.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113062", "113062008", "story_v_out_113062.awb")
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
	Play113062009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113062009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play113062010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1042ui_story"]) and arg_37_1.var_.characterEffect1042ui_story == nil then
				arg_37_1.var_.characterEffect1042ui_story = arg_37_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1042ui_story"]) then
				if arg_37_1.var_.characterEffect1042ui_story and not isNil(arg_37_1.actors_["1042ui_story"]) then
					arg_37_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1042ui_story"]) and arg_37_1.var_.characterEffect1042ui_story then
				arg_37_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.5

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

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(113062009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 20 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 20)

				if (20 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 20)) > 0 and var_40_2 < var_40_5 then
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
	Play113062010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113062010
		arg_41_1.duration_ = 7.02

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play113062011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_0 = arg_41_1.bgs_.F01:GetComponent("SpriteRenderer")

				if var_44_0 then
					arg_41_1.var_.alphaOldValueF01 = var_44_0.color.a
					arg_41_1.var_.alphaMatValueF01 = var_44_0
				end

				arg_41_1.var_.alphaOldValueF01 = 1
			end

			local var_44_1 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				if arg_41_1.var_.alphaMatValueF01 then
					arg_41_1.var_.alphaMatValueF01.color.a = Mathf.Lerp(arg_41_1.var_.alphaOldValueF01, 0, (arg_41_1.time_ - 0) / var_44_1)
					arg_41_1.var_.alphaMatValueF01.color = arg_41_1.var_.alphaMatValueF01.color
				end
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 and arg_41_1.var_.alphaMatValueF01 then
				arg_41_1.var_.alphaMatValueF01.color.a = 0
				arg_41_1.var_.alphaMatValueF01.color = arg_41_1.var_.alphaMatValueF01.color
			end

			local var_44_2 = arg_41_1.actors_["1084ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = var_44_2.localPosition
			end

			local var_44_3 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_3)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0, 100, 0)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			local var_44_4 = arg_41_1.actors_["1042ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1042ui_story = var_44_4.localPosition
			end

			local var_44_5 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(0, 100, 0)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_6 = 2.01666666666667
			local var_44_7 = 0.6

			if 2.01666666666667 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_8 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_8:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(113062010).content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 24 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 24)

				if (24 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 24)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11
					var_44_6 = var_44_6 + 0.3

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = var_44_6 + 0.3
			local var_44_13 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_13 and arg_41_1.time_ < var_44_12 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play113062011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 113062011
		arg_47_1.duration_ = 14.67

		local var_47_0 = {
			ja = 11.766,
			ko = 14.666,
			zh = 11.2,
			en = 12.633
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play113062012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_0 = arg_47_1.bgs_.F01:GetComponent("SpriteRenderer")

				if var_50_0 then
					arg_47_1.var_.alphaOldValueF01 = var_50_0.color.a
					arg_47_1.var_.alphaMatValueF01 = var_50_0
				end

				arg_47_1.var_.alphaOldValueF01 = 0
			end

			local var_50_1 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				if arg_47_1.var_.alphaMatValueF01 then
					arg_47_1.var_.alphaMatValueF01.color.a = Mathf.Lerp(arg_47_1.var_.alphaOldValueF01, 1, (arg_47_1.time_ - 0) / var_50_1)
					arg_47_1.var_.alphaMatValueF01.color = arg_47_1.var_.alphaMatValueF01.color
				end
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 and arg_47_1.var_.alphaMatValueF01 then
				arg_47_1.var_.alphaMatValueF01.color.a = 1
				arg_47_1.var_.alphaMatValueF01.color = arg_47_1.var_.alphaMatValueF01.color
			end

			local var_50_2 = arg_47_1.actors_["1042ui_story"].transform

			if 1.8 < arg_47_1.time_ and arg_47_1.time_ <= 1.8 + arg_50_0 then
				arg_47_1.var_.moveOldPos1042ui_story = var_50_2.localPosition
			end

			local var_50_3 = 0.001

			if 1.8 <= arg_47_1.time_ and arg_47_1.time_ < 1.8 + var_50_3 then
				var_50_2.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_47_1.time_ - 1.8) / var_50_3)
				var_50_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_2.position).x, (manager.ui.mainCamera.transform.position - var_50_2.position).y, (manager.ui.mainCamera.transform.position - var_50_2.position).z)
				var_50_2.localEulerAngles.z = 0
				var_50_2.localEulerAngles.x = 0
				var_50_2.localEulerAngles = var_50_2.localEulerAngles
			end

			if arg_47_1.time_ >= 1.8 + var_50_3 and arg_47_1.time_ < 1.8 + var_50_3 + arg_50_0 then
				var_50_2.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_50_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_2.position).x, (manager.ui.mainCamera.transform.position - var_50_2.position).y, (manager.ui.mainCamera.transform.position - var_50_2.position).z)
				var_50_2.localEulerAngles.z = 0
				var_50_2.localEulerAngles.x = 0
				var_50_2.localEulerAngles = var_50_2.localEulerAngles
			end

			if 1.8 < arg_47_1.time_ and arg_47_1.time_ <= 1.8 + arg_50_0 then
				arg_47_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 1.8 < arg_47_1.time_ and arg_47_1.time_ <= 1.8 + arg_50_0 then
				arg_47_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_50_4 = arg_47_1.actors_["1042ui_story"]

			if 1.8 < arg_47_1.time_ and arg_47_1.time_ <= 1.8 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1042ui_story == nil then
				arg_47_1.var_.characterEffect1042ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.2

			if 1.8 <= arg_47_1.time_ and arg_47_1.time_ < 1.8 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect1042ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 1.8 + var_50_5 and arg_47_1.time_ < 1.8 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1042ui_story then
				arg_47_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_7 = 2
			local var_50_8 = 1.275

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_9 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_9:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(113062011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 51 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_11) / 51)

				if (51 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_11) / 51)) > 0 and var_50_8 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13
					var_50_7 = var_50_7 + 0.3

					if var_50_13 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062011", "story_v_out_113062.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_113062", "113062011", "story_v_out_113062.awb") / 1000

					if var_50_14 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_7
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_113062", "113062011", "story_v_out_113062.awb")

						arg_47_1:RecordAudio("113062011", var_50_15)
						arg_47_1:RecordAudio("113062011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_113062", "113062011", "story_v_out_113062.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_113062", "113062011", "story_v_out_113062.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = var_50_7 + 0.3
			local var_50_17 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_16) / var_50_17

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play113062012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 113062012
		arg_53_1.duration_ = 10.53

		local var_53_0 = {
			ja = 10.533,
			ko = 6.166,
			zh = 6.7,
			en = 8.2
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
				arg_53_0:Play113062013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action424")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_0 = 0
			local var_56_1 = 0.9

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(113062012)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 30 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 30)

				if (30 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 30)) > 0 and var_56_1 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062012", "story_v_out_113062.awb") ~= 0 then
					local var_56_6 = manager.audio:GetVoiceLength("story_v_out_113062", "113062012", "story_v_out_113062.awb") / 1000

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end

					if var_56_2.prefab_name ~= "" and arg_53_1.actors_[var_56_2.prefab_name] ~= nil then
						local var_56_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_2.prefab_name].transform, "story_v_out_113062", "113062012", "story_v_out_113062.awb")

						arg_53_1:RecordAudio("113062012", var_56_7)
						arg_53_1:RecordAudio("113062012", var_56_7)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_113062", "113062012", "story_v_out_113062.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_113062", "113062012", "story_v_out_113062.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play113062013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 113062013
		arg_57_1.duration_ = 9.53

		local var_57_0 = {
			ja = 9.533,
			ko = 6.633,
			zh = 7.333,
			en = 7.8
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
				arg_57_0:Play113062014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_60_0 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_57_1.stage_.transform)

				var_60_0.name = "1041ui_story"
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1041ui_story"] = var_60_0

				local var_60_1 = var_60_0:GetComponentInChildren(typeof(CharacterEffect))

				var_60_1.enabled = true

				local var_60_2 = GameObjectTools.GetOrAddComponent(var_60_0, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(false)
				end

				arg_57_1:ShowWeapon(var_60_1.transform, false)

				arg_57_1.var_["1041ui_story" .. "Animator"] = var_60_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_57_1.var_["1041ui_story" .. "Animator"].applyRootMotion = true
				arg_57_1.var_["1041ui_story" .. "LipSync"] = var_60_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_60_3 = arg_57_1.actors_["1041ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1041ui_story = var_60_3.localPosition
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_3.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_57_1.time_ - 0) / var_60_4)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_60_5 = arg_57_1.actors_["1041ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1041ui_story == nil then
				arg_57_1.var_.characterEffect1041ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.characterEffect1041ui_story and not isNil(var_60_5) then
					arg_57_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1041ui_story then
				arg_57_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_60_8 = arg_57_1.actors_["1042ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.characterEffect1042ui_story == nil then
				arg_57_1.var_.characterEffect1042ui_story = var_60_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_9 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_9 and not isNil(var_60_8) then
				if arg_57_1.var_.characterEffect1042ui_story and not isNil(var_60_8) then
					arg_57_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_9)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_9 and arg_57_1.time_ < 0 + var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.characterEffect1042ui_story then
				arg_57_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_60_10 = 0
			local var_60_11 = 0.875

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_12 = arg_57_1:GetWordFromCfg(113062013)
				local var_60_13 = arg_57_1:FormatText(var_60_12.content)

				arg_57_1.text_.text = var_60_13

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_15 = 35 <= 0 and var_60_11 or var_60_11 * (utf8.len(var_60_13) / 35)

				if (35 <= 0 and var_60_11 or var_60_11 * (utf8.len(var_60_13) / 35)) > 0 and var_60_11 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_10 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_10
					end
				end

				arg_57_1.text_.text = var_60_13
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062013", "story_v_out_113062.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062013", "story_v_out_113062.awb") / 1000

					if var_60_16 + var_60_10 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_10
					end

					if var_60_12.prefab_name ~= "" and arg_57_1.actors_[var_60_12.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_12.prefab_name].transform, "story_v_out_113062", "113062013", "story_v_out_113062.awb")

						arg_57_1:RecordAudio("113062013", var_60_17)
						arg_57_1:RecordAudio("113062013", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_113062", "113062013", "story_v_out_113062.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_113062", "113062013", "story_v_out_113062.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_11, arg_57_1.talkMaxDuration)

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_10) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_10 + var_60_18 and arg_57_1.time_ < var_60_10 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play113062014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 113062014
		arg_61_1.duration_ = 16.23

		local var_61_0 = {
			ja = 16.233,
			ko = 13.5,
			zh = 13.7,
			en = 12.833
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
				arg_61_0:Play113062015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1041ui_story"]) and arg_61_1.var_.characterEffect1041ui_story == nil then
				arg_61_1.var_.characterEffect1041ui_story = arg_61_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1041ui_story"]) then
				if arg_61_1.var_.characterEffect1041ui_story and not isNil(arg_61_1.actors_["1041ui_story"]) then
					arg_61_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1041ui_story"]) and arg_61_1.var_.characterEffect1041ui_story then
				arg_61_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_64_1 = arg_61_1.actors_["1042ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1042ui_story == nil then
				arg_61_1.var_.characterEffect1042ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1042ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1042ui_story then
				arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action5_2")
			end

			local var_64_4 = 0
			local var_64_5 = 1.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(113062014)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 55 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 55)

				if (55 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 55)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062014", "story_v_out_113062.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062014", "story_v_out_113062.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_113062", "113062014", "story_v_out_113062.awb")

						arg_61_1:RecordAudio("113062014", var_64_11)
						arg_61_1:RecordAudio("113062014", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_113062", "113062014", "story_v_out_113062.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_113062", "113062014", "story_v_out_113062.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play113062015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 113062015
		arg_65_1.duration_ = 12.83

		local var_65_0 = {
			ja = 12.833,
			ko = 10.366,
			zh = 10.8,
			en = 11.566
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
				arg_65_0:Play113062016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1042ui_story"]) and arg_65_1.var_.characterEffect1042ui_story == nil then
				arg_65_1.var_.characterEffect1042ui_story = arg_65_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1042ui_story"]) then
				if arg_65_1.var_.characterEffect1042ui_story and not isNil(arg_65_1.actors_["1042ui_story"]) then
					arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1042ui_story"]) and arg_65_1.var_.characterEffect1042ui_story then
				arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_68_1 = arg_65_1.actors_["1041ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1041ui_story == nil then
				arg_65_1.var_.characterEffect1041ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1041ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1041ui_story then
				arg_65_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_4 = 0
			local var_68_5 = 1.15

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(113062015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 46 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 46)

				if (46 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 46)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062015", "story_v_out_113062.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062015", "story_v_out_113062.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_113062", "113062015", "story_v_out_113062.awb")

						arg_65_1:RecordAudio("113062015", var_68_11)
						arg_65_1:RecordAudio("113062015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_113062", "113062015", "story_v_out_113062.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_113062", "113062015", "story_v_out_113062.awb")
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
	Play113062016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 113062016
		arg_69_1.duration_ = 4.6

		local var_69_0 = {
			ja = 4.6,
			ko = 3.533,
			zh = 4.5,
			en = 3.5
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
				arg_69_0:Play113062017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1041ui_story = arg_69_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1041ui_story"].transform.position).z)
				arg_69_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1041ui_story"].transform.localEulerAngles = arg_69_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1041ui_story"].transform.position).z)
				arg_69_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1041ui_story"].transform.localEulerAngles = arg_69_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1042ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1042ui_story = var_72_1.localPosition
			end

			local var_72_2 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 then
				var_72_1.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_2)
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

			local var_72_3 = arg_69_1.actors_["1084ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1084ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_72_5 = arg_69_1.actors_["1084ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_72_8 = 0
			local var_72_9 = 0.375

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(113062016)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 15 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 15)

				if (15 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 15)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062016", "story_v_out_113062.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_113062", "113062016", "story_v_out_113062.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_113062", "113062016", "story_v_out_113062.awb")

						arg_69_1:RecordAudio("113062016", var_72_15)
						arg_69_1:RecordAudio("113062016", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_113062", "113062016", "story_v_out_113062.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_113062", "113062016", "story_v_out_113062.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play113062017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 113062017
		arg_73_1.duration_ = 9.4

		local var_73_0 = {
			ja = 7.6,
			ko = 9.133,
			zh = 8.033,
			en = 9.4
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
				arg_73_0:Play113062018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = arg_73_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(arg_73_1.actors_["1084ui_story"]) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_76_1 = "1038ui_story"

			if arg_73_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_76_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_73_1.stage_.transform)

				var_76_2.name = var_76_1
				var_76_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_[var_76_1] = var_76_2

				local var_76_3 = var_76_2:GetComponentInChildren(typeof(CharacterEffect))

				var_76_3.enabled = true

				local var_76_4 = GameObjectTools.GetOrAddComponent(var_76_2, typeof(DynamicBoneHelper))

				if var_76_4 then
					var_76_4:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_3.transform, false)

				arg_73_1.var_[var_76_1 .. "Animator"] = var_76_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_[var_76_1 .. "Animator"].applyRootMotion = true
				arg_73_1.var_[var_76_1 .. "LipSync"] = var_76_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_5 = arg_73_1.actors_["1038ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1038ui_story = var_76_5.localPosition
			end

			local var_76_6 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 then
				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_73_1.time_ - 0) / var_76_6)
				var_76_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_5.position).x, (manager.ui.mainCamera.transform.position - var_76_5.position).y, (manager.ui.mainCamera.transform.position - var_76_5.position).z)
				var_76_5.localEulerAngles.z = 0
				var_76_5.localEulerAngles.x = 0
				var_76_5.localEulerAngles = var_76_5.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_76_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_5.position).x, (manager.ui.mainCamera.transform.position - var_76_5.position).y, (manager.ui.mainCamera.transform.position - var_76_5.position).z)
				var_76_5.localEulerAngles.z = 0
				var_76_5.localEulerAngles.x = 0
				var_76_5.localEulerAngles = var_76_5.localEulerAngles
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_76_7 = arg_73_1.actors_["1038ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1038ui_story == nil then
				arg_73_1.var_.characterEffect1038ui_story = var_76_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_8 and not isNil(var_76_7) then
				if arg_73_1.var_.characterEffect1038ui_story and not isNil(var_76_7) then
					arg_73_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_8 and arg_73_1.time_ < 0 + var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1038ui_story then
				arg_73_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_76_10 = 0
			local var_76_11 = 0.975

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_12 = arg_73_1:GetWordFromCfg(113062017)
				local var_76_13 = arg_73_1:FormatText(var_76_12.content)

				arg_73_1.text_.text = var_76_13

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_15 = 39 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_13) / 39)

				if (39 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_13) / 39)) > 0 and var_76_11 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_10
					end
				end

				arg_73_1.text_.text = var_76_13
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062017", "story_v_out_113062.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062017", "story_v_out_113062.awb") / 1000

					if var_76_16 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_10
					end

					if var_76_12.prefab_name ~= "" and arg_73_1.actors_[var_76_12.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_12.prefab_name].transform, "story_v_out_113062", "113062017", "story_v_out_113062.awb")

						arg_73_1:RecordAudio("113062017", var_76_17)
						arg_73_1:RecordAudio("113062017", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_113062", "113062017", "story_v_out_113062.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_113062", "113062017", "story_v_out_113062.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_18 and arg_73_1.time_ < var_76_10 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play113062018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 113062018
		arg_77_1.duration_ = 9.63

		local var_77_0 = {
			ja = 7,
			ko = 8.566,
			zh = 6.5,
			en = 9.633
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
				arg_77_0:Play113062019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_80_0 = 0
			local var_80_1 = 0.85

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(113062018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 34 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 34)

				if (34 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 34)) > 0 and var_80_1 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062018", "story_v_out_113062.awb") ~= 0 then
					local var_80_6 = manager.audio:GetVoiceLength("story_v_out_113062", "113062018", "story_v_out_113062.awb") / 1000

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end

					if var_80_2.prefab_name ~= "" and arg_77_1.actors_[var_80_2.prefab_name] ~= nil then
						local var_80_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_2.prefab_name].transform, "story_v_out_113062", "113062018", "story_v_out_113062.awb")

						arg_77_1:RecordAudio("113062018", var_80_7)
						arg_77_1:RecordAudio("113062018", var_80_7)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_113062", "113062018", "story_v_out_113062.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_113062", "113062018", "story_v_out_113062.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play113062019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 113062019
		arg_81_1.duration_ = 13.77

		local var_81_0 = {
			ja = 8.4,
			ko = 13.766,
			zh = 10.4,
			en = 11.3
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
				arg_81_0:Play113062020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_84_0 = 0
			local var_84_1 = 1.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(113062019)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 52 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 52)

				if (52 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 52)) > 0 and var_84_1 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062019", "story_v_out_113062.awb") ~= 0 then
					local var_84_6 = manager.audio:GetVoiceLength("story_v_out_113062", "113062019", "story_v_out_113062.awb") / 1000

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end

					if var_84_2.prefab_name ~= "" and arg_81_1.actors_[var_84_2.prefab_name] ~= nil then
						local var_84_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_2.prefab_name].transform, "story_v_out_113062", "113062019", "story_v_out_113062.awb")

						arg_81_1:RecordAudio("113062019", var_84_7)
						arg_81_1:RecordAudio("113062019", var_84_7)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_113062", "113062019", "story_v_out_113062.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_113062", "113062019", "story_v_out_113062.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play113062020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 113062020
		arg_85_1.duration_ = 5.63

		local var_85_0 = {
			ja = 3.366,
			ko = 5.633,
			zh = 3.3,
			en = 3.166
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
				arg_85_0:Play113062021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = arg_85_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) then
				if arg_85_1.var_.characterEffect1084ui_story and not isNil(arg_85_1.actors_["1084ui_story"]) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_2 = arg_85_1.actors_["1038ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1038ui_story == nil then
				arg_85_1.var_.characterEffect1038ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect1038ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1038ui_story then
				arg_85_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(113062020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 16 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 16)

				if (16 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 16)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062020", "story_v_out_113062.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062020", "story_v_out_113062.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_113062", "113062020", "story_v_out_113062.awb")

						arg_85_1:RecordAudio("113062020", var_88_11)
						arg_85_1:RecordAudio("113062020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_113062", "113062020", "story_v_out_113062.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_113062", "113062020", "story_v_out_113062.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play113062021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 113062021
		arg_89_1.duration_ = 6.33

		local var_89_0 = {
			ja = 6.333,
			ko = 4.7,
			zh = 4.133,
			en = 6.2
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
				arg_89_0:Play113062022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = arg_89_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(arg_89_1.actors_["1084ui_story"]) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["1038ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1038ui_story == nil then
				arg_89_1.var_.characterEffect1038ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1038ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1038ui_story then
				arg_89_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_92_4 = 0
			local var_92_5 = 0.5

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(113062021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 19 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 19)

				if (19 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 19)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062021", "story_v_out_113062.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062021", "story_v_out_113062.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_113062", "113062021", "story_v_out_113062.awb")

						arg_89_1:RecordAudio("113062021", var_92_11)
						arg_89_1:RecordAudio("113062021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_113062", "113062021", "story_v_out_113062.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_113062", "113062021", "story_v_out_113062.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play113062022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 113062022
		arg_93_1.duration_ = 12.1

		local var_93_0 = {
			ja = 12.1,
			ko = 9.633,
			zh = 8.533,
			en = 9.033
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
				arg_93_0:Play113062023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = arg_93_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1038ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1038ui_story = var_96_1.localPosition
			end

			local var_96_2 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 then
				var_96_1.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_2)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 then
				var_96_1.localPosition = Vector3.New(0, 100, 0)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			local var_96_3 = "6045_story"

			if arg_93_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_96_4 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_93_1.stage_.transform)

				var_96_4.name = var_96_3
				var_96_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_[var_96_3] = var_96_4

				local var_96_5 = var_96_4:GetComponentInChildren(typeof(CharacterEffect))

				var_96_5.enabled = true

				local var_96_6 = GameObjectTools.GetOrAddComponent(var_96_4, typeof(DynamicBoneHelper))

				if var_96_6 then
					var_96_6:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_5.transform, false)

				arg_93_1.var_[var_96_3 .. "Animator"] = var_96_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_[var_96_3 .. "Animator"].applyRootMotion = true
				arg_93_1.var_[var_96_3 .. "LipSync"] = var_96_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_7 = arg_93_1.actors_["6045_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos6045_story = var_96_7.localPosition

				local var_96_8 = GameObjectTools.GetOrAddComponent(var_96_7.gameObject, typeof(DynamicBoneHelper))

				if var_96_8 then
					var_96_8:EnableDynamicBone(false)
				end
			end

			local var_96_9 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 then
				var_96_7.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_93_1.time_ - 0) / var_96_9)
				var_96_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_7.position).x, (manager.ui.mainCamera.transform.position - var_96_7.position).y, (manager.ui.mainCamera.transform.position - var_96_7.position).z)
				var_96_7.localEulerAngles.z = 0
				var_96_7.localEulerAngles.x = 0
				var_96_7.localEulerAngles = var_96_7.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 then
				var_96_7.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_96_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_7.position).x, (manager.ui.mainCamera.transform.position - var_96_7.position).y, (manager.ui.mainCamera.transform.position - var_96_7.position).z)
				var_96_7.localEulerAngles.z = 0
				var_96_7.localEulerAngles.x = 0
				var_96_7.localEulerAngles = var_96_7.localEulerAngles

				local var_96_10 = GameObjectTools.GetOrAddComponent(var_96_7.gameObject, typeof(DynamicBoneHelper))

				if var_96_10 then
					var_96_10:EnableDynamicBone(true)
				end
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_96_11 = arg_93_1.actors_["6045_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect6045_story == nil then
				arg_93_1.var_.characterEffect6045_story = var_96_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_12 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_12 and not isNil(var_96_11) then
				if arg_93_1.var_.characterEffect6045_story and not isNil(var_96_11) then
					arg_93_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_12 and arg_93_1.time_ < 0 + var_96_12 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect6045_story then
				arg_93_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_96_14 = 0
			local var_96_15 = 0.7

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_16 = arg_93_1:GetWordFromCfg(113062022)
				local var_96_17 = arg_93_1:FormatText(var_96_16.content)

				arg_93_1.text_.text = var_96_17

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 28 <= 0 and var_96_15 or var_96_15 * (utf8.len(var_96_17) / 28)

				if (28 <= 0 and var_96_15 or var_96_15 * (utf8.len(var_96_17) / 28)) > 0 and var_96_15 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19

					if var_96_19 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_14
					end
				end

				arg_93_1.text_.text = var_96_17
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062022", "story_v_out_113062.awb") ~= 0 then
					local var_96_20 = manager.audio:GetVoiceLength("story_v_out_113062", "113062022", "story_v_out_113062.awb") / 1000

					if var_96_20 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_14
					end

					if var_96_16.prefab_name ~= "" and arg_93_1.actors_[var_96_16.prefab_name] ~= nil then
						local var_96_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_16.prefab_name].transform, "story_v_out_113062", "113062022", "story_v_out_113062.awb")

						arg_93_1:RecordAudio("113062022", var_96_21)
						arg_93_1:RecordAudio("113062022", var_96_21)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_113062", "113062022", "story_v_out_113062.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_113062", "113062022", "story_v_out_113062.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_15, arg_93_1.talkMaxDuration)

			if var_96_14 <= arg_93_1.time_ and arg_93_1.time_ < var_96_14 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_14) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_14 + var_96_22 and arg_93_1.time_ < var_96_14 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play113062023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113062023
		arg_97_1.duration_ = 3.47

		local var_97_0 = {
			ja = 3.466,
			ko = 3.033,
			zh = 2.766,
			en = 2.433
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
				arg_97_0:Play113062024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["6045_story"]) and arg_97_1.var_.characterEffect6045_story == nil then
				arg_97_1.var_.characterEffect6045_story = arg_97_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["6045_story"]) then
				if arg_97_1.var_.characterEffect6045_story and not isNil(arg_97_1.actors_["6045_story"]) then
					arg_97_1.var_.characterEffect6045_story.fillFlat = true
					arg_97_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["6045_story"]) and arg_97_1.var_.characterEffect6045_story then
				arg_97_1.var_.characterEffect6045_story.fillFlat = true
				arg_97_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_100_1 = "6046_story"

			if arg_97_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_100_2 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_97_1.stage_.transform)

				var_100_2.name = var_100_1
				var_100_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_[var_100_1] = var_100_2

				local var_100_3 = var_100_2:GetComponentInChildren(typeof(CharacterEffect))

				var_100_3.enabled = true

				local var_100_4 = GameObjectTools.GetOrAddComponent(var_100_2, typeof(DynamicBoneHelper))

				if var_100_4 then
					var_100_4:EnableDynamicBone(false)
				end

				arg_97_1:ShowWeapon(var_100_3.transform, false)

				arg_97_1.var_[var_100_1 .. "Animator"] = var_100_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_97_1.var_[var_100_1 .. "Animator"].applyRootMotion = true
				arg_97_1.var_[var_100_1 .. "LipSync"] = var_100_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_100_5 = arg_97_1.actors_["6046_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos6046_story = var_100_5.localPosition

				local var_100_6 = GameObjectTools.GetOrAddComponent(var_100_5.gameObject, typeof(DynamicBoneHelper))

				if var_100_6 then
					var_100_6:EnableDynamicBone(false)
				end
			end

			local var_100_7 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_97_1.time_ - 0) / var_100_7)
				var_100_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_5.position).x, (manager.ui.mainCamera.transform.position - var_100_5.position).y, (manager.ui.mainCamera.transform.position - var_100_5.position).z)
				var_100_5.localEulerAngles.z = 0
				var_100_5.localEulerAngles.x = 0
				var_100_5.localEulerAngles = var_100_5.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_100_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_5.position).x, (manager.ui.mainCamera.transform.position - var_100_5.position).y, (manager.ui.mainCamera.transform.position - var_100_5.position).z)
				var_100_5.localEulerAngles.z = 0
				var_100_5.localEulerAngles.x = 0
				var_100_5.localEulerAngles = var_100_5.localEulerAngles

				local var_100_8 = GameObjectTools.GetOrAddComponent(var_100_5.gameObject, typeof(DynamicBoneHelper))

				if var_100_8 then
					var_100_8:EnableDynamicBone(true)
				end
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_100_9 = arg_97_1.actors_["6046_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect6046_story == nil then
				arg_97_1.var_.characterEffect6046_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_10 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_10 and not isNil(var_100_9) then
				if arg_97_1.var_.characterEffect6046_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_10 and arg_97_1.time_ < 0 + var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect6046_story then
				arg_97_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_100_12 = 0
			local var_100_13 = 0.25

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_14 = arg_97_1:GetWordFromCfg(113062023)
				local var_100_15 = arg_97_1:FormatText(var_100_14.content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_17 = 10 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 10)

				if (10 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 10)) > 0 and var_100_13 < var_100_17 then
					arg_97_1.talkMaxDuration = var_100_17

					if var_100_17 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_12
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062023", "story_v_out_113062.awb") ~= 0 then
					local var_100_18 = manager.audio:GetVoiceLength("story_v_out_113062", "113062023", "story_v_out_113062.awb") / 1000

					if var_100_18 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_12
					end

					if var_100_14.prefab_name ~= "" and arg_97_1.actors_[var_100_14.prefab_name] ~= nil then
						local var_100_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_14.prefab_name].transform, "story_v_out_113062", "113062023", "story_v_out_113062.awb")

						arg_97_1:RecordAudio("113062023", var_100_19)
						arg_97_1:RecordAudio("113062023", var_100_19)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113062", "113062023", "story_v_out_113062.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113062", "113062023", "story_v_out_113062.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_20 = math.max(var_100_13, arg_97_1.talkMaxDuration)

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_20 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_12) / var_100_20

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_12 + var_100_20 and arg_97_1.time_ < var_100_12 + var_100_20 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play113062024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113062024
		arg_101_1.duration_ = 4.8

		local var_101_0 = {
			ja = 3.666,
			ko = 3.7,
			zh = 3.3,
			en = 4.8
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
				arg_101_0:Play113062025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos6046_story = arg_101_1.actors_["6046_story"].transform.localPosition

				local var_104_0 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_0 then
					var_104_0:EnableDynamicBone(false)
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_1)
				arg_101_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).z)
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles = arg_101_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).z)
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles = arg_101_1.actors_["6046_story"].transform.localEulerAngles

				local var_104_2 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(true)
				end
			end

			local var_104_3 = arg_101_1.actors_["6045_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos6045_story = var_104_3.localPosition

				local var_104_4 = GameObjectTools.GetOrAddComponent(var_104_3.gameObject, typeof(DynamicBoneHelper))

				if var_104_4 then
					var_104_4:EnableDynamicBone(false)
				end
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_5)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(0, 100, 0)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles

				local var_104_6 = GameObjectTools.GetOrAddComponent(var_104_3.gameObject, typeof(DynamicBoneHelper))

				if var_104_6 then
					var_104_6:EnableDynamicBone(true)
				end
			end

			local var_104_7 = arg_101_1.actors_["1084ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1084ui_story = var_104_7.localPosition
			end

			local var_104_8 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_8 then
				var_104_7.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_101_1.time_ - 0) / var_104_8)
				var_104_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_7.position).x, (manager.ui.mainCamera.transform.position - var_104_7.position).y, (manager.ui.mainCamera.transform.position - var_104_7.position).z)
				var_104_7.localEulerAngles.z = 0
				var_104_7.localEulerAngles.x = 0
				var_104_7.localEulerAngles = var_104_7.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_8 and arg_101_1.time_ < 0 + var_104_8 + arg_104_0 then
				var_104_7.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_104_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_7.position).x, (manager.ui.mainCamera.transform.position - var_104_7.position).y, (manager.ui.mainCamera.transform.position - var_104_7.position).z)
				var_104_7.localEulerAngles.z = 0
				var_104_7.localEulerAngles.x = 0
				var_104_7.localEulerAngles = var_104_7.localEulerAngles
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_104_9 = arg_101_1.actors_["1084ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_10 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_10 and not isNil(var_104_9) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_10 and arg_101_1.time_ < 0 + var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_104_12 = 0
			local var_104_13 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_14 = arg_101_1:GetWordFromCfg(113062024)
				local var_104_15 = arg_101_1:FormatText(var_104_14.content)

				arg_101_1.text_.text = var_104_15

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 15 <= 0 and var_104_13 or var_104_13 * (utf8.len(var_104_15) / 15)

				if (15 <= 0 and var_104_13 or var_104_13 * (utf8.len(var_104_15) / 15)) > 0 and var_104_13 < var_104_17 then
					arg_101_1.talkMaxDuration = var_104_17

					if var_104_17 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_17 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_15
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062024", "story_v_out_113062.awb") ~= 0 then
					local var_104_18 = manager.audio:GetVoiceLength("story_v_out_113062", "113062024", "story_v_out_113062.awb") / 1000

					if var_104_18 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_12
					end

					if var_104_14.prefab_name ~= "" and arg_101_1.actors_[var_104_14.prefab_name] ~= nil then
						local var_104_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_14.prefab_name].transform, "story_v_out_113062", "113062024", "story_v_out_113062.awb")

						arg_101_1:RecordAudio("113062024", var_104_19)
						arg_101_1:RecordAudio("113062024", var_104_19)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_113062", "113062024", "story_v_out_113062.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_113062", "113062024", "story_v_out_113062.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_20 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_20 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_12) / var_104_20

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_12 + var_104_20 and arg_101_1.time_ < var_104_12 + var_104_20 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play113062025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113062025
		arg_105_1.duration_ = 6.3

		local var_105_0 = {
			ja = 3.866,
			ko = 6.3,
			zh = 4.1,
			en = 4.633
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
				arg_105_0:Play113062026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos6045_story = arg_105_1.actors_["6045_story"].transform.localPosition

				local var_108_0 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_0 then
					var_108_0:EnableDynamicBone(false)
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos6045_story, Vector3.New(0.7, -0.5, -6.3), (arg_105_1.time_ - 0) / var_108_1)
				arg_105_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6045_story"].transform.position).z)
				arg_105_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["6045_story"].transform.localEulerAngles = arg_105_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["6045_story"].transform.localPosition = Vector3.New(0.7, -0.5, -6.3)
				arg_105_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6045_story"].transform.position).z)
				arg_105_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["6045_story"].transform.localEulerAngles = arg_105_1.actors_["6045_story"].transform.localEulerAngles

				local var_108_2 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_108_3 = arg_105_1.actors_["6045_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect6045_story == nil then
				arg_105_1.var_.characterEffect6045_story = var_108_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 and not isNil(var_108_3) then
				if arg_105_1.var_.characterEffect6045_story and not isNil(var_108_3) then
					arg_105_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect6045_story then
				arg_105_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_108_6 = arg_105_1.actors_["1084ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1084ui_story then
				arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_108_8 = 0
			local var_108_9 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(113062025)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 16 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 16)

				if (16 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 16)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062025", "story_v_out_113062.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_113062", "113062025", "story_v_out_113062.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_113062", "113062025", "story_v_out_113062.awb")

						arg_105_1:RecordAudio("113062025", var_108_15)
						arg_105_1:RecordAudio("113062025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_113062", "113062025", "story_v_out_113062.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_113062", "113062025", "story_v_out_113062.awb")
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
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play113062026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113062026
		arg_109_1.duration_ = 4.83

		local var_109_0 = {
			ja = 3.5,
			ko = 4.833,
			zh = 2.4,
			en = 2.6
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play113062027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action459")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_112_0 = arg_109_1.actors_["1084ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_1 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(var_112_0) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_112_3 = 0
			local var_112_4 = 0.325

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(113062026)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 13 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 13)

				if (13 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 13)) > 0 and var_112_4 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062026", "story_v_out_113062.awb") ~= 0 then
					local var_112_9 = manager.audio:GetVoiceLength("story_v_out_113062", "113062026", "story_v_out_113062.awb") / 1000

					if var_112_9 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_3
					end

					if var_112_5.prefab_name ~= "" and arg_109_1.actors_[var_112_5.prefab_name] ~= nil then
						local var_112_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_5.prefab_name].transform, "story_v_out_113062", "113062026", "story_v_out_113062.awb")

						arg_109_1:RecordAudio("113062026", var_112_10)
						arg_109_1:RecordAudio("113062026", var_112_10)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113062", "113062026", "story_v_out_113062.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113062", "113062026", "story_v_out_113062.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_11 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_11 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_11

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_11 and arg_109_1.time_ < var_112_3 + var_112_11 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play113062027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113062027
		arg_113_1.duration_ = 3.83

		local var_113_0 = {
			ja = 3.466,
			ko = 3.1,
			zh = 3.833,
			en = 3.6
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
				arg_113_0:Play113062028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos6045_story = arg_113_1.actors_["6045_story"].transform.localPosition

				local var_116_0 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_0 then
					var_116_0:EnableDynamicBone(false)
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_1)
				arg_113_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["6045_story"].transform.position).z)
				arg_113_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["6045_story"].transform.localEulerAngles = arg_113_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["6045_story"].transform.position).z)
				arg_113_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["6045_story"].transform.localEulerAngles = arg_113_1.actors_["6045_story"].transform.localEulerAngles

				local var_116_2 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(true)
				end
			end

			local var_116_3 = arg_113_1.actors_["1042ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1042ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_116_5 = arg_113_1.actors_["1042ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1042ui_story == nil then
				arg_113_1.var_.characterEffect1042ui_story = var_116_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.characterEffect1042ui_story and not isNil(var_116_5) then
					arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1042ui_story then
				arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_116_8 = arg_113_1.actors_["1084ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_9 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_9 and not isNil(var_116_8) then
				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_8) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_9)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_9 and arg_113_1.time_ < 0 + var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_116_10 = 0
			local var_116_11 = 0.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_12 = arg_113_1:GetWordFromCfg(113062027)
				local var_116_13 = arg_113_1:FormatText(var_116_12.content)

				arg_113_1.text_.text = var_116_13

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_15 = 12 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 12)

				if (12 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 12)) > 0 and var_116_11 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_10
					end
				end

				arg_113_1.text_.text = var_116_13
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062027", "story_v_out_113062.awb") ~= 0 then
					local var_116_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062027", "story_v_out_113062.awb") / 1000

					if var_116_16 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_10
					end

					if var_116_12.prefab_name ~= "" and arg_113_1.actors_[var_116_12.prefab_name] ~= nil then
						local var_116_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_12.prefab_name].transform, "story_v_out_113062", "113062027", "story_v_out_113062.awb")

						arg_113_1:RecordAudio("113062027", var_116_17)
						arg_113_1:RecordAudio("113062027", var_116_17)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113062", "113062027", "story_v_out_113062.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113062", "113062027", "story_v_out_113062.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_18 = math.max(var_116_11, arg_113_1.talkMaxDuration)

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_18 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_10) / var_116_18

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_10 + var_116_18 and arg_113_1.time_ < var_116_10 + var_116_18 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play113062028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113062028
		arg_117_1.duration_ = 4.9

		local var_117_0 = {
			ja = 4.9,
			ko = 4.833,
			zh = 4.8,
			en = 3.366
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play113062029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1084ui_story = arg_117_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1084ui_story"].transform.position).z)
				arg_117_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1084ui_story"].transform.localEulerAngles = arg_117_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1084ui_story"].transform.position).z)
				arg_117_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1084ui_story"].transform.localEulerAngles = arg_117_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1042ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1042ui_story = var_120_1.localPosition
			end

			local var_120_2 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 then
				var_120_1.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_2)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 then
				var_120_1.localPosition = Vector3.New(0, 100, 0)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			local var_120_3 = 0
			local var_120_4 = 0.15

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_5 = arg_117_1:GetWordFromCfg(113062028)
				local var_120_6 = arg_117_1:FormatText(var_120_5.content)

				arg_117_1.text_.text = var_120_6

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_8 = 6 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_6) / 6)

				if (6 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_6) / 6)) > 0 and var_120_4 < var_120_8 then
					arg_117_1.talkMaxDuration = var_120_8

					if var_120_8 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_3
					end
				end

				arg_117_1.text_.text = var_120_6
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062028", "story_v_out_113062.awb") ~= 0 then
					local var_120_9 = manager.audio:GetVoiceLength("story_v_out_113062", "113062028", "story_v_out_113062.awb") / 1000

					if var_120_9 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_3
					end

					if var_120_5.prefab_name ~= "" and arg_117_1.actors_[var_120_5.prefab_name] ~= nil then
						local var_120_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_5.prefab_name].transform, "story_v_out_113062", "113062028", "story_v_out_113062.awb")

						arg_117_1:RecordAudio("113062028", var_120_10)
						arg_117_1:RecordAudio("113062028", var_120_10)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113062", "113062028", "story_v_out_113062.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113062", "113062028", "story_v_out_113062.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_4, arg_117_1.talkMaxDuration)

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_3) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_3 + var_120_11 and arg_117_1.time_ < var_120_3 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play113062029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113062029
		arg_121_1.duration_ = 3.23

		local var_121_0 = {
			ja = 3.233,
			ko = 2.333,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play113062030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_124_0 = arg_121_1.actors_["1042ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1042ui_story = var_124_0.localPosition
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_121_1.time_ - 0) / var_124_1)
				var_124_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_0.position).x, (manager.ui.mainCamera.transform.position - var_124_0.position).y, (manager.ui.mainCamera.transform.position - var_124_0.position).z)
				var_124_0.localEulerAngles.z = 0
				var_124_0.localEulerAngles.x = 0
				var_124_0.localEulerAngles = var_124_0.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_124_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_0.position).x, (manager.ui.mainCamera.transform.position - var_124_0.position).y, (manager.ui.mainCamera.transform.position - var_124_0.position).z)
				var_124_0.localEulerAngles.z = 0
				var_124_0.localEulerAngles.x = 0
				var_124_0.localEulerAngles = var_124_0.localEulerAngles
			end

			local var_124_2 = arg_121_1.actors_["1042ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1042ui_story == nil then
				arg_121_1.var_.characterEffect1042ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1042ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1042ui_story then
				arg_121_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_124_5 = 0
			local var_124_6 = 0.15

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:GetWordFromCfg(113062029)
				local var_124_8 = arg_121_1:FormatText(var_124_7.content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 6 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 6)

				if (6 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 6)) > 0 and var_124_6 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062029", "story_v_out_113062.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_out_113062", "113062029", "story_v_out_113062.awb") / 1000

					if var_124_11 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_5
					end

					if var_124_7.prefab_name ~= "" and arg_121_1.actors_[var_124_7.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_7.prefab_name].transform, "story_v_out_113062", "113062029", "story_v_out_113062.awb")

						arg_121_1:RecordAudio("113062029", var_124_12)
						arg_121_1:RecordAudio("113062029", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113062", "113062029", "story_v_out_113062.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113062", "113062029", "story_v_out_113062.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_13 and arg_121_1.time_ < var_124_5 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play113062030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113062030
		arg_125_1.duration_ = 10.63

		local var_125_0 = {
			ja = 10.633,
			ko = 6.7,
			zh = 5.366,
			en = 8.766
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
				arg_125_0:Play113062031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) and arg_125_1.var_.characterEffect1042ui_story == nil then
				arg_125_1.var_.characterEffect1042ui_story = arg_125_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) then
				if arg_125_1.var_.characterEffect1042ui_story and not isNil(arg_125_1.actors_["1042ui_story"]) then
					arg_125_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) and arg_125_1.var_.characterEffect1042ui_story then
				arg_125_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_128_1 = "1097ui_story"

			if arg_125_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_128_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_125_1.stage_.transform)

				var_128_2.name = var_128_1
				var_128_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_[var_128_1] = var_128_2

				local var_128_3 = var_128_2:GetComponentInChildren(typeof(CharacterEffect))

				var_128_3.enabled = true

				local var_128_4 = GameObjectTools.GetOrAddComponent(var_128_2, typeof(DynamicBoneHelper))

				if var_128_4 then
					var_128_4:EnableDynamicBone(false)
				end

				arg_125_1:ShowWeapon(var_128_3.transform, false)

				arg_125_1.var_[var_128_1 .. "Animator"] = var_128_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_125_1.var_[var_128_1 .. "Animator"].applyRootMotion = true
				arg_125_1.var_[var_128_1 .. "LipSync"] = var_128_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_128_5 = arg_125_1.actors_["1097ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1097ui_story = var_128_5.localPosition
			end

			local var_128_6 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 then
				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_125_1.time_ - 0) / var_128_6)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(0.7, -0.54, -6.3)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_128_7 = arg_125_1.actors_["1097ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_8 and not isNil(var_128_7) then
				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_7) then
					arg_125_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_8 and arg_125_1.time_ < 0 + var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.characterEffect1097ui_story then
				arg_125_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_128_10 = 0
			local var_128_11 = 0.55

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_12 = arg_125_1:GetWordFromCfg(113062030)
				local var_128_13 = arg_125_1:FormatText(var_128_12.content)

				arg_125_1.text_.text = var_128_13

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 22 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_13) / 22)

				if (22 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_13) / 22)) > 0 and var_128_11 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_10
					end
				end

				arg_125_1.text_.text = var_128_13
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062030", "story_v_out_113062.awb") ~= 0 then
					local var_128_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062030", "story_v_out_113062.awb") / 1000

					if var_128_16 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_10
					end

					if var_128_12.prefab_name ~= "" and arg_125_1.actors_[var_128_12.prefab_name] ~= nil then
						local var_128_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_12.prefab_name].transform, "story_v_out_113062", "113062030", "story_v_out_113062.awb")

						arg_125_1:RecordAudio("113062030", var_128_17)
						arg_125_1:RecordAudio("113062030", var_128_17)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113062", "113062030", "story_v_out_113062.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113062", "113062030", "story_v_out_113062.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_18 = math.max(var_128_11, arg_125_1.talkMaxDuration)

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_18 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_10) / var_128_18

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_10 + var_128_18 and arg_125_1.time_ < var_128_10 + var_128_18 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play113062031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113062031
		arg_129_1.duration_ = 10.5

		local var_129_0 = {
			ja = 10.5,
			ko = 8.066,
			zh = 8.5,
			en = 7.633
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
				arg_129_0:Play113062032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1097ui_story"]) and arg_129_1.var_.characterEffect1097ui_story == nil then
				arg_129_1.var_.characterEffect1097ui_story = arg_129_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1097ui_story"]) then
				if arg_129_1.var_.characterEffect1097ui_story and not isNil(arg_129_1.actors_["1097ui_story"]) then
					arg_129_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1097ui_story"]) and arg_129_1.var_.characterEffect1097ui_story then
				arg_129_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_132_1 = arg_129_1.actors_["1042ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1042ui_story = var_132_1.localPosition
			end

			local var_132_2 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 then
				var_132_1.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_2)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 then
				var_132_1.localPosition = Vector3.New(0, 100, 0)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			local var_132_3 = arg_129_1.actors_["6046_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos6046_story = var_132_3.localPosition

				local var_132_4 = GameObjectTools.GetOrAddComponent(var_132_3.gameObject, typeof(DynamicBoneHelper))

				if var_132_4 then
					var_132_4:EnableDynamicBone(false)
				end
			end

			local var_132_5 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				var_132_3.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_129_1.time_ - 0) / var_132_5)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				var_132_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles

				local var_132_6 = GameObjectTools.GetOrAddComponent(var_132_3.gameObject, typeof(DynamicBoneHelper))

				if var_132_6 then
					var_132_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_132_7 = arg_129_1.actors_["6046_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.characterEffect6046_story == nil then
				arg_129_1.var_.characterEffect6046_story = var_132_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_8 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_8 and not isNil(var_132_7) then
				if arg_129_1.var_.characterEffect6046_story and not isNil(var_132_7) then
					arg_129_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_8 and arg_129_1.time_ < 0 + var_132_8 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.characterEffect6046_story then
				arg_129_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_132_10 = 0
			local var_132_11 = 0.825

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_12 = arg_129_1:GetWordFromCfg(113062031)
				local var_132_13 = arg_129_1:FormatText(var_132_12.content)

				arg_129_1.text_.text = var_132_13

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_15 = 33 <= 0 and var_132_11 or var_132_11 * (utf8.len(var_132_13) / 33)

				if (33 <= 0 and var_132_11 or var_132_11 * (utf8.len(var_132_13) / 33)) > 0 and var_132_11 < var_132_15 then
					arg_129_1.talkMaxDuration = var_132_15

					if var_132_15 + var_132_10 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_10
					end
				end

				arg_129_1.text_.text = var_132_13
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062031", "story_v_out_113062.awb") ~= 0 then
					local var_132_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062031", "story_v_out_113062.awb") / 1000

					if var_132_16 + var_132_10 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_10
					end

					if var_132_12.prefab_name ~= "" and arg_129_1.actors_[var_132_12.prefab_name] ~= nil then
						local var_132_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_12.prefab_name].transform, "story_v_out_113062", "113062031", "story_v_out_113062.awb")

						arg_129_1:RecordAudio("113062031", var_132_17)
						arg_129_1:RecordAudio("113062031", var_132_17)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113062", "113062031", "story_v_out_113062.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113062", "113062031", "story_v_out_113062.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_18 = math.max(var_132_11, arg_129_1.talkMaxDuration)

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_18 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_10) / var_132_18

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_10 + var_132_18 and arg_129_1.time_ < var_132_10 + var_132_18 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play113062032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113062032
		arg_133_1.duration_ = 4.8

		local var_133_0 = {
			ja = 4.766,
			ko = 4.8,
			zh = 3.7,
			en = 4.666
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
				arg_133_0:Play113062033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["6046_story"]) and arg_133_1.var_.characterEffect6046_story == nil then
				arg_133_1.var_.characterEffect6046_story = arg_133_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["6046_story"]) then
				if arg_133_1.var_.characterEffect6046_story and not isNil(arg_133_1.actors_["6046_story"]) then
					arg_133_1.var_.characterEffect6046_story.fillFlat = true
					arg_133_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["6046_story"]) and arg_133_1.var_.characterEffect6046_story then
				arg_133_1.var_.characterEffect6046_story.fillFlat = true
				arg_133_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_136_1 = arg_133_1.actors_["1097ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1097ui_story == nil then
				arg_133_1.var_.characterEffect1097ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1097ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1097ui_story then
				arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(113062032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 11 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 11)

				if (11 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 11)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062032", "story_v_out_113062.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062032", "story_v_out_113062.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_113062", "113062032", "story_v_out_113062.awb")

						arg_133_1:RecordAudio("113062032", var_136_11)
						arg_133_1:RecordAudio("113062032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113062", "113062032", "story_v_out_113062.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113062", "113062032", "story_v_out_113062.awb")
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
	Play113062033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113062033
		arg_137_1.duration_ = 10.63

		local var_137_0 = {
			ja = 8.3,
			ko = 7.133,
			zh = 8.5,
			en = 10.633
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
			arg_137_1.auto_ = false
		end

		function arg_137_1.playNext_(arg_139_0)
			arg_137_1.onStoryFinished_()
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1097ui_story = arg_137_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1097ui_story"].transform.position).z)
				arg_137_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1097ui_story"].transform.localEulerAngles = arg_137_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1097ui_story"].transform.position).z)
				arg_137_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1097ui_story"].transform.localEulerAngles = arg_137_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["6046_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos6046_story = var_140_1.localPosition

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_1.gameObject, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end
			end

			local var_140_3 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 then
				var_140_1.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_3)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 then
				var_140_1.localPosition = Vector3.New(0, 100, 0)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles

				local var_140_4 = GameObjectTools.GetOrAddComponent(var_140_1.gameObject, typeof(DynamicBoneHelper))

				if var_140_4 then
					var_140_4:EnableDynamicBone(true)
				end
			end

			local var_140_5 = arg_137_1.actors_["1042ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1042ui_story = var_140_5.localPosition
			end

			local var_140_6 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 then
				var_140_5.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_137_1.time_ - 0) / var_140_6)
				var_140_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_5.position).x, (manager.ui.mainCamera.transform.position - var_140_5.position).y, (manager.ui.mainCamera.transform.position - var_140_5.position).z)
				var_140_5.localEulerAngles.z = 0
				var_140_5.localEulerAngles.x = 0
				var_140_5.localEulerAngles = var_140_5.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 then
				var_140_5.localPosition = Vector3.New(0, -1.06, -6.2)
				var_140_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_5.position).x, (manager.ui.mainCamera.transform.position - var_140_5.position).y, (manager.ui.mainCamera.transform.position - var_140_5.position).z)
				var_140_5.localEulerAngles.z = 0
				var_140_5.localEulerAngles.x = 0
				var_140_5.localEulerAngles = var_140_5.localEulerAngles
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action5_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_140_7 = arg_137_1.actors_["1042ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect1042ui_story == nil then
				arg_137_1.var_.characterEffect1042ui_story = var_140_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_8 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_8 and not isNil(var_140_7) then
				if arg_137_1.var_.characterEffect1042ui_story and not isNil(var_140_7) then
					arg_137_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_8 and arg_137_1.time_ < 0 + var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect1042ui_story then
				arg_137_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_140_10 = 0
			local var_140_11 = 0.6

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_12 = arg_137_1:GetWordFromCfg(113062033)
				local var_140_13 = arg_137_1:FormatText(var_140_12.content)

				arg_137_1.text_.text = var_140_13

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_15 = 24 <= 0 and var_140_11 or var_140_11 * (utf8.len(var_140_13) / 24)

				if (24 <= 0 and var_140_11 or var_140_11 * (utf8.len(var_140_13) / 24)) > 0 and var_140_11 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_10
					end
				end

				arg_137_1.text_.text = var_140_13
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062033", "story_v_out_113062.awb") ~= 0 then
					local var_140_16 = manager.audio:GetVoiceLength("story_v_out_113062", "113062033", "story_v_out_113062.awb") / 1000

					if var_140_16 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_10
					end

					if var_140_12.prefab_name ~= "" and arg_137_1.actors_[var_140_12.prefab_name] ~= nil then
						local var_140_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_12.prefab_name].transform, "story_v_out_113062", "113062033", "story_v_out_113062.awb")

						arg_137_1:RecordAudio("113062033", var_140_17)
						arg_137_1:RecordAudio("113062033", var_140_17)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113062", "113062033", "story_v_out_113062.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113062", "113062033", "story_v_out_113062.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = math.max(var_140_11, arg_137_1.talkMaxDuration)

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_10) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_10 + var_140_18 and arg_137_1.time_ < var_140_10 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01"
	},
	voices = {
		"story_v_out_113062.awb"
	}
}
